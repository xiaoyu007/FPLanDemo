//
//  FundItem.m
//  优顾理财
//
//  Created by Mac on 15-4-16.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPFundItem.h"
#import "FundListsSqlite.h"

@implementation FPFundItem

- (void)jsonToObject:(NSDictionary *)dict{
  self.fundId = dict[@"fundid"];
  self.fundName = dict[@"fundname"];
  self.pinyin = dict[@"pinyin"];
  self.invstType = [dict[@"invsttype"]stringValue];
  self.incTime = [dict[@"inctime"] stringValue];
  self.incType = [dict[@"inctype"]stringValue];
  self.isSelected = @"0";
}
@end

@implementation FPSearchFundList
- (void)jsonToObject:(NSDictionary *)dict{
  [super jsonToObject:dict];
  NSArray* lists = dict[@"result"];
  _fundLists = [[NSMutableArray alloc] init];
  __block NSString *lastTime;
  [lists enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    FPFundItem *item = [[FPFundItem alloc]init];
    [item jsonToObject:obj];
    //数据库存储
    switch ([item.incType integerValue]) {
      case OperatingTypeAdd:
      case OperatingTypeChange: {
        [_fundLists addObject:item];
      } break;
      case OperatingTypeDelete: {
        [[FundListsSqlite sharedManager] deleteListWithFundName:item.fundName];
      } break;
      default:
        break;
    }
    //记录最后一条数据时间
    if (!lastTime) {
      lastTime = item.incTime;
    }
  }];
  if (_fundLists&&[_fundLists count] > 0) {
    NSString *currentModTime = [[NSUserDefaults standardUserDefaults]objectForKey:@"currentModTime"];
    if ([currentModTime integerValue] == 0 ) {
      //先清除再添加
      [[FundListsSqlite sharedManager] deleteFundLists];
    }
    [[FundListsSqlite sharedManager] saveFundLists:_fundLists];
  }
    if (lastTime) {
      //保存最后刷新时间
      [[NSUserDefaults standardUserDefaults] setObject:lastTime
                                                forKey:@"fundListLastUpdateTime"];
      [[NSUserDefaults standardUserDefaults] synchronize];
  }
}

+ (void)getFundTableWithLastModtime:(NSString *)lastModtime
                      withCallback:(HttpRequestCallBack *)callback{
  NSString *path = [NSString
                    stringWithFormat:
                    @"%@fincenWeb/fund/detail/getModifiedFundTable?lastmodtime=%@",
                    IP_HTTP_SHOPPING_SHOPPING, lastModtime];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[FPSearchFundList class]
             withHttpRequestCallBack:callback];
}

@end