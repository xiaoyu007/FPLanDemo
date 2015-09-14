//
//  RadioButton.m
//  SimuStock
//
//  Created by jhss_wyz on 15/4/9.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "FPRadioButton.h"

@interface FPRadioButton ()

@property(weak, nonatomic) CAShapeLayer *shapeLayer;

@end

@implementation FPRadioButton

- (void)drawRect:(CGRect)rect {
  self.layer.cornerRadius = self.width / 2;
  self.layer.borderWidth = 1.0;
  self.layer.borderColor = [[Globle colorFromHexRGB:@"f07533"] CGColor];
  //      [Globle colorFromHexRGB:Color_TooltipSureButton].CGColor;
}

- (void)setRadioBtnSelected:(BOOL)radioBtnSelected {
  _radioBtnSelected = radioBtnSelected;

  if (radioBtnSelected) {
    self.shapeLayer.hidden = YES;
  } else {
    self.shapeLayer.hidden = NO;
  }

  self.selected = self.radioBtnSelected;
}

- (CAShapeLayer *)shapeLayer {
  if (_shapeLayer == nil) {
    UIBezierPath *temp_bezierpath = [UIBezierPath
        bezierPathWithArcCenter:CGPointMake(self.width / 2, self.height / 2)
                         radius:self.width / 2 / 25 * 13
                     startAngle:0
                       endAngle:M_PI * 2
                      clockwise:YES];

    CAShapeLayer *temp_shapeLayer = [CAShapeLayer layer];
    temp_shapeLayer.path = temp_bezierpath.CGPath;
    temp_shapeLayer.fillColor = [[Globle colorFromHexRGB:@"f07533"] CGColor];

    //        [[Globle colorFromHexRGB:Color_TooltipSureButton] CGColor];
    _shapeLayer = temp_shapeLayer;
    [self.layer addSublayer:_shapeLayer];
  }
  return _shapeLayer;
}

@end
