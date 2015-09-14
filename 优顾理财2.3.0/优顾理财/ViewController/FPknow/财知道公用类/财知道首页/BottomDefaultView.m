//
//  BottomDefaultView.m
//  优顾理财
//
//  Created by Mac on 15/1/28.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "BottomDefaultView.h"

@implementation BottomDefaultView

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.userInteractionEnabled = NO;
    _imageview = [[UIImageView alloc]
        initWithFrame:CGRectMake((self.width - 133.5) / 2.0f,
                                 (self.height - 92 - 30) / 2.0f, 133.5, 92)];
    _imageview.image = [UIImage imageNamed:@"加载.png"];
    [self addSubview:_imageview];

    _label = [[UILabel alloc]
        initWithFrame:CGRectMake((self.width - 120) / 2.0f,
                                 self.imageview.bottom + 10, 120, 20)];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.backgroundColor = [UIColor clearColor];
    _label.font = [UIFont systemFontOfSize:17];
    _label.text = @"暂 无 数 据";
    _label.textColor = [Globle colorFromHexRGB:@"939393"];
    [self addSubview:_label];
  }
  return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
