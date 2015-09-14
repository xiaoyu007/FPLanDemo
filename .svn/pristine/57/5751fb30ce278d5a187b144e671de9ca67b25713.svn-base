//
//  GesturePasswordButton.m
//  GesturePassword
//
//  Created by hb on 14-8-23.
//  Copyright (c) 2014年 黑と白の印记. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "FPGesturePasswordButton.h"

#define bounds self.bounds

@implementation FPGesturePasswordButton
@synthesize selected;
@synthesize success;

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
    success = YES;
    [self setBackgroundColor:[UIColor clearColor]];
  }
  return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
  // Drawing code
  CGContextRef context = UIGraphicsGetCurrentContext();

  if (selected) {
    if (success) {
      CGContextSetRGBStrokeColor(context, 0, 226.0f / 255.f, 205.0f / 255.f,
                                 1); //线条颜色
      CGContextSetRGBFillColor(context, 0, 226.0f / 255.f, 205.0f / 255.f, 1);
    } else {
      CGContextSetRGBStrokeColor(context, 255.0f / 255.f, 83.0f / 255.f,
                                 83.0f / 255.f, 1); //线条颜色
      CGContextSetRGBFillColor(context, 255.0f / 255.f, 83.0f / 255.f,
                               83.0f / 255.f, 1);
    }
    //圆心绘制
    float radius = bounds.size.width / 2.0f;
    float ratio = 0.46f; //比例
    CGRect frame = CGRectMake(radius - radius * ratio, radius - radius * ratio,
                              radius * ratio * 2.0f, radius * ratio * 2.0f);

    CGContextAddEllipseInRect(context, frame);
    CGContextFillPath(context);
  } else {
    CGContextSetRGBStrokeColor(context, 1.0f, 1.0f, 1.0f, 0.5f); //线条颜色
  }

  CGContextSetLineWidth(context, 2);
  CGRect frame =
      CGRectMake(2, 2, bounds.size.width - 4, bounds.size.height - 4);
  CGContextAddEllipseInRect(context, frame);
  CGContextStrokePath(context);
  //环形填充色
  if (success) {
    CGContextSetRGBFillColor(context, 30 / 255.f, 175 / 255.f, 235 / 255.f,
                             0.0f);
  } else {
    CGContextSetRGBFillColor(context, 208 / 255.f, 36 / 255.f, 36 / 255.f,
                             0.0f);
  }
  CGContextAddEllipseInRect(context, frame);
  if (selected) {
    CGContextFillPath(context);
  }
}

@end
