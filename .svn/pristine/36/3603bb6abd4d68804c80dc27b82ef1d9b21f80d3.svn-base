//
//  FPPurchaseViewController.m
//  优顾理财
//
//  Created by Mac on 15/7/17.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPPurchaseVC.h"
#import "FPFundTradeRuleViewController.h"

@implementation FPPurchaseVC
- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
  [super viewDidLoad];
  self.topNavView.mainLableString = @"申购";
  [self createMainPage];
  [self createRuleButton];
  [self createNotification];
}
/** 创建主界面 */
- (void)createMainPage {
  buyVC = [[FPBuuyViewController alloc] initWithNibName:@"FPBuuyViewController" bundle:nil];
  buyVC.bankNumArray = _bankArray;
  buyVC.mutFeeList = _mutFeeList;
  buyVC.nameLabelStr = _fundName;
  buyVC.buyFundId = _fundId;
  buyVC.buyTextFieldStr = _minMoney;
  buyVC.netRatelabelStr = _fundFeeRate;
  buyVC.view.frame = self.childView.bounds;
  [self.childView addSubview:buyVC.view];
}
/** 创建规则按钮 */
- (void)createRuleButton {
  UIButton *earningRuleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  earningRuleBtn.frame = CGRectMake(windowWidth - 100.0f, 0, 100.0f, 50.0f);
  earningRuleBtn.backgroundColor = [UIColor clearColor];
  [earningRuleBtn setTitle:@"收益规则" forState:UIControlStateNormal];
  [earningRuleBtn setTitleColor:[Globle colorFromHexRGB:customFilledColor]
                       forState:UIControlStateNormal];
  earningRuleBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
  UIImage *highLightImage = [FPYouguUtil createImageWithColor:buttonHighLightColor];
  [earningRuleBtn setBackgroundImage:highLightImage forState:UIControlStateHighlighted];
  [earningRuleBtn addTarget:self
                     action:@selector(showRules)
           forControlEvents:UIControlEventTouchUpInside];
  [self.topNavView addSubview:earningRuleBtn];
}
- (void)showRules {
  FPFundTradeRuleViewController *rule = [[FPFundTradeRuleViewController alloc] init];
  [AppDelegate pushViewControllerFromRight:rule];
}
/** 创建通知 */
- (void)createNotification {
  /** 注册观察者移除子视图*/
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(removeFromParentView)
                                               name:@"removeFromParentView"
                                             object:nil];
}
- (void)removeFromParentView {
  [AppDelegate popViewController:NO];
}
@end
