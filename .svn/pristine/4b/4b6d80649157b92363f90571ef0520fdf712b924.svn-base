//
//  TradeItem.m
//  优顾理财
//
//  Created by jhss on 15-4-16.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

@implementation FPTradeItem


- (void)jsonToObject:(NSDictionary *)dic {
  self.action = dic[@"action"];
  self.fundname = dic[@"fundname"];
  self.money = dic[@"money"];
  self.traderemark = dic[@"traderemark"];
  self.status = dic[@"status"];
  self.time = dic[@"time"];
}
@end

@implementation FPTradeList

- (NSArray *)getArray
{
    return _tradeLists;
}

- (void)jsonToObject:(NSDictionary *)dic {
  [super jsonToObject:dic];
  self.tradeLists = [[NSMutableArray alloc] init];
  NSArray *array = dic[@"result"];
  NSMutableArray *dataArray = [[NSMutableArray alloc] init];
  [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
    FPTradeItem *item = [[FPTradeItem alloc] init];
    [item jsonToObject:obj];
    [dataArray addObject:item];
  }];
  [self.tradeLists addObjectsFromArray:dataArray];
}

+ (void)sendRequestWithTradeWithPageIndex:(NSInteger)pageIndex
                             withPageSize:(NSInteger)pageSize
                             withCallback:(HttpRequestCallBack *)callback {
  NSString *path = [NSString stringWithFormat:@"%@financeMarketWeb/financeMarket/transHis", IP_HTTP_SHOPPING];

  NSString *indexStr = [NSString stringWithFormat:@"%ld", (long)pageIndex];
  NSString *sizeStr = [NSString stringWithFormat:@"%ld", (long)pageSize];
  NSDictionary *dict = @{ @"pageIndex" : indexStr, @"pageSize" : sizeStr };
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"POST"
               withRequestParameters:dict
              withRequestObjectClass:[FPTradeList class]
             withHttpRequestCallBack:callback];
}

+ (void)sendRequestWithTradeWithDic:(NSDictionary *)dic
                             withCallback:(HttpRequestCallBack *)callback {
    
    NSString *path = [NSString stringWithFormat:@"%@financeMarketWeb/financeMarket/transHis", IP_HTTP_SHOPPING];
    JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
    [request asynExecuteWithRequestUrl:path
                     WithRequestMethod:@"POST"
                 withRequestParameters:dic
                withRequestObjectClass:[FPTradeList class]
               withHttpRequestCallBack:callback];
}

@end
