//
//  FinacingShopCell.m
//  优顾理财
//
//  Created by Mac on 15-4-1.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPFinacingShopCell.h"
//产品详情页
#import "FPFundDetailedViewController.h"
#import "FPFinishOpenAcountViewController.h"
#import "FPOpenAccountInfo.h"

@implementation FPFinacingShopCell {
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
  /**  申购状态*/
  NSString *buyStatusStr;
  /**  赎回状态*/
  NSString *redStatusStr;
  NSMutableArray *_dataArray;
  BOOL *isBuyClick;
  
}

- (void)awakeFromNib {
  [_centerCircleView.layer setBorderWidth:2.0f];
  [_centerCircleView.layer setBorderColor:[UIColor whiteColor].CGColor];
  [_centerCircleView.layer setMasksToBounds:YES];
  [_centerCircleView.layer setCornerRadius:5.0f];
  //背景高亮
  UIImage *bgHighLightImage = [FPYouguUtil
      createImageWithColor:[Globle colorFromHexRGB:@"000000" withAlpha:0.1f]];
  [_leftBGButton setBackgroundImage:bgHighLightImage
                           forState:UIControlStateHighlighted];
  [_rightBGButton setBackgroundImage:bgHighLightImage
                            forState:UIControlStateHighlighted];
  [_leftBGButton addTarget:self
                    action:@selector(clickLeft:)
          forControlEvents:UIControlEventTouchUpInside];
  [_rightBGButton addTarget:self
                     action:@selector(clickRight:)
           forControlEvents:UIControlEventTouchUpInside];
  [_leftBuyButton addTarget:self
                     action:@selector(leftBuyButtonClicked:)
           forControlEvents:UIControlEventTouchUpInside];
  [_rightBuyButton addTarget:self
                      action:@selector(rightBuyButtonClicked:)
            forControlEvents:UIControlEventTouchUpInside];

  _dataArray = [[NSMutableArray alloc] init];
}
- (void)leftBuyButtonClicked:(id)sender {
  [self buyClickBtn];
}

- (void)rightBuyButtonClicked:(id)sender {
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
        [[FPOpenAccountInfo shareInstance]openAccountStatusJudgementWithFromPage:YouGu_User_USerid andCurrentFundId:self->currentFundId];
      }
    }
  }];
}
/**
 *  开户完成后继续跳转购买
 */
-(void)rightBuyBtn{
  /**   验证用户是否开户，，，跳转相应的界面*/
  [[FPOpenAccountInfo shareInstance]openAccountStatusJudgementWithFromPage:YouGu_User_USerid andCurrentFundId:self->currentFundId];
}
- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)clickLeft:(id)sender {
  //产品详情页
  FPFundDetailedViewController *fundDVC =
      [[FPFundDetailedViewController alloc] init];
  fundDVC.currentFundId = currentFundId;
  fundDVC.currentFundName = currentFundName;
  fundDVC.invsttypeStr = invsttypeStr;
  fundDVC.isBuyStr = buyStatusStr;
  fundDVC.isRedStr = redStatusStr;
  fundDVC.isDeatil = NO;
  [AppDelegate pushViewControllerFromRight:fundDVC];
}
- (void)clickRight:(id)sender {
    //产品详情页
  FPFundDetailedViewController *fundDVC =
      [[FPFundDetailedViewController alloc] init];
  fundDVC.currentFundId = currentFundId;
  fundDVC.currentFundName = currentFundName;
  fundDVC.invsttypeStr = invsttypeStr;
  fundDVC.isBuyStr = buyStatusStr;
  fundDVC.isRedStr = redStatusStr;
  fundDVC.isDeatil = NO;
  [AppDelegate pushViewControllerFromRight:fundDVC];
}
- (void)showLeftData:(FPFundShopItem *)item {
  //只显示第一条
  if (item.fields && [item.fields count] > 0) {
    FPFieldItem *fieldItem = [item.fields objectAtIndex:0];
    _leftTimeLabel.text = fieldItem.name;
    //数值过大
    if ([fieldItem.value floatValue] > 99999&&[fieldItem.name isEqualToString:@"最低起购门槛"]) {
      fieldItem.value = [NSString stringWithFormat:@"%ld", (long)[fieldItem.value integerValue]/10000];
      fieldItem.unitType = @"万元";
    }
    _rightProfitRateLabel.text = fieldItem.value;
    //居中
    CGSize profitSize =
        [fieldItem.value sizeWithFont:[UIFont boldSystemFontOfSize:22.0f]];
    _leftPercentLabel.origin = CGPointMake(_leftProfitRateLabel.center.x +
                                               profitSize.width / 2.0f + 2.0f,
                                           _leftPercentLabel.origin.y);
    _leftProfitRateLabel.text = fieldItem.value;
    if (![fieldItem.name isEqualToString:@"万份年化收益"]&&(![fieldItem.unitType isEqualToString:@"%"]||[fieldItem.name isEqualToString:@"费率"])) {
      _leftPercentLabel.textColor = [Globle colorFromHexRGB:DataZeroColor];
      _leftProfitRateLabel.textColor = [Globle colorFromHexRGB:DataZeroColor];
    }else{
      if ([fieldItem.value floatValue] > 0) {
        _leftProfitRateLabel.textColor = [Globle colorFromHexRGB:DataUpColor];
        _leftPercentLabel.textColor = [Globle colorFromHexRGB:DataUpColor];
      } else if ([fieldItem.value floatValue] == 0) {
        _leftPercentLabel.textColor = [Globle colorFromHexRGB:DataZeroColor];
        _leftProfitRateLabel.textColor = [Globle colorFromHexRGB:DataZeroColor];
      } else {
        _leftPercentLabel.textColor = [Globle colorFromHexRGB:DataDownColor];
        _leftProfitRateLabel.textColor = [Globle colorFromHexRGB:DataDownColor];
      }
    }
    currentFundId = item.fundid;
    currentFundName = item.fundname;
    invsttypeStr = item.invsttype;
    _leftPercentLabel.text = fieldItem.unitType;
    buyStatusStr = item.buystatus;
    redStatusStr = item.redstatus;
  }
  //自适应基金名称高度
  CGSize fontSize = [item.fundname sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(windowWidth/2.0f - 75.0f, 30.0f)];
  CGRect frame = _leftStockTypeLabel.frame;
  _leftStockTypeLabel.frame = CGRectMake(frame.origin.x, frame.origin.y, windowWidth/2.0f - 75.0f, fontSize.height + 2.0f);
  _leftStockTypeLabel.text = item.fundname;
}
- (void)showRightData:(FPFundShopItem *)item {
  //只显示第一条
  if (item.fields && [item.fields count] > 0) {
    FPFieldItem *fieldItem = [item.fields objectAtIndex:0];
    _rightTimeLabel.text = fieldItem.name;
    //数值过大
    if ([fieldItem.value floatValue] > 99999&&[fieldItem.name isEqualToString:@"最低起购门槛"]) {
      fieldItem.value = [NSString stringWithFormat:@"%ld", [fieldItem.value integerValue]/10000];
      fieldItem.unitType = @"万元";
    }
    _rightProfitRateLabel.text = fieldItem.value;
    //居中
    CGSize profitSize =
        [fieldItem.value sizeWithFont:[UIFont boldSystemFontOfSize:22.0f]];
    _rightPercentLabel.origin = CGPointMake(_rightProfitRateLabel.center.x +
                                                profitSize.width / 2.0f + 2.0f,
                                            _rightPercentLabel.origin.y);
    if (![fieldItem.name isEqualToString:@"万份年化收益"]&&(![fieldItem.unitType isEqualToString:@"%"]||[fieldItem.name isEqualToString:@"费率"])) {
      _rightPercentLabel.textColor = [Globle colorFromHexRGB:DataZeroColor];
      _rightProfitRateLabel.textColor = [Globle colorFromHexRGB:DataZeroColor];
    }else{
      if ([fieldItem.value floatValue] > 0) {
        _rightPercentLabel.textColor = [Globle colorFromHexRGB:DataUpColor];
        _rightProfitRateLabel.textColor = [Globle colorFromHexRGB:DataUpColor];
      } else if ([fieldItem.value floatValue] == 0) {
        _rightPercentLabel.textColor = [Globle colorFromHexRGB:DataZeroColor];
        _rightProfitRateLabel.textColor = [Globle colorFromHexRGB:DataZeroColor];
      } else {
        _rightPercentLabel.textColor = [Globle colorFromHexRGB:DataDownColor];
        _rightProfitRateLabel.textColor = [Globle colorFromHexRGB:DataDownColor];
      }
    }
    currentFundId = item.fundid;
    currentFundName = item.fundname;
    invsttypeStr = item.invsttype;
    //单位
    _rightPercentLabel.text = fieldItem.unitType;
    buyStatusStr = item.buystatus;
    redStatusStr = item.redstatus;
  }
  //自适应基金名称高度
  CGSize fontSize = [item.fundname sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(windowWidth/2.0f - 75.0f, 30.0f)];
  CGRect frame = _rightStockTypeLabel.frame;
  _rightStockTypeLabel.frame = CGRectMake(frame.origin.x, frame.origin.y, windowWidth/2.0f - 75.0f, fontSize.height + 2.0f);
  _rightStockTypeLabel.text = item.fundname;
}
- (void)showLeftView:(BOOL)isHidden {
  _leftLinkLine.hidden = !isHidden;
  _leftTimeLabel.hidden = !isHidden;
  _leftProfitRateLabel.hidden = !isHidden;
  _leftPercentLabel.hidden = !isHidden;
  _leftStockTypeLabel.hidden = !isHidden;
  _leftBGButton.hidden = !isHidden;
  _leftBuyButton.hidden = !isHidden;

  _rightLinkLine.hidden = isHidden;
  _rightTimeLabel.hidden = isHidden;
  _rightProfitRateLabel.hidden = isHidden;
  _rightPercentLabel.hidden = isHidden;
  _rightStockTypeLabel.hidden = isHidden;
  _rightBGButton.hidden = isHidden;
  _rightBuyButton.hidden = isHidden;
}

@end
