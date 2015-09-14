//
//  MyOptionalShareManager.m
//  优顾理财
//
//  Created by Mac on 15-5-11.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPMyOptionalShareManager.h"
#import "PlistOperation.h"

#define myOptionalPlistName @"myOptionalHistoryList.plist"

@implementation FPMyOptionalShareManager

+ (FPMyOptionalShareManager *)shareManager {
  static FPMyOptionalShareManager *myOptionalInstance = nil;
  static dispatch_once_t predicate;
  dispatch_once(&predicate, ^{
    myOptionalInstance = [[self alloc] init];
  });
  return myOptionalInstance;
}
- (id)init {
  self = [super init];
  if (self) {
    myOptionalCacheArray = [NSMutableArray
        arrayWithArray:
            [NSMutableArray
                arrayWithContentsOfFile:[PlistOperation
                                            getPlistPath:myOptionalPlistName]]];
  }
  return self;
}
/**
 *  我的自选读取缓存
 *  参数
 *  fundname, fundId, netvalue, invsttype, cumvalue, netvaluerate, type
 */

#if 0
- (NSMutableArray *)readItemOfSaved{
  for (NSDictionary *dict in myOptionalCacheArray) {
    /*
    MyOptionalItem *item = [[MyOptionalItem alloc]init];
    item.fundName = dict[@"fundname"];
    item.fundId = dict[@"fundid"];
    item.netValue = dict[@"netvalue"];
    item.invsttype = dict[@"invsttype"];
    item.cumvalue = dict[@"cumvalue"];
    item.netValueRate = dict[@"netvaluerate"];
    item.fundType = dict[@"type"];
    item.isSelected = @"1";
     */
    [myOptionalCacheArray addObject:dict];
  }
  return myOptionalCacheArray;
}
#endif
/** 历史数据判重 */
- (BOOL)judgeDataRepeat:(NSString *)localFundid {
  for (NSDictionary *tempDict in myOptionalCacheArray) {
    NSString *tempFundId = tempDict[@"fundid"];
    tempFundId = [NSString stringWithFormat:@"%d", (int)[tempFundId intValue]];
    NSMutableString *str = [[NSMutableString alloc] initWithString:@"000000"];

    [str replaceCharactersInRange:NSMakeRange(str.length - tempFundId.length,
                                              tempFundId.length)
                       withString:tempFundId];

    if ([str isEqualToString:localFundid]) {
      //已加入自选
      return NO;
    }
  }
  return YES;
}
/** 缓存参数不完整自选信息 */
- (void)saveMyOptionalListWith:(FPFundItem *)item {
  if (!item) {
    return;
  }
  if ([self judgeDataRepeat:item.fundId]) {
    NSMutableDictionary *selectedDict = [[NSMutableDictionary alloc] init];
    selectedDict[@"fundid"] = item.fundId;
    //[selectedDict setObject:item.fundName forKey:@"fundname"];
    [myOptionalCacheArray addObject:selectedDict];
  }
  //输入写入
  [myOptionalCacheArray
      writeToFile:[PlistOperation getPlistPath:myOptionalPlistName]
       atomically:YES];
}
/** 删除一条基金自选 */
- (void)deleteMyOptionalListWithID:(NSString *)tempFundId {
  //是否存在
  if (![self judgeDataRepeat:tempFundId]) {
    NSMutableDictionary *selectedDict = [[NSMutableDictionary alloc] init];
    selectedDict[@"fundid"] = tempFundId;
    [myOptionalCacheArray removeObject:selectedDict];
  }
  //输入写入
  [myOptionalCacheArray
      writeToFile:[PlistOperation getPlistPath:myOptionalPlistName]
       atomically:YES];
}
/**
 *  加载自选数据
 *  参数
 *  fundname, fundId, netvalue, invsttype, cumvalue, netvaluerate, type
 */
- (void)loadMyOptionalData {
  //只请求一次
  if (dataLoadSuccess||[YouGu_User_USerid isEqualToString:@"-1"]||[myOptionalCacheArray count] > 0) {
    return;
  }
  [[WebServiceManager sharedManager]
      loadOptionalListsWithUserId:YouGu_User_USerid
                   withCompletion:^(id response) {
                     if (response && [[response objectForKey:@"status"]
                                         isEqualToString:@"0000"]) {
                       //解析
                       [self bindOptionalListsWithResponse:response];
                       dataLoadSuccess = YES;
                     }
                     else {
                       dataLoadSuccess = NO;
                       NSString *message = [NSString
                           stringWithFormat:@"%@",
                                            [response objectForKey:@"message"]];
                       if (!message || [message length] == 0 ||
                           [message isEqualToString:@"(null)"]) {
                         message = networkFailed;
                       }
                     }
                   }];
}
- (void)bindOptionalListsWithResponse:(NSDictionary *)dict {
  if (myOptionalCacheArray&&[myOptionalCacheArray count] > 0) {
    [myOptionalCacheArray removeAllObjects];
  }
  NSArray *lists = dict[@"result"];
  for (NSDictionary *subDict in lists) {
    NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
    tempDict[@"fundid"] = subDict[@"fundid"];
    [myOptionalCacheArray addObject:tempDict];
  }
  if (myOptionalCacheArray && [myOptionalCacheArray count] > 0) {
    //自选列表写入缓存
    [myOptionalCacheArray
        writeToFile:[PlistOperation getPlistPath:myOptionalPlistName]
         atomically:YES];
  }
}

@end
