//
//  GuideMapView.m
//  优顾理财
//
//  Created by Mac on 14/12/10.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "GuideMapView.h"

@implementation GuideMapView

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {

    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.6;
    [self addSubview:view];

    UITapGestureRecognizer *tapGestureRecognizer =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(tap_Click:)];
    [view addGestureRecognizer:tapGestureRecognizer];

    UIImageView *imageView =
        [[UIImageView alloc] initWithFrame:CGRectMake(100, 310, 120, 90)];
    imageView.image = [UIImage imageNamed:@"个人中心首次引导小图_ios." @"png"];
    [self addSubview:imageView];

    UILabel *prompt_label =
        [[UILabel alloc] initWithFrame:CGRectMake(80, 100, 160, 60)];
    prompt_label.backgroundColor = [UIColor clearColor];
    prompt_label.textColor = [UIColor whiteColor];
    prompt_label.textAlignment = NSTextAlignmentCenter;
    prompt_label.numberOfLines = 2;
    prompt_label.font = [UIFont fontWithName:@"Noteworthy" size:16];
    prompt_label.text = @"点击工具箱\n算出你不知道的“秘密”";
    [self addSubview:prompt_label];

    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
      imageView.top = 300;
      prompt_label.top = 260;
    }
  }
  return self;
}

- (void)tap_Click:(UITapGestureRecognizer *)sender {
  self.hidden = YES;
  [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
