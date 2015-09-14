//
//  UIButton+CustomButton.m
//  优顾理财
//
//  Created by Mac on 15-4-2.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "UIButton+CustomButton.h"

@implementation UIButton (CustomButton)
/** 圆环 + 文本高亮 */
- (void)setButtonHighlightStateWithTitleColor:(NSString *)titleColor {
  [self setTitleColor:[Globle colorFromHexRGB:titleColor withAlpha:0.5f]
             forState:UIControlStateHighlighted];
  /** 9种触摸手势 */
  /*for (int st = 0; st < 9 ; st++) {
   NSInteger event = 1<< st;
   if (event == UIControlEventTouchDown) {
     [self addTarget:self action:@selector(buttonTouchdown:)
 forControlEvents:event];
   }else{
     [self addTarget:self action:@selector(buttonTouched:)
 forControlEvents:event];
   }
 }*/
  [self addTarget:self
                action:@selector(buttonTouchdown:)
      forControlEvents:UIControlEventTouchDown];
  [self addTarget:self
                action:@selector(buttonTouched:)
      forControlEvents:UIControlEventTouchUpInside];
  [self addTarget:self
                action:@selector(buttonTouched:)
      forControlEvents:UIControlEventTouchUpOutside];
  [self addTarget:self
                action:@selector(buttonTouched:)
      forControlEvents:UIControlEventTouchDragInside];
  [self addTarget:self
                action:@selector(buttonTouched:)
      forControlEvents:UIControlEventTouchDragOutside];
  /* buton手势种类
  UIControlEventTouchDown           = 1 <<  0,      // on all touch downs
  UIControlEventTouchDownRepeat     = 1 <<  1,      // on multiple touchdowns
  (tap count > 1)
  UIControlEventTouchDragInside     = 1 <<  2,
  UIControlEventTouchDragOutside    = 1 <<  3,
  UIControlEventTouchDragEnter      = 1 <<  4,
  UIControlEventTouchDragExit       = 1 <<  5,
  UIControlEventTouchUpInside       = 1 <<  6,
  UIControlEventTouchUpOutside      = 1 <<  7,
  UIControlEventTouchCancel
   */
}
- (void)buttonTouched:(UIButton *)sender {
  UIColor *tempColor = [self titleColorForState:UIControlStateNormal];
  [self.layer setBorderColor:tempColor.CGColor];
}
- (void)buttonTouchdown:(UIButton *)sender {
  UIColor *tempColor = [self titleColorForState:UIControlStateNormal];
  tempColor = [tempColor colorWithAlphaComponent:0.5f];
  [self.layer setBorderColor:tempColor.CGColor];
}
/** 内部填充，标题白色 */
- (void)setButtonHighlightStateWithFilledColor:(NSString *)titleColor {
  UIImage *highlightImage =
      [FPYouguUtil createImageWithColor:[Globle colorFromHexRGB:titleColor]];
  [self setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
  [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
}

@end
