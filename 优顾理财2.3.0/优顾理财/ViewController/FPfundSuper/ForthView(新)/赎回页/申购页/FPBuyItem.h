//
//  BuyItem.h
//  优顾理财
//
//  Created by jhss on 15-4-17.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FPBuyItem : NSObject
///金额
@property(nonatomic, strong) NSString *money;
///基金名称
@property(nonatomic, strong) NSString *fundname;
///银行名称
@property(nonatomic, strong) NSString *bankname;
///申购时间
@property(nonatomic, strong) NSString *purchasedt;
///预计确认时间
@property(nonatomic, strong) NSString *ackdt;

@end
