//
//  MySettingTextFont.m
//  优顾理财
//
//  Created by Mac on 14-3-17.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "MySettingTextFont.h"

@implementation MySettingTextFont

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    [self start];
  }
  return self;
}

- (void)start {
  NSString *font_size = YouGu_Font_text_Model;
  int be_num = [self font_text_YouGU:[font_size intValue]];

  NSArray *array = @[ @"小", @"中", @"大", @"特" ];
  for (int i = 0; i < 4; i++) {
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20 + 40 * i, 17, 26, 26);
    button1.layer.cornerRadius = 13;
    button1.tag = 1000 + i;
    [[button1 layer] setBorderWidth:1];
    [[button1 layer] setBorderColor:[UIColor grayColor].CGColor];
    button1.titleLabel.font = [UIFont systemFontOfSize:13];
    button1.titleLabel.textAlignment = NSTextAlignmentCenter;

    [button1 setTitle:array[i] forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button1 addTarget:self
                  action:@selector(buttonClick:)
        forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button1];

    if (be_num == i) {
      button1.backgroundColor = [Globle colorFromHexRGB:@"0790e5"];
      [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [[button1 layer] setBorderColor:[UIColor clearColor].CGColor];
    }
  }
}

- (int)font_text_YouGU:(int)font {
  switch (font) {
  case 16: {
    return 0;
  } break;
  case 18: {
    return 1;
  } break;
  case 20: {
    return 2;
  } break;
  case 22: {
    return 3;
  } break;

  default:
    break;
  }

  return 1;
}

- (NSString *)btn_to_font:(int)num {
  switch (num) {
  case 0: {
    return @"16";
  } break;
  case 1: {
    return @"18";
  } break;
  case 2: {
    return @"20";
  } break;
  case 3: {
    return @"22";
  } break;

  default:
    break;
  }

  return @"18";
}

- (void)buttonClick:(UIButton *)sender {
  for (UIButton *btn in self.subviews) {
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [[btn layer] setBorderColor:[UIColor grayColor].CGColor];
  }

  sender.backgroundColor = [Globle colorFromHexRGB:@"0790e5"];

  [[sender layer] setBorderColor:[UIColor clearColor].CGColor];
  [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

  YouGu_defaults_double([self btn_to_font:(int)sender.tag - 1000], @"font_text_webview");

  [[NSNotificationCenter defaultCenter] postNotificationName:@"MySettingTextFont" object:nil];
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
