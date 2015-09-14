//
//  FPPurchaseDelegationVC.m
//  优顾理财
//
//  Created by Mac on 15/7/21.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPPurchaseDelegationVC.h"

@interface FPPurchaseDelegationVC ()

@end

@implementation FPPurchaseDelegationVC

- (void)viewDidLoad {
  [super viewDidLoad];
  self.topNavView.mainLableString = @"委托成功";
  [self createMainPageAndRefreshUI];
}
/** 更新界面 */
- (void)createMainPageAndRefreshUI{
  delegateVC = [[FPDelegationViewController alloc]initWithNibName:@"FPDelegationViewController" bundle:nil];
  delegateVC.view.frame = self.childView.bounds;
  [self.childView addSubview:delegateVC.view];
  //银行卡名称及卡号
  delegateVC.cardNameLabel.text = _cardNameAndNumber;
  //购买金额
  delegateVC.moneyNumber.text = [NSString stringWithFormat:@"%@元", _moneyStr];
   delegateVC.nameLabel.text = [NSString stringWithFormat:@"%@(%@)",_productName,_fundIdStr];
  CGSize nameSize = [_productName sizeWithFont:[UIFont systemFontOfSize:15.0f] constrainedToSize:CGSizeMake(windowWidth - 95.0f, 100)];
  delegateVC.nameLabel.height = nameSize.height + 2.0f;
  delegateVC.timeLabel.text = _timeStr;
  //温馨小提示
  delegateVC.downTimeLabel.text = [NSString stringWithFormat:@"基金份额确认日期为%@", _confirmTimeStr];
  [delegateVC.backNameBtn addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)backButtonClicked:(UIButton *)button{
  ///释放掉申购页面
  [[NSNotificationCenter defaultCenter ]postNotificationName:@"removeFromParentView" object:nil];
  [AppDelegate popViewController:YES];
}
@end
