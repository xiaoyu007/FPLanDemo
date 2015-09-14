//
//  BankStepViewController.m
//  优顾理财
//
//  Created by jhss on 15/5/20.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPBankStepViewController.h"

#define PI 3.14159265358979323846


@implementation FPBankStepViewController {

  CAShapeLayer *solidLine;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.view.backgroundColor = [UIColor clearColor];
  [self createPicture];
}

- (void)createPicture {

  /*
   *画实线圆
   */
  /*
  solidLine =  [CAShapeLayer layer];
  CGMutablePathRef solidPath =  CGPathCreateMutable();
  solidLine.lineWidth = 2.0f ;
  solidLine.strokeColor = [UIColor colorWithRed:0.96f green:0.55f blue:0.30f
  alpha:1.00f].CGColor;
  solidLine.fillColor = [UIColor clearColor].CGColor;
  CGPathAddEllipseInRect(solidPath, nil, CGRectMake(17.0f, 93.0f, 40.0f,
  40.0f));
  solidLine.path = solidPath;
  CGPathRelease(solidPath);
  [self.view.layer addSublayer:solidLine];



  view1 = [[UIView alloc] initWithFrame:CGRectMake(23.5, 99.5, 27, 27)];
  view1.backgroundColor =
  [UIColor colorWithRed:0.96f green:0.55f blue:0.30f alpha:1.00f];
  view1.layer.cornerRadius = 13.5;
  view1.layer.masksToBounds = YES;
  [self.view addSubview:view1];
*/

  //图标1
  _firstStepBGView.layer.cornerRadius = 20;
  _firstStepBGView.layer.masksToBounds = YES;
  _firstStepBGView.layer.borderWidth = 2.0f;
  _firstStepBGView.layer.borderColor = [Globle colorFromHexRGB:customFilledColor].CGColor;
  
  _firstStepInterView.layer.cornerRadius = 13.0f;
  _firstStepInterView.layer.masksToBounds = YES;

  _firstStepImageView.image = [UIImage imageNamed:@"01数字小图标"];

  //图标2
  _secondStepBGView.layer.cornerRadius = 20;
  _secondStepBGView.layer.masksToBounds = YES;
  _secondStepBGView.layer.borderWidth = 2.0f;
  _secondStepBGView.layer.borderColor = [Globle colorFromHexRGB:@"cecece"].CGColor;
 
  _secondStepInterView.layer.cornerRadius = 13.0f;
  _secondStepInterView.layer.masksToBounds = YES;
  
  _secondStepImageView.image = [UIImage imageNamed:@"02数字小图标"];
  
  //图标3
  _thirdStepBGView.layer.cornerRadius = 20;
  _thirdStepBGView.layer.masksToBounds = YES;
  _thirdStepBGView.layer.borderWidth = 2.0f;
  _thirdStepBGView.layer.borderColor = [Globle colorFromHexRGB:@"cecece"].CGColor;
  
  _thirdStepInterView.layer.cornerRadius = 13.0f;
  _thirdStepInterView.layer.masksToBounds = YES;

  _thirdStepImageView.image = [UIImage imageNamed:@"03数字小图标"];
}



@end
