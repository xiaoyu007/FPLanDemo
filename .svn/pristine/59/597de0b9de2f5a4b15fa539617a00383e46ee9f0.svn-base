//
//  OrderButton.m
//  ifengNewsOrderDemo
//
//  Created by zer0 on 14-2-27.
//  Copyright (c) 2014年 zer0. All rights reserved.
//

#import "OrderButton.h"

@implementation OrderButton

@synthesize highlightedColor_1;

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
  }
  return self;
}
+ (id)orderButtonWithViewController:(UIViewController*)vc {
  OrderButton* orderButton = [OrderButton buttonWithType:UIButtonTypeCustom];
  [orderButton setVc:vc];
  [orderButton
      setFrame:CGRectMake(KOrderButtonFrameOriginX, KOrderButtonFrameOriginY,
                          KOrderButtonFrameSizeX, KOrderButtonFrameSizeY)];
  return orderButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
