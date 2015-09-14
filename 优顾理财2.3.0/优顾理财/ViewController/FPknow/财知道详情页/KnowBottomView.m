//
//  KnowBottomView.m
//  优顾理财
//
//  Created by Mac on 14-3-26.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "KnowBottomView.h"

@implementation KnowBottomView
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
    [self Creat_bottom_Comment];
  }
  return self;
}

//创建一个bottom，评论
- (void)Creat_bottom_Comment {
  bottom_view = [[UIView alloc] initWithFrame:self.bounds];
  [self addSubview:bottom_view];

  //    分割线
  C_Fen_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowWidth, 0.5f)];
  [bottom_view addSubview:C_Fen_view];

  C_view = [[UIView alloc] initWithFrame:CGRectMake(16, 7, 36, 36)];
  C_view.layer.cornerRadius = 18;
  C_view.clipsToBounds = YES;
  [bottom_view addSubview:C_view];

  UIImageView *C_image =
      [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"发言.png"]];
  C_image.frame = C_view.bounds;
  [C_view addSubview:C_image];

  C_field_view = [[UIView alloc] initWithFrame:CGRectMake(72, 7, 230, 36)];
  [bottom_view addSubview:C_field_view];
  C_field_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 230, 36)];
  C_field_label.backgroundColor = [UIColor clearColor];
  C_field_label.text = @"  说说我的看法";
  C_field_label.font = [UIFont systemFontOfSize:16];
  [C_field_view addSubview:C_field_label];

  UIButton *C_button = [UIButton buttonWithType:UIButtonTypeCustom];
  C_button.frame = bottom_view.bounds;
  C_button.userInteractionEnabled = YES;
  [C_button addTarget:self
                action:@selector(CC_button_click:)
      forControlEvents:UIControlEventTouchUpInside];
  [bottom_view addSubview:C_button];

  //        视图背景颜色
  bottom_view.backgroundColor = [UIColor whiteColor];
  C_Fen_view.backgroundColor = [Globle colorFromHexRGB:lightCuttingLine];
  C_view.backgroundColor = [Globle colorFromHexRGB:@"ececec"];
  C_field_view.backgroundColor = [Globle colorFromHexRGB:@"ededed"];
  C_field_label.textColor = [Globle colorFromHexRGB:@"686868"];
  C_field_label.backgroundColor = [Globle colorFromHexRGB:@"ececec"];
}

- (void)CC_button_click:(UIButton *)sender {
  if ([delegate respondsToSelector:@selector(C_button_click:)]) {
    [delegate C_button_click:sender];
  }
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
