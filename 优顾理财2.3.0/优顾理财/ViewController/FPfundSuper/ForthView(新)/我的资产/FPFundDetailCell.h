//
//  FundDetailCell.h
//  优顾理财
//
//  Created by Mac on 15-4-8.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 资产详情页面 */
@interface FPFundDetailCell : UITableViewCell<UIAlertViewDelegate>

/** 顶部左侧分割线 */
@property (weak, nonatomic) IBOutlet UIImageView *topCuttingLineImageView;
/** 产品名称 */
@property(weak, nonatomic) IBOutlet UILabel *productNameLabel;
/** 资产 */
@property(weak, nonatomic) IBOutlet UILabel *assetsLabel;
/** 持有份额 */
@property (weak, nonatomic) IBOutlet UILabel *holdNumberLabel;

/** 盈亏金额 */
@property(weak, nonatomic) IBOutlet UILabel *proAndLossLabel;
/** 赎回 */
@property(weak, nonatomic) IBOutlet UIButton *redeemButton;
/** 购买 */
@property(weak, nonatomic) IBOutlet UIButton *buyButton;
/** 提醒 */
@property (weak, nonatomic) IBOutlet UIButton *warnButton;

/** 基金id */
@property(nonatomic, strong) NSString *cellFundId;
/** 基金名称 */
@property(nonatomic, strong) NSString *cellFundName;
/** 交易账号 */
@property(nonatomic, strong) NSString *cellTradeacco;
/** 提醒状态 */
@property(nonatomic, assign) BOOL cellRemindStatus;
/** 赎回操作 */
- (IBAction)redeemButtonClicked:(id)sender;
/** 购买操作 */
- (IBAction)buyButtonClicked:(id)sender;
/** 提醒操作 */
- (IBAction)warnButtonClicked:(id)sender;
/** 刷新提醒状态 */
- (void)refreshWarningButtonWithIsRemind:(BOOL)isRemind;
@end
