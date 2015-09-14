//
//  MyOptionalFundCell.h
//  优顾理财
//
//  Created by Mac on 15-4-19.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 我的自选cell */
@interface FPMyOptionalFundCell : UITableViewCell
/** 基金名称 */
@property(weak, nonatomic) IBOutlet UILabel *fundNameLabel;
/** 最新净值 */
@property(weak, nonatomic) IBOutlet UILabel *NewNetworthLabel;
/** 涨跌幅 */
@property(weak, nonatomic) IBOutlet UILabel *PriceRattingLabel;
/** 近30日收益 */
@property(weak, nonatomic) IBOutlet UILabel *oneMonthProfitLabel;

@end
