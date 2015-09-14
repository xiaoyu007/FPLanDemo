//
//  OpenAccountInfo.m
//  优顾理财
//
//  Created by Mac on 15/6/2.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPOpenAccountInfo.h"
#import "NetLoadingWaitView.h"
#import "FPMyAssetViewController.h"
#import "FPOpenAcountFirstStepViewController.h"
#import "FPConnectBankCardVC.h"
#import "FPSetPasswordViewController.h"

#import "FPRetrieveTradePwViewController.h"
#import "FPRevampTradeViewController.h"
#import "FPPurchaseVC.h"
#import "OnLoginRequestItem.h"
static FPOpenAccountInfo *shareInstance = nil;

@implementation FPOpenAccountInfo

    {
  //**************************************************我的资产界面数据
  ///手机号码
  NSString *mobile;
  ///身份证号码
  NSString *IDCardNum;
  ///姓名
  NSString *nameLabel;

  NSMutableArray *_dataArray;

  //**************************************************跳转申购界面数据
  /**基金名称 */
  NSString *fundNameLabel;
  /** 费率*/
  NSString *feeLabel;
  /** 最少购买金额*/
  NSString *minMoneyLabel;
  /** 银行卡名称*/
  NSString *bankNameLabel;

  /** 基金代码*/
  NSString *fundIdStr;
  /** 用户绑卡ID*/
  NSString *bankIdStr;
  /**  基金类型*/
  NSString *invsttypeStr;

  /**  众禄费率*/
  NSString *netRateLabel;
  /**   存储费率数据*/
  NSMutableArray *mutFeeArray;

  //**************************************************申购界面数据

  //**************************************赎回界面数据
  ///最小赎回份额
  NSString *minredantLabel;
  ///持仓份额
  NSString *balanceLabel;
}
+ (FPOpenAccountInfo *)shareInstance {
  @synchronized(self) {
    if (shareInstance == nil) {
      shareInstance = [[FPOpenAccountInfo alloc] init];
    }
  }
  return shareInstance;
}
- (id)init {
  self = [super init];
  if (self) {
  }
  return self;
}
#pragma mark - 开户判断
///点击我的资产按钮
- (void)myAssetViewController {
  if ([[SimuControl openAcountType] integerValue] == 1) {
    //去我的资产界面
    [self goToMyAssetView];
    return;
  }
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  [NetLoadingWaitView startAnimating];
  //未开户
  [[WebServiceManager sharedManager] sendRequestWithIsOpenWithCompletion:^(NSDictionary *dic) {
    [NetLoadingWaitView stopAnimating];
    if (dic && [[dic objectForKey:@"status"] isEqualToString:@"0000"]) {
      [SimuControl openAcountWithType:@"1"];
      [SimuControl myAssetOpenAcountType:@"1"];
      //去我的资产界面
      [self goToMyAssetView];
    } else {
      NSString *status = [dic objectForKey:@"status"];
      if (status) {
        switch ([status integerValue]) {
        case 1001:
        case 1002:
        case 1003: {
          //去我的资产界面
          [self goToMyAssetView];
        } break;
        default: {
          NSString *message = [NSString stringWithFormat:@"%@", [dic objectForKey:@"message"]];
          if (!message || [message length] == 0 || [message isEqualToString:@"(null)"]) {
            message = networkFailed;
          }
          if (dic && [dic[@"status"] isEqualToString:@"0101"]) {
          } else {
            YouGu_animation_Did_Start(message);
          }
        } break;
        }
      } else {
        //未登录，提示登录
        [FPYouguUtil setAlterViewIsExist:NO];
      }
    }
  }];
}

/*  发送数据请求判断是否开户*/
- (void)openAccountStatusJudgementWithFromPage:(OpenAccountSwitchType)pageType {
  if ([[SimuControl openAcountType] integerValue] == 1) {
    [self switchPageWithType:pageType];
    return;
  }
  [NetLoadingWaitView startAnimating];
  //未开户
  [[WebServiceManager sharedManager] sendRequestWithIsOpenWithCompletion:^(NSDictionary *dic) {
    [NetLoadingWaitView stopAnimating];
    if (dic && [[dic objectForKey:@"status"] isEqualToString:@"0000"]) {
      [SimuControl openAcountWithType:@"1"];
      [self switchPageWithType:pageType];
    } else {
      //未开户
      if (dic && [[dic objectForKey:@"status"] isEqualToString:@"1001"]) {
        if ([SimuControl bingMobileType] == 1) {
          ///去关联银行卡界面
          [self switchPageWithType:OpenAccountSwitchTypeBackCardList];
          return;
        } else {
          ///去开户界面
          [self switchPageWithType:OpenAccountSwitchTypeAccountCenter];
          return;
        }
      }
      ///未绑定银行卡
      if (dic && [[dic objectForKey:@"status"] isEqualToString:@"1002"]) {
        YouGu_animation_Did_Start(@"未绑定银行卡");
        [self switchPageWithType:OpenAccountSwitchTypeBackCardList];
        return;
      }

      ///开户为设置交易密码
      if (dic && [[dic objectForKey:@"status"] isEqualToString:@"1003"]) {
        [self switchPageWithType:OpenAccountSwitchTypeSetPassword];
        return;
      }
      NSString *message = [NSString stringWithFormat:@"%@", [dic objectForKey:@"message"]];
      if (!message || [message length] == 0 || [message isEqualToString:@"(null)"]) {
        message = networkFailed;
      }
      if (dic && [dic[@"status"] isEqualToString:@"0101"]) {
      } else {
        YouGu_animation_Did_Start(message);
      }
      return;
    }
  }];
}
/** 界面跳转 */
- (void)switchPageWithType:(OpenAccountSwitchType)pageType {
  switch (pageType) {
  case OpenAccountSwitchTypeMyAssets: {
    [self goToMyAssetView];
  } break;
  case OpenAccountSwitchTypeAccountCenter: {
    [self goToMyOpenAcount];
  } break;
  case OpenAccountSwitchTypeBackCardList: {
    ///去关联银行卡界面
    [self goToMyConnectionBankVC];
  } break;
  case OpenAccountSwitchTypeSetPassword: {
    ///去设置界面
    [self goToMySetPasswordVC];
  } break;
  case OpenAccountSwitchTypeChangeTradePassword: {
    ///修改交易密码
    [self goToMyRevampTradeView];
  } break;
  case OpenAccountSwitchTypeFindTradePassword: {
    ///去找回交易密码界面
    [self goToMyTradePassword];
  } break;
  case IsopenAccountType: {
    ///去银行卡管理界面
    [self goToBankManageView];
  } break;
  default:
    break;
  }
}

///去银行卡管理界面
- (void)goToBankManageView {
  [[NSNotificationCenter defaultCenter] postNotificationName:@"go_to_bankManage"
                                                      object:self
                                                    userInfo:nil];
}

///修改交易密码
- (void)goToMyRevampTradeView {
  FPRevampTradeViewController *revTVC = [[FPRevampTradeViewController alloc] init];
  [AppDelegate pushViewControllerFromRight:revTVC];
}

///去找回交易密码界面
- (void)goToMyTradePassword {
  FPRetrieveTradePwViewController *ret = [[FPRetrieveTradePwViewController alloc] init];
  [AppDelegate pushViewControllerFromRight:ret];
}

///我的资产界面
- (void)goToMyAssetView {
  //注意：使用完通知后，立即将观察者注销
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  FPMyAssetViewController *myAssets = [[FPMyAssetViewController alloc] init];
  [AppDelegate pushViewControllerFromRight:myAssets];
}

///开户界面
- (void)goToMyOpenAcount {
  FPOpenAcountFirstStepViewController *openVC = [[FPOpenAcountFirstStepViewController alloc] init];
  [AppDelegate pushViewControllerFromRight:openVC];
}

///关联银行卡界面
- (void)goToMyConnectionBankVC {
  UserBindThirdItem *thirdItem = [[UserBindThirdItem alloc] init];
  FPConnectBankCardVC *connVC = [[FPConnectBankCardVC alloc] init];
  /**  绑定的手机号 */
  connVC.iphoneNumber = thirdItem.BindOpenid;
  [AppDelegate pushViewControllerFromRight:connVC];
}

///开户设置银行卡界面
- (void)goToMySetPasswordVC {
  FPSetPasswordViewController *setPasswordVC = [[FPSetPasswordViewController alloc] init];
  [AppDelegate pushViewControllerFromRight:setPasswordVC];
}

//**************************************************跳转申购界面数据
#pragma mark - 申购
/**  跳转申购*/
- (void)openAccountStatusJudgementWithFromPage:(NSString *)userId
                              andCurrentFundId:(NSString *)currentFundID {
  [NetLoadingWaitView startAnimating];
  [[WebServiceManager sharedManager]
      sendRequestWithBuyUserId:userId
                     andFundId:currentFundID
                withCompletion:^(NSDictionary *dic) {
                  [NetLoadingWaitView stopAnimating];
                  if (dic && [[dic objectForKey:@"status"] isEqualToString:@"0000"]) {
                    [SimuControl openAcountWithType:@"1"];
                    // 解析
                    [self showBuyBankListWithResponse:dic];
                  } else {
                    //未开户
                    if (dic && [[dic objectForKey:@"status"] isEqualToString:@"1001"]) {
                      if ([SimuControl bingMobileType] == 1) {
                        ///去关联银行卡界面
                        [self switchPageWithType:OpenAccountSwitchTypeBackCardList];
                        return;
                      } else {
                        ///去开户界面
                        [self switchPageWithType:OpenAccountSwitchTypeAccountCenter];
                        return;
                      }
                    }
                    ///未绑定银行卡
                    if (dic && [[dic objectForKey:@"status"] isEqualToString:@"1002"]) {
                      [self switchPageWithType:OpenAccountSwitchTypeBackCardList];
                      return;
                    }
                    ///开户为设置交易密码
                    if (dic && [[dic objectForKey:@"status"] isEqualToString:@"1003"]) {
                      [self switchPageWithType:OpenAccountSwitchTypeSetPassword];
                      return;
                    }
                    if (dic && [[dic objectForKey:@"status"] isEqualToString:@"1004"]) {
                      YouGu_animation_Did_Start(@"该" @"基金暂不支持购买，请选择其他" @"基金");
                      return;
                    }
                    if (dic && [[dic objectForKey:@"status"] isEqualToString:@"1005"]) {
                      YouGu_animation_Did_Start(@"该" @"基金不在支持购买，请选择其他" @"基金");
                      return;
                    }
                    NSString *message =
                        [NSString stringWithFormat:@"%@", [dic objectForKey:@"message"]];
                    if (!message || [message length] == 0 || [message isEqualToString:@"(null)"]) {
                      message = networkFailed;
                    }
                    if (dic && [dic[@"status"] isEqualToString:@"0101"]) {
                    } else {
                      YouGu_animation_Did_Start(message);
                    }
                    return;
                  }
                }];
}

- (void)showBuyBankListWithResponse:(NSDictionary *)dict {
  _dataArray = [NSMutableArray array];
  mutFeeArray = [NSMutableArray array];
  FPGoToBuyItem *item = [DicToArray parseGoToBuyWithList:dict];
  fundNameLabel = item.fundname;
  //  feeLabel = item.fee;
  minMoneyLabel = item.minPurchaseMoney;
  fundIdStr = item.fundid; //基金代码
  netRateLabel = item.netfee;
  if (mutFeeArray.count > 0) {
    [mutFeeArray removeAllObjects];
  }
  //费率数据
  [mutFeeArray addObjectsFromArray:item.feeLists];
  //    bankNameLabel = item.bankName ;
  if (_dataArray.count > 0) {
    [_dataArray removeAllObjects];
  }
  [_dataArray addObjectsFromArray:item.bankLists];
  if (_dataArray && [_dataArray count] > 0) {
    //申购界面
    [self goToBuyVC];
  }
}
- (void)goToBuyVC {
  FPPurchaseVC *purchaseVC = [[FPPurchaseVC alloc] init];
  purchaseVC.bankArray = [[NSMutableArray alloc] init];
  purchaseVC.mutFeeList = [[NSMutableArray alloc] init];
  purchaseVC.fundName = fundNameLabel;
  purchaseVC.minMoney = minMoneyLabel;
  purchaseVC.fundFeeRate = netRateLabel;
  purchaseVC.fundId = fundIdStr;
  [purchaseVC.bankArray addObjectsFromArray:_dataArray];
  [purchaseVC.mutFeeList addObjectsFromArray:mutFeeArray];
  [AppDelegate pushViewControllerFromRight:purchaseVC];
}
#pragma mark - 赎回
/**  跳转赎回*/
- (void)openAccountStatusJudgementWithFromRedeem:(NSString *)userId
                                andCurrentFundId:(NSString *)currentFundID
                                  andTradeaccoId:(NSString *)tradeacco
                                    withCallBack:(TradeAccountBlock)callback {
  currentBlock = callback;
  /**  基金id*/
  fundIdStr = currentFundID;
  currentTradeAcco = tradeacco;
  [NetLoadingWaitView startAnimating];
  [[WebServiceManager sharedManager]
      sendRequestWithRedeemUserId:userId
                        andFundId:currentFundID
                   andTradeaccoId:tradeacco
                   withCompletion:^(NSDictionary *dic) {
                     [NetLoadingWaitView stopAnimating];
                     if (dic && [[dic objectForKey:@"status"] isEqualToString:@"0000"]) {
                       [SimuControl openAcountWithType:@"1"];
                       [self showRedeemBankListWithResponse:dic];
                     } else {
                       if (dic && [[dic objectForKey:@"status"] isEqualToString:@"1004"]) {
                         YouGu_animation_Did_Start(@"您" @"还"
                                                          @"未申购此产品，不能进行赎回");
                         return;
                       }
                       if (dic && [[dic objectForKey:@"status"] isEqualToString:@"1005"]) {
                         YouGu_animation_Did_Start(@"您" @"还"
                                                          @"未申购此产品，不能进行赎回");
                         return;
                       }
                       //未开户
                       if (dic && [[dic objectForKey:@"status"] isEqualToString:@"1001"]) {
                         if ([SimuControl bingMobileType] == 1) {
                           ///去关联银行卡界面
                           [self switchPageWithType:OpenAccountSwitchTypeBackCardList];
                           return;
                         } else {
                           ///去开户界面
                           [self switchPageWithType:OpenAccountSwitchTypeAccountCenter];
                           return;
                         }
                       }
                       ///未绑定银行卡
                       if (dic && [[dic objectForKey:@"status"] isEqualToString:@"1002"]) {
                         [self switchPageWithType:OpenAccountSwitchTypeBackCardList];
                         return;
                       }
                       ///开户为设置交易密码
                       if (dic && [[dic objectForKey:@"status"] isEqualToString:@"1003"]) {
                         [self switchPageWithType:OpenAccountSwitchTypeSetPassword];
                         return;
                       }
                       NSString *message =
                           [NSString stringWithFormat:@"%@", [dic objectForKey:@"message"]];
                       if (!message || [message length] == 0 ||
                           [message isEqualToString:@"(null)"]) {
                         message = networkFailed;
                         YouGu_animation_Did_Start(message);
                       }
                       YouGu_animation_Did_Start(message);
                       return;
                     }
                   }];
}

///展示赎回界面的数据
- (void)showRedeemBankListWithResponse:(NSDictionary *)dict {
  _dataArray = [[NSMutableArray alloc] init];
  FPJumpRedeemItem *item = [DicToArray parseGoToRedeemWithList:dict];

  fundNameLabel = item.fundname;
  minredantLabel = item.minredamt;
  balanceLabel = item.balance;
  bankNameLabel = item.bankName;
  bankIdStr = item.bankid;

  [self changeToRedeemPageWithRemindStatus:item.isRemind];
}
/** 赎回提醒 */
- (void)changeToRedeemPageWithRemindStatus:(NSString *)isRemind {
  if ([isRemind isEqualToString:@"1"]) {
    UIAlertView *alertView = [
        [UIAlertView alloc] initWithTitle:@"温馨提示"
                                  message:@"赎" @"回产品后，该产品的涨跌提醒将会自" @"动删除，是否继续赎回？"
                                 delegate:self
                        cancelButtonTitle:@"取消"
                        otherButtonTitles:@"确定", nil];
    [alertView show];
  } else {
    ///去赎回页面
    [self goToRedeemVC];
  }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (buttonIndex == 1) {
    ///去赎回页面
    [self goToRedeemVC];
  }
}
- (void)goToRedeemVC {
  FPRedeemVC *redeemVC = [[FPRedeemVC alloc] initWithCallBack:^(BOOL isSuccess) {
    if (isSuccess && currentBlock) {
      currentBlock(YES);
    }
  }];
  redeemVC.fundNameStr = fundNameLabel;
  redeemVC.currentTradeAcco = currentTradeAcco;
  redeemVC.balanceStr = balanceLabel;
  redeemVC.minRedeemStr = minredantLabel;
  redeemVC.bankNameStr = bankNameLabel;
  redeemVC.redemUserbankid = bankIdStr;
  redeemVC.redemFundid = fundIdStr;
  [AppDelegate pushViewControllerFromRight:redeemVC];
}

@end
