//
//  StockMarketTableViewCell.m
//  优顾理财
//
//  Created by Mac on 15/8/31.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "StockMarketTableViewCell.h"
#import "Stock_Market_ViewController.h"
#import "YouGuNewsUtil.h"

@implementation StockMarketTableViewCell

- (void)awakeFromNib {
    // Initialization code
  self.layer.masksToBounds=YES;
  [_marketBtn setBackgroundImage:[YouGuNewsUtil imageFromColor:@"000000" alpha:0.5]
                        forState:UIControlStateHighlighted];
  _stockView1.titleName.text = @"上证指数";
  _stockView2.titleName.text = @"深证指数";
  _stockView3.titleName.text = @"创业板指";
  NSMutableArray *array = YouGu_defaults_array(YouGu_stock_market_key);
  if (array && array.count > 0) {
    [self marketRequest:array];
  }  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(refrashStockMarket)
                                               name:@"RefrashStockMarket"
                                             object:nil];
}
-(void)dealloc
{
  [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)refrashStockMarket {
  NSMutableArray *array = (NSMutableArray *)YouGu_defaults_array(YouGu_stock_market_key);
  if (array && array.count > 0) {
    [self marketRequest:array];
  }
}
- (IBAction)StockBtnClick:(id)sender {
  Stock_Market_ViewController *stockVC = [[Stock_Market_ViewController alloc] init];
  [AppDelegate pushViewControllerFromRight:stockVC];
}
//网络请求
- (void)marketRequest:(NSArray *)array {
  for (int i = 0; i < [array count]; i++) {
    NSDictionary *dic = array[i];
    switch (i) {
      case 0: {
        _stockView1.titleName.text = [FPYouguUtil ishave_blank:dic[@"name"]];
        _stockView1.TapePoints.text =
        [NSString stringWithFormat:@"%0.2f", [dic[@"curPrice"] floatValue]];
        
        float change = [dic[@"change"] floatValue];
        if (change == 0) {
          _stockView1.status = GrayColorType;
          _stockView1.addPoints.text =
          [NSString stringWithFormat:@"%0.2f", [dic[@"change"] floatValue]];
          _stockView1.addRatio.text =
          [NSString stringWithFormat:@"%0.2f%%", [dic[@"dataPer"] floatValue]];
        } else if (change > 0) {
          _stockView1.status = RedColorType;
          _stockView1.addPoints.text =
          [NSString stringWithFormat:@"+%0.2f", [dic[@"change"] floatValue]];
          _stockView1.addRatio.text =
          [NSString stringWithFormat:@"+%0.2f%%", [dic[@"dataPer"] floatValue]];
        } else {
          _stockView1.status = GreenColorType;
          _stockView1.addPoints.text =
          [NSString stringWithFormat:@"%0.2f", [dic[@"change"] floatValue]];
          _stockView1.addRatio.text =
          [NSString stringWithFormat:@"%0.2f%%", [dic[@"dataPer"] floatValue]];
        }
        [_stockView1 stock_market_color];
      } break;
      case 1: {
        _stockView2.titleName.text = [FPYouguUtil ishave_blank:dic[@"name"]];
        _stockView2.TapePoints.text =
        [NSString stringWithFormat:@"%0.2f", [dic[@"curPrice"] floatValue]];
        float change = [dic[@"change"] floatValue];
        if (change == 0) {
          _stockView2.status = GrayColorType;
          _stockView2.addPoints.text =
          [NSString stringWithFormat:@"%0.2f", [dic[@"change"] floatValue]];
          _stockView2.addRatio.text =
          [NSString stringWithFormat:@"%0.2f%%", [dic[@"dataPer"] floatValue]];
        } else if (change > 0) {
          _stockView2.status = RedColorType;
          _stockView2.addPoints.text =
          [NSString stringWithFormat:@"+%0.2f", [dic[@"change"] floatValue]];
          _stockView2.addRatio.text =
          [NSString stringWithFormat:@"+%0.2f%%", [dic[@"dataPer"] floatValue]];
        } else {
          _stockView2.status = GreenColorType;
          _stockView2.addPoints.text =
          [NSString stringWithFormat:@"%0.2f", [dic[@"change"] floatValue]];
          _stockView2.addRatio.text =
          [NSString stringWithFormat:@"%0.2f%%", [dic[@"dataPer"] floatValue]];
        }
        [_stockView2 stock_market_color];
      } break;
      case 2: {
        _stockView3.titleName.text = [FPYouguUtil ishave_blank:dic[@"name"]];
        _stockView3.TapePoints.text = [NSString stringWithFormat:@"%0.2f", [[FPYouguUtil ishave_blank:dic[@"curPrice"]] floatValue]];
        float change = [dic[@"change"] floatValue];
        if (change == 0) {
          _stockView3.status = GrayColorType;
          _stockView3.addPoints.text =
          [NSString stringWithFormat:@"%0.2f", [dic[@"change"] floatValue]];
          _stockView3.addRatio.text =
          [NSString stringWithFormat:@"%0.2f%%", [dic[@"dataPer"] floatValue]];
        } else if (change > 0) {
          _stockView3.status = RedColorType;
          _stockView3.addPoints.text =
          [NSString stringWithFormat:@"+%0.2f", [dic[@"change"] floatValue]];
          _stockView3.addRatio.text =
          [NSString stringWithFormat:@"+%0.2f%%", [dic[@"dataPer"] floatValue]];
        } else {
          _stockView3.status = GreenColorType;
          _stockView3.addPoints.text =
          [NSString stringWithFormat:@"%0.2f", [dic[@"change"] floatValue]];
          _stockView3.addRatio.text =
          [NSString stringWithFormat:@"%0.2f%%", [dic[@"dataPer"] floatValue]];
        }
        [_stockView3 stock_market_color];
      } break;
      default:
        break;
    }
  }
}
@end
