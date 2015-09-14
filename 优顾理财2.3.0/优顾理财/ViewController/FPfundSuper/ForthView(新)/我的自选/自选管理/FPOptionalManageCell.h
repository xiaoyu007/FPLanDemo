//
//  OptionalManageCell.h
//  优顾理财
//
//  Created by Mac on 15-4-21.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 我的自选管理cell */
@interface FPOptionalManageCell : UITableViewCell
///单选按钮
@property(weak, nonatomic) IBOutlet UIButton *radioButton;
/** 背景按钮 */
@property (weak, nonatomic) IBOutlet UIButton *cellBgButton;
/** 对号 */
@property(weak, nonatomic) IBOutlet UIImageView *radioImageView;
///基金名称
@property(weak, nonatomic) IBOutlet UILabel *fundNameLabel;
///基金代码
@property(weak, nonatomic) IBOutlet UILabel *fundIdLabel;
///涨跌榜
@property(weak, nonatomic) IBOutlet UILabel *newestProfitLabel;
///近30日收益
@property(weak, nonatomic) IBOutlet UILabel *priceRateLabel;

/** 单选按钮 */
- (IBAction)radioButtonClicked:(UIButton *)sender;

@end
