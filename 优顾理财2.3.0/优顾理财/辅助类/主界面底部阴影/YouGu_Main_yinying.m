
//
//  YouGu_Main_yinying.m
//  优顾理财
//
//  Created by Mac on 14-4-18.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "YouGu_Main_yinying.h"

@implementation YouGu_Main_yinying

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
    View_1 =
        [[UIView alloc] initWithFrame:CGRectMake(0, 2, 1, self.height - 2)];
    [self addSubview:View_1];

    View_2 =
        [[UIView alloc] initWithFrame:CGRectMake(1, 2, 1, self.height - 2)];
    [self addSubview:View_2];

    View_1.backgroundColor = [Globle colorFromHexRGB:@"d8d8d8"];
    View_2.backgroundColor = [UIColor whiteColor];
  }
  return self;
}

- (void)dealloc {
  [self removeAllSubviews];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
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
