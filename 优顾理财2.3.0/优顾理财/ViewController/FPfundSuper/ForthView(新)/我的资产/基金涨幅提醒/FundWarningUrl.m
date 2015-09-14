//
//  FundWarningUrl.m
//  优顾理财
//
//  Created by Mac on 15/7/14.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FundWarningUrl.h"

@implementation FPFundInfoItem

@end

@implementation ProfitAndLossRemindItem

- (void)jsonToObject:(NSDictionary *)dic{
  [super jsonToObject:dic];
  NSDictionary *subDict = dic[@"result"];
  self.profit = subDict[@"profit"];
  self.loss = subDict[@"loss"];
  self.profitRate = subDict[@"profitRate"];
  self.lossRate = subDict[@"lossRate"];
  self.netValue = subDict[@"netvalue"];
  self.dayRate = subDict[@"dayrate"];
}

/** 获取盈亏提醒详细 */
+ (void)getProfitAndLossDetailWithFundId:(NSString *)fundId
                           withTradeacco:(NSString *)tradeacco
                          withCallback:(HttpRequestCallBack *)callback{
  NSString *path = [NSString stringWithFormat:@"%@financeMarketWeb/financeMarket/getRemind", IP_HTTP_SHOPPING];
  NSDictionary *dict = @{ @"fundid" : fundId, @"tradeacco" : tradeacco};
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"POST"
               withRequestParameters:dict
              withRequestObjectClass:[ProfitAndLossRemindItem class]
             withHttpRequestCallBack:callback];
}
@end

#pragma mark- 基金价格提醒
@implementation FundWarningUrl
-(void)jsonToObject:(NSDictionary *)dic
{
  [super jsonToObject:dic];
}
/** 有fundid获取基金信息 */
+ (void)getFundInfoWithFundId:(NSString *)fundId
                 withCallback:(HttpRequestCallBack *)callback{
  NSString *path = [NSString stringWithFormat:@"%@fincenWeb/fund/detail/getfund?fundid=%@", IP_HTTP_SHOPPING_SHOPPING, fundId];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[FundWarningUrl class]
             withHttpRequestCallBack:callback];
}
@end
@implementation FundUserTradeOrdersNumber
-(void)jsonToObject:(NSDictionary *)dic
{
  [super jsonToObject:dic];
  self.number = dic[@"result"];
}
+ (void)getUserTradeOrdersNumberwithCallback:(HttpRequestCallBack *)callback{
  NSString *path = [NSString stringWithFormat:@"%@financeMarketWeb/financeMarket/tradingNum", IP_HTTP_SHOPPING];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"POST"
               withRequestParameters:nil
              withRequestObjectClass:[FundUserTradeOrdersNumber class]
             withHttpRequestCallBack:callback];
}
@end
@implementation ProfitAndLossDetail
-(void)jsonToObject:(NSDictionary *)dic
{
  [super jsonToObject:dic];
}
/** 设置盈亏提醒详细 */
/*
 "status": "0000",
 "message": "已成功设置盈亏提醒。"
 */
+ (void)setProfitAndLossDetailWithBody:(NSDictionary *)dict
                          withCallback:(HttpRequestCallBack *)callback{
  NSString *path = [NSString stringWithFormat:@"%@financeMarketWeb/financeMarket/setRemind", IP_HTTP_SHOPPING];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"POST"
               withRequestParameters:dict
              withRequestObjectClass:[ProfitAndLossDetail class]
             withHttpRequestCallBack:callback];
}
@end
@implementation FundUserProAndLossRemind
- (void)jsonToObject:(NSDictionary *)dic{
  [super jsonToObject:dic];
}
/** 删除盈亏提醒 */
/*
 "status": "0000",
 "message": "删除成功。"
 */
+ (void)deleteUserProAndLossRemindWithId:(NSDictionary *)dict
                          withCallback:(HttpRequestCallBack *)callback{
  NSString *path = [NSString stringWithFormat:@"%@financeMarketWeb/financeMarket/delRemind", IP_HTTP_SHOPPING];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"POST"
               withRequestParameters:dict
              withRequestObjectClass:[FundUserProAndLossRemind class]
             withHttpRequestCallBack:callback];
}

@end
