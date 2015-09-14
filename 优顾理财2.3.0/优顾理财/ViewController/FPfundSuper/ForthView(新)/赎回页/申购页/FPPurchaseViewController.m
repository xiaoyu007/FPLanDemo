//
//  FPPurchaseViewController.m
//  优顾理财
//
//  Created by Mac on 15/7/17.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

@interface FPPurchaseViewController ()

@end

@implementation FPPurchaseViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.topNavView.mainLableString = @"申购";
  [self createMainPage];
  [self createNotification];
}
/** 创建主界面 */
- (void)createMainPage{
  buyVC = [[FPBuuyViewController alloc]initWithNibName:@"FPBuuyViewController" bundle:nil];
  buyVC.bankNumArray = _bankArray;
  buyVC.mutFeeList = _mutFeeList;
  buyVC.nameLabelStr = _fundName;
  buyVC.buyFundId = _fundId;
  buyVC.buyTextFieldStr = _minMoney;
  buyVC.netRatelabelStr = _fundFeeRate;
  [self.childView addSubview:buyVC.view];
}
/** 创建通知 */
- (void)createNotification{
  /** 注册观察者移除子视图*/
  [[NSNotificationCenter defaultCenter]
   addObserver:self
   selector:@selector(removeFromParentView)
   name:@"removeFromParentView"
   object:nil];
}
- (void)removeFromParentView {
  [self removeFromParentViewController];
}
@end
