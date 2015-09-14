//
//  FinacingShopCell.h
//  优顾理财
//
//  Created by Mac on 15-4-1.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPFundShopList.h"



/** 基金列表cell */
@interface FPFinacingShopCell : UITableViewCell {
  
  /** 当前基金ID */
  NSString *currentFundId;
  /** 当前基金名称 */
  NSString *currentFundName;
}
/** 左侧背景按钮 */
@property(weak, nonatomic) IBOutlet UIButton *leftBGButton;
/** 右侧背景按钮 */
@property(weak, nonatomic) IBOutlet UIButton *rightBGButton;
/**左连接线*/
@property(weak, nonatomic) IBOutlet UIView *leftLinkLine;
/** 右连接线 */
@property(weak, nonatomic) IBOutlet UIView *rightLinkLine;
/** 左侧购买按钮 */
@property(weak, nonatomic) IBOutlet UIButton *leftBuyButton;
/** 右购买按钮 */
@property(weak, nonatomic) IBOutlet UIButton *rightBuyButton;
/** 中部圆点 */
@property(weak, nonatomic) IBOutlet UIView *centerCircleView;
/** 左日期 */
@property(weak, nonatomic) IBOutlet UILabel *leftTimeLabel;
/** 左盈利率 */
@property(weak, nonatomic) IBOutlet UILabel *leftProfitRateLabel;
/** 左百分号 */
@property(weak, nonatomic) IBOutlet UILabel *leftPercentLabel;
/** 左股票类型 */
@property(weak, nonatomic) IBOutlet UILabel *leftStockTypeLabel;
/** 右日期 */
@property(weak, nonatomic) IBOutlet UILabel *rightTimeLabel;
/** 右盈利率 */
@property(weak, nonatomic) IBOutlet UILabel *rightProfitRateLabel;
/** 右百分号 */
@property(weak, nonatomic) IBOutlet UILabel *rightPercentLabel;
/** 右股票类型 */
@property(weak, nonatomic) IBOutlet UILabel *rightStockTypeLabel;

/** 左侧显示，右侧隐藏或相反 */
- (void)showLeftView:(BOOL)isHidden;
/** 显示右侧数据 */
- (void)showRightData:(FPFundShopItem *)item;
/** 显示左侧数据 */
- (void)showLeftData:(FPFundShopItem *)item;


@end
