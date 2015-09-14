//
//  RedemItem.h
//  优顾理财
//
//  Created by jhss on 15-4-17.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FPRedemItem : NSObject

///赎回份额
@property(nonatomic, strong) NSString *money;
///基金名称
@property(nonatomic, strong) NSString *fundname;
///银行名称
@property(nonatomic, strong) NSString *bankname;
///赎回时间
@property(nonatomic, strong) NSString *redeemdt;
///预计确认时间
@property(nonatomic, strong) NSString *exackdt;
///预计赎回到账日期
@property(nonatomic, strong) NSString *transferdt;
/**
 *  提醒状态
 */
@property(nonatomic, strong) NSString *remindStatus;

@end
