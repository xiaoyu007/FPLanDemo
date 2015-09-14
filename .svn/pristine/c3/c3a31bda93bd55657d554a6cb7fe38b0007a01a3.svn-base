//
//  YouGuOpendingStatus.h
//  优顾理财
//
//  Created by Mac on 14-9-18.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    TradeOpenning=0,
    TradeClosed,
    TradeStatusUnknown,
} TradeStatus;

@interface YouGuOpendingStatus : NSObject


/**
 * 状态码，int类型，-2：非交易日，-1非交易时间，0：交易时间
 */
@property(nonatomic, assign)int result;

/**
 * 状态描述，string类型
 */
@property(nonatomic, copy)NSString *desc;

/**
 * 服务器时间,long类型
 */
@property(nonatomic, assign)long long serverTime;

/**
 * 距离下次开盘的时间，long类型
 */
@property(nonatomic, assign)long long openCountDown;

/**
 * 距离下次收盘时间，long类型
 */
@property(nonatomic, assign)long long closeCountDown;

/**
 * 本次修改时间
 */
@property(nonatomic, assign)long long mtime;


+ (YouGuOpendingStatus *)instance;

/**
 * 发起请求获取最新的交易所状态
 */
-(void)requestExchangeStatus;


/**
 * 获取交易所状态：开市中TradeOpenning，已经闭市TradeClosed，状态未知TradeStatusUnknown
 * 如果返回状态未知，发起请求获取最新的交易所状态
 */
-(TradeStatus) getExchangeStatus;

@end
