//
//  FundShopList.h
//  优顾理财
//
//  Created by Mac on 15-4-7.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRequestObject.h"
#import "JsonFormatRequester.h"

typedef NS_ENUM(NSUInteger, FundListType) {
  /** 7日年化收益率（%）,保留小数点后4位 */
  FundListTypeSevenProfitRate,
  /** 万份年化收益（元）,保留小数点后4位 */
  FundListTypeTenThousandPro,
  /** 近一周收益率（%）,保留小数点后2位 */
  FundListTypeSevenDaysProfitRate,
  /** 近一月收益率（%）,保留小数点后2位 */
  FundListTypeOneMonthProfitRate,
  /** 近三月收益率（%） ,保留小数点后2位 */
  FundListTypeThreeMonthProfitRate,
  /** 近半年收益率（%）,保留小数点后2位 */
  FundListTypeHalfYearProfitRate,
  /** 近一年收益率（%）,保留小数点后2位 */
  FundListTypeOneYearProfitRate,
  /** 今年以来收益率（%）,保留小数点后2位 */
  FundListTypeThisYearProfitRate,
  /** 成立以来收益率（%）,保留小数点后2位 */
  FundListTypeFromCreatingProfitRate,
  
  /** 最低起购门槛（元）,保留小数点后2位,无小数位，就为整数 */
  FundListTypeLowestBuyPrice,
  /** 费率（%）,保留小数点后2位,无小数位，就为整数 */
  FundListTypeFeeRate,
  /** 购买人数（人）,保留整数 */
  FundListTypeNumberOfPeople,
  /** 最新净值（元） ,保留小数点后4位*/
  FundListTypeNewestNetWorth,
  /** 昨日涨跌幅（%）,保留小数点后2位 */
  FundListTypeTomorrowChangeRate,
  /** 累计净值（元）,保留小数点后4位 */
  FundListTypeTotalProfit,
};

/** 基金领域模型 */
@interface FPFieldItem : JsonRequestObject
/** 领域名称 */
@property(strong, nonatomic) NSString *name;
/** 领域值 */
@property(strong, nonatomic) NSString *value;
/** 单位类型 */
@property(nonatomic, strong) NSString *unitType;

@end

/** 基金模型 */
@interface FPFundShopItem : JsonRequestObject <Collectionable>
/** 基金代码 */
@property(nonatomic, strong) NSString *fundid;
/** 基金名称 */
@property(nonatomic, strong) NSString *fundname;
/** 数值类型 */
@property(nonatomic, assign) FundListType fundListType;
/** 投资类型 */
@property(nonatomic, strong) NSString *invsttype;
/** 申购状态 */
@property(nonatomic, strong) NSString *buystatus;
/**  赎回状态*/
@property(nonatomic,strong) NSString *redstatus;
/** 领域 */
@property(nonatomic, strong) NSMutableArray *fields;
@end

/** 基金列表 */
@interface FPFundShopList : JsonRequestObject <Collectionable>
/** 描述 */
@property(nonatomic, strong) NSString *desc;
/** 基金列表 */
@property(nonatomic, strong) NSMutableArray *fundLists;
/** 获取基金列表 */
+ (void)getFundListsWithType:(NSInteger)fundType
               withCallback:(HttpRequestCallBack *)callback;
@end
