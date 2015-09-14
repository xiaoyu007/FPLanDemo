//
//  RemindLists.m
//  优顾理财
//
//  Created by Mac on 15/7/16.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "RemindLists.h"
#import "PlistOperation.h"

#define RemindListsPlist @"remindLists.plist"

@implementation RemindItem

- (void)jsonToObject:(NSDictionary *)dict{
  self.primaryId = dict[@"id"];
  self.fundName = dict[@"fundname"];
  self.fundId = dict[@"fundid"];
  self.tradeAcco = dict[@"tradeacco"];
  self.userId = dict[@"userid"];
  self.profit = dict[@"profit"];
  self.loss = dict[@"loss"];
  self.profitRate = dict[@"profitRate"];
  self.lossRate = dict[@"lossRate"];
}

@end

@implementation RemindLists
- (void)jsonToObject:(NSDictionary *)dict{
  [super jsonToObject:dict];
  NSArray *array = dict[@"result"];
  _remindLists = [[NSMutableArray alloc]initWithCapacity:0];
  [array enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx,
                                      BOOL* stop) {
    RemindItem* item = [[RemindItem alloc] init];
    [item jsonToObject:obj];
    [_remindLists addObject:item];
  }];
  //提醒列表本地保存
  [_remindLists
   writeToFile:[PlistOperation getPlistPath:RemindListsPlist]
   atomically:YES];
}
- (RemindItem *)isExistTradeAcco:(NSString *)tradeAcco{
  for (RemindItem *item in _remindLists) {
    if ([tradeAcco isEqualToString:item.tradeAcco]) {
      return item;
    }
  }
  return nil;
}
/** 获取用户所有盈亏提醒 */
/** {
 {
 "status": "0000",
 "message": "获取盈亏提醒成功。",
 "result": [
 {"createTime":1436513466000,
 "fundid":"000003",
 "id":0,
 "loss":2000,
 "lossRate":10.02,
 "profit":2000,
 "profitRate":20.01,
 "remindNum":0,
 "status":0,
 "tradeacco":"1000242644",
 "userid":5316973}，
 {....},
 {....}
 ]
 }hao } */
+ (void)getUserAllProfitAndLossDetailwithCallback:(HttpRequestCallBack *)callback{
  NSString *path = [NSString stringWithFormat:@"%@financeMarketWeb/financeMarket/getUserReminds", IP_HTTP_SHOPPING];
  [[WebServiceManager sharedManager]NetworkRequestsWithPath:path andDic:nil andType:RFRequestMethodPost andCompletion:^(NSDictionary *response) {
    RemindLists *remindLists = [[RemindLists alloc]init];
    [remindLists jsonToObject:response];
  }];
}

/** 删除盈亏提醒 */
/*
 "status": "0000",
 "message": "删除成功。"
 */
+ (void)deleteUserProAndLossRemindWithId:(NSString *)primaryKey
                          withCallback:(HttpRequestCallBack *)callback{
  NSDictionary *dict = @{ @"id" : primaryKey};
  NSString *path = [NSString stringWithFormat:@"%@financeMarketWeb/financeMarket/delRemind", IP_HTTP_SHOPPING];
  [[WebServiceManager sharedManager]NetworkRequestsWithPath:path andDic:dict andType:RFRequestMethodPost andCompletion:^(NSDictionary *response) {
    NSLog(@"response = %@", response);
  }];
}

@end
