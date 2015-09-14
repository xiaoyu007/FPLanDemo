//
//  CommercialLoansView.m
//  优顾理财
//
//  Created by Mac on 14/10/22.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//  商业贷款

#import "CommercialLoansView.h"

@implementation CommercialLoansView {
  YL_SelectionButton *YLselectBtn;

  ExpressTextField *textFieldForMultiple;

  NSString *text0;
}

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.contentSize = CGSizeMake(self.width, 500);

    [self start];
  }
  return self;
}

//实现界面UI
- (void)start {
  Repayment = 1;
  Time_num = 0;
  Year_Rate_num = 0;
  //获取贷款期限选项数据
  NSString *path_1 = [[NSBundle mainBundle] pathForResource:@"贷款期限.plist" ofType:nil];
  YG_Time = [[NSMutableArray alloc] initWithContentsOfFile:path_1];
  //获取年利率的选项数据
  NSString *path_2 = [[NSBundle mainBundle] pathForResource:@"House_Year_Rate.plist" ofType:nil];
  YG_Rate = [[NSMutableArray alloc] initWithContentsOfFile:path_2];

  NSArray *array2 = @[@"等额本息", @"等额本金"];
  YLselectBtn = [[YL_SelectionButton alloc] initWithFrame:CGRectMake(-10, 15, self.width, 50)
                                                 andTitle:@"还款方式 :"
                                                  andType:1
                                                 andArray:array2];
  YLselectBtn.delegate = self;
  [self addSubview:YLselectBtn];

  //贷款金额
  UILabel *city_lable = [[UILabel alloc] initWithFrame:CGRectMake(40, 60, 80, 30)];
  city_lable.text = @"贷款金额 :";
  city_lable.backgroundColor = [UIColor clearColor];
  city_lable.textColor = [Globle colorFromHexRGB:textNameColor];
  city_lable.textAlignment = NSTextAlignmentRight;
  city_lable.font = [UIFont systemFontOfSize:15];
  [self addSubview:city_lable];

  Push_money_textfield = [[ExpressTextField alloc] initWithFrame:CGRectMake(130, 60, 100, 30)];
  Push_money_textfield.layer.cornerRadius = 5;
  Push_money_textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  Push_money_textfield.layer.borderWidth = 1.0f;
  Push_money_textfield.keyboardType = UIKeyboardTypeDecimalPad;
  Push_money_textfield.delegate = self;
  [Push_money_textfield setSpaceAtStart];
  [self addSubview:Push_money_textfield];

  UILabel *sign_label = [[UILabel alloc] initWithFrame:CGRectMake(240, 60, 40, 30)];
  sign_label.text = @"万元";
  sign_label.backgroundColor = [UIColor clearColor];
  sign_label.textAlignment = NSTextAlignmentLeft;
  sign_label.textColor = [Globle colorFromHexRGB:textNameColor];
  sign_label.font = [UIFont systemFontOfSize:15];
  [self addSubview:sign_label];

  //贷款期限
  UILabel *city_lable_1 = [[UILabel alloc] initWithFrame:CGRectMake(40, 110, 80, 30)];
  city_lable_1.text = @"贷款期限 :";
  city_lable_1.backgroundColor = [UIColor clearColor];
  city_lable_1.textAlignment = NSTextAlignmentRight;
  city_lable_1.textColor = [Globle colorFromHexRGB:textNameColor];
  city_lable_1.font = [UIFont systemFontOfSize:15];
  [self addSubview:city_lable_1];

  //贷款期限选择按钮
  Time_textfield_btn = [[Textfield_btn alloc] initWithFrame:CGRectMake(130, 110, 100, 30)];
  Time_textfield_btn.city_label.text = @"5年";
  [Time_textfield_btn.click_btn addTarget:self
                                   action:@selector(Time_click_btn:)
                         forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:Time_textfield_btn];

  //年利率
  UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(60, 160, 140, 30)];
  label6.backgroundColor = [UIColor clearColor];
  label6.text = @"年利率 : 基准利率的";
  label6.textColor = [Globle colorFromHexRGB:textNameColor];
  label6.textAlignment = NSTextAlignmentCenter;
  label6.font = [UIFont systemFontOfSize:15];
  [self addSubview:label6];

  textFieldForMultiple = [[ExpressTextField alloc] initWithFrame:CGRectMake(200, 160, 50, 30)];
  textFieldForMultiple.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  textFieldForMultiple.tag = 100;
  textFieldForMultiple.layer.cornerRadius = 5;
  textFieldForMultiple.layer.borderWidth = 1.0f;
  textFieldForMultiple.keyboardType = UIKeyboardTypeDecimalPad;
  textFieldForMultiple.layer.borderColor = [Globle colorFromHexRGB:@"a1a1a1"].CGColor;
  text0 = @"1.0";
  textFieldForMultiple.text = text0;
  textFieldForMultiple.delegate = self;
  textFieldForMultiple.textAlignment = NSTextAlignmentCenter;
  [self addSubview:textFieldForMultiple];

  UILabel *label7 = [[UILabel alloc] initWithFrame:CGRectMake(250, 160, 20, 30)];
  label7.text = @"倍";
  label7.backgroundColor = [UIColor clearColor];
  label7.textAlignment = NSTextAlignmentCenter;
  label7.font = [UIFont systemFontOfSize:15];
  [self addSubview:label7];

  //计算
  UIButton *Operation_btn = [UIButton buttonWithType:UIButtonTypeCustom];
  Operation_btn.frame = CGRectMake(55, 210, 100, 30);
  Operation_btn.backgroundColor = [Globle colorFromHexRGB:@"2f8ef2"];
  Operation_btn.layer.cornerRadius = 5;
  [Operation_btn addTarget:self
                    action:@selector(Calculation)
          forControlEvents:UIControlEventTouchUpInside];
  [Operation_btn setTitle:@"计算" forState:UIControlStateNormal];
  UIImage *highlightImage = [FPYouguUtil createImageWithColor:buttonHighLightColor];
  [Operation_btn setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
  Operation_btn.titleLabel.textAlignment = NSTextAlignmentCenter;
  Operation_btn.titleLabel.font = [UIFont systemFontOfSize:15];
  [self addSubview:Operation_btn];

  //重置
  UIButton *Operation_btn_2 = [UIButton buttonWithType:UIButtonTypeCustom];
  Operation_btn_2.frame = CGRectMake(165, 210, 100, 30);
  Operation_btn_2.backgroundColor = [Globle colorFromHexRGB:@"2f8ef2"];
  Operation_btn_2.layer.cornerRadius = 5;
  [Operation_btn_2 setTitle:@"重置" forState:UIControlStateNormal];
  [Operation_btn_2 setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
  [Operation_btn_2 addTarget:self
                      action:@selector(Reset:)
            forControlEvents:UIControlEventTouchUpInside];
  Operation_btn_2.titleLabel.textAlignment = NSTextAlignmentCenter;
  Operation_btn_2.titleLabel.font = [UIFont systemFontOfSize:15];
  [self addSubview:Operation_btn_2];

  //分割线
  UIView *line_View = [[UIView alloc] initWithFrame:CGRectMake(20, 269, 280, 1)];
  line_View.backgroundColor = [Globle colorFromHexRGB:@"d9d9d9"];
  [self addSubview:line_View];

  Detail_tableView = [[NALMatrixTableView alloc] initWithFrame:CGRectMake(20, 290, 280, 30)
                                                      andArray:@[
                                                        @[ @"等额本息", @"每期等额还款" ],
                                                        @[ @"贷款总额 :", @"元" ],
                                                        @[ @"贷款期限 :", @"期" ],
                                                        @[ @"月均还款 :", @"元" ],
                                                        @[ @"支付利息 :", @"元" ],
                                                        @[ @"还款总额 :", @"元" ]
                                                      ]
                                              andColumnsWidths:@[ @140, @140 ]];
  [self addSubview:Detail_tableView];

  city_lable.textColor = [Globle colorFromHexRGB:textNameColor];
  sign_label.textColor = [Globle colorFromHexRGB:textNameColor];
  city_lable_1.textColor = [Globle colorFromHexRGB:textNameColor];

  Push_money_textfield.keyboardAppearance = UIKeyboardAppearanceDefault;
  Push_money_textfield.textColor = [Globle colorFromHexRGB:textfieldContentColor];
  Push_money_textfield.layer.borderColor = [Globle colorFromHexRGB:textfieldBordColor].CGColor;

  textFieldForMultiple.layer.borderColor = [Globle colorFromHexRGB:textfieldBordColor].CGColor;
  textFieldForMultiple.textColor = [Globle colorFromHexRGB:textfieldContentColor];

  label6.textColor = [Globle colorFromHexRGB:textNameColor];
  label7.textColor = [Globle colorFromHexRGB:textNameColor];

  Operation_btn.backgroundColor = [Globle colorFromHexRGB:@"2f8ef2"];
  Operation_btn_2.backgroundColor = [Globle colorFromHexRGB:@"2f8ef2"];
}

#pragma mark - YL_selection_button的代理方法，当点击选择时调用
- (void)selection_btn:(int)row {
  if (YLselectBtn.row == 0) {
    [Detail_tableView NaL_Matrix_array:@[
      @[ @"等额本息", @"每期等额还款" ],
      @[ @"贷款总额 :", @"元" ],
      @[ @"贷款期限 :", @"期" ],
      @[ @"首期还款 :", @"元" ],
      @[ @"支付利息 :", @"元" ],
      @[ @"还款总额 :", @"元" ]
    ] andColumnsWidths:@[ @140, @140 ]];
  }
  if (YLselectBtn.row == 1) {
    [Detail_tableView NaL_Matrix_array:@[
      @[ @"等额本金", @"" ],
      @[ @"贷款总额 :", @"元" ],
      @[ @"贷款期限 :", @"期" ],
      @[ @"首期还款 :", @"元" ],
      @[ @"每月递减 :", @"元" ],
      @[ @"支付利息 :", @"元" ],
      @[ @"还款总额 :", @"元" ]
    ] andColumnsWidths:@[ @140, @140 ]];
  }
}

#pragma mark - 选项按钮 两种还款方式的切换
- (void)btn2_Click:(UIButton *)sender {
  if (sender.tag == 20000) {
    Repayment = 1;
    btn2.selected = NO;
    btn3.selected = YES;
  } else if (sender.tag == 30000) {
    Repayment = 2;
    btn2.selected = YES;
    btn3.selected = NO;
  }
}

#pragma mark - 贷款金额输入框的代理方法 实现输入字数的控制
- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string {
  int MAX_CHARS = 9;

  NSMutableString *newtxt = [NSMutableString stringWithString:textField.text];
  //
  [newtxt replaceCharactersInRange:range withString:string];

  return ([newtxt length] <= MAX_CHARS);
}

#pragma mark - 按钮，选择贷款期限
- (void)Time_click_btn:(UIButton *)sender {
  if (Time_PickerView == nil) {
    Time_PickerView = [[My_PickerView alloc] initWithFrame:[[self superview] superview].bounds];
    Time_PickerView.Main_datePicker.tag = 2000;
    Time_PickerView.Title_datePicker.text = @"贷款期限";
    Time_PickerView.delegate = self;
    [Time_PickerView.pickerArray addObjectsFromArray:YG_Time];
    [[[self superview] superview] addSubview:Time_PickerView];

    if ([YG_Time count] >= 1) {
      Time_num = 0;
      Time_textfield_btn.city_label.text = YG_Time[0];
    }
  } else {
    Time_PickerView.hidden = NO;
  }
}

//#pragma mark - 按钮 选择年利率
//-(void)Rate_click_btn:(UIButton *)sender
//{
//    if (Rate_PickerView== nil)
//    {
//        Rate_PickerView=[[My_PickerView alloc]initWithFrame:[[self superview]
//        superview].bounds];
//        Rate_PickerView.Main_datePicker.tag=3000;
//        Rate_PickerView.Title_datePicker.text=@"年利率";
//        Rate_PickerView.delegate=self;
//        //添加显示内容
//        [Rate_PickerView.pickerArray addObjectsFromArray:YG_Rate];
//        [[[self superview] superview] addSubview:Rate_PickerView];
//        [Rate_PickerView release];
//
//        if ([YG_Rate count]>=1)
//        {
//            Year_Rate_num=0;
//            Rate_textfield_btn.city_label.text=[YG_Rate objectAtIndex:0];
//        }
//    }
//    else
//    {
//        Rate_PickerView.hidden=NO;
//    }
//}

#pragma mark -  计算按钮
//计算
- (void)Calculation {
  if ([Push_money_textfield.text doubleValue] <= 0) {
    YouGu_animation_Did_Start(@"请输入符合条件的贷款总金额");
    return;
  }
  text0 = textFieldForMultiple.text;
  if ([text0 doubleValue] <= 0) {
    YouGu_animation_Did_Start(@"请输入基准利率的倍数");
    return;
  }

  ///总金额
  int Lump_sum = [Push_money_textfield.text doubleValue] * 10000;
  NSString *Lump_sum_str = [NSString stringWithFormat:@"%d元", Lump_sum];
  ///还款期数
  float Repayment_num = [self Get_deadline:Time_num] * 1.0;
  NSString *Repayment_num_str = [NSString stringWithFormat:@"%d期", [self Get_deadline:Time_num]];
  ///月利率
  double month_Rate = [self The_actual_lending_rates:Time_num] * 0.01 / 12.0;
  /// 1 等额本息   2 等额本金
  if (YLselectBtn.row == 0) {
    /// 每月还款额
    double Each_payments_float = (Lump_sum * month_Rate * pow((1 + month_Rate), Repayment_num)) /
                                 (1.0 * (pow((1 + month_Rate), Repayment_num) - 1));
    NSString *Each_payments = [NSString stringWithFormat:@"%0.2lf元", Each_payments_float];
    NSLog(@"++++++++++++++++++++++++++%f", month_Rate);
    /// 支付利息
    NSString *Total_interest =
        [NSString stringWithFormat:@"%0.2lf元", (Each_payments_float * Repayment_num - Lump_sum)];

    /// 还款总额
    NSString *The_total_repayment = [NSString stringWithFormat:@"%0.2lf元", Each_payments_float * Repayment_num];

    [Detail_tableView NaL_Matrix_array:@[
      @[ @"等额本息", @"每期等额还款" ],
      @[ @"贷款总额 :", Lump_sum_str ],
      @[ @"贷款期限 :", Repayment_num_str ],
      @[ @"月均还款 :", Each_payments ],
      @[ @"支付利息 :", Total_interest ],
      @[ @"还款总额 :", The_total_repayment ]
    ] andColumnsWidths:@[ @140, @140 ]];
  }

  else {
    /// 每月还款额
    double Each_payments_float = Lump_sum / (Repayment_num * 1.0) + Lump_sum * month_Rate;
    NSString *Each_paymentsStr = [NSString stringWithFormat:@"%0.2lf元", Each_payments_float];

    ///每月递减
    double monthDecress = Lump_sum / (Repayment_num * 1.0) * month_Rate;
    NSString *monthDecressStr = [NSString stringWithFormat:@"%0.2lf元", monthDecress];

    /// 支付利息
    NSString *Total_interest =
        [NSString stringWithFormat:@"%0.2lf元", Lump_sum * month_Rate * Repayment_num -
                                                    (Lump_sum * month_Rate / Repayment_num) *
                                                        (0 + Repayment_num - 1) * Repayment_num / 2.0];

    /// 还款总额
    NSString *The_total_repayment =
        [NSString stringWithFormat:@"%0.2lf元", [Total_interest doubleValue] + Lump_sum];

    [Detail_tableView NaL_Matrix_array:@[
      @[ @"等额本金", @"每期等额还款" ],
      @[ @"贷款总额 :", Lump_sum_str ],
      @[ @"贷款期限 :", Repayment_num_str ],
      @[ @"首期还款 :", Each_paymentsStr ],
      @[ @"每月递减 :", monthDecressStr ],
      @[ @"支付利息 :", Total_interest ],
      @[ @"还款总额 :", The_total_repayment ]
    ] andColumnsWidths:@[ @140, @140 ]];
  }
}

///实际 贷款利率
- (float)The_actual_lending_rates:(int)num {
  if (num == 0) {
    /// 贷款利率 (五年）
    double Rate_float = (double)self.Benchmark_rate_5Below * [textFieldForMultiple.text doubleValue];
    return [self notRounding:Rate_float afterPoint:2];
  } else {
    /// 贷款利率（五年以上）
    double Rate_float = self.Benchmark_rate_5Above * [textFieldForMultiple.text doubleValue];

    return [self notRounding:Rate_float afterPoint:2];
  }
}
//格式话小数 四舍五入类型
- (double)notRounding:(double)price afterPoint:(int)position {
  double sum = (int)roundf(pow(10, position)) * price;
  double result = roundf(sum) / ((int)roundf(pow(10, position)) * 1.0);
  return result;
}

///// 获取 贷款年利率倍数
//-(double)APR_times:(int)num
//{
//    switch (num) {
//        case 0:
//        {
//            return 1.0;
//        }
//            break;
//        case 1:
//        {
//            return 0.7;
//        }
//            break;
//        case 2:
//        {
//            return 0.8;
//        }
//            break;
//        case 3:
//        {
//            return 0.9;
//        }
//            break;
//        case 4:
//        {
//            return 1.1;
//        }
//            break;
//        case 5:
//        {
//            return 1.2;
//        }
//            break;
//        case 6:
//        {
//            return 1.3;
//        }
//            break;
//        default:
//            break;
//    }
//    return 1.0;
//}
- (int)Get_deadline:(int)num

/// 获取  还款期数
{
  return (num + 1) * 5 * 12;
}

#pragma mark - 重置按钮
- (void)Reset:(UIButton *)sender {
  Push_money_textfield.text = @"";
  [Detail_tableView NaL_Matrix_array:@[
    @[ @"等额本息", @"每期等额还款" ],
    @[ @"贷款总额 :", @"元" ],
    @[ @"贷款期限 :", @"期" ],
    @[ @"月均还款 :", @"元" ],
    @[ @"支付利息 :", @"元" ],
    @[ @"还款总额 :", @"元" ]
  ] andColumnsWidths:@[ @140, @140 ]];
}

#pragma mark - 贷款期限和年利率两个选择框的代理方法，实现选择功能
- (void)Show_PickerView_Time:(NSString *)time andTag:(NSInteger)Tag andSelectRow:(NSInteger)row {
  if (Tag == 2000) {
    Time_num = (int)row;
    Time_textfield_btn.city_label.text = time;
  } else if (Tag == 3000) {
    Year_Rate_num = (int)row;
    Rate_textfield_btn.city_label.text = time;
  }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
  if (textField.tag == 100) {
    self.contentOffset = CGPointMake(0, 50);
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
