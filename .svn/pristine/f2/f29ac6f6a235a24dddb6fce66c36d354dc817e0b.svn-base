//
//  FPNoTitleBaseTableViewController.m
//  优顾理财
//
//  Created by Mac on 15/8/13.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPNoTitleBaseTableViewController.h"

@implementation FPNoTitleBaseTableViewController

- (id)initWithRefreshLable:(NSString *)labletext {
  self = [super init];
  if (self) {
    _refrashIndex = 0;
    _RefreshLable = labletext;
  }
  return self;
}
- (id)initWithFrame:(CGRect)frame AndRefreshLable:(NSString *)labletext {
  self = [super initWithFrame:frame];
  if (self) {
    _refrashIndex = 0;
    _RefreshLable = labletext;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self creatBaseTableView];
}
- (void)creatBaseTableView {
  self.isStatus = NO;
  // Do any additional setup after loading the view from its nib.
  _startIndex = 0;
  _refrashIndex = 0;
  //资讯新闻页下方的新闻标题
  _dataArray = [[DataArray alloc] init];
  _tableView = [[PullingRefreshTableView alloc] initWithFrame:self.childView.bounds
                                              pullingDelegate:self
                                                andRefresh_id:_RefreshLable];
  _tableView.backgroundColor = [UIColor clearColor];
  _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  _tableView.dataSource = self;
  _tableView.delegate = self;
  [self.childView addSubview:_tableView];
}

#pragma mark - 刷新数据
///刷新数据
- (void)requestData {
}

- (void)setNoNetWork {
  if (!self.dataArray.dataBinded) {
    [self.loading animationNoNetWork];
  } else if (self.dataArray.dataBinded && [self.dataArray.array count] == 0) {
    [self.loading notDataStatus];
  } else {
    self.loading.hidden = YES;
  }
  YouGu_animation_Did_Start(networkFailed);
  [_tableView tableViewDidFinishedLoading];
}

#pragma mark - PullingRefreshTableViewDelegate
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView {
  if (![FPYouguUtil isExistNetwork]) {
    [self setNoNetWork];
    return;
  }
  _refrashIndex = _startIndex;
  [self performSelector:@selector(requestData) withObject:nil afterDelay:1];
}

- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView {
  if (![FPYouguUtil isExistNetwork]) {
    [self setNoNetWork];
    return;
  }
  _refrashIndex++;
  [self requestData];
}

- (HttpRequestCallBack *)getHttpCallBack {
  HttpRequestCallBack *callback = [[HttpRequestCallBack alloc] init];
  __weak FPNoTitleBaseTableViewController *weakSelf = self;
  callback.onCheckQuitOrStopProgressBar = ^{
    FPNoTitleBaseTableViewController *strongObj = weakSelf;
    if (strongObj) {
      strongObj.loading.hidden = YES;
      return NO;
    } else {
      return YES;
    }
  };
  callback.onSuccess = ^(NSObject *obj) {
    FPNoTitleBaseTableViewController *strongObj = weakSelf;
    if (strongObj) {
      strongObj.isSuccess = YES;
      [strongObj.tableView tableViewDidFinishedLoading];
      [strongObj returnBlock:obj];
    }
  };
  callback.onError = ^(BaseRequestObject *err, NSException *ex) {
    FPNoTitleBaseTableViewController *strongObj = weakSelf;
    if (strongObj) {
      strongObj.refrashIndex--;
      [strongObj.tableView tableViewDidFinishedLoading];
      [BaseRequester defaultErrorHandler](err, ex);
      [strongObj returnError:err];
    }
  };
  callback.onFailed = ^{
    FPNoTitleBaseTableViewController *strongObj = weakSelf;
    if (strongObj) {
      strongObj.refrashIndex--;
      [strongObj.tableView tableViewDidFinishedLoading];
      [strongObj returnFail];
      [BaseRequester defaultFailedHandler]();
    }
  };
  return callback;
}
/**
 *  失败
 *
 *  @return
 */
- (void)returnFail {
}
- (void)returnError:(BaseRequestObject *)err {
}
///成功回调
- (void)returnBlock:(NSObject *)obj {
}

///数据解析
- (void)jsonToDic:(NSArray *)array {
  self.dataArray.dataBinded = YES;
  if (array.count > 0) {
    if (self.refrashIndex == _startIndex) {
      self.dataArray.dataComplete = NO;
      self.tableView.footerView.state = kPRStateNormal;
      [self.dataArray.array removeAllObjects];
    }
    [self.dataArray.array addObjectsFromArray:array];
    self.loading.hidden = YES;
    [self.tableView reloadData];
  } else {
    self.dataArray.dataComplete = YES;
    self.tableView.footerView.state = kPRStateHitTheEnd;
    if ([self.dataArray.array count] == 0) {
      self.loading.hidden = NO;
      [self.loading notDataStatus];
    } else {
      self.loading.hidden = YES;
    }
  }
}
#pragma 刷新结束后，更变，更新刷新时间
- (NSDate *)pullingTableViewRefreshingFinishedDate {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
  //    特点的一片文章的评论
  NSString *key = YouGu_StringWithFormat_double(@"NewsListRefrash_", _RefreshLable);
  NSString *date_time = YouGu_defaults(key);
  NSDate *date = [dateFormatter dateFromString:date_time];
  YouGu_defaults_double(date_time, key);
  if (_isSuccess) {
    date = [NSDate date];
    NSString *date_ttime = [dateFormatter stringFromDate:date];
    YouGu_defaults_double(date_ttime, key);
    _isSuccess = NO;
  }
  return date;
}

#pragma mark - Scroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  [_tableView tableViewDidScroll:scrollView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
  [_tableView tableViewDidEndDragging:scrollView];
}

#pragma mark - Table view data source
/** 默认返回一个section */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  if (section == 0) {
    return 0;
  }
  return 3.0;
}
/** 默认返回数组的长度 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return _dataArray.array.count;
}

/** 子类必须实现的方法 */
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSException *ex = [NSException
      exceptionWithName:@"not implement exception"
                 reason:@"[tableView:cellForRowAtIndexPath:] " @"method is not implemented"
               userInfo:nil];
  [ex raise];
  return nil;
}

/** 子类必须实现的方法 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSException *ex = [NSException
      exceptionWithName:@"not implement exception"
                 reason:@"[tableView:heightForRowAtIndexPath:] " @"method is not implemented"
               userInfo:nil];
  [ex raise];
  return 0.0f;
}

/** 当显示最后一行数据时，自动加载下一页 */
- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger section = [self numberOfSectionsInTableView:tableView];
  if (section == 1 || (section >= 2 && indexPath.section == section - 1)) {
    if (indexPath.row == [self tableView:tableView numberOfRowsInSection:section-1] - 1) { //显示最后一行

      NSArray *indexes = [tableView indexPathsForVisibleRows];
      if (indexes && indexes.count > 0) {
        NSIndexPath *firstRow = indexes[0];
        if (firstRow.row == 0) {
          //如果第一行和最后一行都显示了，不自动加载，让用户手动加载吧
          self.dataArray.dataComplete = YES;
          self.tableView.footerView.state = kPRStateHitTheEnd;
          return;
        }
      }

      if (_dataArray.dataComplete) {
        return;
      }
      //滑动至数据的最后一条时，加载下一页
      NSLog(@"loadNextPage");
      [self pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView];
    }
  }
}
@end
