//
//  FourCarViewController.m
//  优顾理财
//
//  Created by Mac on 14/10/20.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//  车贷

#import "FourCarViewController.h"
#import "Tools_data_object.h"

@implementation FourCarViewController {
  YL_SelectionButton *YLSelectionBtn;
}

- (void)btn2_Click:(UIButton *)sender {
  if (sender.tag == 20000) {
    Repayment = 1;
    btn3.selected = YES;
    btn2.selected = NO;
  } else if (sender.tag == 30000) {
    Repayment = 2;
    btn2.selected = YES;
    btn3.selected = NO;
  }
}

- (void)viewDidLoad {
  [super viewDidLoad];
  Repayment = 1;
  Down_payment = 0;
  // Do any additional setup after loading the view.
  [self.topNavView setMainLableString:@"汽车贷款计算"];
  self.content_view.contentSize = CGSizeMake(self.view.width, 550);

  NSString *path_1 = [[NSBundle mainBundle] pathForResource:@"Car_Downpayment.plist" ofType:nil];
  NSString *path_2 = [[NSBundle mainBundle] pathForResource:@"Car_Loan_period.plist" ofType:nil];

  self.YG_Downpayment = [[NSMutableArray alloc] initWithContentsOfFile:path_1];
  self.YG_Loan_period = [[NSMutableArray alloc] initWithContentsOfFile:path_2];
  self.YG_bank = [[NSMutableArray alloc] initWithCapacity:0];
  self.YG_Year_Rate = [[NSMutableArray alloc] initWithCapacity:0];

  NSArray *array2 = @[ @"等额本息", @"等额本金" ];
  YLSelectionBtn = [[YL_SelectionButton alloc] initWithFrame:CGRectMake(0, 10, self.content_view.width, 50)
                                                    andTitle:@"还款方式 :"
                                                     andType:1
                                                    andArray:array2];
  YLSelectionBtn.delegate = self;
  [self.content_view addSubview:YLSelectionBtn];

  //购买价格
  UILabel *city_lable = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 80, 30)];
  city_lable.text = @"购买价格 :";
  city_lable.backgroundColor = [UIColor clearColor];
  city_lable.textAlignment = NSTextAlignmentRight;
  city_lable.font = [UIFont systemFontOfSize:15];
  [self.content_view addSubview:city_lable];

  Push_money_textfield = [[ExpressTextField alloc] initWithFrame:CGRectMake(140, 50, 100, 30)];
  Push_money_textfield.layer.cornerRadius = 5;
  Push_money_textfield.layer.borderWidth = 1.0f;
  Push_money_textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  Push_money_textfield.keyboardType = UIKeyboardTypeDecimalPad;
  Push_money_textfield.delegate = self;
  [Push_money_textfield setSpaceAtStart];
  [self.content_view addSubview:Push_money_textfield];

  UILabel *sign_label = [[UILabel alloc] initWithFrame:CGRectMake(250, 50, 30, 30)];
  sign_label.text = @"万元";
  sign_label.backgroundColor = [UIColor clearColor];
  sign_label.textAlignment = NSTextAlignmentLeft;
  sign_label.font = [UIFont systemFontOfSize:15];
  [self.content_view addSubview:sign_label];

  //贷款首付比例
  UILabel *city_lable_1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, 120, 30)];
  city_lable_1.text = @"贷款首付比例 :";
  city_lable_1.backgroundColor = [UIColor clearColor];
  city_lable_1.textAlignment = NSTextAlignmentRight;
  city_lable_1.font = [UIFont systemFontOfSize:15];
  [self.content_view addSubview:city_lable_1];

  First_ratio_textfield_btn = [[Textfield_btn alloc] initWithFrame:CGRectMake(140, 90, 100, 30)];
  First_ratio_textfield_btn.city_label.text = @"零首付";
  [First_ratio_textfield_btn.click_btn addTarget:self
                                          action:@selector(Time_click_btn:)
                                forControlEvents:UIControlEventTouchUpInside];
  [self.content_view addSubview:First_ratio_textfield_btn];

  //储蓄银行
  UILabel *city_lable_3 = [[UILabel alloc] initWithFrame:CGRectMake(50, 130, 80, 30)];
  city_lable_3.text = @"储蓄银行 :";
  city_lable_3.backgroundColor = [UIColor clearColor];
  city_lable_3.textAlignment = NSTextAlignmentRight;
  city_lable_3.font = [UIFont systemFontOfSize:15];
  [self.content_view addSubview:city_lable_3];

  Bank_textfield_btn = [[Textfield_btn alloc] initWithFrame:CGRectMake(140, 130, 100, 30)];
  Bank_textfield_btn.city_label.text = @"基准利率";
  [Bank_textfield_btn.click_btn addTarget:self
                                   action:@selector(Bank_click_btn:)
                         forControlEvents:UIControlEventTouchUpInside];
  [self.content_view addSubview:Bank_textfield_btn];

  //贷款期限
  UILabel *city_lable_2 = [[UILabel alloc] initWithFrame:CGRectMake(50, 170, 80, 30)];
  city_lable_2.text = @"贷款期限 :";
  city_lable_2.backgroundColor = [UIColor clearColor];
  city_lable_2.textAlignment = NSTextAlignmentRight;
  city_lable_2.font = [UIFont systemFontOfSize:15];
  [self.content_view addSubview:city_lable_2];

  The_period_textfield_btn = [[Textfield_btn alloc] initWithFrame:CGRectMake(140, 170, 100, 30)];
  The_period_textfield_btn.city_label.text = @"6个月";
  [The_period_textfield_btn.click_btn addTarget:self
                                         action:@selector(Rate_click_btn:)
                               forControlEvents:UIControlEventTouchUpInside];
  [self.content_view addSubview:The_period_textfield_btn];

  //贷款年利率
  UILabel *city_lable_4 = [[UILabel alloc] initWithFrame:CGRectMake(40, 210, 90, 30)];
  city_lable_4.text = @"贷款年利率 :";
  city_lable_4.backgroundColor = [UIColor clearColor];
  city_lable_4.textAlignment = NSTextAlignmentRight;
  city_lable_4.font = [UIFont systemFontOfSize:15];
  [self.content_view addSubview:city_lable_4];

  interest_rate_textfield = [[ExpressTextField alloc] initWithFrame:CGRectMake(140, 210, 100, 30)];
  interest_rate_textfield.layer.cornerRadius = 5;
  interest_rate_textfield.layer.borderWidth = 1.0f;
  interest_rate_textfield.tag = 5000;
  interest_rate_textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  interest_rate_textfield.keyboardType = UIKeyboardTypeDecimalPad;
  interest_rate_textfield.delegate = self;
  [interest_rate_textfield setSpaceAtStart];
  [self.content_view addSubview:interest_rate_textfield];

  UILabel *sign_label_2 = [[UILabel alloc] initWithFrame:CGRectMake(250, 210, 20, 30)];
  sign_label_2.text = @"％";
  sign_label_2.backgroundColor = [UIColor clearColor];
  sign_label_2.textAlignment = NSTextAlignmentLeft;
  sign_label_2.font = [UIFont systemFontOfSize:15];
  [self.content_view addSubview:sign_label_2];

  //计算
  UIButton *Operation_btn = [UIButton buttonWithType:UIButtonTypeCustom];
  Operation_btn.frame = CGRectMake(70, 260, 180, 30);
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
  [self.content_view addSubview:Operation_btn];

  //分割线
  UIView *line_View = [[UIView alloc] initWithFrame:CGRectMake(20, 299, 280, 1)];
  line_View.backgroundColor = [Globle colorFromHexRGB:@"d9d9d9"];
  [self.content_view addSubview:line_View];

  Detail_tableView = [[NALMatrixTableView alloc] initWithFrame:CGRectMake(20, 310, 280, 30)
                                                      andArray:@[
                                                        @[ @"等额本息", @"每期等额还款" ],
                                                        @[ @"贷款总额 :", @"元" ],
                                                        @[ @"贷款期限 :", @"期" ],
                                                        @[ @"月均还款 :", @"元" ],
                                                        @[ @"支付利息 :", @"元" ],
                                                        @[ @"还款总额 :", @"元" ]
                                                      ]
                                              andColumnsWidths:@[ @140, @140 ]];
  [self.content_view addSubview:Detail_tableView];

  if (YouGu_fileExistsAtPath(pathInCacheDirectory(@"Car_year_rateyear.plist"))) {
    NSDictionary *dic = [NSDictionary
        dictionaryWithContentsOfFile:pathInCacheDirectory(@"Car_year_rateyear.plist")];

    [self Car_year_rateyear:dic];
  } else {
    NSString *path_3 =
        [[NSBundle mainBundle] pathForResource:@"Car_year_rateyear.plist" ofType:nil];

    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path_3];

    [self Car_year_rateyear:dic];
  }

  [self Car_loan_interest_rates];

  city_lable.textColor = [Globle colorFromHexRGB:textNameColor];
  sign_label.textColor = [Globle colorFromHexRGB:textNameColor];
  city_lable_1.textColor = [Globle colorFromHexRGB:textNameColor];
  city_lable_2.textColor = [Globle colorFromHexRGB:textNameColor];
  city_lable_3.textColor = [Globle colorFromHexRGB:textNameColor];
  city_lable_4.textColor = [Globle colorFromHexRGB:textNameColor];
  sign_label_2.textColor = [Globle colorFromHexRGB:textNameColor];

  Push_money_textfield.keyboardAppearance = UIKeyboardAppearanceDefault;
  Push_money_textfield.textColor = [Globle colorFromHexRGB:textfieldContentColor];
  Push_money_textfield.layer.borderColor = [Globle colorFromHexRGB:textfieldBordColor].CGColor;
  interest_rate_textfield.keyboardAppearance = UIKeyboardAppearanceDefault;
  interest_rate_textfield.textColor = [Globle colorFromHexRGB:textfieldContentColor];
  interest_rate_textfield.layer.borderColor = [Globle colorFromHexRGB:textfieldBordColor].CGColor;

  Operation_btn.backgroundColor = [Globle colorFromHexRGB:@"2f8ef2"];
}
- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string {
  int MAX_CHARS = 9;
  if (textField.tag == 5000) {
    MAX_CHARS = 5;
  }

  NSMutableString *newtxt = [NSMutableString stringWithString:textField.text];

  [newtxt replaceCharactersInRange:range withString:string];

  return ([newtxt length] <= MAX_CHARS);
}

- (void)Car_loan_interest_rates {
  [[WebServiceManager sharedManager] The_Four_Car_completion:^(NSDictionary *dic) {
    if (dic && [dic[@"status"] isEqualToString:@"0000"]) {
      //存款利息利率 保存 本地
      [dic writeToFile:pathInCacheDirectory(@"Car_year_rateyear.plist") atomically:YES];

      [self Car_year_rateyear:dic];
    }
  }];
}

/// 数据解析  获得新的 贷款年利率
- (void)Car_year_rateyear:(NSDictionary *)dic {
  NSMutableArray *array = [Tools_Car_Loan_object Car_Loan_Rate_reData_analysis:dic];

  [self.YG_Year_Rate removeAllObjects];
  [self.YG_Year_Rate addObjectsFromArray:array];

  [self.YG_bank removeAllObjects];
  for (Tools_Car_Loan_object *Car_object in array) {
    ///去除 公积金
    if (![Car_object.bankName isEqualToString:@"公积金"]) {
      [self.YG_bank addObject:Car_object.bankName];
    }
  }

  /// 获取 指定银行的贷款利率
  [self Setting_interest_rates:The_period_num andBankName:Bank_textfield_btn.city_label.text];
}

///确认，贷款年利率
- (void)Setting_interest_rates:(int)num andBankName:(NSString *)bankName {
  switch (num) {
  case 0: {
    Tools_Car_Loan_object *Car_object = [self Get_Car_Loan:bankName];

    interest_rate_textfield.text = Car_object.six_below_Rate;

    Period_Installments = 6;
  } break;
  case 1: {
    Tools_Car_Loan_object *Car_object = [self Get_Car_Loan:bankName];

    interest_rate_textfield.text = Car_object.one_year_Rate;

    Period_Installments = 12;
  } break;
  case 2: {
    Tools_Car_Loan_object *Car_object = [self Get_Car_Loan:bankName];

    interest_rate_textfield.text = Car_object.three_year_Rate;

    Period_Installments = 24;
  } break;
  case 3: {
    Tools_Car_Loan_object *Car_object = [self Get_Car_Loan:bankName];

    interest_rate_textfield.text = Car_object.three_year_Rate;

    Period_Installments = 36;
  } break;
  case 4: {
    Tools_Car_Loan_object *Car_object = [self Get_Car_Loan:bankName];

    interest_rate_textfield.text = Car_object.five_year_Rate;

    Period_Installments = 48;
  } break;
  case 5: {
    Tools_Car_Loan_object *Car_object = [self Get_Car_Loan:bankName];

    interest_rate_textfield.text = Car_object.five_year_Rate;

    Period_Installments = 60;
  } break;
  default:
    break;
  }
  return;
}

- (Tools_Car_Loan_object *)Get_Car_Loan:(NSString *)bankName {
  for (Tools_Car_Loan_object *car_Object in self.YG_Year_Rate) {
    if ([YouGu_StringWithFormat(bankName) isEqualToString:car_Object.bankName]) {
      return car_Object;
    }
  }
  return nil;
}

#pragma mark -  计算按钮
///计算
- (void)Calculation {
  if ([interest_rate_textfield.text doubleValue] <= 0) {
    YouGu_animation_Did_Start(@"请输入正确的年利率");
    return;
  }
  if ([Push_money_textfield.text doubleValue] <= 0) {
    YouGu_animation_Did_Start(@"请输入符合条件的购买价格");
    return;
  }

  ///总金额
  double Lump_sum = [Push_money_textfield.text doubleValue] * 10000 * (1 - Down_payment * 0.1);
  NSString *Lump_sum_str = [NSString stringWithFormat:@"%0.2lf元", Lump_sum];
  ///还款期数
  NSString *Repayment_num = [NSString stringWithFormat:@"%d期", Period_Installments];
  ///月利率
  float month_Rate = [interest_rate_textfield.text doubleValue] * 0.01 / 12.0;
  /// 1 为等额本息   2 为 等额本金
  if (YLSelectionBtn.row == 0) {
    /// 每月还款额
    double Each_payments_double = (Lump_sum * month_Rate * pow((1 + month_Rate), Period_Installments)) /
                                  (pow((1 + month_Rate), Period_Installments) - 1);
    NSString *Each_payments = [NSString stringWithFormat:@"%0.2lf元", Each_payments_double];
    //            if (Each_payments_double>100000000)
    //            {
    //                Each_payments=[NSString
    //                stringWithFormat:@"%0.2lf亿元",Each_payments_double/100000000.0];
    //            }
    //            else if(Each_payments_double>1000000)
    //            {
    //                Each_payments=[NSString
    //                stringWithFormat:@"%0.2lf万元",Each_payments_double/10000.0];
    //            }
    /// 支付利息
    double Total_interest_double = Each_payments_double * Period_Installments - Lump_sum;
    NSString *Total_interest = [NSString stringWithFormat:@"%0.2lf元", Total_interest_double];
    //            if (Total_interest_double>100000000)
    //            {
    //                Total_interest=[NSString
    //                stringWithFormat:@"%0.2lf亿元",Total_interest_double/100000000.0];
    //            }
    //            else if (Total_interest_double>10000)
    //            {
    //                Total_interest=[NSString
    //                stringWithFormat:@"%0.2lf万元",Total_interest_double/10000.0];
    //            }
    /// 还款总额
    double The_total_repayment_double = Each_payments_double * Period_Installments;
    NSString *The_total_repayment = [NSString stringWithFormat:@"%0.2lf元", The_total_repayment_double];
    //            if (The_total_repayment_double >100000000)
    //            {
    //                The_total_repayment=[NSString
    //                stringWithFormat:@"%0.2lf亿元",The_total_repayment_double/100000000.0];
    //            }
    //            else if(The_total_repayment_double >10000)
    //            {
    //                The_total_repayment=[NSString
    //                stringWithFormat:@"%0.2lf万元",The_total_repayment_double/10000.0];
    //            }
    [Detail_tableView NaL_Matrix_array:@[
      @[ @"等额本息", @"每期等额还款" ],
      @[ @"贷款总额 :", Lump_sum_str ],
      @[ @"贷款期限 :", Repayment_num ],
      @[ @"月均还款 :", Each_payments ],
      @[ @"支付利息 :", Total_interest ],
      @[ @"还款总额 :", The_total_repayment ]
    ] andColumnsWidths:@[ @140, @140 ]];
  }

  else {
    /// 每月还款额
    double Each_payments_double = Lump_sum / Period_Installments + Lump_sum * month_Rate;
    double Each_Difference = (Lump_sum / Period_Installments * month_Rate);
    NSString *Each_payments = [NSString stringWithFormat:@"%0.2lf元", Each_payments_double];
    NSString *Each_DifferenceString = [NSString stringWithFormat:@"%0.2lf元", Each_Difference];
    //            if (Each_payments_double>100000000)
    //            {
    //                if (Each_Difference>100000000)
    //                {
    //                    Each_payments=[NSString
    //                    stringWithFormat:@"%0.2lf亿元(%0.2lf亿元)",Each_payments_double/100000000.0,Each_Difference/100000000.0];
    //                }
    //                else if(Each_Difference>1000000)
    //                {
    //                    Each_payments=[NSString
    //                    stringWithFormat:@"%0.2lf万元(%0.2lf万元)",Each_payments_double/100000000.0,Each_Difference/10000.0];
    //                }
    //                else
    //                {
    //                   Each_payments=[NSString
    //                   stringWithFormat:@"%0.2lf亿元(%0.2lf元)",Each_payments_double/100000000.0,Each_Difference];
    //                }
    //            }
    //            else if(Each_payments_double>1000000)
    //            {
    //                if (Each_Difference>100000000)
    //                {
    //                    Each_payments=[NSString
    //                    stringWithFormat:@"%0.2lf万元(%0.2lf亿元)",Each_payments_double/10000.0,Each_Difference/100000000.0];
    //                }
    //                else if(Each_Difference>1000000)
    //                {
    //                    Each_payments=[NSString
    //                    stringWithFormat:@"%0.2lf万元(%0.2lf万元)",Each_payments_double/10000.0,Each_Difference/10000.0];
    //                }
    //                else
    //                {
    //                    Each_payments=[NSString
    //                    stringWithFormat:@"%0.2lf万元(%0.2lf元)",Each_payments_double/10000.0,Each_Difference];
    //                }
    //            }
    //            else
    //            {
    //                if (Each_Difference>100000000)
    //                {
    //                    Each_payments=[NSString
    //                    stringWithFormat:@"%0.2lf元(%0.2lf亿元)",Each_payments_double,Each_Difference/100000000.0];
    //                }
    //                else if(Each_Difference>1000000)
    //                {
    //                    Each_payments=[NSString
    //                    stringWithFormat:@"%0.2lf元(%0.2lf万元)",Each_payments_double,Each_Difference/10000.0];
    //                }
    //                else
    //                {
    //                    Each_payments=[NSString
    //                    stringWithFormat:@"%0.2lf元(%0.2lf元)",Each_payments_double,Each_Difference];
    //                }
    //            }

    /// 支付利息
    double Total_interest_double = (Lump_sum * month_Rate) * Period_Installments -
                                   Lump_sum * month_Rate / (1.0 * Period_Installments) *
                                       (0 + Period_Installments - 1) * Period_Installments / 2.0;
    NSString *Total_interest = [NSString stringWithFormat:@"%0.2lf元", Total_interest_double];
    //            if (Total_interest_double>100000000)
    //            {
    //                Total_interest=[NSString
    //                stringWithFormat:@"%0.2lf亿元",Total_interest_double/100000000.0];
    //            }
    //            else if (Total_interest_double>10000)
    //            {
    //                Total_interest=[NSString
    //                stringWithFormat:@"%0.2lf万元",Total_interest_double/10000.0];
    //            }
    /// 还款总额
    double The_total_repayment_double = Total_interest_double + Lump_sum;
    NSString *The_total_repayment = [NSString stringWithFormat:@"%0.2lf元", The_total_repayment_double];
    //            if (The_total_repayment_double >100000000)
    //            {
    //                The_total_repayment=[NSString
    //                stringWithFormat:@"%0.2lf亿元",The_total_repayment_double/100000000.0];
    //            }
    //            else if(The_total_repayment_double >10000)
    //            {
    //                The_total_repayment=[NSString
    //                stringWithFormat:@"%0.2lf万元",The_total_repayment_double/10000.0];
    //            }
    [Detail_tableView NaL_Matrix_array:@[
      @[ @"等额本息", @"每期等额还款" ],
      @[ @"贷款总额 :", Lump_sum_str ],
      @[ @"贷款期限 :", Repayment_num ],
      @[ @"首期还款 :", Each_payments ],
      @[ @"每月递减 :", Each_DifferenceString ],
      @[ @"支付利息 :", Total_interest ],
      @[ @"还款总额 :", The_total_repayment ]
    ] andColumnsWidths:@[ @140, @140 ]];
  }
}

#pragma mark - 按钮，选择
- (void)Time_click_btn:(UIButton *)sender {
  if (First_ratio_PickerView == nil) {
    First_ratio_PickerView = [[My_PickerView alloc] initWithFrame:self.view.bounds];
    First_ratio_PickerView.Main_datePicker.tag = 2000;
    First_ratio_PickerView.Title_datePicker.text = @"贷款首付比例";
    First_ratio_PickerView.delegate = self;
    [First_ratio_PickerView.pickerArray addObjectsFromArray:self.YG_Downpayment];
    [self.view addSubview:First_ratio_PickerView];

    if ([self.YG_Downpayment count] >= 1) {
      Down_payment = 0;
      First_ratio_textfield_btn.city_label.text = self.YG_Downpayment[0];
    }
  } else {
    First_ratio_PickerView.hidden = NO;
  }
}

/// 银行， 选择
- (void)Bank_click_btn:(UIButton *)sender {
  if (Bank_PickerView == nil) {
    Bank_PickerView = [[My_PickerView alloc] initWithFrame:self.view.bounds];
    Bank_PickerView.Main_datePicker.tag = 4000;
    Bank_PickerView.Title_datePicker.text = @"储蓄银行";
    Bank_PickerView.delegate = self;
    [Bank_PickerView.pickerArray addObjectsFromArray:self.YG_bank];
    [self.view addSubview:Bank_PickerView];

    if ([self.YG_bank count] >= 1) {
      Bank_textfield_btn.city_label.text = self.YG_bank[0];
      /// 获取 指定银行的贷款利率
      [self Setting_interest_rates:The_period_num andBankName:Bank_textfield_btn.city_label.text];
    }
  } else {
    [Bank_PickerView.pickerArray addObjectsFromArray:self.YG_bank];
    Bank_PickerView.hidden = NO;
  }
}

#pragma mark - 选择商业贷款年利率
- (void)Rate_click_btn:(UIButton *)sender {
  if (The_period_pickerView == nil) {
    The_period_pickerView = [[My_PickerView alloc] initWithFrame:self.view.bounds];
    The_period_pickerView.Main_datePicker.tag = 3000;
    The_period_pickerView.Title_datePicker.text = @"贷款期限";
    The_period_pickerView.delegate = self;
    [The_period_pickerView.pickerArray addObjectsFromArray:self.YG_Loan_period];
    [self.view addSubview:The_period_pickerView];

    if ([self.YG_Loan_period count] >= 1) {
      The_period_num = 0;
      The_period_textfield_btn.city_label.text = self.YG_Loan_period[0];
      /// 获取 指定银行的贷款利率
      [self Setting_interest_rates:The_period_num andBankName:Bank_textfield_btn.city_label.text];
    }
  } else {
    The_period_pickerView.hidden = NO;
  }
}

- (void)Show_PickerView_Time:(NSString *)time andTag:(NSInteger)Tag andSelectRow:(NSInteger)row {
  if (Tag == 2000) {
    Down_payment = (int)row;
    First_ratio_textfield_btn.city_label.text = time;
  } else if (Tag == 3000) {
    The_period_num = (int)row;
    The_period_textfield_btn.city_label.text = time;
    /// 获取 指定银行的贷款利率
    [self Setting_interest_rates:The_period_num andBankName:Bank_textfield_btn.city_label.text];
  } else if (Tag == 4000) {
    Bank_textfield_btn.city_label.text = time;
    /// 获取 指定银行的贷款利率
    [self Setting_interest_rates:The_period_num andBankName:Bank_textfield_btn.city_label.text];
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)selection_btn:(int)row {
  if (YLSelectionBtn.row == 0) {
    [Detail_tableView NaL_Matrix_array:@[
      @[ @"等额本息", @"每期等额还款" ],
      @[ @"贷款总额 :", @"元" ],
      @[ @"贷款期限 :", @"期" ],
      @[ @"月均还款 :", @"元" ],
      @[ @"支付利息 :", @"元" ],
      @[ @"还款总额 :", @"元" ]
    ] andColumnsWidths:@[ @140, @140 ]];
  }
  if (YLSelectionBtn.row == 1) {
    [Detail_tableView NaL_Matrix_array:@[
      @[ @"等额本息", @"每期等额还款" ],
      @[ @"贷款总额 :", @"元" ],
      @[ @"贷款期限 :", @"期" ],
      @[ @"首月还款 :", @"元" ],
      @[ @"每月递减 :", @"元" ],
      @[ @"支付利息 :", @"元" ],
      @[ @"还款总额 :", @"元" ]
    ] andColumnsWidths:@[ @140, @140 ]];
  }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
