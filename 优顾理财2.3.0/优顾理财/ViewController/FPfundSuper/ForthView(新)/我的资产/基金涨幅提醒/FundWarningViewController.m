//
//  FundWarningViewController.m
//  优顾理财
//
//  Created by Mac on 15/7/7.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FundWarningViewController.h"

@implementation FundWarningViewController

- (id)initWithCallback:(RemindCallback)callback {
  self = [super init];
  if (self) {
    currentCallback = callback;
  }
  return self;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  self.loading.hidden = YES;
  self.topNavView.mainLableString = @"提醒设置";
  [self createSumitButton];
  warningXib = [[FundWarningViewXib alloc] initWithNibName:@"FundWarningViewXib" bundle:nil];
  warningXib.currentFundName = _currentFundName;
  warningXib.currentFundId = _currentFundId;
  warningXib.currentPurchaseAmount = _currentPurchaseAmount;
  self.childView.clipsToBounds = YES;
  [self.childView addSubview:warningXib.view];
  [self getRemindInfoWithFundId:_currentFundId];
}
#pragma mark - 获取提醒信息
/** 由fundid得到基金信息 */
- (void)getRemindInfoWithFundId:(NSString *)fundId {
  HttpRequestCallBack *callback = [[HttpRequestCallBack alloc] init];
  callback.onSuccess = ^(NSObject *obj) {
    ProfitAndLossRemindItem *item = (ProfitAndLossRemindItem *)obj;
    if (item) {
      [warningXib refreshSwitchStatusWithItem:item];
    }
  };
  [ProfitAndLossRemindItem getProfitAndLossDetailWithFundId:fundId
                                              withTradeacco:_currentTradeacco
                                               withCallback:callback];
}
#pragma mark - sumit
/** 提交按钮 */
- (void)createSumitButton {
  UIButton *sumitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  sumitBtn.frame = CGRectMake(windowWidth - 80, 0, 80, 50);
  sumitBtn.backgroundColor = [UIColor clearColor];
  [sumitBtn setTitle:@"提交" forState:UIControlStateNormal];
  [sumitBtn setTitleColor:[Globle colorFromHexRGB:customFilledColor] forState:UIControlStateNormal];
  [sumitBtn setTitleColor:[Globle colorFromHexRGB:customFilledColor]
                 forState:UIControlStateHighlighted];
  UIImage *highLightImage = [FPYouguUtil createImageWithColor:buttonHighLightColor];
  [sumitBtn setBackgroundImage:highLightImage forState:UIControlStateHighlighted];
  [sumitBtn addTarget:self
                action:@selector(sumitSettingData:)
      forControlEvents:UIControlEventTouchUpInside];
  [self.topNavView addSubview:sumitBtn];
}
/** 提交 */
- (void)sumitSettingData:(id)sender {
  NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
  //    NSDictionary *dict = @{@"fundid": _currentFundId, @"tradeacco" :_currentTradeacco};
  dict[@"fundid"] = _currentFundId;
  dict[@"tradeacco"] = _currentTradeacco;
  //收益
  CGFloat pro = [warningXib.addProfitTextField.text floatValue];
  if (!warningXib.addSwitch.on || pro == 0) {
    dict[@"profit"] = @"0";
  } else {
    dict[@"profit"] = warningXib.addProfitTextField.text;
  }
  //亏损
  CGFloat loss = [warningXib.lossProfitTextField.text floatValue];
  if (!warningXib.lossSwitch.on || loss == 0) {
    dict[@"loss"] = @"0";
  } else {
    dict[@"loss"] = warningXib.lossProfitTextField.text;
  }
  //盈利达
  CGFloat proRate = [warningXib.profitRateAddToTextField.text floatValue];
  if (!warningXib.addRateSwitch.on || proRate == 0) {
    dict[@"profitRate"] = @"0";
  } else {
    dict[@"profitRate"] = warningXib.profitRateAddToTextField.text;
  }
  //亏损达
  CGFloat lossRate = [warningXib.profitRateLossToTextField.text floatValue];
  if (!warningXib.lossRateSwitch.on || lossRate == 0) {
    dict[@"lossRate"] = @"0";
  } else {
    dict[@"lossRate"] = warningXib.profitRateLossToTextField.text;
  }
  //删除提醒
  if ([self isClearRemind]) {
    return;
  }
  
  if ((pro == 0 && warningXib.addSwitch.on) || (loss == 0 && warningXib.lossSwitch.on) ||
      (proRate == 0 && warningXib.addRateSwitch.on) || (lossRate == 0 && warningXib.lossRateSwitch.on)) {
    if (warningXib.addProfitTextField.text.length == 0) {
      YouGu_animation_Did_Start(@"提醒设置不能为空，请您重新输入");
    } else {
      YouGu_animation_Did_Start(@"提醒设置不能为0，请您重新输入");
    }
    return;
  }
  //预判断:当亏损金额大于购买金额时
  if ((loss > [_currentPurchaseAmount floatValue]) && warningXib.lossSwitch.on) {
    YouGu_animation_Did_Start(@"您所输入的亏损金额有误，请重新输入");
    return;
  }
  //用户填写的亏损率大于-100%时
  if (lossRate > 100 && warningXib.lossRateSwitch.on) {
    YouGu_animation_Did_Start(@"您所输入的亏损率有误，请重新输入");
    return;
  }

  HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
  __weak FundWarningViewController *weakSelf = self;
  callBack.onSuccess = ^(NSObject *obj) {
    FundWarningViewController *strongSelf = weakSelf;
    if (strongSelf) {
      YouGu_animation_Did_Start(@"已成功设置盈亏提醒");
      if (currentCallback) {
        currentCallback(YES);
        _isRemindStatus = YES;
      }
      [AppDelegate popViewController:YES];
    }
  };
  [ProfitAndLossDetail setProfitAndLossDetailWithBody:dict withCallback:callBack];
}
/**
 *  所有开关关闭时，删除提醒
 *
 *  @return 是否全部关闭
 */
- (BOOL)isClearRemind {
  if (!warningXib.addSwitch.on && !warningXib.lossSwitch.on && !warningXib.addRateSwitch.on &&
      !warningXib.lossRateSwitch.on ) {
    if (_isRemindStatus) {
      NSDictionary *dict = @{ @"fundid" : _currentFundId, @"tradeacco" : _currentTradeacco };
      HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
      __weak FundWarningViewController *weakSelf = self;
      callBack.onSuccess = ^(NSObject *obj) {
        FundWarningViewController *strongSelf = weakSelf;
        if (strongSelf) {
          if (currentCallback) {
            currentCallback(NO);
            YouGu_animation_Did_Start(@"提醒删除成功");
            [AppDelegate popViewController:YES];
          }
        }
      };
      [FundUserProAndLossRemind deleteUserProAndLossRemindWithId:dict withCallback:callBack];
    }else{
      if (warningXib.addProfitTextField.text.length == 0) {
        YouGu_animation_Did_Start(@"提醒设置不能为空，请您重新输入");
      } else {
        YouGu_animation_Did_Start(@"提醒设置不能为0，请您重新输入");
      }
    }
    return YES;
  } else {
    return NO;
  }
}

@end
