//
//  YL_SelectionButton.m
//  优顾理财
//
//  Created by Mac on 14/12/18.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "YL_SelectionButton.h"
#import "SettingButton.h"
@implementation YL_SelectionButton

- (id)initWithFrame:(CGRect)frame
           andTitle:(NSString *)title
            andType:(int)type
           andArray:(NSArray *)array {
  self = [super initWithFrame:frame];
  if (self) {
    _mainArray = [[NSMutableArray alloc] initWithArray:array];

    if (title != nil) {
      //还款方式
      city_lable_first =
          [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 80, 30)];
      city_lable_first.backgroundColor = [UIColor clearColor];
      city_lable_first.text = title;
      city_lable_first.textAlignment = NSTextAlignmentRight;
      city_lable_first.font = [UIFont systemFontOfSize:15];
      [self addSubview:city_lable_first];

        city_lable_first.textColor = [Globle colorFromHexRGB:textNameColor];
    }

    switch (type) {
    case 1: {
      [self LineView:_mainArray];
    } break;
    case 2: {
      [self VerticalView:_mainArray];
    } break;
    default:
      break;
    }
  }
  return self;
}
///两个行屏的
- (void)LineView:(NSMutableArray *)array {
  for (int i = 0; i < [array count]; i++) {
    SettingButton *btn2 = [[SettingButton alloc]
        initWithFrame:CGRectMake(130 + 90 * i, 5, 20, 20)
             andIs_eq:YES];
    [btn2 addTarget:self
                  action:@selector(btn2_Click:)
        forControlEvents:UIControlEventTouchUpInside];
    btn2.tag = 1000 + i;
    btn2.selected = YES;
    [self addSubview:btn2];

    UILabel *label_2 =
        [[UILabel alloc] initWithFrame:CGRectMake(150 + 90 * i, 0, 90, 30)];
    label_2.backgroundColor = [UIColor clearColor];
    label_2.text = array[i];
    label_2.textAlignment = NSTextAlignmentLeft;
    label_2.font = [UIFont systemFontOfSize:15];
    [self addSubview:label_2];

      label_2.textColor = [Globle colorFromHexRGB:textNameColor];
  }
  SettingButton *btn = (SettingButton *)[self viewWithTag:1000];
  btn.selected = NO;
}
///恢复初始化
- (void)my_init_btn {
  SettingButton *btn = (SettingButton *)[self viewWithTag:1000];
  [self btn2_Click:btn];
}
///竖屏的
- (void)VerticalView:(NSMutableArray *)array {
  float heigt = 30.0f;
  if (city_lable_first == nil) {
    heigt = 0.0f;
  }
  for (int i = 0; i < [array count]; i++) {
    SettingButton *btn6 = [[SettingButton alloc]
        initWithFrame:CGRectMake(50, heigt + 15 + i * 40, 20, 20)
             andIs_eq:YES];
    [btn6 addTarget:self
                  action:@selector(btn2_Click:)
        forControlEvents:UIControlEventTouchUpInside];
    btn6.tag = 1000 + i;
    btn6.selected = YES;
    [self addSubview:btn6];

    UILabel *label_6 = [[UILabel alloc]
        initWithFrame:CGRectMake(70, heigt + 10 + i * 40, 220, 30)];
    label_6.backgroundColor = [UIColor clearColor];
    label_6.text = array[i];
    label_6.textAlignment = NSTextAlignmentLeft;
    label_6.font = [UIFont systemFontOfSize:15];
    [self addSubview:label_6];

      label_6.textColor = [Globle colorFromHexRGB:textNameColor];
  }
  SettingButton *btn = (SettingButton *)[self viewWithTag:1000];
  btn.selected = NO;
}

- (void)btn2_Click:(SettingButton *)sender {
  for (int i = 1000; i < [_mainArray count] + 1000; i++) {
    SettingButton *btn = (SettingButton *)[self viewWithTag:i];
    if (i == sender.tag) {
      btn.selected = NO;
    } else {
      btn.selected = YES;
    }
  }

  _row = sender.tag - 1000;

  if ([_delegate respondsToSelector:@selector(selection_btn:)]) {
    [_delegate selection_btn:(int)sender.tag - 1000];
  }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
