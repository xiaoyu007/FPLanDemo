//
//  WaterWaveView.h
//  优顾理财
//
//  Created by Mac on 15/6/18.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterWaveView : UIView {
  ///上层水波颜色
  UIColor *upWaveColor;
  ///下层水波颜色
  UIColor *downWaveColor;
  /**
   *  填充色
   */
  UIColor *_filledColor;
  /**
   *  边框色
   */
  UIColor *_borderColor;
  ///正余弦参数
  CGFloat a, b, space;
  ///变化形式
  BOOL isAddSpace;
  ///定时器
//  NSTimer *timer;
}
///水波高度
@property(nonatomic, assign) CGFloat waveHeight;
@property(nonatomic, strong) NSTimer * timer;
@end
