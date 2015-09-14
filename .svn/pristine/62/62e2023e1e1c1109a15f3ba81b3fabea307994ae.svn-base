//
//  WaterWaveView.m
//  优顾理财
//
//  Created by Mac on 15/6/18.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "WaterWaveView.h"

@implementation WaterWaveView
- (void)awakeFromNib {
  return;
  self.backgroundColor = [UIColor clearColor];
  [self initParamerter];
  [_timer setFireDate:[NSDate distantPast]];
}

- (void)initParamerter {
  a = 1.5f;
  b = 0.0f;
  space = 0.01f;
  isAddSpace = NO;

  upWaveColor = [Globle colorFromHexRGB:customFilledColor withAlpha:0.5f];
  downWaveColor = [Globle colorFromHexRGB:customFilledColor withAlpha:0.5f];
  _filledColor = [Globle colorFromHexRGB:@"fea576" withAlpha:0.5f];
  _borderColor = [Globle colorFromHexRGB:@"fec3e3" withAlpha:0.5f];

  _timer = [NSTimer scheduledTimerWithTimeInterval:0.03
                                           target:self
                                         selector:@selector(animateWave)
                                         userInfo:nil
                                          repeats:YES];
}

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [Globle colorFromHexRGB:@"f95f05"];
    [self initParamerter];
  }
  return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    self.backgroundColor = [Globle colorFromHexRGB:@"f95f05"];
    [self initParamerter];

    _waveHeight = 110.0f;
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
  }
  return self;
}
- (void)setHidden:(BOOL)hidden {
  [super setHidden:hidden];
  if (hidden) {
    //关闭定时器
    [_timer setFireDate:[NSDate distantFuture]];
  } else {
    //打开定时器
    [_timer setFireDate:[NSDate distantPast]];
  }
}
- (void)animateWave {
  if (isAddSpace) {
    a += space;
  } else {
    a -= space;
  }

  if (a <= 1) {
    isAddSpace = YES;
  }

  if (a >= 1.5) {
    isAddSpace = NO;
  }

  b += 0.1;

  [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
  //正弦
  [self createWaveLineWithRect:rect
                       withSin:YES
               withFilledColor:_filledColor
               withBorderColor:_borderColor];
  //余弦
  [self createWaveLineWithRect:rect
                       withSin:NO
               withFilledColor:_filledColor
               withBorderColor:_borderColor];
}
- (void)createWaveLineWithRect:(CGRect)rect
                       withSin:(BOOL)isSin
               withFilledColor:(UIColor *)filledColor
               withBorderColor:(UIColor *)borderColor {
  //当前绘图层
  CGContextRef context = UIGraphicsGetCurrentContext();
  //创建path句柄
  CGMutablePathRef path = CGPathCreateMutable();
  //画波纹
  CGContextSetLineWidth(context, 1.0f);
  //填充色
  CGContextSetFillColorWithColor(context, filledColor.CGColor);
  //移动到起始点
  CGPathMoveToPoint(path, nil, 0.0f, _waveHeight);
  CGFloat y = _waveHeight;
  if (isSin) {
    for (float x = 0; x <= windowWidth; x++) {
      y = a * sin(x / 180 * M_PI + 4 * b / M_PI) * 5 + _waveHeight;
      CGPathAddLineToPoint(path, nil, x, y);
    }
  } else {
    for (float x = 0; x <= windowWidth; x++) {
      y = a * cos(x / 180 * M_PI + 4 * b / M_PI) * 5 + _waveHeight;
      CGPathAddLineToPoint(path, nil, x, y);
    }
  }
  CGPathAddLineToPoint(path, nil, rect.size.width, rect.size.height);
  CGPathAddLineToPoint(path, nil, 0, rect.size.height);
  CGPathAddLineToPoint(path, nil, 0, _waveHeight);
  CGContextAddPath(context, path);
  CGContextFillPath(context);
  CGContextDrawPath(context, kCGPathStroke);
  CGPathRelease(path);
}
@end
