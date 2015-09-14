//
//  UserCenterHeadVC.m
//  优顾理财
//
//  Created by Mac on 15/9/6.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "UserCenterHeadVC.h"

@interface UserCenterHeadVC ()

@end

@implementation UserCenterHeadVC

- (void)viewDidLoad {
  [super viewDidLoad];
  _upCuttingLineView.height = 0.5f;
  _downCuttingLineView.height = 0.5f;
}
#pragma mark - 用户持仓、在途交易、我的自选、账户管理
/** 持仓按钮点击 */
- (IBAction)positionButtonClicked:(id)sender {
}
/** 途中交易按钮点击 */
- (IBAction)routeTradeButtonClicked:(id)sender {
}
/** 我的自选点击 */
- (IBAction)myOptionButtonClicked:(id)sender {
}
/** 账户管理按钮点击 */
- (IBAction)accountButtonClicked:(id)sender {
}
- (void)refreshUserCenterWithUserCenterInfo:(UserCenterInfo *)info {
  _totalAssetLabel.text = info.countAssets;
  _accumulatedProfitLabel.text = info.countProfit;
  _positionNumLabel.text = info.positionNum;
  _routeTradeNumLabel.text = info.tranNum;
  _yestProfitLabel.text = info.yesterDayProfit;
  _myOptionNumLabel.text = info.zxNum;
}
@end
