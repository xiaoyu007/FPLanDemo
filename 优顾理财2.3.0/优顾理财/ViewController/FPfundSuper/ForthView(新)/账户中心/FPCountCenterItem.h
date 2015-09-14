//
//  CountCenterItem.h
//  优顾理财
//
//  Created by jhss on 15-5-5.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FPCountCenterItem : NSObject
///身份证号
@property(nonatomic, strong) NSString *idno;
///手机号
@property(nonatomic, strong) NSString *mobile;
///真实姓名
@property(nonatomic, strong) NSString *name;

@property(nonatomic, strong) NSMutableArray *bankList;
///银行卡代码
@property(nonatomic, strong) NSString *no;
//@property(nonatomic,strong)NSString *name;
///银行卡号
@property(nonatomic, strong) NSString *bankacco;
///银行logo
@property(nonatomic, strong) NSString *logo;
///第三方标识
@property(nonatomic, strong) NSString *partnerid;

@end
