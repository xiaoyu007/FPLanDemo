//
//  FPRedemDelegationVC.m
//  优顾理财
//
//  Created by Mac on 15/7/21.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPRedeemVC.h"
#import "FPFundTradeRuleViewController.h"

@implementation FPRedeemVC
- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (id)initWithCallBack:(TradeAccountBlock)callback {
  self = [super init];
  if (self) {
    currentCallback = callback;
  }
  return self;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  self.topNavView.mainLableString = @"赎回";
  [self createMainPageAndRefreshUI];
  [self createRuleButton];
  [self createNotification];
}
/** 创建主界面 */
- (void)createMainPageAndRefreshUI {
  redeemVC = [[FPRedemViewController alloc] initWithNibName:@"FPRedemViewController" bundle:nil];
  redeemVC.currentBlock = currentCallback;
  redeemVC.fundNameStr = _fundNameStr;
  redeemVC.currentTradeAcco = _currentTradeAcco;
  redeemVC.balanceStr = _balanceStr;
  redeemVC.minRedeemStr = _minRedeemStr;
  redeemVC.redemUserbankid = _redemUserbankid;
  redeemVC.redemFundid = _redemFundid;
  [self.childView addSubview:redeemVC.view];
  ///银行卡名称及尾号
  redeemVC.bankNameAndNumLabel.text = _bankNameStr;
}
/** 创建规则按钮 */
- (void)createRuleButton {
  UIButton *earningRuleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  earningRuleBtn.frame = CGRectMake(windowWidth - 100.0f, 0, 100.0f, 50.0f);
  earningRuleBtn.backgroundColor = [UIColor clearColor];
  [earningRuleBtn setTitle:@"取出规则" forState:UIControlStateNormal];
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
