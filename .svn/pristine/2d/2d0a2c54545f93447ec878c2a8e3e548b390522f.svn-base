//
//  FourDepositViewController.m
//  优顾理财
//
//  Created by Mac on 14/10/20.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//  存款

#import "FourDepositViewController.h"

#import "Tools_data_object.h"

@implementation FourDepositViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  [self.topNavView setMainLableString:@"存款利息利率"];
  self.content_view.contentSize = CGSizeMake(self.view.width, 450);

  Type_num = 0;
  Rate_Proportion = 0.0;
  _deposit_array = [[NSMutableArray alloc] initWithCapacity:0];
  if (YouGu_fileExistsAtPath(pathInCacheDirectory(@"DepositRate_array.plist"))) {
    NSDictionary *dic = [NSDictionary
        dictionaryWithContentsOfFile:pathInCacheDirectory(@"DepositRate_array.plist")];

    [self DepositRate_reData_analysis:dic];
  } else {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"DepositRate_array.plist" ofType:nil];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    [self DepositRate_reData_analysis:dic];
  }

  NSString *path_1 = [[NSBundle mainBundle] pathForResource:@"Storage_Type.plist" ofType:nil];
  YG_type = [[NSArray alloc] initWithContentsOfFile:path_1];

  YG_days = @[ @"天", @"月" ];

  if (YouGu_fileExistsAtPath(pathInCacheDirectory(@"BankName.plist"))) {
    YG_bank =
        [[NSMutableArray alloc] initWithContentsOfFile:pathInCacheDirectory(@"BankName.plist")];
  } else {
    NSString *path_2 = [[NSBundle mainBundle] pathForResource:@"BankName.plist" ofType:nil];
    YG_bank = [[NSMutableArray alloc] initWithContentsOfFile:path_2];
  }

  //存款金额
  UILabel *city_lable = [[UILabel alloc] initWithFrame:CGRectMake(30, 20, 80, 30)];
  city_lable.text = @"存款金额 :";
  city_lable.textColor = [Globle colorFromHexRGB:textNameColor];
  city_lable.backgroundColor = [UIColor clearColor];
  city_lable.textAlignment = NSTextAlignmentRight;
  city_lable.font = [UIFont systemFontOfSize:15];
  [self.content_view addSubview:city_lable];

  Capital_money_textfield = [[ExpressTextField alloc] initWithFrame:CGRectMake(120, 20, 100, 30)];
  Capital_money_textfield.layer.cornerRadius = 5;
  Capital_money_textfield.layer.borderWidth = 1.0f;
  Capital_money_textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  [Capital_money_textfield.layer setBorderColor:[Globle colorFromHexRGB:textfieldBordColor].CGColor];
  Capital_money_textfield.textColor = [Globle colorFromHexRGB:textfieldContentColor];
  Capital_money_textfield.keyboardType = UIKeyboardTypeNumberPad;
  Capital_money_textfield.delegate = self;
  [Capital_money_textfield setSpaceAtStart];
  [self.content_view addSubview:Capital_money_textfield];

  UILabel *sign_label = [[UILabel alloc] initWithFrame:CGRectMake(230, 20, 20, 30)];
  sign_label.text = @"元";
  sign_label.textColor = [Globle colorFromHexRGB:textNameColor];
  sign_label.backgroundColor = [UIColor clearColor];
  sign_label.textAlignment = NSTextAlignmentLeft;
  sign_label.font = [UIFont systemFontOfSize:15];
  [self.content_view addSubview:sign_label];

  //储蓄类型
  UILabel *city_lable_1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 70, 80, 30)];
  city_lable_1.text = @"存款类型 :";
  city_lable_1.textColor = [Globle colorFromHexRGB:textNameColor];
  city_lable_1.backgroundColor = [UIColor clearColor];
  city_lable_1.textAlignment = NSTextAlignmentRight;
  city_lable_1.font = [UIFont systemFontOfSize:15];
  [self.content_view addSubview:city_lable_1];

  Type_textfield_btn = [[Textfield_btn alloc] initWithFrame:CGRectMake(120, 70, 100, 30)];
  Type_textfield_btn.city_label.text = @"活期存款";
  [Type_textfield_btn.click_btn addTarget:self
                                   action:@selector(Type_click_btn:)
                         forControlEvents:UIControlEventTouchUpInside];
  [self.content_view addSubview:Type_textfield_btn];

  Second_time_View = [[UIView alloc] initWithFrame:CGRectMake(220, 70, 100, 30)];
  [self.content_view addSubview:Second_time_View];

  Day_Input_box = [[ExpressTextField alloc] initWithFrame:CGRectMake(3, 0, 60, 30)];
  Day_Input_box.layer.cornerRadius = 5;
  Day_Input_box.tag = 5000;
  Day_Input_box.layer.borderWidth = 1.0f;
  Day_Input_box.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  [Day_Input_box.layer setBorderColor:[Globle colorFromHexRGB:textfieldBordColor].CGColor];
  [Day_Input_box setTextColor:[Globle colorFromHexRGB:textfieldContentColor]];
  Day_Input_box.keyboardType = UIKeyboardTypeNumberPad;
  Day_Input_box.delegate = self;
  [Day_Input_box setSpaceAtStart];
  [Second_time_View addSubview:Day_Input_box];

  Days_textfield_btn = [[Textfield_btn alloc] initWithFrame:CGRectMake(65, 0, 30, 30)];
  Days_textfield_btn.city_label.text = @"天";
  [Days_textfield_btn.click_btn addTarget:self
                                   action:@selector(Days_click_btn:)
                         forControlEvents:UIControlEventTouchUpInside];
  [Second_time_View addSubview:Days_textfield_btn];

  //储蓄银行
  UILabel *city_lable_3 = [[UILabel alloc] initWithFrame:CGRectMake(30, 120, 80, 30)];
  city_lable_3.text = @"储蓄银行 :";
  city_lable_3.textColor = [Globle colorFromHexRGB:textNameColor];
  city_lable_3.backgroundColor = [UIColor clearColor];
  city_lable_3.textAlignment = NSTextAlignmentRight;
  city_lable_3.font = [UIFont systemFontOfSize:15];
  [self.content_view addSubview:city_lable_3];

  Bank_textfield_btn = [[Textfield_btn alloc] initWithFrame:CGRectMake(120, 120, 100, 30)];
  Bank_textfield_btn.city_label.text = @"基准利率";
  [Bank_textfield_btn.click_btn addTarget:self
                                   action:@selector(Bank_click_btn:)
                         forControlEvents:UIControlEventTouchUpInside];
  [self.content_view addSubview:Bank_textfield_btn];

  //年利率
  UILabel *city_lable_4 = [[UILabel alloc] initWithFrame:CGRectMake(30, 170, 80, 30)];
  city_lable_4.text = @"年利率 :";
  city_lable_4.textColor = [Globle colorFromHexRGB:textNameColor];
  city_lable_4.backgroundColor = [UIColor clearColor];
  city_lable_4.textAlignment = NSTextAlignmentRight;
  city_lable_4.font = [UIFont systemFontOfSize:15];
  [self.content_view addSubview:city_lable_4];

  APR_rate_textfield = [[ExpressTextField alloc] initWithFrame:CGRectMake(120, 170, 100, 30)];
  APR_rate_textfield.layer.cornerRadius = 5;
  APR_rate_textfield.layer.borderWidth = 1.0f;
  APR_rate_textfield.tag = 6000;
  APR_rate_textfield.textColor = [Globle colorFromHexRGB:textfieldContentColor];
  [APR_rate_textfield.layer setBorderColor:[Globle colorFromHexRGB:textfieldBordColor].CGColor];
  APR_rate_textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  APR_rate_textfield.keyboardType = UIKeyboardTypeDecimalPad;
  APR_rate_textfield.delegate = self;
  [APR_rate_textfield setSpaceAtStart];
  [self.content_view addSubview:APR_rate_textfield];

  UILabel *sign_label_2 = [[UILabel alloc] initWithFrame:CGRectMake(230, 170, 20, 30)];
  sign_label_2.text = @"％";
  sign_label_2.backgroundColor = [UIColor clearColor];
  sign_label_2.textColor = [Globle colorFromHexRGB:textNameColor];
  sign_label_2.textAlignment = NSTextAlignmentLeft;
  sign_label_2.font = [UIFont systemFontOfSize:15];
  [self.content_view addSubview:sign_label_2];

  Prompt_label = [[UILabel alloc] initWithFrame:CGRectMake(120, 195, 200, 30)];
  Prompt_label.text = @"没有该存款期限的年利率";
  Prompt_label.hidden = YES;
  Prompt_label.backgroundColor = [UIColor clearColor];
  Prompt_label.textColor = [Globle colorFromHexRGB:@"b10000"];
  Prompt_label.textAlignment = NSTextAlignmentLeft;
  Prompt_label.font = [UIFont boldSystemFontOfSize:10];
  [self.content_view addSubview:Prompt_label];

  //计算
  UIButton *Operation_btn = [UIButton buttonWithType:UIButtonTypeCustom];
  Operation_btn.frame = CGRectMake(self.view.width / 4, 220, self.view.width / 2, 30);
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

  Detail_tableView = [[NALMatrixTableView alloc]
         initWithFrame:CGRectMake(30, 270, 260, 30)
              andArray:@[ @[ @" ", @"结果" ],
                          @[ @"利息总额", @"元" ],
                          @[ @"本息合计", @"元" ] ]
      andColumnsWidths:@[ @80, @180 ]];
  [self.content_view addSubview:Detail_tableView];

  [self DepositRate];
  //基准利率
  [self Get_APR_rate:Type_num andBankName:@"基准利率"];

  city_lable.textColor = [Globle colorFromHexRGB:textfieldContentColor];
  sign_label.textColor = [Globle colorFromHexRGB:textfieldContentColor];
  city_lable_1.textColor = [Globle colorFromHexRGB:textfieldContentColor];
  city_lable_3.textColor = [Globle colorFromHexRGB:textfieldContentColor];
  city_lable_4.textColor = [Globle colorFromHexRGB:textfieldContentColor];
  sign_label_2.textColor = [Globle colorFromHexRGB:textfieldContentColor];

  Capital_money_textfield.keyboardAppearance = UIKeyboardAppearanceDefault;
  Capital_money_textfield.textColor = [Globle colorFromHexRGB:textfieldContentColor];
  Capital_money_textfield.layer.borderColor = [Globle colorFromHexRGB:textfieldBordColor].CGColor;
  Day_Input_box.keyboardAppearance = UIKeyboardAppearanceDefault;
  Day_Input_box.textColor = [Globle colorFromHexRGB:textfieldContentColor];
  Day_Input_box.layer.borderColor = [Globle colorFromHexRGB:textfieldBordColor].CGColor;
  APR_rate_textfield.keyboardAppearance = UIKeyboardAppearanceDefault;
  APR_rate_textfield.textColor = [Globle colorFromHexRGB:textfieldContentColor];
  APR_rate_textfield.layer.borderColor = [Globle colorFromHexRGB:textfieldBordColor].CGColor;

  Operation_btn.backgroundColor = [Globle colorFromHexRGB:@"2f8ef2"];
}

- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string {
  if ([APR_rate_textfield.text doubleValue] > 0) {
    Prompt_label.hidden = YES;
  }

  int MAX_CHARS = 9;
  if (textField.tag == 5000) {
    MAX_CHARS = 4;
  } else if (textField.tag == 6000) {
    MAX_CHARS = 5;
  }

  NSMutableString *newtxt = [NSMutableString stringWithString:textField.text];

  [newtxt replaceCharactersInRange:range withString:string];

  return ([newtxt length] <= MAX_CHARS);
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
  if ([APR_rate_textfield.text doubleValue] > 0) {
    Prompt_label.hidden = YES;
  }
  return YES;
}

//= 存款利息利率
#pragma mark -  存款利息利率
- (void)DepositRate {
  [[WebServiceManager sharedManager] The_depositRate_completion:^(NSDictionary *dic) {
    if (dic && [dic[@"status"] isEqualToString:@"0000"]) {
      //存款利息利率 保存 本地
      [dic writeToFile:pathInCacheDirectory(@"DepositRate_array.plist") atomically:YES];

      NSMutableArray *Bank_array = [[NSMutableArray alloc] initWithCapacity:0];
      NSArray *depositRate_array = dic[@"depositList"];
      for (NSDictionary *bank_dic in depositRate_array) {
        [Bank_array addObject:YouGu_ishave_blank(bank_dic[@"bankName"])];
      }
      //储蓄银行
      [Bank_array writeToFile:pathInCacheDirectory(@"BankName.plist") atomically:YES];

      if ([Bank_array count] > 0) {
        [YG_bank removeAllObjects];
        [YG_bank addObjectsFromArray:Bank_array];
      }
    }
  }];
}

- (void)DepositRate_reData_analysis:(NSDictionary *)dic {
  NSMutableArray *bank_deposit_array = [Tools_Bank_depositRate_object DepositRate_reData_analysis:dic];

  if ([bank_deposit_array count] > 0) {
    [self.deposit_array removeAllObjects];
    [self.deposit_array addObjectsFromArray:bank_deposit_array];
  }
}

#pragma mark -  计算按钮
//计算
- (void)Calculation {
  if ([APR_rate_textfield.text doubleValue] > 0) {
    Prompt_label.hidden = YES;
  }

  if ([Capital_money_textfield.text doubleValue] > 0) {
    if (Type_num == 0 && [Day_Input_box.text doubleValue] <= 0) {
      YouGu_animation_Did_Start(@"请输入活期存储天数");
      return;
    }

    [self get_Year_Rate:Type_num];
    if (Rate_Proportion <= 0) {
      Prompt_label.hidden = NO;
      return;
    }
    //   本息
    double Interest_double = [Capital_money_textfield.text doubleValue] * Rate_Proportion;

    //   合计
    double Sum_double = [Capital_money_textfield.text doubleValue] * (1 + Rate_Proportion);

    if (Type_num == 0) {
      if ([Days_textfield_btn.city_label.text isEqualToString:@"月"]) {
        //   本息
        Interest_double = Interest_double * [Day_Input_box.text doubleValue] * 30;
        //   合计
        Sum_double = [Capital_money_textfield.text doubleValue] + Interest_double;
      } else {
        //   本息
        Interest_double = Interest_double * [Day_Input_box.text doubleValue];
        //   合计
        Sum_double = [Capital_money_textfield.text doubleValue] + Interest_double;
      }
    }
    NSString *Sum = [NSString stringWithFormat:@"%0.2lf元", Sum_double];
    NSString *Interest = [NSString stringWithFormat:@"%0.2lf元", Interest_double];
    if (Interest_double > 100000000) {
      Interest = [NSString stringWithFormat:@"%0.2lf元", Interest_double];
    } else if (Interest_double > 10000) {
      Interest = [NSString stringWithFormat:@"%0.2lf元", Interest_double];
    }

    if (Sum_double > 100000000) {
      Sum = [NSString stringWithFormat:@"%0.2lf元", Sum_double];
    } else if (Sum_double > 10000) {
      Sum = [NSString stringWithFormat:@"%0.2lf元", Sum_double];
    }

    [Detail_tableView
        NaL_Matrix_array:
            @[ @[ @" ", @"结果" ], @[ @"利息总额", Interest ], @[ @"本息合计", Sum ] ]
        andColumnsWidths:@[ @80, @180 ]];
  } else {
    YouGu_animation_Did_Start(@"请输入本金");
  }
}

#pragma mark -  自行填写  年利率，计算
- (void)get_Year_Rate:(int)num {
  switch (num) {
  case 0: {
    Rate_Proportion = [APR_rate_textfield.text doubleValue] * 0.01 / 360;
  } break;
  case 1: {
    Rate_Proportion = 3 * [APR_rate_textfield.text doubleValue] * 0.01 / 12;
  } break;
  case 2: {
    Rate_Proportion = 6 * [APR_rate_textfield.text doubleValue] * 0.01 / 12;
  } break;
  case 3: {
    Rate_Proportion = 12 * [APR_rate_textfield.text doubleValue] * 0.01 / 12;
  } break;
  case 4: {
    Rate_Proportion = 24 * [APR_rate_textfield.text doubleValue] * 0.01 / 12;
  } break;
  case 5: {
    Rate_Proportion = 36 * [APR_rate_textfield.text doubleValue] * 0.01 / 12;
  } break;
  case 6: {
    Rate_Proportion = 60 * [APR_rate_textfield.text doubleValue] * 0.01 / 12;
  } break;
  default:
    break;
  }
}

#pragma mark -  自定义textfield
- (void)Type_click_btn:(UIButton *)sender {
  if (Type_PickerView == nil) {
    Type_PickerView = [[My_PickerView alloc] initWithFrame:self.view.bounds];
    Type_PickerView.Main_datePicker.tag = 2000;
    Type_PickerView.Title_datePicker.text = @"存款类型";
    Type_PickerView.delegate = self;
    [Type_PickerView.pickerArray addObjectsFromArray:YG_type];
    [self.view addSubview:Type_PickerView];

    if ([YG_type count] >= 1) {
      Type_textfield_btn.city_label.text = YG_type[0];
      Type_num = 0;
      [self Get_APR_rate:Type_num andBankName:Bank_textfield_btn.city_label.text];
      if ([YG_type[0] isEqualToString:@"活期存款"]) {
        Second_time_View.hidden = NO;
      } else {
        Second_time_View.hidden = YES;
      }
    }
  } else {
    Type_PickerView.hidden = NO;
  }
}

- (void)Show_PickerView_Time:(NSString *)time andTag:(NSInteger)Tag andSelectRow:(NSInteger)row {
  if (Tag == 2000) {
    Type_textfield_btn.city_label.text = time;
    if ([time isEqualToString:@"活期存款"]) {
      Second_time_View.hidden = NO;
    } else {
      Second_time_View.hidden = YES;
    }
    Type_num = (int)row;
    [self Get_APR_rate:Type_num andBankName:Bank_textfield_btn.city_label.text];
  } else if (Tag == 3000) {
    Days_textfield_btn.city_label.text = time;
  } else if (Tag == 4000) {
    Bank_textfield_btn.city_label.text = time;

    [self Get_APR_rate:Type_num andBankName:time];
  }
}
///通过  存款类型，和 银行，选择年利率
- (void)Get_APR_rate:(int)num andBankName:(NSString *)bankName {
  switch (num) {
  case 0: {
    Tools_Bank_depositRate_object *bank_deposit_object = [self Get_Bank_deposit:bankName];

    APR_rate_textfield.text = bank_deposit_object.currentDepositRate;

    Rate_Proportion = [APR_rate_textfield.text doubleValue] * 0.01 / 360;
  } break;
  case 1: {
    Tools_Bank_depositRate_object *bank_deposit_object = [self Get_Bank_deposit:bankName];

    APR_rate_textfield.text = bank_deposit_object.fixedDeposit3month;

    Rate_Proportion = 3 * [APR_rate_textfield.text doubleValue] * 0.01 / 12;
  } break;
  case 2: {
    Tools_Bank_depositRate_object *bank_deposit_object = [self Get_Bank_deposit:bankName];

    APR_rate_textfield.text = bank_deposit_object.fixedDeposit6month;

    Rate_Proportion = 6 * [APR_rate_textfield.text doubleValue] * 0.01 / 12;
  } break;
  case 3: {
    Tools_Bank_depositRate_object *bank_deposit_object = [self Get_Bank_deposit:bankName];

    APR_rate_textfield.text = bank_deposit_object.fixedDeposit1year;

    Rate_Proportion = 12 * [APR_rate_textfield.text doubleValue] * 0.01 / 12;
  } break;
  case 4: {
    Tools_Bank_depositRate_object *bank_deposit_object = [self Get_Bank_deposit:bankName];

    APR_rate_textfield.text = bank_deposit_object.fixedDeposit2year;

    Rate_Proportion = 24 * [APR_rate_textfield.text doubleValue] * 0.01 / 12;
  } break;
  case 5: {
    Tools_Bank_depositRate_object *bank_deposit_object = [self Get_Bank_deposit:bankName];

    APR_rate_textfield.text = bank_deposit_object.fixedDeposit3year;

    Rate_Proportion = 36 * [APR_rate_textfield.text doubleValue] * 0.01 / 12;
  } break;
  case 6: {
    Tools_Bank_depositRate_object *bank_deposit_object = [self Get_Bank_deposit:bankName];

    APR_rate_textfield.text = bank_deposit_object.fixedDeposit5year;

    Rate_Proportion = 60 * [APR_rate_textfield.text doubleValue] * 0.01 / 12;
  } break;
  default:
    break;
  }
  if ([APR_rate_textfield.text doubleValue] > 0) {
    Prompt_label.hidden = YES;
  }
  return;
}

- (Tools_Bank_depositRate_object *)Get_Bank_deposit:(NSString *)bankName {
  for (Tools_Bank_depositRate_object *bank_Object in self.deposit_array) {
    if ([YouGu_StringWithFormat(bankName) isEqualToString:bank_Object.bankName]) {
      return bank_Object;
    }
  }
  return nil;
}

- (void)Days_click_btn:(UIButton *)sener {
  if (Days_PickerView == nil) {
    Days_PickerView = [[My_PickerView alloc] initWithFrame:self.view.bounds];
    Days_PickerView.Main_datePicker.tag = 3000;
    Days_PickerView.Title_datePicker.text = @"时间单位";
    Days_PickerView.delegate = self;
    [Days_PickerView.pickerArray addObjectsFromArray:YG_days];
    [self.view addSubview:Days_PickerView];

  } else {
    [Days_PickerView.pickerArray addObjectsFromArray:YG_days];
    Days_PickerView.hidden = NO;
  }
}
- (void)Bank_click_btn:(UIButton *)sender {
  if (Bank_PickerView == nil) {
    Bank_PickerView = [[My_PickerView alloc] initWithFrame:self.view.bounds];
    Bank_PickerView.Main_datePicker.tag = 4000;
    Bank_PickerView.Title_datePicker.text = @"储蓄银行";
    Bank_PickerView.delegate = self;
    [Bank_PickerView.pickerArray addObjectsFromArray:YG_bank];
    [self.view addSubview:Bank_PickerView];

    if ([YG_bank count] >= 1) {
      Bank_textfield_btn.city_label.text = YG_bank[0];

      [self Get_APR_rate:Type_num andBankName:YG_bank[0]];
    }
  } else {
    [Bank_PickerView.pickerArray addObjectsFromArray:YG_bank];

    Bank_PickerView.hidden = NO;
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
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
