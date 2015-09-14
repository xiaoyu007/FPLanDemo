//
//  ExpressTextField.m
//  优顾理财
//
//  Created by Mac on 15-5-9.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "ExpressTextField.h"

@implementation ExpressTextField

/** 起始空隙 */
- (void)setSpaceAtStart {
  UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
  leftView.backgroundColor = [UIColor clearColor];
  self.leftView = leftView;
  self.leftViewMode = UITextFieldViewModeAlways;
  self.contentVerticalAlignment =
      UIControlContentVerticalAlignmentCenter; //垂直居中，6、7适配时存在bug
}

/** 尾部空隙 */
- (void)setSpaceInTheEnd {
  UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
  rightView.backgroundColor = [UIColor clearColor];
  self.rightView = rightView;
  self.rightViewMode = UITextFieldViewModeAlways;
  self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
}

@end
