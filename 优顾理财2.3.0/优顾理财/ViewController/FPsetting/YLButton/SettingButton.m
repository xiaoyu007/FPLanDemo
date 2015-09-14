//
//  SettingButton.m
//  优顾理财
//
//  Created by Mac on 14-3-18.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "SettingButton.h"

@implementation SettingButton

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
    CGRect imageFrame = CGRectMake(0, 0, self.height, self.height);
    UIEdgeInsets imageInset = UIEdgeInsetsMake(0, 0, 0, 20);
    self.imageView.frame = imageFrame;
    self.imageEdgeInsets = imageInset;
    [self setImage:[UIImage imageNamed:@"选择框1_白天"]
          forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"选择框_白天"]
          forState:UIControlStateSelected];
  }
  return self;
}

- (id)initWithFrame:(CGRect)frame andWidth:(float)width {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
    CGRect imageFrame = CGRectMake(0, 0, self.height, self.height);
    UIEdgeInsets imageInset = UIEdgeInsetsMake(0, 10, 0, 0);
    self.imageView.frame = imageFrame;
    self.imageEdgeInsets = imageInset;
    [self setImage:[UIImage imageNamed:@"选择框1_白天"]
          forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"选择框_白天"]
          forState:UIControlStateSelected];
  }
  return self;
}

- (id)initWithFrame:(CGRect)frame andIs_eq:(BOOL)is_eq {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
    CGRect imageFrame = CGRectMake(0, 0, self.height, self.height);
    UIEdgeInsets imageInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.imageView.frame = imageFrame;
    self.imageEdgeInsets = imageInset;
    [self setImage:[UIImage imageNamed:@"选择框1_白天"]
          forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"选择框_白天"]
          forState:UIControlStateSelected];
  }
  return self;
}

- (void)dealloc {
  [self removeAllSubviews];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
