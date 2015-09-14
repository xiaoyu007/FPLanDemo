//
//  StockItemView.m
//  优顾理财
//
//  Created by Mac on 15/7/8.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "StockItemView.h"

@implementation StockItemView

-(id)initWithCoder:(NSCoder *)aDecoder
{
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self start];
  }
  return self;
}

-(void)awakeFromNib
{
  [super awakeFromNib];
  [self stock_market_color];
}
- (void)start {
  _titleName = [[UILabel alloc] initWithFrame:CGRectMake(1, 10, self.width-2, 20)];
  self.titleName.textAlignment = NSTextAlignmentCenter;
  self.titleName.font = [UIFont systemFontOfSize:15];
  self.titleName.textColor = [Globle colorFromHexRGB:@"bbbbbb"];
  self.titleName.backgroundColor = [Globle colorFromHexRGB:@"656565"];
  [self addSubview:self.titleName];
  
  _TapePoints = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, self.width, 30)];
  self.TapePoints.textAlignment = NSTextAlignmentCenter;
  self.TapePoints.font = [UIFont systemFontOfSize:20];
  self.TapePoints.backgroundColor = [UIColor clearColor];
  self.TapePoints.text = @"0.00";
  [self addSubview:self.TapePoints];
  
  _addPoints =
  [[UILabel alloc] initWithFrame:CGRectMake(0, 60, self.width / 2, 20)];
  self.addPoints.textAlignment = NSTextAlignmentCenter;
  self.addPoints.font = [UIFont systemFontOfSize:10];
  self.addPoints.backgroundColor = [UIColor clearColor];
  self.addPoints.text = @"0.00";
  [self addSubview:self.addPoints];
  
  _addRatio = [[UILabel alloc]
                initWithFrame:CGRectMake(self.width / 2, 60, self.width / 2, 20)];
  self.addRatio.textAlignment = NSTextAlignmentCenter;
  self.addRatio.font = [UIFont systemFontOfSize:10];
  self.addRatio.backgroundColor = [UIColor clearColor];
  self.addRatio.text = @"0.00%";
  [self addSubview:self.addRatio];
}
//股票行情，数据的颜色问题
- (void)stock_market_color {
  self.titleName.textColor = [UIColor whiteColor];
  switch (self.status) {
    case GrayColorType: {
      self.titleName.backgroundColor = [Globle colorFromHexRGB:@"656565"];
      self.TapePoints.textColor = [Globle colorFromHexRGB:@"656565"];
      self.addPoints.textColor = [Globle colorFromHexRGB:@"656565"];
      self.addRatio.textColor = [Globle colorFromHexRGB:@"656565"];
    } break;
    case RedColorType: {
      self.titleName.backgroundColor = [Globle colorFromHexRGB:@"d71919"];
      self.TapePoints.textColor = [Globle colorFromHexRGB:@"d71919"];
      self.addPoints.textColor = [Globle colorFromHexRGB:@"d71919"];
      self.addRatio.textColor = [Globle colorFromHexRGB:@"d71919"];
    } break;
    case GreenColorType: {
      self.titleName.backgroundColor = [Globle colorFromHexRGB:@"158a15"];
      self.TapePoints.textColor = [Globle colorFromHexRGB:@"158a15"];
      self.addPoints.textColor = [Globle colorFromHexRGB:@"158a15"];
      self.addRatio.textColor = [Globle colorFromHexRGB:@"158a15"];
    } break;
    default:
      break;
  }
}

@end
