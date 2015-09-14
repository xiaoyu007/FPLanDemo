//
//  FundWarningViewController.h
//  优顾理财
//
//  Created by Mac on 15/7/7.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPBaseViewController.h"
#import "FundWarningViewXib.h"

typedef  void (^RemindCallback)(BOOL  isRemind);

@interface FundWarningViewController : FPBaseViewController
{
  /** 提醒主界面 */
  FundWarningViewXib *warningXib;
  /** 当前状态 */
  RemindCallback currentCallback;
}
/** 当前界面基金id */
@property(nonatomic, strong) NSString *currentFundId;
/** 当前基金名称 */
@property(nonatomic, strong)NSString *currentFundName;
/** 当前交易账号 */
@property(nonatomic, strong)NSString *currentTradeacco;
/** 当前购买金额 */
@property(nonatomic, strong)NSString *currentPurchaseAmount;
/** 是否提醒 */
@property(nonatomic, assign)BOOL isRemindStatus;
/**
 *  提醒成功
 *
 *  @param callback 提醒状态判定
 *
 *  @return 提醒界面对象
 */
- (id)initWithCallback:(RemindCallback)callback;

@end
