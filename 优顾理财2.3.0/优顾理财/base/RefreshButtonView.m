//
//  RefreshButtonView.m
//  优顾理财
//
//  Created by Yuemeng on 15/9/9.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "RefreshButtonView.h"

@implementation RefreshButtonView

- (instancetype)initWithSuperView:(UIView *)superView {
  if (self =
          [super initWithFrame:CGRectMake(superView.width - 50, 0, 50, 50)]) {
    [superView addSubview:self];
    [self createUI];
  }
  return self;
}

- (void)createUI {

  _refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
  _refreshButton.frame = self.bounds;
  [_refreshButton setImage:[UIImage imageNamed:@"刷新小图标"]
                  forState:UIControlStateNormal];
  [_refreshButton setImage:[UIImage imageNamed:@"刷新小图标"]
                  forState:UIControlStateHighlighted];
  _refreshButton.imageEdgeInsets = UIEdgeInsetsMake(16.0f, 15.0f, 16.0f, 15.0f);

  __weak RefreshButtonView *weakSelf = self;
  [_refreshButton setOnButtonPressedHandler:^{
    if (weakSelf.refreshButtonPressDownBlock) {
      weakSelf.refreshButtonPressDownBlock();
    }
  }];

  [self addSubview:_refreshButton];

  _indicator = [[UIActivityIndicatorView alloc]
      initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
  _indicator.center = _refreshButton.center;
  _indicator.hidden = YES;
  [self addSubview:_indicator];
}

/** 显示菊花 */
- (void)showIndicator {
  _refreshButton.hidden = YES;
  _indicator.hidden = NO;
  [_indicator startAnimating];
}
/** 隐藏菊花 */
- (void)hiddenIndicator {
  _refreshButton.hidden = NO;
  _indicator.hidden = YES;
  [_indicator stopAnimating];
}

@end
