//
//  UserCenterInfo.m
//  优顾理财
//
//  Created by Mac on 15/9/6.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "UserCenterInfo.h"

@implementation UserCenterInfo

- (void)jsonToObject:(NSDictionary *)dic {
  [super jsonToObject:dic];
  NSDictionary *dict = dic[@"result"];
  self.countAssets = [NSString stringWithFormat:@"%0.2f", [dict[@"countAssets"] doubleValue]];
  self.countProfit = [NSString stringWithFormat:@"%0.2f", [dict[@"countProfit"] doubleValue]];
  self.positionNum = [dict[@"positionNum"] stringValue];
  self.tranNum = [dict[@"tranNum"] stringValue];
  self.userName = dict[@"userName"];
  self.mobile = dict[@"mobile"];
  self.yesterDay = dict[@"yesterDay"];
  self.yesterDayProfit =
      [NSString stringWithFormat:@"%0.2f", [dict[@"yesterDayProfit"] doubleValue]];
  self.zxNum = [dict[@"zxNum"] stringValue];
}

+ (void)sendUserCenterRequestWithCallback:(HttpRequestCallBack *)callback {
  NSString *path = [NSString stringWithFormat:@"%@financeMarketWeb/financeMarket/userCenter", IP_HTTP_SHOPPING];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"POST"
               withRequestParameters:nil
              withRequestObjectClass:[UserCenterInfo class]
             withHttpRequestCallBack:callback];
}

@end
