//
//  My_PickerView.m
//  优顾理财
//
//  Created by Mac on 14/10/28.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "My_PickerView.h"

@implementation My_PickerView

@synthesize Main_datePicker;
@synthesize Title_datePicker;
@synthesize Btn_datePicker;
@synthesize pickerArray;
@synthesize selected_num;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self start];
  }
  return self;
}

- (id)initWithFrame:(CGRect)frame andPickerArray:(NSMutableArray *)array {
  self = [super initWithFrame:frame];
  if (self) {
    [self start];
  }
  return self;
}

- (void)start {
  pickerArray = [[NSMutableArray alloc] initWithCapacity:0];

  UITapGestureRecognizer *My_tap_Gesturerecgnizer =
      [[UITapGestureRecognizer alloc]
          initWithTarget:self
                  action:@selector(tap_gesturerecognizer_click:)];
  [self addGestureRecognizer:My_tap_Gesturerecgnizer];

  UIView *Top_View = [[UIView alloc]
      initWithFrame:CGRectMake(0, self.height - 206, self.width, 44)];
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

  Main_datePicker = [[UIPickerView alloc]
      initWithFrame:CGRectMake(0, self.height - 206 + 44, 320, 206 - 44)];
  Main_datePicker.backgroundColor = [Globle colorFromHexRGB:@"e1e1e1"];
  Main_datePicker.bottom = self.bottom;
  Main_datePicker.delegate = self;
  Main_datePicker.dataSource = self;
  [self addSubview:Main_datePicker];

    Top_View.backgroundColor = [Globle colorFromHexRGB:@"bbbbbb"];
    Main_datePicker.backgroundColor = [Globle colorFromHexRGB:@"e1e1e1"];
}

- (void)tap_gesturerecognizer_click:(UITapGestureRecognizer *)sender {
  self.hidden = YES;
}

- (void)Btn_datePicker_Click:(UIButton *)sender {
  self.hidden = YES;
}

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {
  UILabel *label = [[UILabel alloc] init];
  label.width = pickerView.width;
  label.text = pickerArray[row];
  label.textAlignment = NSTextAlignmentCenter;
  label.font = [UIFont boldSystemFontOfSize:18];
    label.textColor = [UIColor blackColor];

  return label;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView
    numberOfRowsInComponent:(NSInteger)component {
  return [pickerArray count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
  return pickerArray[row];
}

//监听轮子的移动
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
  if ([delegate respondsToSelector:@selector(Show_PickerView_Time:
                                                           andTag:
                                                     andSelectRow:)]) {
    self.selected_num = (int)row;

    [delegate Show_PickerView_Time:pickerArray[row]
                            andTag:pickerView.tag
                      andSelectRow:row];
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
