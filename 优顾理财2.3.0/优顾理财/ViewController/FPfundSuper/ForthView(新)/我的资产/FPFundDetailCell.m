//
//  FundDetailCell.m
//  优顾理财
//
//  Created by Mac on 15-4-8.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPFundDetailCell.h"
#import "UIButton+CustomButton.h"
#import "FPFundDetailedViewController.h"
#import "FPFinishOpenAcountViewController.h"
#import "FPOpenAccountInfo.h"
#import "FundWarningViewController.h"

#define cellButtonColor @"f07533"

@implementation FPFundDetailCell
- (void)awakeFromNib {
  _topCuttingLineImageView.image = [FPYouguUtil createImageWithColor:[Globle colorFromHexRGB:customFilledColor]];
  //赎回
  [_redeemButton.layer setBorderWidth:1.0f];
  [_redeemButton.layer
      setBorderColor:[Globle colorFromHexRGB:cellButtonColor].CGColor];
  [_redeemButton.layer setMasksToBounds:YES];
  [_redeemButton.layer setCornerRadius:15.0f];
  [_redeemButton setButtonHighlightStateWithFilledColor:cellButtonColor];
  //购买
  [_buyButton.layer setBorderWidth:1.0f];
  [_buyButton.layer
      setBorderColor:[Globle colorFromHexRGB:cellButtonColor].CGColor];
  [_buyButton.layer setMasksToBounds:YES];
  [_buyButton.layer setCornerRadius:15.0f];
  [_buyButton setButtonHighlightStateWithFilledColor:cellButtonColor];
  //提醒
  [_warnButton.layer setBorderWidth:1.0f];
  [_warnButton.layer
   setBorderColor:[Globle colorFromHexRGB:cellButtonColor].CGColor];
  [_warnButton.layer setMasksToBounds:YES];
  [_warnButton.layer setCornerRadius:15.0f];
  //按下
  [_warnButton setButtonHighlightStateWithFilledColor:cellButtonColor];
}
/** 刷新提醒状态 */
- (void)refreshWarningButtonWithIsRemind:(BOOL)isRemind{
  if (isRemind) {
    [_warnButton setImage:[UIImage imageNamed:@"基金提醒小图标"] forState:UIControlStateNormal];
    [_warnButton setTitle:@"提醒" forState:UIControlStateNormal];
  }else{
    [_warnButton setImage:nil forState:UIControlStateNormal];
    [_warnButton setTitle:@"提醒" forState:UIControlStateNormal];
  }
}
- (IBAction)redeemButtonClicked:(id)sender {
  [self redeemClickBtn];
}
///开户完成后继续跳转赎回
-(void)redeemBtn{
   [[FPOpenAccountInfo shareInstance]openAccountStatusJudgementWithFromRedeem:YouGu_User_USerid andCurrentFundId:_cellFundId andTradeaccoId:_cellTradeacco withCallBack:^(BOOL isSuccess) {
   }];
}
- (IBAction)buyButtonClicked:(id)sender {
  ///点击申购按钮
  [self buyClickBtn];
  
}
///点击申购按钮
-(void)buyClickBtn{
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  //申购回调
  [FPFinishOpenAcountViewController  checkOpenAcountStatusWithCallback:^(BOOL openSuccessCallback) {
    [self rightBuyBtn];
  }];
  [Login_ViewController checkLoginStatusWithCallback:^(BOOL logonSuccess) {
    if (logonSuccess) {
      if ([SimuControl OnLoginType] == 1) {
        [[FPOpenAccountInfo shareInstance]openAccountStatusJudgementWithFromPage:YouGu_User_USerid andCurrentFundId:_cellFundId];
      }
    }
  }];
}
///点击赎回按钮
-(void)redeemClickBtn{
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  //赎回回调
  [FPFinishOpenAcountViewController  checkOpenAcountStatusWithCallback:^(BOOL openSuccessCallback) {
    [self redeemBtn];
  }];
  [Login_ViewController checkLoginStatusWithCallback:^(BOOL logonSuccess) {
    if (logonSuccess) {
      if ([SimuControl OnLoginType] == 1) {
        __weak FPFundDetailCell *weakSelf = self;
        [[FPOpenAccountInfo shareInstance]openAccountStatusJudgementWithFromRedeem:YouGu_User_USerid andCurrentFundId:_cellFundId andTradeaccoId:_cellTradeacco withCallBack:^(BOOL isSuccess) {
          if (isSuccess) {
            FPFundDetailCell *strongSelf = weakSelf;
            if (strongSelf) {
              if (isSuccess) {
                [strongSelf refreshWarningButtonWithIsRemind:NO];
              }
            }
          }
        }];
      }
    }
  }];
}
///开户完成后继续跳转购买
-(void)rightBuyBtn{
  /**   验证用户是否开户，跳转相应的界面*/
  [[FPOpenAccountInfo shareInstance]openAccountStatusJudgementWithFromPage:YouGu_User_USerid andCurrentFundId:_cellFundId];
}
/** 提醒按钮点击 */
- (IBAction)warnButtonClicked:(id)sender {
  __weak FPFundDetailCell *weakSelf = self;
  FundWarningViewController *warning = [[FundWarningViewController alloc]initWithCallback:^(BOOL isRemind) {
    FPFundDetailCell *strongSelf = weakSelf;
    if (strongSelf) {
      _cellRemindStatus = isRemind;
      [strongSelf refreshWarningButtonWithIsRemind:isRemind];
    }
  }];
  warning.currentFundId = _cellFundId;
  warning.currentFundName = _cellFundName;
  warning.currentTradeacco = _cellTradeacco;
  warning.currentPurchaseAmount = _assetsLabel.text;
  warning.isRemindStatus = _cellRemindStatus;
  [AppDelegate pushViewControllerFromRight:warning];
}
@end
