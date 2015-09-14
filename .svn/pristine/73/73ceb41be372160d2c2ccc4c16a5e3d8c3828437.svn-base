//
//  UserCenterHeadVC.h
//  优顾理财
//
//  Created by Mac on 15/9/6.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserCenterInfo.h"

@interface UserCenterHeadVC : UIViewController

/** 总资产 */
@property(weak, nonatomic) IBOutlet UILabel *totalAssetLabel;
/** 昨日收益 */
@property(weak, nonatomic) IBOutlet UILabel *yestProfitLabel;
/** 累计收益 */
@property(weak, nonatomic) IBOutlet UILabel *accumulatedProfitLabel;

/** 持仓按钮 */
@property(weak, nonatomic) IBOutlet UIButton *positionButton;
/** 持仓数 */
@property(weak, nonatomic) IBOutlet UILabel *positionNumLabel;
/** 在途交易按钮 */
@property(weak, nonatomic) IBOutlet UIButton *routeTradeButton;
/** 中途交易数 */
@property(weak, nonatomic) IBOutlet UILabel *routeTradeNumLabel;
/** 我的自选按钮 */
@property(weak, nonatomic) IBOutlet UIButton *myOptionButton;
/** 我的自选数 */
@property(weak, nonatomic) IBOutlet UILabel *myOptionNumLabel;
/** 账户管理按钮 */
@property(weak, nonatomic) IBOutlet UIButton *accountButton;
/** 上分割线 */
@property (weak, nonatomic) IBOutlet UIView *upCuttingLineView;
/** 下分割线 */
@property (weak, nonatomic) IBOutlet UIView *downCuttingLineView;

/** 持仓按钮点击 */
- (IBAction)positionButtonClicked:(id)sender;
/** 途中交易按钮点击 */
- (IBAction)routeTradeButtonClicked:(id)sender;
/** 我的自选点击 */
- (IBAction)myOptionButtonClicked:(id)sender;
/** 账户管理按钮点击 */
- (IBAction)accountButtonClicked:(id)sender;
/** 刷新用户数据 */
- (void)refreshUserCenterWithUserCenterInfo:(UserCenterInfo *)info;
@end
