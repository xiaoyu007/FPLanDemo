//
//  TradeTitleTableViewController.m
//  优顾理财
//
//  Created by Yuemeng on 15/9/9.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "TradeTitleTableViewController.h"
#import "FPTradeTableViewCell.h"
#import "RefreshButtonView.h"

@implementation TradeTableAdapter

- (NSString *)nibName {
  static NSString *nibFileName;
  if (nibFileName == nil) {
    nibFileName = NSStringFromClass([FPTradeTableViewCell class]);
  }
  return nibFileName;
}

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 140.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellId = @"FPTradeTableViewCell";
  FPTradeTableViewCell *cell = (FPTradeTableViewCell *)
      [tableView dequeueReusableCellWithIdentifier:cellId];
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
  NSDate *date = [[NSDate alloc]
      initWithTimeIntervalSince1970:[titem.time longLongValue] / 1000];
  cell.timeLabel.text = [dateFormatter stringFromDate:date];

  return cell;
}

@end

/**
 *  tableViewController
 */
@implementation TradeTableViewController

/** 请求最新数据，此方法子类必须实现 */
- (void)requestDataListWithRefreshType:(RefreshType)refreshType
                         withDataArray:(DataArray *)existDataList
                          withCallBack:(HttpRequestCallBack *)callback {

  [FPTradeList sendRequestWithTradeWithDic:
                   [self getRequestParamertsWithRefreshType:refreshType]
                              withCallback:callback];
}

- (NSDictionary *)getRequestParamertsWithRefreshType:(RefreshType)refreshType {
  NSString *start = @"1";

  if (refreshType == RefreshTypeLoaderMore) {
    start = [@((self.dataArray.array.count + 9) / 10 + 1) stringValue];
  }
  return @{ @"pageIndex" : start, @"pageSize" : @"10" };
}

- (BOOL)isDataValidWithResponseObject:(NSObject<Collectionable> *)latestData
                withRequestParameters:(NSDictionary *)parameters
                      withRefreshType:(RefreshType)refreshType {
  if (refreshType == RefreshTypeLoaderMore) {
    if (((self.dataArray.array.count + 9) / 10 + 1) !=
        [parameters[@"pageIndex"] integerValue]) {
      return NO;
    }
  }
  return YES;
}

/** 返回表格数据适配器，此方法子类必须实现 */
- (BaseTableAdapter *)getBaseTableAdaperWithDataList:(DataArray *)dataList {
  if (_tableAdapter == nil) {
    _tableAdapter =
        [[TradeTableAdapter alloc] initWithTableViewController:self
                                                 withDataArray:self.dataArray];
    UINib *cellNib = [UINib nibWithNibName:_tableAdapter.nibName bundle:nil];
    [self.tableView registerNib:cellNib
         forCellReuseIdentifier:_tableAdapter.nibName];
  }
  return _tableAdapter;
}

@end

/**
 *  titleViewController
 */
@implementation TradeTitleTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.topNavView.mainLableString = @"交易记录";

  RefreshButtonView *refreshButtonView =
      [[RefreshButtonView alloc] initWithSuperView:self.topNavView];

  refreshButtonView.refreshButtonPressDownBlock = ^{
    [_tableVC refreshButtonPressDown];
  };

  _tableVC =
      [[TradeTableViewController alloc] initWithFrame:self.clientView.bounds];

  _tableVC.beginRefreshCallBack = ^{
    [refreshButtonView showIndicator];
  };

  _tableVC.endRefreshCallBack = ^{
    [refreshButtonView hiddenIndicator];
  };

  [self.clientView addSubview:_tableVC.view];
  [self addChildViewController:_tableVC];
  [_tableVC refreshButtonPressDown];
}

@end
