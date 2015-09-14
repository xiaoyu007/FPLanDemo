//
//  StockItemView.h
//  优顾理财
//
//  Created by Mac on 15/7/8.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, StockMarketType) {
  GrayColorType = 0,
  RedColorType = 1,
  GreenColorType = 2,
};

@interface StockItemView : UIView
@property (nonatomic) StockMarketType status;
@property (strong, nonatomic) UILabel *titleName;
@property (strong, nonatomic) UILabel *TapePoints;
@property (strong, nonatomic) UILabel *addPoints;
@property (strong, nonatomic) UILabel *addRatio;

//股票行情，数据的颜色问题
- (void)stock_market_color;
@end
