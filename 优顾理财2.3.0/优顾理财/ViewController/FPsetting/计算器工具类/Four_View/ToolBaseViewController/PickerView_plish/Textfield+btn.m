//
//  Textfield+btn.m
//  优顾理财
//
//  Created by Mac on 14/10/20.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "Textfield+btn.h"

@implementation Textfield_btn
@synthesize city_label;
@synthesize image;
@synthesize click_btn;
- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.layer.cornerRadius = 5;
    [self start];
  }

  return self;
}

- (void)start {

  self.layer.borderWidth = 1.0f;
  self.layer.borderColor = [Globle colorFromHexRGB:@"e5e5e5"].CGColor;

  //当label过小时，作调整
  if (self.width - 30 < 13) {
    city_label =
        [[UILabel alloc] initWithFrame:CGRectMake(14, 0, 13, self.height)];
  } else {
    city_label = [[UILabel alloc]
        initWithFrame:CGRectMake(14, 0, self.width - 30, self.height)];
  }
  city_label.textAlignment = NSTextAlignmentLeft;
  city_label.backgroundColor = [UIColor clearColor];
  city_label.numberOfLines = 1;
  city_label.font = [UIFont systemFontOfSize:13.0f];
  [self addSubview:city_label];

  image = [[UIImageView alloc]
      initWithImage:[UIImage imageNamed:@"三角." @"png"]];
  image.frame = CGRectMake(self.width - 25, (self.height - 7) / 2, 8, 7);
  [self addSubview:image];
  image.backgroundColor = [UIColor clearColor];

  click_btn = [UIButton buttonWithType:UIButtonTypeCustom];
  click_btn.backgroundColor = [UIColor clearColor];
  click_btn.frame = self.bounds;
  [self addSubview:click_btn];

  [self Night_backgroundColor];
}

- (void)Night_backgroundColor {
    city_label.textColor = [Globle colorFromHexRGB:@"8c8c8c"];
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [Globle colorFromHexRGB:@"e5e5e5"].CGColor;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
