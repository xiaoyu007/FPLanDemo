//
//  MyFundItem.h
//  优顾理财
//
//  Created by Mac on 15-4-12.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 我的资产模型 */
@interface FPMyFundItem : NSObject
/** 用户名称 */
@property(nonatomic, strong) NSString *userName;
/** 手机 */
@property(nonatomic, strong) NSString *mobile;
/** 昨天收益 */
@property(nonatomic, strong) NSString *yesterdayProfit;
/** 昨天收益时间 */
@property(nonatomic, strong) NSString *yesterdayProTime;
/** 累计收益 */
@property(nonatomic, strong) NSString *countProfit;
/** 总资产 */
@property(nonatomic, strong) NSString *countAssets;

/** 保存资金明细列表 */
@property(nonatomic, strong) NSMutableArray *fundLists;
/** 基金代码 */
@property(nonatomic, strong) NSString *fundId;
/** 基金名称 */
@property(nonatomic, strong) NSString *fundName;
/** 资产 */
@property(nonatomic, strong) NSString *assets;
/** 盈亏金额 */
@property(nonatomic, strong) NSString *profit;
/** 收益率 */
@property(nonatomic, strong) NSString *profitProp;
/** 是否购买 */
@property(nonatomic, strong) NSString *isBuy;

@end
