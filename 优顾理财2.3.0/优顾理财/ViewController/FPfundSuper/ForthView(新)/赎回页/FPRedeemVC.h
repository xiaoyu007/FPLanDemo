//
//  FPRedemDelegationVC.h
//  优顾理财
//
//  Created by Mac on 15/7/21.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPBaseViewController.h"
#import "FPRedemViewController.h"

@interface FPRedeemVC : FPBaseViewController
{
  /** 赎回主界面 */
  FPRedemViewController *redeemVC;
  /** 当前回调 */
  TradeAccountBlock currentCallback;
}
///所选银行卡ID
@property(nonatomic, strong) NSString *redemUserbankid;
///基金代码
@property(nonatomic, strong) NSString *redemFundid;
///基金名称
@property(nonatomic, strong) NSString *fundNameStr;
///持仓份额
@property(nonatomic, strong) NSString *balanceStr;
///最小赎回份额
@property(nonatomic,strong) NSString *minRedeemStr;
///银行卡信息
@property(nonatomic,strong) NSString *bankNameStr;
/** 交易账号 */
@property(nonatomic,strong) NSString *currentTradeAcco;
/**
 *  赎回总控制器
 *
 *  @param callback 是否赎回成功
 *
 *  @return 初始化
 */
- (id)initWithCallBack:(TradeAccountBlock)callback;

@end
