//
//  StockMarketTableViewCell.h
//  优顾理财
//
//  Created by Mac on 15/8/31.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StockItemView.h"
#import "Lineview.h"
@interface StockMarketTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *stockView;
@property (weak, nonatomic) IBOutlet StockItemView *stockView1;
@property (weak, nonatomic) IBOutlet StockItemView *stockView2;
@property (weak, nonatomic) IBOutlet StockItemView *stockView3;
@property (weak, nonatomic) IBOutlet UIButton *marketBtn;
@property (weak, nonatomic) IBOutlet Lineview *lineView;
@end
