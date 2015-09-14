//
//  TradeTableViewCell.h
//  优顾理财
//
//  Created by jhss on 15-4-12.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FPTradeTableViewCell : UITableViewCell
///产品名称
@property(weak, nonatomic) IBOutlet UILabel *productNameLabel;
///操作
@property(weak, nonatomic) IBOutlet UILabel *operationLabel;
///金额
@property(weak, nonatomic) IBOutlet UILabel *moneyLabel;
///时间
@property(weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
