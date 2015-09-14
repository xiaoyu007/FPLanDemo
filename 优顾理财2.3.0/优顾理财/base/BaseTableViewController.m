//
//  BaseTableViewController.m
//  SimuStock
//
//  Created by Mac on 15/4/26.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "BaseTableViewController.h"

@implementation BaseTableViewController

- (void)dealloc {
  if (_footerView) {
    [_footerView free];
  }
  if (_headerView) {
    [_headerView free];
  }
}

- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    _dataArray = [[DataArray alloc] init];
    _showTableFooter = NO;
  }
  return self;
}

- (void)requestDataListWithRefreshType:(RefreshType)refreshType
                         withDataArray:(DataArray *)existDataList
                          withCallBack:(HttpRequestCallBack *)callback {
  [NSException
       raise:@"not implement method"
      format:
          @"[requestWithRefreshType:withDataArray:] method is not implemented"];
}

- (BOOL)isDataValidWithResponseObject:(NSObject<Collectionable> *)latestData
                withRequestParameters:(NSDictionary *)parameters
                      withRefreshType:(RefreshType)refreshType {
  return YES;
}

- (BaseTableAdapter *)getBaseTableAdaperWithDataList:(DataArray *)dataList {
  [NSException raise:@"not implement method"
              format:@"[getBaseTableAdaper:] method is not implemented]"];

  return nil;
}

- (BOOL)supportAutoLoadMore {
  return YES;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self createViews];
  self.loading.frame = self.view.bounds;
}

- (void)createViews {

  _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
  _tableView.delegate = [self getBaseTableAdaperWithDataList:_dataArray];
  _tableView.dataSource = [self getBaseTableAdaperWithDataList:_dataArray];
  _tableView.bounces = YES; //与安卓版一致，下拉自动刷新
  _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  _tableView.backgroundColor = [Globle colorFromHexRGB:Color_BG_Common];
  _tableView.scrollsToTop = YES;
  [self.view addSubview:_tableView];
  //初始化默认显示持仓列表
  _tableView.hidden = NO;

  // 上拉加载更多
  _footerView = [[MJRefreshFooterView alloc] initWithFrame:self.view.bounds];
  _footerView.delegate = self;
  _footerView.scrollView = _tableView;
  _footerView.hidden = YES;
  [_footerView singleRow];
  _headerView = [[MJRefreshHeaderView alloc] initWithPage:[self headerViewKey]];
  _headerView.scrollView = _tableView;
  _headerView.delegate = self;
  [_headerView singleRow];
}

- (NSString *)headerViewKey {
  return NSStringFromClass([self class]);
}

- (void)refreshButtonPressDown {
  [self requestResponseWithRefreshType:RefreshTypeRefresh];
}

- (BOOL)dataBinded {
  return self.dataArray.dataBinded;
}

#pragma mark MJRefreshBaseViewDelegate代理方法 - 进入刷新状态就会调用
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView {
  if (![FPYouguUtil isExistNetwork]) {
    [self performSelector:@selector(endRefreshLoading)
               withObject:nil
               afterDelay:0.5];
    [self setNoNetWork];
    return;
  }

  if (refreshView == _footerView) {
    //当前无数据，不能加载更多
    if (isLoadMore || _dataArray.dataComplete ||
        [_dataArray.array count] == 0) {
      [self performSelector:@selector(endRefreshLoading)
                 withObject:nil
                 afterDelay:0.5];
      return;
    }
    isLoadMore = YES;
    [self requestResponseWithRefreshType:RefreshTypeLoaderMore];
  }
  if (refreshView == _headerView) {
    [self requestResponseWithRefreshType:RefreshTypeHeaderRefresh];
  }
}

- (void)setNoNetWork {
  [NewShowLabel showNoNetworkTip];
  if (_dataArray.dataBinded) {
    _tableView.tableFooterView = nil;
    self.loading.hidden = YES;
  } else {
    [self.loading animationNoNetWork];
    _tableView.tableFooterView = self.loading;
  }
  [self IsWhetherHaveData:nil];
}

- (void)endRefreshLoading {
  isLoadMore = NO;
  if (_headerView) {
    [_headerView endRefreshing];
  }
  if (_footerView) {
    [_footerView endRefreshing];
  }
  if (self.endRefreshCallBack) {
    self.endRefreshCallBack();
  }
}

- (NSDictionary *)getRequestParamertsWithRefreshType:(RefreshType)refreshType {
  return nil;
}

///刷新或者加载下一页数据
- (void)requestResponseWithRefreshType:(RefreshType)refreshType {
  if (self.beginRefreshCallBack) {
    self.beginRefreshCallBack();
  }

  if (![FPYouguUtil isExistNetwork]) {
    [self endRefreshLoading];
    [self setNoNetWork];
    return;
  }

  NSDictionary *requestParamerts =
      [self getRequestParamertsWithRefreshType:refreshType];

  HttpRequestCallBack *callback = [[HttpRequestCallBack alloc] init];
  __weak BaseTableViewController *weakSelf = self;
  callback.onCheckQuitOrStopProgressBar = ^{
    BaseTableViewController *strongSelf = weakSelf;
    if (strongSelf) {
      [strongSelf endRefreshLoading];
      return NO;
    } else {
      return YES;
    }
  };

  callback.onSuccess = ^(NSObject *obj) {
    BaseTableViewController *strongSelf = weakSelf;
    if (strongSelf) {
      if ([obj conformsToProtocol:@protocol(Collectionable)]) {
        NSObject<Collectionable> *latestData = (NSObject<Collectionable> *)obj;
        [strongSelf bindRequestObject:latestData
                withRequestParameters:requestParamerts
                      withRefreshType:refreshType];
      } else {
        [NSException raise:@"not implement protocol"
                    format:@"Collectionable Protocol is not implemented"];
      }
    }
  };

  callback.onFailed = ^() {
    [weakSelf setNoNetWork];
  };

  [self requestDataListWithRefreshType:refreshType
                         withDataArray:_dataArray
                          withCallBack:callback];
}

//绑定数据
- (void)bindRequestObject:(NSObject<Collectionable> *)latestData
    withRequestParameters:(NSDictionary *)parameters
          withRefreshType:(RefreshType)refreshType {

  if (![self isDataValidWithResponseObject:latestData
                     withRequestParameters:parameters
                           withRefreshType:refreshType]) {
    [self IsWhetherHaveData:nil];
    return;
  }

  if (refreshType == RefreshTypeRefresh ||
      refreshType == RefreshTypeHeaderRefresh ||
      refreshType == RefreshTypeTimerRefresh) {
    //刷新，则清除数据
    _headerView.lastUpdateTime = [NSDate date];
    [_dataArray.array removeAllObjects];
  }

  //刷新按钮点击时，回到头部
  if (refreshType == RefreshTypeRefresh) {
    [_tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
  }

  NSArray *array = [latestData getArray];
  [_dataArray.array addObjectsFromArray:array];

  // DataArray绑定数据
  _dataArray.dataBinded = YES;

  if ([array count] > 0) {
    _dataArray.dataComplete = NO;
  } else { //最后一段数据或空
    _dataArray.dataComplete = YES;
  }

  //数据完整，则上拉加载更多控件隐藏
  _footerView.hidden = _dataArray.dataComplete;

  if ([_dataArray.array count] == 0) {
    //数据为空，显示小牛
    [self.loading notDataStatus];
    _tableView.tableFooterView = self.loading;
  } else {
    //只要有数据显示，则隐藏小牛
    self.loading.hidden = YES;

    if (_dataArray.dataComplete) {
      [_tableView setTableFooterView:_showTableFooter
                                         ? [self noDataShowFootView]
                                         : nil];
      if (!_showTableFooter && refreshType == RefreshTypeLoaderMore) {
        [NewShowLabel setMessageContent:@"暂无更多数据"];
      }
    } else {
      [_tableView setTableFooterView:nil];
    }
  }

  [_tableView reloadData];
  if (self.onDataReadyCallBack) {
    self.onDataReadyCallBack();
  }

  [self IsWhetherHaveData:nil];
}

///判断网络请求结束以后,判断当前界面是否有数据
- (void)IsWhetherHaveData:(DataArray *)array {
  ///给子类继承，重写用,(不是一定要继承的）
}

//暂无加载更多
- (UIView *)noDataShowFootView {
  if (noDataFootView == nil) {
    CGRect frame = self.view.frame;
    noDataFootView =
        [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 1.0f)];
    noDataFootView.backgroundColor = [Globle colorFromHexRGB:Color_BG_Common];
    //灰线
    UIView *grayLine =
        [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 0.5f)];
    grayLine.backgroundColor = [Globle colorFromHexRGB:@"e3e3e3"];
    [noDataFootView addSubview:grayLine];
    //白线
    UIView *whiteLine = [[UIView alloc]
        initWithFrame:CGRectMake(0, 0.5f, frame.size.width, 0.5f)];
    whiteLine.backgroundColor = [UIColor whiteColor];
    [noDataFootView addSubview:whiteLine];

    UILabel *noDataLabel =
        [[UILabel alloc] initWithFrame:CGRectMake(0, 2, frame.size.width, 38)];
    noDataLabel.backgroundColor = [Globle colorFromHexRGB:Color_BG_Common];
    [noDataFootView addSubview:noDataLabel];
    //按钮
    UIButton *noDataFootButton = [UIButton buttonWithType:UIButtonTypeCustom];
    noDataFootButton.frame = CGRectMake(0, 2, frame.size.width, 38);
    [noDataFootButton setTitleColor:[Globle colorFromHexRGB:@"939393"]
                           forState:UIControlStateNormal];
    noDataFootButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [noDataFootButton setTitle:@"暂无更多数据" forState:UIControlStateNormal];
    noDataFootButton.backgroundColor = [UIColor clearColor];
    [noDataFootView addSubview:noDataFootButton];
  }

  return noDataFootView;
}

@end
