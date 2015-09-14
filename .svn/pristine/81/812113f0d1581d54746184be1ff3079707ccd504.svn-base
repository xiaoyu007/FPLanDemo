//
//  UserCenterInfo.h
//  优顾理财
//
//  Created by Mac on 15/9/6.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "BaseRequestObject.h"

@interface UserCenterInfo : JsonRequestObject

/** 总资产 */
@property(nonatomic, strong) NSString *countAssets;
/** 累计盈亏 */
@property(nonatomic, strong) NSString *countProfit;
/** 持仓数 */
@property(nonatomic, strong) NSString *positionNum;
/** 在途交易数 */
@property(nonatomic, strong) NSString *tranNum;
/** 用户姓名 */
@property(nonatomic, strong) NSString *userName;
/** 手机号 */
@property(nonatomic, strong) NSString *mobile;
/** 昨日收益日期 */
@property(nonatomic, strong) NSString *yesterDay;
/** 昨日收益 */
@property(nonatomic, strong) NSString *yesterDayProfit;
/** 自选基金数量 */
@property(nonatomic, strong) NSString *zxNum;

/** 获取用户中心信息 */
+ (void)sendUserCenterRequestWithCallback:(HttpRequestCallBack *)callback;

@end
