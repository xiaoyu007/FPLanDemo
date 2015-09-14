//
//  My_Datepicker.m
//  优顾理财
//
//  Created by Mac on 14/10/27.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "My_Datepicker.h"

@implementation My_Datepicker
@synthesize Main_datePicker;
@synthesize Title_datePicker;
@synthesize Btn_datePicker;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self start];
  }
  return self;
}

- (void)start {

  UITapGestureRecognizer *My_tap_Gesturerecgnizer =
      [[UITapGestureRecognizer alloc]
          initWithTarget:self
                  action:@selector(tap_gesturerecognizer_click:)];
  [self addGestureRecognizer:My_tap_Gesturerecgnizer];

  UIView *Top_View = [[UIView alloc]
      initWithFrame:CGRectMake(0, self.height - 216 - 44, self.width, 44)];
  Top_View.backgroundColor = [Globle colorFromHexRGB:@"bbbbbb"];
  [self addSubview:Top_View];

  Title_datePicker = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 230, 40)];
  Title_datePicker.textAlignment = NSTextAlignmentLeft;
  Title_datePicker.font = [UIFont boldSystemFontOfSize:15];
  Title_datePicker.textColor = [Globle colorFromHexRGB:@"5a9aff"];
  Title_datePicker.backgroundColor = [UIColor clearColor];
  [Top_View addSubview:Title_datePicker];

  Btn_datePicker = [UIButton buttonWithType:UIButtonTypeCustom];
  Btn_datePicker.frame = CGRectMake(250, 2, 60, 40);
  [Btn_datePicker addTarget:self
                     action:@selector(Btn_datePicker_Click:)
           forControlEvents:UIControlEventTouchUpInside];
  [Btn_datePicker setTitleColor:[Globle colorFromHexRGB:@"5a9aff"]
                       forState:UIControlStateNormal];
  Btn_datePicker.titleLabel.textAlignment = NSTextAlignmentCenter;
  [Btn_datePicker setTitle:@"确认" forState:UIControlStateNormal];
  [Top_View addSubview:Btn_datePicker];

  Main_datePicker = [[UIDatePicker alloc]
      initWithFrame:CGRectMake(0, self.height - 216, 320, 216)];
  Main_datePicker.backgroundColor = [Globle colorFromHexRGB:@"e1e1e1"];
  // 设置时区
  [Main_datePicker setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
  // 设置当前显示时间
  [Main_datePicker setDate:[NSDate date] animated:YES];
  // 设置显示最大时间（此处为当前时间）
  //    [Main_datePicker setMaximumDate:[NSDate date]];
  // 设置UIDatePicker的显示模式
  [Main_datePicker setDatePickerMode:UIDatePickerModeDate];
  // 当值发生改变的时候调用的方法
  [Main_datePicker addTarget:self
                      action:@selector(datePickerValueChanged:)
            forControlEvents:UIControlEventValueChanged];
  [self addSubview:Main_datePicker];
}

- (void)tap_gesturerecognizer_click:(UITapGestureRecognizer *)sender {
  self.hidden = YES;
}

- (void)Btn_datePicker_Click:(UIButton *)sender {
  self.hidden = YES;
}

- (void)datePickerValueChanged:(UIDatePicker *)sender {
  if ([delegate respondsToSelector:@selector(Show_DatePicker_Time:andTag:)]) {
    [delegate Show_DatePicker_Time:[self stringFromDate:[sender date]]
                            andTag:sender.tag];
  }
}

- (NSString *)stringFromDate:(NSDate *)date {

  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

  // zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。

  [dateFormatter setDateFormat:@"yyyy-MM-dd"];

  NSString *destDateString = [dateFormatter stringFromDate:date];

  return destDateString;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
