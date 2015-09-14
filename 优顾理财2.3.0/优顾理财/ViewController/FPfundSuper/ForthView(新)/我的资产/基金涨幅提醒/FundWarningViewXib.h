//
//  FundWarningViewController.h
//  优顾理财
//
//  Created by Mac on 15/7/7.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FundWarningUrl.h"

@interface FundWarningViewXib : UIViewController<UITextFieldDelegate>
/** 基金名称 */
@property (weak, nonatomic) IBOutlet UILabel *fundNameLabel;
/** 购买金额 */
@property (weak, nonatomic) IBOutlet UILabel *buyAccountLabel;
/** 最新净值 */
@property (weak, nonatomic) IBOutlet UILabel *theNewestWorthLabel;
/** 日涨幅 */
@property (weak, nonatomic) IBOutlet UILabel *dailyIncreasesLabel;
/** 分割线 */
@property (weak, nonatomic) IBOutlet UIView *cuttingLineView;
/** 分割线高度 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cuttingLineHeight;


/** 盈利背景 */
@property (weak, nonatomic) IBOutlet UIView *addProfitBgView;
/** 盈利金额 */
@property (weak, nonatomic) IBOutlet UITextField *addProfitTextField;
/** 亏损背景 */
@property (weak, nonatomic) IBOutlet UIView *lossProfitBgView;
/** 亏损金额 */
@property (weak, nonatomic) IBOutlet UITextField *lossProfitTextField;
/** 盈利率背景 */
@property (weak, nonatomic) IBOutlet UIView *addProfitRateBgView;
/** 盈利率达 */
@property (weak, nonatomic) IBOutlet UITextField *profitRateAddToTextField;
/** 亏损率背景 */
@property (weak, nonatomic) IBOutlet UIView *lossRateBgView;
/** 亏损率达 */
@property (weak, nonatomic) IBOutlet UITextField *profitRateLossToTextField;

/** 盈利金额开关 */
@property (weak, nonatomic) IBOutlet UISwitch *addSwitch;
/** 亏损金额开关 */
@property (weak, nonatomic) IBOutlet UISwitch *lossSwitch;
/** 盈利率达开关 */
@property (weak, nonatomic) IBOutlet UISwitch *addRateSwitch;
/** 亏损率达开关 */
@property (weak, nonatomic) IBOutlet UISwitch *lossRateSwitch;

/** 当前基金名称 */
@property(nonatomic, strong)NSString *currentFundName;
/** 当前基金id */
@property(nonatomic, strong)NSString *currentFundId;
/** 当前购买金额 */
/**  */
@property(nonatomic, strong)NSString *currentPurchaseAmount;
/** 刷新开关状态 */
- (void)refreshSwitchStatusWithItem:(ProfitAndLossRemindItem *)item;

@end
