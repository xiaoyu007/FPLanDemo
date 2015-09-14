//
//  circularRingView.m
//  优顾理财
//
//  Created by Mac on 15/7/24.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "circularRingView.h"

@implementation circularRingView

- (id)initWithFrame:(CGRect)frame{
  self = [super initWithFrame:frame];
  if (self) {
    [self createCircularRing];
  }
  return self;
}
- (void)createCircularRing{
  /** 大白圆 */
  bigCircle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
  bigCircle.backgroundColor = [UIColor whiteColor];
  [bigCircle.layer setMasksToBounds:YES];
  [bigCircle.layer setCornerRadius:20.0f];
  [bigCircle.layer setBorderWidth:1.0f];
  [bigCircle.layer setBorderColor:[Globle colorFromHexRGB:customFilledColor].CGColor];
  [self addSubview:bigCircle];
  /** 中间小圆 */
  smallCircle = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 28.0f, 28.0f)];
  smallCircle.backgroundColor = [Globle colorFromHexRGB:customFilledColor];
  [smallCircle.layer setMasksToBounds:YES];
  [smallCircle.layer setCornerRadius:14.0f];
  [self addSubview:smallCircle];
  /** 中间图片部分 */
  imageView = [[UIImageView alloc]initWithFrame:smallCircle.bounds];
  imageView.contentMode = UIViewContentModeScaleAspectFit;
  [smallCircle addSubview:imageView];
}
/** 刷新控件 */
- (void)refreshImageViewWithImageName:(NSString *)imageName
                   withBigCircleColor:(NSString *)bigCircleColor
                 withSmallCircleColor:(NSString *)smallCircleColor{
  if (imageName) {
    imageView.image = [UIImage imageNamed:imageName];
  }
  if (bigCircleColor) {
    bigCircle.backgroundColor = [Globle colorFromHexRGB:bigCircleColor];
  }
  if (smallCircleColor) {
    smallCircle.backgroundColor = [Globle colorFromHexRGB:smallCircleColor];
    [bigCircle.layer setBorderColor:[Globle colorFromHexRGB:smallCircleColor].CGColor];
  }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
