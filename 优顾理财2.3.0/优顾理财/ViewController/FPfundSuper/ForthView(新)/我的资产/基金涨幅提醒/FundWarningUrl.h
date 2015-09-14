//
//  FundWarningUrl.h
//  优顾理财
//
//  Created by Mac on 15/7/14.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRequestObject.h"
#import "JsonFormatRequester.h"

@interface FPFundInfoItem : JsonRequestObject
/** 基金id */
@property(nonatomic, strong)NSString *fundId;
/** 基金名称 */
@property(nonatomic, strong)NSString *fundName;
/** 投资类型 */
@property(nonatomic, strong)NSString *invstType;
/** 七日年化收益（货币型或理财型） */
@property(nonatomic, strong)NSString *annuYield;
/** 万份收益（货币型或理财型） */
@property(nonatomic, strong)NSString *tenThousandYield;
/** 日收益 */
@property(nonatomic, strong)NSString *dayRate;
/** 单位净值（债券型、股票型或混合型） */
@property(nonatomic, strong)NSString *netValue;
/** 累计净值（债券型、股票型或混合型） */
@property(nonatomic, strong)NSString *cumValue;
/** 净值日（每日净值） */
@property(nonatomic, strong)NSString *valueDate;
/** 周收益 */
@property(nonatomic, strong)NSString *weekRate;
/** 同类周排行 */
@property(nonatomic, strong)NSString *weekRankType;
/** 月收益 */
@property(nonatomic, strong)NSString *monthRate;
/** 同类月排行 */
@property(nonatomic, strong)NSString *monthRankType;
/** 季收益 */
@property(nonatomic, strong)NSString *seasonRate;
/** 同类季排行 */
@property(nonatomic, strong)NSString *seasonRankType;
/** 半年收益 */
@property(nonatomic, strong)NSString *semiRate;
/** 半年收益排行 */
@property(nonatomic, strong)NSString *semiRankType;
/** 年收益 */
@property(nonatomic, strong)NSString *yearRate;
/** 同类年排行 */
@property(nonatomic, strong)NSString *yearRankType;
/** 今年以来的收益 */
@property(nonatomic, strong)NSString *thisYearRate;
/** 同类今年以来排行 */
@property(nonatomic, strong)NSString *thisYearRankType;
/** 成立以来的收益 */
@property(nonatomic, strong)NSString *foundRate;
/** 同类成立以来的排名 */
@property(nonatomic, strong)NSString *foundRankType;
/** 申购状态 */
@property(nonatomic, strong)NSString *redStatus;
/** 赎回状态 */
@property(nonatomic, strong)NSString *buyStatus;
@end

/** 获取用户所有盈亏提醒 */
@interface ProfitAndLossRemindItem : JsonRequestObject

/** 盈利 */
@property(nonatomic, strong)NSNumber *profit;
/** 亏损 */
@property(nonatomic, strong)NSNumber *loss;
/** 盈利率 */
@property(nonatomic, strong)NSNumber *profitRate;
/** 亏损率 */
@property(nonatomic, strong)NSNumber *lossRate;
/** 最新净值 */
@property(nonatomic, strong)NSNumber *netValue;
/** 日涨幅 */
@property(nonatomic, strong)NSNumber *dayRate;
//@end
///** 获取盈亏提醒信息 */
//@interface ProfitAndLossUrl : JsonRequestObject
/** 获取盈亏提醒详细 */
+ (void)getProfitAndLossDetailWithFundId:(NSString *)fundId
                           withTradeacco:(NSString *)tradeacco
                          withCallback:(HttpRequestCallBack *)callback;
@end
#pragma ---基金价格提醒
@interface FundWarningUrl : JsonRequestObject
/** 有fundid获取基金信息 */
+ (void)getFundInfoWithFundId:(NSString *)fundId
                 withCallback:(HttpRequestCallBack *)callback;
@end
@interface FundUserTradeOrdersNumber : JsonRequestObject
@property(nonatomic, strong) NSString * number;
+ (void)getUserTradeOrdersNumberwithCallback:(HttpRequestCallBack *)callback;
@end
@interface ProfitAndLossDetail : JsonRequestObject
+ (void)setProfitAndLossDetailWithBody:(NSDictionary *)dict
                          withCallback:(HttpRequestCallBack *)callback;
@end

@interface FundUserProAndLossRemind : JsonRequestObject
/** 删除盈亏提醒 */
+ (void)deleteUserProAndLossRemindWithId:(NSDictionary *)dict
                          withCallback:(HttpRequestCallBack *)callback;

@end
