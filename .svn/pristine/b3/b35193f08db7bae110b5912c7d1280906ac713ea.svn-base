//
//  OpenAccountInfo.h
//  优顾理财
//
//  Created by Mac on 15/6/2.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FPRedeemVC.h"

typedef NS_ENUM(NSUInteger, OpenAccountSwitchType) {
  /** 我的资产 */
  OpenAccountSwitchTypeMyAssets,
  /** 账户中心 */
  OpenAccountSwitchTypeAccountCenter,
  /** 首页跳转申购 */
  OpenAccountSwitchTypeFundSkipBuy,
  /** 申购 */
  OpenAccountSwitchTypeFundDetailBuy,
  /** 银行卡界面 */
  OpenAccountSwitchTypeBackCardList,
  /** 设置密码 */
  OpenAccountSwitchTypeSetPassword,
  /**  修改交易密码*/
  OpenAccountSwitchTypeChangeTradePassword,
  /**  找回交易密码*/
  OpenAccountSwitchTypeFindTradePassword,
  /**  判断是否开户*/
  IsopenAccountType,
  /**  跳转赎回*/
  OpenAccountSwitchTypeFundDetailRedeem,
};

@interface FPOpenAccountInfo : NSObject<UIAlertViewDelegate> {
  /** 当前交易账号 */
  NSString *currentTradeAcco;
  /** 赎回block */
  TradeAccountBlock currentBlock;
}
+ (FPOpenAccountInfo *)shareInstance;
/**  我的资产*/
- (void)openAccountStatusJudgementWithFromPage:(OpenAccountSwitchType)pageType;

/**  跳转申购*/
- (void)openAccountStatusJudgementWithFromPage:(NSString *)userId
                              andCurrentFundId:(NSString *)currentFundID;

/**  跳转赎回*/
- (void)openAccountStatusJudgementWithFromRedeem:(NSString *)userId
                                andCurrentFundId:(NSString *)currentFundID
                                  andTradeaccoId:(NSString *)tradeacco
                                    withCallBack:(TradeAccountBlock)callback;

///点击我的资产按钮
- (void)myAssetViewController;
@end
