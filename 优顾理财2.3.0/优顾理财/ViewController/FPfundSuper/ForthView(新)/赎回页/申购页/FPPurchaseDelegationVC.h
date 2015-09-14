//
//  FPPurchaseDelegationVC.h
//  优顾理财
//
//  Created by Mac on 15/7/21.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPBaseViewController.h"
#import "FPDelegationViewController.h"


@interface FPPurchaseDelegationVC : FPBaseViewController
{
  ///委托成功主界面
  FPDelegationViewController *delegateVC;
}
/** 银行卡及尾号*/
@property(nonatomic, strong) NSString *cardNameAndNumber;
/** 产品名称*/
@property(nonatomic, strong) NSString *productName;
/** 金额*/
@property(nonatomic, strong) NSString *moneyStr;
/** 购买时间*/
@property(nonatomic, strong) NSString *timeStr;
/**  确认时间*/
@property(nonatomic, strong) NSString *confirmTimeStr;
/**  基金代码*/
@property(nonatomic,strong) NSString *fundIdStr;

@end
