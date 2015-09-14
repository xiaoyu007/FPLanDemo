//
//  FPFundDetailWebVC.h
//  优顾理财
//
//  Created by Mac on 15/7/13.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FPFundDetailWebVC : UIViewController<UIScrollViewDelegate>
/** 顶部视图 */
@property (weak, nonatomic) IBOutlet UIView *topBgView;
/** 顶部分割线 */
@property (weak, nonatomic) IBOutlet UIView *topCuttingLine;
/** 基金走势 */
@property (weak, nonatomic) IBOutlet UIButton *fundTrendButton;
/** 基金概况 */
@property (weak, nonatomic) IBOutlet UIButton *fundProfileButton;
/** 基金经理 */
@property (weak, nonatomic) IBOutlet UIButton *fundManagerButton;
/** 费率 */
@property (weak, nonatomic) IBOutlet UIButton *fundRatingButton;

/** 滚动视图模块 */
@property (weak, nonatomic) IBOutlet UIView *scrollowBgView;
/** 滚动视图 */
@property (weak, nonatomic) IBOutlet UIScrollView *fundDetailScrView;

/** 按钮选择模块 */
@property (weak, nonatomic) IBOutlet UIView *bottomBgView;
/** 底部分割线 */
@property (weak, nonatomic) IBOutlet UIView *bottomCuttingLine;
/** 申购 */
@property (weak, nonatomic) IBOutlet UIButton *buyFundButton;
/** 赎回 */
@property (weak, nonatomic) IBOutlet UIButton *redeemFundButton;
/** 自选按钮 */
@property (weak, nonatomic) IBOutlet UIButton *optionalFundButton;
/** 自选图标 */
@property (weak, nonatomic) IBOutlet UIImageView *optionalImageView;
/** 自选标题 */
@property (weak, nonatomic) IBOutlet UILabel *optionalLabel;
/** 当前基金id */
@property (nonatomic, strong)NSString *currentFundId;
/**  */

/** 基金走势 */
- (IBAction)fundTrendButtonClicked:(id)sender;
/** 基金概况 */
- (IBAction)fundProfileButtonClicked:(id)sender;
/** 基金经理 */
- (IBAction)fundManagerButtonClicked:(id)sender;
/** 费率 */
- (IBAction)fundRatingButtonClicked:(id)sender;
/** 申购 */
- (IBAction)buyFundButtonClicked:(id)sender;
/** 赎回 */
- (IBAction)redeemButtonClicked:(id)sender;
/** 自选 */
- (IBAction)optionalButtonClicked:(id)sender;

/** 切换到费率一栏 */
- (void)switchToFeeRate;

@end
