//
//  FileFundListUtil.m
//  优顾理财
//
//  Created by Mac on 15/7/10.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FileFundListUtil.h"

///基金列表
static NSString* const Cache_FundList = @"cacheFundList";

@implementation FileFundListUtil

///存储基金列表
+ (void)saveFundLists:(FPFundShopList*)data withType:(NSInteger)fundType
{
  NSString *key = [NSString stringWithFormat:@"%@#%ld", Cache_FundList, fundType];
  [FileFundListUtil saveCacheData:data withKey:key];
}

///加载基金列表
+ (FPFundShopList*)loadCachedFundListWithType:(NSInteger)fundType
{
   NSString *key = [NSString stringWithFormat:@"%@#%ld", Cache_FundList, fundType];
  return [FileFundListUtil loadCacheWithKey:key
                             withClassType:[FPFundShopList class]];
}

@end
