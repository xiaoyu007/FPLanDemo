//
//  TriangleView.m
//  优顾理财
//
//  Created by Mac on 14-4-23.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "TriangleView.h"

@implementation TriangleView
@synthesize is_XiaoYou;

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
    [self start];
  }
  return self;
}

- (void)start {
  self.backgroundColor = [UIColor clearColor];

  VIEW_Main = [[UIView alloc]
      initWithFrame:CGRectMake(10, 0, self.width - 10, self.height)];
  [[VIEW_Main layer] setBorderWidth:1];
  VIEW_Main.layer.cornerRadius = 5;
  [self addSubview:VIEW_Main];

  img_View = [[UIImageView alloc] initWithFrame:CGRectMake(1, 0, 13, 12)];
  [self addSubview:img_View];
  
  [self SET_San_background:NO];
}

- (void)dealloc {
  [self removeAllSubviews];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//选择三角箭头的位置
- (void)San_JIAO_Frame:(BOOL)is_left {
  if (!is_left) {
    img_View.transform = CGAffineTransformMakeScale(1, 1);
    img_View.frame = CGRectMake(1, 0, 13, 12);
    VIEW_Main.frame = CGRectMake(10, 0, self.width - 10, self.height);
  } else {
    img_View.transform = CGAffineTransformMakeScale(-1, 1);
    img_View.frame = CGRectMake(self.width - 14, 0, 13, 12);
    VIEW_Main.frame = CGRectMake(0, 0, self.width - 10, self.height);
  }
}

- (void)SAN_IMG_Width:(int)width and_left_right:(BOOL)ishave {
  VIEW_Main.width = width;
  if (ishave == YES) {
    VIEW_Main.left = self.width - width - 10;
  }
}

//选择三角的背景颜色
- (void)SET_San_background:(BOOL)is_User {
    if (is_User) {
      VIEW_Main.backgroundColor = [Globle colorFromHexRGB:@"d7eef1"];
      [[VIEW_Main layer]
          setBorderColor:[Globle colorFromHexRGB:@"a3b6b8"].CGColor];
      img_View.image = [UIImage imageNamed:@"反馈箭头3"];
      [self San_JIAO_Frame:YES];
    } else {
      VIEW_Main.backgroundColor = [UIColor whiteColor];
      [[VIEW_Main layer]
          setBorderColor:[Globle colorFromHexRGB:@"cccccc"].CGColor];
      img_View.image = [UIImage imageNamed:@"反馈箭头"];
      [self San_JIAO_Frame:NO];
    }
}

//调整高度
- (void)SET_VIEW_Height:(float)height {
  self.height = height;
  VIEW_Main.height = self.height;
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
