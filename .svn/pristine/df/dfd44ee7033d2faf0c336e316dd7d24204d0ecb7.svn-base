//
//  UserLoadingView.m
//  优顾理财
//
//  Created by Mac on 14-4-29.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

@implementation UserLoadingView
@synthesize alter_lable;

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    [self start];
  }
  return self;
}

- (void)start {
  view_context = [[UIView alloc]
      initWithFrame:CGRectMake(windowWidth/2.0f - 50.0f, self.frame.size.height / 2 - 100, 100,
                               100)];
  view_context.layer.cornerRadius = 10;
  view_context.backgroundColor =
      [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5];
  [self addSubview:view_context];

  UIActivityIndicatorView *testActivityIndicator = [
      [UIActivityIndicatorView alloc]
      initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
  testActivityIndicator.frame =
      CGRectMake(30, 15, 40, 40); //只能设置中心，不能设置大小
  [view_context addSubview:testActivityIndicator];
  [testActivityIndicator startAnimating];

  alter_lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 100, 20)];
  alter_lable.textAlignment = NSTextAlignmentCenter;
  alter_lable.font = [UIFont systemFontOfSize:13];
  alter_lable.textColor = [UIColor colorWithRed:220 / 255.0f
                                          green:220 / 255.0
                                           blue:220 / 255.0f
                                          alpha:1.0f];
  alter_lable.backgroundColor = [UIColor clearColor];
  [view_context addSubview:alter_lable];
}

- (void)dealloc {
  [self removeAllSubviews];
}

/*
// Only override drawRect: if you perform(做) custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
