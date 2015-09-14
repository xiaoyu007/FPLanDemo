
//  YGButton.m
//  优顾理财
//
//  Created by Mac on 15/3/25.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//
#import "YGButton.h"
#import "Macro.h"

#define PLUS_SYMBOL_CENTER                                                     \
  CGPointMake(self.frame.size.width / 6, self.frame.size.height / 2)
#define PLUS_SYMBOL_COLOR [UIColor whiteColor]

@implementation YGButton

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  self.backgroundColor = YGORANG_CORLOR;

  _verticalView =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width / 8,
                                               self.frame.size.height / 8)];
  _verticalView.center = PLUS_SYMBOL_CENTER;
  _verticalView.backgroundColor = PLUS_SYMBOL_COLOR;
  [self addSubview:_verticalView];

  _horizontalView =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width / 30,
                                               self.frame.size.height * 3 / 6)];
  _horizontalView.center = PLUS_SYMBOL_CENTER;

  _horizontalView.backgroundColor = PLUS_SYMBOL_COLOR;
  [self addSubview:_horizontalView];
  self.layer.cornerRadius = self.frame.size.height / 2;

  return self;
}

@end
