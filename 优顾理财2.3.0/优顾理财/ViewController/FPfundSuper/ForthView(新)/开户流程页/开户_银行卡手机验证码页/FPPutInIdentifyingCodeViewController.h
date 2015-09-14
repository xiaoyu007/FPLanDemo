//
//  PutInIdentifyingCodeViewController.h
//  优顾理财
//
//  Created by Mac on 15/3/19.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//
/**
 
 本类主要是手机验证码类，确认用户的信息
 */
#import "YGBaseViewController.h"

@interface FPPutInIdentifyingCodeViewController : YGBaseViewController
///验证手机号码
@property(nonatomic, strong) NSString *authPhoneTextField;
///银行卡ID
@property(nonatomic, strong) NSString *bankCardId;
///开户流水号
@property(nonatomic, strong) NSString *openNumber;
/** 温馨提示 */
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@end
