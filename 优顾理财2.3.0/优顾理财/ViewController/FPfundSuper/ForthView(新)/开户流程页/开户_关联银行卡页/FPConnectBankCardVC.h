//
//  FPConnectBankCardVC.h
//  优顾理财
//
//  Created by Mac on 15/7/24.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPBaseViewController.h"
#import "FPConnectBankCadViewController.h"

@interface FPConnectBankCardVC : FPBaseViewController
{
  //关联银行卡
  FPConnectBankCadViewController *connectBankCardVC;
}
///绑定的手机号
@property(nonatomic,strong) NSString *iphoneNumber;

@end
