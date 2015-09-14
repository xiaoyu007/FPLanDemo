//
//  UserRegistView.m
//  优顾理财
//
//  Created by Mac on 14/11/29.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "UserRegistView.h"

@implementation UserRegistView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _btn_Main = [[clickLabel alloc] initWithFrame:self.bounds];
    _btn_Main.userInteractionEnabled = YES;
    [self addSubview:_btn_Main];

    _top_imageView =
        [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    _top_imageView.userInteractionEnabled = NO;
    [self addSubview:_top_imageView];

    _title_label = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 80, 30)];
    _title_label.userInteractionEnabled = NO;
    _title_label.backgroundColor = [UIColor clearColor];
    _title_label.textAlignment = NSTextAlignmentCenter;
    _title_label.backgroundColor = [UIColor clearColor];
    _title_label.font = [UIFont systemFontOfSize:14.0f];
    [self addSubview:_title_label];

    _title_label_Subtitle =
        [[UILabel alloc] initWithFrame:CGRectMake(115, 15, 160, 20)];
    _title_label_Subtitle.userInteractionEnabled = NO;
    _title_label_Subtitle.backgroundColor = [UIColor clearColor];
    _title_label_Subtitle.textAlignment = NSTextAlignmentCenter;
    _title_label_Subtitle.backgroundColor = [UIColor clearColor];
    _title_label_Subtitle.font = [UIFont systemFontOfSize:14.0f];
    [self addSubview:_title_label_Subtitle];
  }

  return self;
}

+ (id)alloc {
  return [super alloc];
}

@end
