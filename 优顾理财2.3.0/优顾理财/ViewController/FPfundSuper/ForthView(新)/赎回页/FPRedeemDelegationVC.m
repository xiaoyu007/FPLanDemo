//
//  FPRedeemDelegationVC.m
//  优顾理财
//
//  Created by Mac on 15/7/21.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPRedeemDelegationVC.h"

@implementation FPRedeemDelegationVC

- (id)initWithCallback:(RedeemSuccessCallback)callback {
  self = [super init];
  if (self) {
    currentCallback = callback;
  }
  return self;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  self.topNavView.mainLableString = @"委托成功";
  [self createMainPage];
}
- (void)createMainPage {
  redeemDelVC =
      [[FPRedemDelegationViewController alloc] initWithNibName:@"FPRedemDelegationViewController"
                                                        bundle:nil];
  redeemDelVC.productName = _productName;
  [self addChildViewController:redeemDelVC];
  [self.childView addSubview:redeemDelVC.view];
  ///赎回份额
  redeemDelVC.moneyLabel.text = [NSString stringWithFormat:@"%0.2lf份", [_redeemNum doubleValue]];
  ///银行卡名称及尾号
  redeemDelVC.bankName.text = _bankAndName;
  ///申购时间
  redeemDelVC.timeLabel.text = _buyTime;
  ///预计确认时间
  redeemDelVC.planTimeLabel.text = [NSString stringWithFormat:@"预计赎回确认日期为%@", _planTime];
  ///预计赎回到账时间
  redeemDelVC.finishTimeLabel.text =
      [NSString stringWithFormat:@"到账时间预计为%@(23:59前)", _finishPlanTime];
  [redeemDelVC.backBtn addTarget:self
                          action:@selector(navigationBtn:)
                forControlEvents:UIControlEventTouchUpInside];
}
- (void)leftButtonPress {
  if (currentCallback) {
    currentCallback(YES);
  }
  [super leftButtonPress];
}
///按钮点击事件
- (void)navigationBtn:(UIButton *)btn {
  //释放掉赎回页
  [[NSNotificationCenter defaultCenter] postNotificationName:@"removeFromParentView" object:nil];
  [AppDelegate popViewController:YES];
}

@end
