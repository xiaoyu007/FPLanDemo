//
//  FundShopList.m
//  优顾理财
//
//  Created by Mac on 15-4-7.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPFundShopList.h"

@implementation FPFieldItem

- (void)jsonToObject:(NSDictionary*)dict {
  self.name = dict[@"name"];
  self.value = dict[@"value"];
  if ([self.value hasSuffix:@"%"]) {
    self.unitType = @"%";
  } else if ([self.value hasSuffix:@"人"]) {
    self.unitType = @"人";
  } else if ([self.value hasSuffix:@"元"]) {
    self.unitType = @"元";
  } else if ([self.value hasSuffix:@"-"]) {
  } else {
    //其它单位类型
    self.unitType = [self.value substringFromIndex:[self.value length] - 2];
  }
  if ([self.name isEqualToString:@"7日年化收益率"] ||
      [self.name isEqualToString:@"万份年化收益"] ||
      [self.name isEqualToString:@"最新净值"] ||
      [self.name isEqualToString:@"累计净值"]) {
    self.value =
        [NSString stringWithFormat:@"%0.4f", [dict[@"value"] floatValue]];
  } else if ([self.name isEqualToString:@"购买人数"]) {
    self.value =
        [NSString stringWithFormat:@"%ld", (long)[dict[@"value"] integerValue]];
  } else if ([self.name isEqualToString:@"最低起购门槛"] ||
             [self.name isEqualToString:@"费率"]) {
    if ([dict[@"value"] integerValue] == [dict[@"value"] floatValue]) {
      self.value = [NSString
          stringWithFormat:@"%ld", (long)[dict[@"value"] integerValue]];
    } else {
      self.value =
          [NSString stringWithFormat:@"%0.2f", [dict[@"value"] floatValue]];
    }
  } else {
    self.value =
        [NSString stringWithFormat:@"%0.2f", [dict[@"value"] floatValue]];
  }
  //无值情况
  if ([dict[@"value"] hasPrefix:@"--"]) {
    self.value = @"--";
    self.unitType = @"";
  }
}
@end

@implementation FPFundShopItem
- (void)jsonToObject:(NSDictionary*)dict {
  {
    self.buystatus = [dict[@"buystatus"] stringValue];
    self.redstatus = [dict[@"redstatus"] stringValue];
    self.fundid = dict[@"fundid"];
    self.fundname = dict[@"fundname"];
    self.invsttype = [dict[@"invsttype"] stringValue];
    self.fields = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray* fieldArray = [dict objectForKey:@"fields"];
    [fieldArray enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx,
                                             BOOL* stop) {
      FPFieldItem* item = [[FPFieldItem alloc] init];
      [item jsonToObject:obj];
      [self.fields addObject:item];
    }];
  }
}
- (NSArray *)getArray{
  return _fields;
}
///缓存
- (NSDictionary *)mappingDictionary{
  return @{@"fields" : NSStringFromClass([FPFieldItem class])};
}
@end

@implementation FPFundShopList
- (void)jsonToObject:(NSDictionary*)dic {
  [super jsonToObject:dic];
  self.desc = [dic objectForKey:@"desc"];
  _fundLists = [[NSMutableArray alloc] initWithCapacity:0];
  NSArray* lists = dic[@"result"];
  [lists enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx,
                                      BOOL* stop) {
    FPFundShopItem* item = [[FPFundShopItem alloc] init];
    [item jsonToObject:obj];
    [_fundLists addObject:item];
  }];
}

- (NSArray *)getArray{
  return _fundLists;
}
///缓存
- (NSDictionary *)mappingDictionary{
 return @{@"fundLists" : NSStringFromClass([FPFundShopItem class])};
}

+ (void)getFundListsWithType:(NSInteger)fundType
                withCallback:(HttpRequestCallBack*)callback {
  NSString* path =
      [NSString stringWithFormat:@"%@fincenWeb/fund/recomm/list?type=%ld",
                                 IP_HTTP_SHOPPING_SHOPPING, (long)fundType];
  JsonFormatRequester* request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[FPFundShopList class]
             withHttpRequestCallBack:callback];
}

@end