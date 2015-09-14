//
//  RemindLists.h
//  优顾理财
//
//  Created by Mac on 15/7/16.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRequestObject.h"
#import "JsonFormatRequester.h"

@interface RemindItem : NSObject
/** 创建时间 */
@property(nonatomic, strong)NSString *createTime;
/** 主键id */
@property(nonatomic, strong)NSString *primaryId;
/** 基金id */
@property(nonatomic, strong)NSString *fundId;
/** 优顾id */
@property(nonatomic, strong)NSString *userId;
/** 交易账号 */
@property(nonatomic, strong)NSString *tradeAcco;
/** 基金名称 */
@property(nonatomic, strong)NSString *fundName;
/** 盈利 */
@property(nonatomic, strong)NSString *profit;
/** 亏损 */
@property(nonatomic, strong)NSString *loss;
/** 盈利率 */
@property(nonatomic, strong)NSString *profitRate;
/** 亏损率 */
@property(nonatomic, strong)NSString *lossRate;

@end


@interface RemindLists : JsonRequestObject
/** 提醒list */
@property(nonatomic, strong)NSMutableArray *remindLists;

/** 获取用户所有盈亏提醒 */
+ (void)getUserAllProfitAndLossDetailwithCallback:(HttpRequestCallBack *)callback;
/** 删除盈亏提醒 */
+ (void)deleteUserProAndLossRemindWithId:(NSString *)primaryKey
                          withCallback:(HttpRequestCallBack *)callback;

@end
