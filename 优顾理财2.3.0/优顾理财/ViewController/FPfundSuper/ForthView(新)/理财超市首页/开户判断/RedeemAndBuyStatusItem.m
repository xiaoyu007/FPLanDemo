//
//  RedeemAndBuyStatusUrl.m
//  优顾理财
//
//  Created by Mac on 15/8/11.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "RedeemAndBuyStatusItem.h"

@implementation RedeemAndBuyStatusItem

- (void)jsonToObject:(NSDictionary *)dic{
  [super jsonToObject:dic];
  self.redeemButtonStatus = [dic objectForKey:@"redeem"];
  self.buyButtonStatus = [dic objectForKey:@"purchase"];
}
+ (void)getButtonStatusOfRedeemAndBuyWithFundId:(NSString *)fundId
                                   withCallback:(HttpRequestCallBack *)callback{
  NSDictionary *dict = @{@"fundid" : fundId};
  NSString *path = [NSString stringWithFormat:@"%@financeMarketWeb/financeMarket/toFundDetail", IP_HTTP_SHOPPING];
  [[WebServiceManager sharedManager]NetworkRequestsWithPath:path andDic:dict andType:RFRequestMethodPost andCompletion:^(NSDictionary *response) {
    RedeemAndBuyStatusItem *item = [[RedeemAndBuyStatusItem alloc]init];
    [item jsonToObject:response];
  }];
}

@end
