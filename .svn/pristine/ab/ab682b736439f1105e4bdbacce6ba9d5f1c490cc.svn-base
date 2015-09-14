
//
//  TradeViewController.m
//  优顾理财
//
//  Created by jhss on 15-4-12.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPTradeViewController.h"
#import "FPTradeTableViewCell.h"
#import "DateChangeSimple.h"

@interface FPTradeViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation FPTradeViewController {
  ///交易记录model
  FPTradeItem *item;
  //交易结果描述
  UILabel *traderemarkLabel;

  /** 请求时菊花控件 */
  UIActivityIndicatorView *_indicator;
  /** 刷新按钮*/
  UIButton *_refreshButton;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  _cuttingLineView.transform = CGAffineTransformScale(_cuttingLineView.transform, 1.0f, 0.5f);
  self.topNavView.mainLableString = @"交易记录";

  [self createTableView];
  [self registerNibCell];
  /**  刷新按钮*/
  [self createMainView];
  //请求数据
  [self getTradeList];
}

#pragma mark - 注册NibCell
- (void)registerNibCell {
  UINib *cellNib =
      [UINib nibWithNibName:NSStringFromClass([FPTradeTableViewCell class]) bundle:nil];
  [self.tableView registerNib:cellNib forCellReuseIdentifier:@"FPTradeTableViewCell"];
}

- (void)createTableView {
  self.startIndex = 1;
  self.refrashIndex = self.startIndex;
  [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//  [self.tableView setSeparatorColor:[Globle colorFromHexRGB:@"e8e8e8"]];
  [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
  //交易记录
  noMoreDataLabel =
      [[UILabel alloc] initWithFrame:CGRectMake(30, windowHeight / 2 - 40.0f, windowWidth - 60, 40)];
  noMoreDataLabel.text = @"暂无交易记录";
  noMoreDataLabel.textAlignment = NSTextAlignmentCenter;
  noMoreDataLabel.textColor = [Globle colorFromHexRGB:@"cfcfcf"];
  [self.view addSubview:noMoreDataLabel];
  noMoreDataLabel.hidden = YES;
}

- (void)createMainView {
  //刷新按钮
  _refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
  _refreshButton.frame = CGRectMake(windowWidth - 50.0f, 0, 50.0f, 50.0f);
  [_refreshButton setImage:[UIImage imageNamed:@"刷新小图标"] forState:UIControlStateNormal];
  [_refreshButton setImage:[UIImage imageNamed:@"刷新小图标"] forState:UIControlStateHighlighted];
  _refreshButton.imageEdgeInsets = UIEdgeInsetsMake(16.0f, 15.0f, 16.0f, 15.0f);
  [_refreshButton addTarget:self
                    action:@selector(refeshTradeData)
          forControlEvents:UIControlEventTouchUpInside];
  UIImage *highLightImage = [FPYouguUtil createImageWithColor:btnAccordingToTheNormal];
  [_refreshButton setBackgroundImage:highLightImage forState:UIControlStateHighlighted];
  [self.topNavView addSubview:_refreshButton];
  //刷新菊花
  [self createIndicator];
}

/** 菊花控件 */
- (void)createIndicator {
  _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
  _indicator.center = _refreshButton.center;
  _indicator.hidden = YES;
  [self.topNavView addSubview:_indicator];
}

/**   刷新数据*/
- (void)refeshTradeData {
  self.refrashIndex = self.startIndex;
  //请求数据
  [self getTradeList];

}
#pragma mark - loading 代理方法
- (void)refreshNewInfo {
  if ([FPYouguUtil isExistNetwork]) {
    self.refrashIndex = self.startIndex;
    //加载网络请求
    [self getTradeList];
  }
}
#pragma mark - 数据请求
/** 刷新数据按钮 */
- (void)requestData {
  [self getTradeList];
}
/** success返回 */
- (void)returnBlock:(NSObject *)obj {
  FPTradeList *list = (FPTradeList *)obj;
  [super jsonToDic:list.tradeLists];
  #warning  childview的frame中途发生了变化
  self.childView.frame = CGRectMake(0, navigationHeght + statusBarHeight, windowWidth,
                                    windowHeight - statusBarHeight - navigationHeght);
  self.tableView.frame = self.childView.bounds;
}
static int const pageSize = 10;
/** 网络请求 */
- (void)getTradeList {
  //有离线状态，去掉了无网提示
  if (![FPYouguUtil isExistNetwork]) {
    if (!self.dataArray.dataBinded) {
      self.loading.hidden = NO;
      [self.loading animationNoNetWork];
    } else if (self.dataArray.dataBinded && self.dataArray.array.count == 0) {
      self.loading.hidden = NO;
      [self.loading notDataStatus];
    } else {
      self.loading.hidden = YES;
    }
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  [self showIndicator];
  HttpRequestCallBack *callBack = [super getHttpCallBack];
  __weak FPTradeViewController *weakSelf = self;
  callBack.onCheckQuitOrStopProgressBar = ^{
    FPTradeViewController *strongSelf = weakSelf;
    if (strongSelf) {
      [strongSelf hiddenIndicator];
      strongSelf.loading.hidden = YES;
      return NO;
    } else {
      return YES;
    }
  };
  [FPTradeList sendRequestWithTradeWithPageIndex:self.refrashIndex
                                    withPageSize:pageSize
                                    withCallback:callBack];
}
#pragma mark - error
- (void)returnError:(BaseRequestObject *)err {
  NSString *message = [NSString stringWithFormat:@"%@", err.message];
  if (!message || [message length] == 0 || [message isEqualToString:@"(null)"]) {
    message = networkFailed;
  }
  if (err && [err.status isEqualToString:@"0101"]) {
  } else {
    ///无数据时的返回信息
    if (err && [err.status isEqualToString:@"100006"]) {
      if ([self.dataArray.array count] > 0) {
        YouGu_animation_Did_Start(@"暂无更多数据");
        [super jsonToDic:nil];
      } else {
        noMoreDataLabel.hidden = NO;
      }
    }
  }
}
/** 显示菊花 */
- (void)showIndicator {
  _refreshButton.hidden = YES;
  _indicator.hidden = NO;
  [_indicator startAnimating];
}
/** 隐藏菊花 */
- (void)hiddenIndicator {
  _refreshButton.hidden = NO;
  _indicator.hidden = YES;
  [_indicator stopAnimating];
}

#pragma mark - tableViewDelegate
static CGFloat const tableviewHeight = 140.0f;

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return tableviewHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellId = @"FPTradeTableViewCell";
  FPTradeTableViewCell *cell = (FPTradeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
  FPTradeItem *titem = self.dataArray.array[indexPath.row];
  cell.productNameLabel.text = titem.fundname;
  cell.operationLabel.text = titem.traderemark;
  if ([titem.status isEqualToString:@"F"]) {
    cell.operationLabel.textColor = [Globle colorFromHexRGB:DataUpColor];
  } else if ([titem.status isEqualToString:@"S"]) {
    cell.operationLabel.textColor = [Globle colorFromHexRGB:DataDownColor];
  } else {
    cell.operationLabel.textColor = [Globle colorFromHexRGB:DataZeroColor];
  }
  cell.moneyLabel.text = [NSString stringWithFormat:@"%@", titem.money];

  //时间戳-》时间
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"yyyy-MM-dd   hh:mm:ss"];
  NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:[titem.time longLongValue] / 1000];
  cell.timeLabel.text = [dateFormatter stringFromDate:date];

  return cell;
}

@end
