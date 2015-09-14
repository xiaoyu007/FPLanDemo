//
//  FPRedeemDelegationVC.h
//  优顾理财
//
//  Created by Mac on 15/7/21.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPBaseViewController.h"
#import "FPRedemDelegationViewController.h"

typedef void (^RedeemSuccessCallback)(BOOL isRedeemSuccess);

@interface FPRedeemDelegationVC : FPBaseViewController
{
  /** 赎回主界面 */
  FPRedemDelegationViewController *redeemDelVC;
  /** 赎回成功回调 */
  RedeemSuccessCallback currentCallback;
  
}
///银行卡名称及尾号
@property(nonatomic, strong) NSString *bankAndName;
///赎回份额
@property(nonatomic, strong) NSString *redeemNum;
///产品名称
@property(nonatomic, strong) NSString *productName;
///购买时间
@property(nonatomic, strong) NSString *buyTime;
///预计确认时间
@property(nonatomic, strong) NSString *planTime;
///预计到账时间
@property(nonatomic, strong) NSString *finishPlanTime;
/**  基金代码*/
@property(nonatomic,strong)NSString *fundIdStr;
/** 初始化 */
- (id)initWithCallback:(RedeemSuccessCallback)callback;

@end
