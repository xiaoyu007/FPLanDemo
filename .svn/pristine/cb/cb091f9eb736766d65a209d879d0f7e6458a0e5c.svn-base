//
//  TradeStatusInfo.m
//  优顾理财
//
//  Created by Mac on 15/6/12.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPTradeStatusInfo.h"

@implementation FPTradeStatusInfo

+ (NSString *)getTradeTypeFromFundId:(NSString *)type{
  NSString *path =
  [[NSBundle mainBundle] pathForResource:@"FundTradeTypeCodes.plist"
                                  ofType:nil];
  NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
  return dic[type];
};
+ (NSString *)getTradeStatusFromId:(NSString *)status{
  NSMutableDictionary *statusDict = [@{@"A" : @"已受理", @"B" : @"赎回已确认成功", @"C" : @"已撤单", @"D" : @"已生成申购流水", @"E" : @"申购确认成功", @"F" : @"失败", @"I" : @"处理中", @"K" : @"受理中", @"N" : @"已受理", @"S" : @"成功", @"X" : @"赎回已确认失败", @"Y" : @"已处理", @"Z" : @"生成申购申请失败"} mutableCopy];
  for (NSString *statusId in [statusDict allKeys]) {
    if ([statusId isEqualToString:status]) {
      return statusDict[statusId];
    }
  }
  return @"";
}


@end
