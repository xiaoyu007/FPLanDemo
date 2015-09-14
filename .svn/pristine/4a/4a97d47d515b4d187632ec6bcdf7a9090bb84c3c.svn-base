//
//  LoansRepaymentView.m
//  优顾理财
//
//  Created by Mac on 14/10/22.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//    房贷提前还款

#import "LoansRepaymentView.h"
#import "Textfield+btn.h"
#import "NALMatrixTableView.h"
#import "SettingButton.h"
#import "ExpressTextField.h"
@implementation LoansRepaymentView {
  ///贷款方式
  YL_SelectionButton *YLselectBtn1;

  ///还款方式
  YL_SelectionButton *YLselectBtn2;

  ///处理方式
  YL_SelectionButton *YLselectBtn3;

  ///贷款总额
  ExpressTextField *textFieldForTotalLoan;

  ///  原贷款期限
  Textfield_btn *ButtonForChosingYear;

  ///  原贷款期限  选择器
  My_PickerView *yearPickerView;

  ///  首次还款时间 按钮
  Textfield_btn *buttonForChosingFirstTime;

  ///  第一次还款时间 选择器
  My_Datepicker *firstRepaymentTimePickerView;

  ///  预期提前还款时间  按钮
  Textfield_btn *buttonForChosingExceptTime;

  ///  预期提前还款时间  选择器
  My_Datepicker *expectedTimePickerView;

  //基准利率的［］倍 输入框
  ExpressTextField *textFieldForMultiple;

  /// 提前还款方式
  int methodOfAdvanceRepayment;

  ///  提前还款方式
  SettingButton *button1;
  SettingButton *button2;

  ///  部分提前还清金额
  ExpressTextField *textFieldForAdvancedMoney;

  /// 结果表格
  NALMatrixTableView *detailTableView;

  ///表格中显示
  NSArray *tableArray;

  ///   数据
  NSArray *YGtime;
  NSArray *YG_First_time;
  NSArray *YG_Expected_time;
  NSArray *YGrate;

  ///  年利率倍数
  int yearRateNum;

  ///输入框中的倍数
  NSString *text0;

  /// 选择还款方式，1，等额本息  2 等额本金
  int Repayment;

  ///   贷款期限 的num
  int numOfLoanPeriod;

  ///显示“处理方式”
  UILabel *label12;

  ///计算按钮
  UIButton *buttonOfCalculate;

  ///重置按钮
  UIButton *buttonOfReset;

  ///分割线
  UIView *viewOfBreak;

  ///首次还款日历时间
  NSArray *timeArray1;

  ///提前还款日历时间
  NSArray *timeArray2;
}

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.contentSize = CGSizeMake(self.width, 900);

    [self createUI];
  }
  return self;
}

//创建显示界面
- (void)createUI {
  Repayment = 1;
  methodOfAdvanceRepayment = 1;

  NSString *path1 = [[NSBundle mainBundle] pathForResource:@"贷款期限.plist" ofType:nil];
  YGtime = [[NSMutableArray alloc] initWithContentsOfFile:path1];

  NSString *path2 = [[NSBundle mainBundle] pathForResource:@"所有年利率.plist" ofType:nil];
  YGrate = [[NSMutableArray alloc] initWithContentsOfFile:path2];

  NSArray *array1 = @[ @"商业贷款", @"公积金贷款" ];
  YLselectBtn1 = [[YL_SelectionButton alloc] initWithFrame:CGRectMake(0, 5, self.width, 50)
                                                  andTitle:@"贷款方式 :"
                                                   andType:1
                                                  andArray:array1];
  YLselectBtn1.backgroundColor = [UIColor clearColor];
  [self addSubview:YLselectBtn1];

  NSArray *array2 = @[ @"等额本息", @"等额本金" ];
  YLselectBtn2 = [[YL_SelectionButton alloc] initWithFrame:CGRectMake(0, 40, self.width, 50)
                                                  andTitle:@"还款方式 :"
                                                   andType:1
                                                  andArray:array2];
  YLselectBtn2.backgroundColor = [UIColor clearColor];
  YLselectBtn2.delegate = self;
  [self addSubview:YLselectBtn2];

  //贷款总额
  UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(50, 75, 80, 30)];
  label1.text = @"贷款总额 :";
  label1.backgroundColor = [UIColor clearColor];
  label1.textAlignment = NSTextAlignmentRight;
  label1.textColor = [Globle colorFromHexRGB:textNameColor];
  label1.font = [UIFont systemFontOfSize:15];
  [self addSubview:label1];

  textFieldForTotalLoan = [[ExpressTextField alloc] initWithFrame:CGRectMake(140, 75, 110, 30)];
  textFieldForTotalLoan.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  textFieldForTotalLoan.tag = 100;
  textFieldForTotalLoan.layer.cornerRadius = 5;
  textFieldForTotalLoan.layer.borderWidth = 1.0f;
  textFieldForTotalLoan.keyboardType = UIKeyboardTypeDecimalPad;
  textFieldForTotalLoan.layer.borderColor = [Globle colorFromHexRGB:textfieldBordColor].CGColor;
  textFieldForTotalLoan.delegate = self;
  [textFieldForTotalLoan setSpaceAtStart];
  [self addSubview:textFieldForTotalLoan];

  UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(250, 75, 30, 30)];
  label2.text = @"万元";
  label2.backgroundColor = [UIColor clearColor];
  label2.textAlignment = NSTextAlignmentLeft;
  label2.font = [UIFont systemFontOfSize:15];
  label2.textColor = [Globle colorFromHexRGB:textNameColor];
  [self addSubview:label2];

  //原贷款期限
  UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 115, 120, 30)];
  label3.backgroundColor = [UIColor clearColor];
  label3.text = @"贷款期限 :";
  label3.textAlignment = NSTextAlignmentRight;
  label3.font = [UIFont systemFontOfSize:15];
  label3.textColor = [Globle colorFromHexRGB:textNameColor];
  [self addSubview:label3];

  ButtonForChosingYear = [[Textfield_btn alloc] initWithFrame:CGRectMake(140, 115, 110, 30)];
  ButtonForChosingYear.city_label.text = @"5年";
  ButtonForChosingYear.layer.borderWidth = 1.0f;
  [ButtonForChosingYear.click_btn addTarget:self
                                     action:@selector(yearClickBtn:)
                           forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:ButtonForChosingYear];

  //首次还款时间
  UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(10, 160, 120, 30)];
  label4.backgroundColor = [UIColor clearColor];
  label4.text = @"首次还款时间 :";
  label4.textColor = [Globle colorFromHexRGB:textNameColor];
  label4.textAlignment = NSTextAlignmentRight;
  label4.font = [UIFont systemFontOfSize:15];
  [self addSubview:label4];

  buttonForChosingFirstTime = [[Textfield_btn alloc] initWithFrame:CGRectMake(140, 160, 110, 30)];
  buttonForChosingFirstTime.city_label.text = [self stringFromDate:[NSDate date]];
  [buttonForChosingFirstTime.click_btn addTarget:self
                                          action:@selector(firstRepaymentTimeClickBtn:)
                                forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:buttonForChosingFirstTime];

  //预期提前还款时间
  UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(0, 210, 130, 30)];
  label5.backgroundColor = [UIColor clearColor];
  label5.text = @"提前还款时间 :";
  label5.textColor = [Globle colorFromHexRGB:textNameColor];
  label5.textAlignment = NSTextAlignmentRight;
  label5.font = [UIFont systemFontOfSize:15];
  [self addSubview:label5];

  buttonForChosingExceptTime = [[Textfield_btn alloc] initWithFrame:CGRectMake(140, 210, 110, 30)];
  buttonForChosingExceptTime.city_label.text = [self stringFromDate:[NSDate date]];
  [buttonForChosingExceptTime.click_btn addTarget:self
                                           action:@selector(ExpectedTimeClickBtn:)
                                 forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:buttonForChosingExceptTime];

  //年利率
  UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(70, 260, 140, 30)];
  label6.backgroundColor = [UIColor clearColor];
  label6.text = @"年利率 : 基准利率的";
  label6.textColor = [Globle colorFromHexRGB:textNameColor];
  label6.textAlignment = NSTextAlignmentCenter;
  label6.font = [UIFont systemFontOfSize:15];
  [self addSubview:label6];

  textFieldForMultiple = [[ExpressTextField alloc] initWithFrame:CGRectMake(210, 260, 50, 30)];
  textFieldForMultiple.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  textFieldForMultiple.tag = 200;
  textFieldForMultiple.layer.cornerRadius = 5;
  textFieldForMultiple.layer.borderWidth = 1.0f;
  textFieldForMultiple.keyboardType = UIKeyboardTypeDecimalPad;
  textFieldForMultiple.layer.borderColor = [Globle colorFromHexRGB:textfieldBordColor].CGColor;
  text0 = @"1.0";
  textFieldForMultiple.textColor = [Globle colorFromHexRGB:textfieldContentColor];
  textFieldForMultiple.text = text0;
  textFieldForMultiple.delegate = self;
  textFieldForMultiple.textAlignment = NSTextAlignmentCenter;
  [self addSubview:textFieldForMultiple];

  UILabel *label7 = [[UILabel alloc] initWithFrame:CGRectMake(260, 260, 20, 30)];
  label7.text = @"倍";
  label7.backgroundColor = [UIColor clearColor];
  label7.textAlignment = NSTextAlignmentCenter;
  label7.textColor = [Globle colorFromHexRGB:textNameColor];
  label7.font = [UIFont systemFontOfSize:15];
  [self addSubview:label7];

  //提前还款方式
  UILabel *label8 = [[UILabel alloc] initWithFrame:CGRectMake(5, 300, 120, 30)];
  label8.text = @"提前还款方式 :";
  label8.textColor = [Globle colorFromHexRGB:textNameColor];
  label8.backgroundColor = [UIColor clearColor];
  label8.textAlignment = NSTextAlignmentRight;
  label8.font = [UIFont systemFontOfSize:15];
  [self addSubview:label8];

  //一次提前还清
  button1 = [[SettingButton alloc] initWithFrame:CGRectMake(80, 345, 20, 20) andIs_eq:YES];
  [button1 addTarget:self
                action:@selector(btn2Click:)
      forControlEvents:UIControlEventTouchUpInside];
  button1.tag = 40000;
  button1.selected = NO;
  [self addSubview:button1];

  UILabel *label9 = [[UILabel alloc] initWithFrame:CGRectMake(100, 340, 100, 30)];
  label9.backgroundColor = [UIColor clearColor];
  label9.text = @"一次提前还清";
  label9.textColor = [Globle colorFromHexRGB:textNameColor];
  label9.textAlignment = NSTextAlignmentLeft;
  label9.font = [UIFont systemFontOfSize:15];
  [self addSubview:label9];

  //部分提前还清
  button2 = [[SettingButton alloc] initWithFrame:CGRectMake(80, 385, 20, 20) andIs_eq:YES];
  [button2 addTarget:self
                action:@selector(btn2Click:)
      forControlEvents:UIControlEventTouchUpInside];
  button2.tag = 50000;
  button2.selected = YES;
  [self addSubview:button2];

  UILabel *label10 = [[UILabel alloc] initWithFrame:CGRectMake(100, 380, 100, 30)];
  label10.backgroundColor = [UIColor clearColor];
  label10.text = @"部分提前还清";
  label10.textColor = [Globle colorFromHexRGB:textNameColor];
  label10.textAlignment = NSTextAlignmentLeft;
  label10.font = [UIFont systemFontOfSize:15];
  [self addSubview:label10];

  textFieldForAdvancedMoney = [[ExpressTextField alloc] initWithFrame:CGRectMake(190, 380, 80, 30)];
  textFieldForAdvancedMoney.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  textFieldForAdvancedMoney.tag = 300;
  textFieldForAdvancedMoney.layer.cornerRadius = 5;
  textFieldForAdvancedMoney.layer.borderWidth = 1.0f;
  textFieldForAdvancedMoney.keyboardType = UIKeyboardTypeDecimalPad;
  textFieldForAdvancedMoney.layer.borderColor = [Globle colorFromHexRGB:textfieldBordColor].CGColor;
  textFieldForAdvancedMoney.delegate = self;
  [textFieldForAdvancedMoney setSpaceAtStart];
  [self addSubview:textFieldForAdvancedMoney];

  UILabel *label11 = [[UILabel alloc] initWithFrame:CGRectMake(270, 380, 30, 30)];
  label11.text = @"万元";
  label11.backgroundColor = [UIColor clearColor];
  label11.textColor = [Globle colorFromHexRGB:textNameColor];
  label11.textAlignment = NSTextAlignmentLeft;
  label11.font = [UIFont systemFontOfSize:15];
  [self addSubview:label11];

  //处理方式
  label12 = [[UILabel alloc] initWithFrame:CGRectMake(50, 420, 70, 30)];
  label12.backgroundColor = [UIColor clearColor];
  label12.text = @"处理方式 :";
  label12.textColor = [Globle colorFromHexRGB:textNameColor];
  label12.textAlignment = NSTextAlignmentRight;
  label12.font = [UIFont systemFontOfSize:15];
  [self addSubview:label12];
  // clang-format off
  NSArray *array3 = @[ @"缩短还款年限,月还款额基本不变",
                       @"减少月还款额,还款期不变" ];
  // clang-format on
  YLselectBtn3 = [[YL_SelectionButton alloc] initWithFrame:CGRectMake(30, 420, self.width, 130)
                                                  andTitle:@""
                                                   andType:2
                                                  andArray:array3];
  YLselectBtn3.backgroundColor = [UIColor clearColor];
  [self addSubview:YLselectBtn3];

  ///计算
  buttonOfCalculate = [UIButton buttonWithType:UIButtonTypeCustom];
  buttonOfCalculate.frame = CGRectMake(55, 550, 100, 30);
  buttonOfCalculate.backgroundColor = [Globle colorFromHexRGB:@"2f8ef2"];
  buttonOfCalculate.layer.cornerRadius = 5;
  [buttonOfCalculate addTarget:self
                        action:@selector(Calculation)
              forControlEvents:UIControlEventTouchUpInside];
  [buttonOfCalculate setTitle:@"计算" forState:UIControlStateNormal];
  buttonOfCalculate.titleLabel.textAlignment = NSTextAlignmentCenter;
  buttonOfCalculate.titleLabel.font = [UIFont systemFontOfSize:15];
  [self addSubview:buttonOfCalculate];
  UIImage *highlightImage = [FPYouguUtil createImageWithColor:buttonHighLightColor];
  [buttonOfCalculate setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
  ///重置
  buttonOfReset = [UIButton buttonWithType:UIButtonTypeCustom];
  buttonOfReset.frame = CGRectMake(165, 550, 100, 30);
  buttonOfReset.backgroundColor = [Globle colorFromHexRGB:@"2f8ef2"];
  buttonOfReset.layer.cornerRadius = 5;
  [buttonOfReset setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
  [buttonOfReset setTitle:@"重置" forState:UIControlStateNormal];
  buttonOfReset.titleLabel.textAlignment = NSTextAlignmentCenter;
  buttonOfReset.titleLabel.font = [UIFont systemFontOfSize:15];
  [buttonOfReset addTarget:self
                    action:@selector(reset)
          forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:buttonOfReset];

  ///分割线
  viewOfBreak = [[UIView alloc] initWithFrame:CGRectMake(20, 609, 280, 1)];
  viewOfBreak.backgroundColor = [Globle colorFromHexRGB:@"d9d9d9"];
  [self addSubview:viewOfBreak];

  detailTableView = [[NALMatrixTableView alloc] initWithFrame:CGRectMake(20, 630, 280, 30)
                                                     andArray:@[
                                                       @[ @"等额本息", @"" ],
                                                       @[ @"原月还款额 :", @"元" ],
                                                       @[ @"原最后还款期 :", @"" ],
                                                       @[ @"已还款总额 :", @"元" ],
                                                       @[ @"已还利息额 :", @"元" ],
                                                       @[ @"该月一次还款额 :", @"元" ],
                                                       @[ @"下月起月还款额 :", @"元" ],
                                                       @[ @"节省利息支出 :", @"元" ],
                                                       @[ @"新的最后还款期 :", @"" ]
                                                     ]
                                             andColumnsWidths:@[ @140, @140 ]];
  [self addSubview:detailTableView];

  yearPickerView = [[My_PickerView alloc] initWithFrame:[[self superview] superview].bounds];

  label1.textColor = [Globle colorFromHexRGB:textNameColor];
  label2.textColor = [Globle colorFromHexRGB:textNameColor];
  label3.textColor = [Globle colorFromHexRGB:textNameColor];
  label4.textColor = [Globle colorFromHexRGB:textNameColor];
  label5.textColor = [Globle colorFromHexRGB:textNameColor];
  label6.textColor = [Globle colorFromHexRGB:textNameColor];
  label7.textColor = [Globle colorFromHexRGB:textNameColor];
  label8.textColor = [Globle colorFromHexRGB:textNameColor];
  label9.textColor = [Globle colorFromHexRGB:textNameColor];
  label10.textColor = [Globle colorFromHexRGB:textNameColor];
  label11.textColor = [Globle colorFromHexRGB:textNameColor];
  label12.textColor = [Globle colorFromHexRGB:textNameColor];

  textFieldForTotalLoan.keyboardAppearance = UIKeyboardAppearanceDefault;
  textFieldForTotalLoan.textColor = [Globle colorFromHexRGB:textfieldContentColor];

  textFieldForTotalLoan.layer.borderColor = [Globle colorFromHexRGB:textfieldBordColor].CGColor;
  textFieldForAdvancedMoney.keyboardAppearance = UIKeyboardAppearanceDefault;

  [textFieldForMultiple.layer setBorderColor:[Globle colorFromHexRGB:textfieldBordColor].CGColor];
  textFieldForMultiple.textColor = [Globle colorFromHexRGB:textfieldContentColor];

  textFieldForAdvancedMoney.textColor = [Globle colorFromHexRGB:textfieldContentColor];
  textFieldForAdvancedMoney.layer.borderColor = [Globle colorFromHexRGB:textfieldBordColor].CGColor;
}

///把获取的挂历时间转化成字符串
- (NSString *)stringFromDate:(NSDate *)date {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

  // zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。

  [dateFormatter setDateFormat:@"yyyy-MM-dd"];

  NSString *destDateString = [dateFormatter stringFromDate:date];

  return destDateString;
}

#pragma mark -YL_selectedButton代理方法，当被点击时会调用
- (void)selection_btn:(int)row {
  if (YLselectBtn2.row == 1) {
    label12.hidden = YES;
    YLselectBtn3.hidden = YES;

    ///计算

    buttonOfCalculate.frame = CGRectMake(55, 440, 100, 30);

    ///重置

    buttonOfReset.frame = CGRectMake(165, 440, 100, 30);

    ///分割线
    viewOfBreak.frame = CGRectMake(20, 500, 280, 1);

    ///表格
    detailTableView.frame = CGRectMake(20, 520, 280, 30);

    [detailTableView NaL_Matrix_array:@[
      @[ @"等额本金", @"" ],
      @[ @"首月还款额 :", @"元" ], // 1
      @[ @"每月递减 :", @"元" ],
      @[ @"原最后还款期 :", @"" ],      // 2
      @[ @"已还款总额 :", @"元" ],       // 3
      @[ @"已还利息额 :", @"元" ],       // 4
      @[ @"该月一次还款额 :", @"元" ], // 5
      @[ @"下月起月还款额 :", @"元" ], // 6
      @[ @"节省利息支出 :", @"元" ],    // 7
      @[ @"新的最后还款期 :", @"" ]
    ] andColumnsWidths:@[ @140, @140 ]];

  } else {
    label12.hidden = NO;
    YLselectBtn3.hidden = NO;

    ///计算

    buttonOfCalculate.frame = CGRectMake(55, 550, 100, 30);

    ///重置

    buttonOfReset.frame = CGRectMake(165, 550, 100, 30);

    ///分割线
    viewOfBreak.frame = CGRectMake(20, 610, 280, 1);

    ///表格
    detailTableView.frame = CGRectMake(20, 630, 280, 30);

    [detailTableView NaL_Matrix_array:@[
      @[ @"等额本息", @"每期等额还款" ],
      @[ @"原月还款额 :", @"元" ],       // 1
      @[ @"原最后还款期 :", @"" ],      // 2
      @[ @"已还款总额 :", @"元" ],       // 3
      @[ @"已还利息额 :", @"元" ],       // 4
      @[ @"该月一次还款额 :", @"元" ], // 5
      @[ @"下月起月还款额 :", @"元" ], // 6
      @[ @"节省利息支出 :", @"元" ],    // 7
      @[ @"新的最后还款期 :", @"" ]
    ] andColumnsWidths:@[ @140, @140 ]];
  }
}

#pragma mark - 原贷款期限按钮点击事件
- (void)yearClickBtn:(UIButton *)sender {

  yearPickerView = [[My_PickerView alloc] initWithFrame:[[self superview] superview].bounds];
  yearPickerView.Main_datePicker.tag = 3000;
  yearPickerView.Title_datePicker.text = @"贷款期限";
  yearPickerView.delegate = self;
  [yearPickerView.pickerArray addObjectsFromArray:YGtime];
  [[[self superview] superview] addSubview:yearPickerView];
  yearPickerView.hidden = NO;
}

///贷款期限按钮的代理方法，用于实时地获取用户选择的原贷款期限
- (void)Show_PickerView_Time:(NSString *)time andTag:(NSInteger)Tag andSelectRow:(NSInteger)row {
  numOfLoanPeriod = (int)row;
  ButtonForChosingYear.city_label.text = time;
}

#pragma mark -  首次还款的时间挂历
- (void)firstRepaymentTimeClickBtn:(UIButton *)sender {
  self.contentOffset = CGPointMake(0, 100);
  if (firstRepaymentTimePickerView == nil) {
    firstRepaymentTimePickerView = [[My_Datepicker alloc] initWithFrame:[[self superview] superview].bounds];
    firstRepaymentTimePickerView.Title_datePicker.text = @"第" @"一" @"次还款时间";
    firstRepaymentTimePickerView.Main_datePicker.tag = 1000;
    firstRepaymentTimePickerView.delegate = self;
    [[[self superview] superview] addSubview:firstRepaymentTimePickerView];

  } else {
    firstRepaymentTimePickerView.hidden = NO;
  }
}

#pragma mark 提前还款时间时间挂历
- (void)ExpectedTimeClickBtn:(UIButton *)sender {
  self.contentOffset = CGPointMake(0, 120);
  if (expectedTimePickerView == nil) {
    expectedTimePickerView = [[My_Datepicker alloc] initWithFrame:[[self superview] superview].bounds];
    expectedTimePickerView.Title_datePicker.text = @"预期提前还款时间";
    expectedTimePickerView.Main_datePicker.tag = 2000;
    expectedTimePickerView.delegate = self;
    [[[self superview] superview] addSubview:expectedTimePickerView];

  } else {
    expectedTimePickerView.hidden = NO;
  }

  //    NSTimeInterval a=[expectedTimePickerView.Main_datePicker.date
  //    timeIntervalSince1970]*1000;
  //    NSLog(@"时间:%lf",a);
}

///时间选择器的代理方法，用于实时获取当前选择的挂历时间
- (void)Show_DatePicker_Time:(NSString *)time andTag:(NSInteger)Tag {
  if (Tag == 1000) {
    buttonForChosingFirstTime.city_label.text = time;
  } else if (Tag == 2000) {
    buttonForChosingExceptTime.city_label.text = time;
  }
}

#pragma mark 提前还款方式 和 处理方式点击选择事件
- (void)btn2Click:(UIButton *)sender {
  if (sender.tag == 40000) {
    methodOfAdvanceRepayment = 1;
    button1.selected = NO;
    button2.selected = YES;
  } else if (sender.tag == 50000) {
    methodOfAdvanceRepayment = 2;
    button1.selected = YES;
    button2.selected = NO;
  }
}

#pragma mark -  计算
- (void)Calculation {
  if ([textFieldForTotalLoan.text doubleValue] <= 0) {
    YouGu_animation_Did_Start(@"请输入符合条件的贷款总金额");
    return;
  }

  if ([textFieldForTotalLoan.text doubleValue] <= [textFieldForAdvancedMoney.text doubleValue]) {
    YouGu_animation_Did_Start(@"部分提前还款额超过剩余本金");
    return;
  }
  NSTimeInterval expectedTime = 0.0;
  NSTimeInterval firstTime = 0.0;
  if (expectedTimePickerView == nil) {
    expectedTime = [[NSDate date] timeIntervalSince1970] * 1000;
  } else {
    expectedTime = [expectedTimePickerView.Main_datePicker.date timeIntervalSince1970] * 1000;
  }
  if (firstRepaymentTimePickerView == nil) {
    firstTime = [[NSDate date] timeIntervalSince1970] * 1000;
  } else {
    firstTime = [firstRepaymentTimePickerView.Main_datePicker.date timeIntervalSince1970] * 1000;
  }

  NSLog(@"%lf,%lf,%d", expectedTime, firstTime, expectedTime < firstTime);

  if (expectedTime < firstTime) {
    YouGu_animation_Did_Start(@"您选择的还款时间有误");
    return;
  }

  text0 = textFieldForMultiple.text;
  if ([text0 doubleValue] <= 0) {
    YouGu_animation_Did_Start(@"请输入符合条件的基准利率倍数");
    return;
  }

  ///原总还款期
  int numOfMonths = [self getMonthsWith:numOfLoanPeriod];

  ///贷款总金额
  int lumpLoan = [textFieldForTotalLoan.text intValue] * 10000;

  /// 已经还款期数
  int numOfPayedMonth =
      [self getPayedMonthsWithFirstRepaymentTime:buttonForChosingFirstTime.city_label.text
                              andExpectedPayTime:buttonForChosingExceptTime.city_label.text];

  /// 原剩余还款期数
  //  int remainingMonths = numOfMonths - numOfPayedMonth;

  float monthRate;
  ///获取贷款月利率
  if (YLselectBtn1.row == 0) {
    monthRate = [self getMonthRateOfConmercialLoan:numOfLoanPeriod] * 0.01 / 12 *
                [textFieldForMultiple.text doubleValue];
  } else {
    monthRate = [self getMonthRateOfPublicpublicReserveFundLoan:numOfLoanPeriod] * 0.01 / 12 *
                [textFieldForMultiple.text doubleValue];
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////

  // 2原最后还款期
  NSString *lastReypayMentTimeString =
      [self getLastReypayMentTimeWithFirstRepaymentTime:buttonForChosingFirstTime.city_label.text
                                             andTimeNum:numOfLoanPeriod];

  //等额本息
  if (YLselectBtn2.row == 0) {
    NSLog(@"等额本息");
    // 1原月还款额＝a×i×（1＋i）^n/〔（1＋i）^n－1〕（贷款额为a，月利率为i，还款月数为n）
    float formerMonthRepayment = (lumpLoan * monthRate * pow((1 + monthRate), numOfMonths)) /
                                 (pow((1 + monthRate), numOfMonths) - 1);
    NSString *formerMonthRepaymentString = [NSString stringWithFormat:@"%0.2f元", formerMonthRepayment];

    // 3已还款总额

    float totalPayed0 = formerMonthRepayment * numOfPayedMonth;
    float totalPayed1 = formerMonthRepayment * (numOfPayedMonth + 1);
    NSString *totalPayedString = [NSString stringWithFormat:@"%.2f元", totalPayed0];

    // 4已还利息额
    double interestPayed = 0;
    double temp = 0;
    for (int i = 0; i < numOfPayedMonth; i++) {
      interestPayed = interestPayed + (lumpLoan - temp) * monthRate;
      temp = temp + formerMonthRepayment - (lumpLoan - temp) * monthRate;
    }
    NSString *interestPayedString = [NSString stringWithFormat:@"%.2f元", interestPayed];

    //        //当前月利息（a×i－b）×（1＋i）^（n－1）＋b
    //        float
    //        thisInterest=(lumpLoan*monthRate-formerMonthRepayment)*pow(1+monthRate,
    //        numOfPayedMonth+1-1)+formerMonthRepayment;

    if ([textFieldForAdvancedMoney.text doubleValue] * 10000 > (lumpLoan - (totalPayed1 - interestPayed))) {
      YouGu_animation_Did_Start(@"请输入符合条件的提前还款金额");
      return;
    }

    //分支1--------------------------------------等额本息 && 一次提前还清
    if (methodOfAdvanceRepayment == 1) {
      NSLog(@"等额本息&& 一次提前还清");
      // 第n月还款利息为：＝（a×i－b）×（1＋i）^（n－1）＋b（贷款额为a，月利率为i，还款月数为n）
      // 5该月一次还款额=剩余本金+该月利息
      float repaymentNumForOnce =
          lumpLoan - (totalPayed1 - interestPayed) +
          (lumpLoan * monthRate - formerMonthRepayment) * pow(1 + monthRate, numOfPayedMonth) +
          formerMonthRepayment;
      NSString *repaymentNumForOnceString = [NSString stringWithFormat:@"%.2f元", repaymentNumForOnce];

      // 6下月起月还款额
      float nextMonthRepayMent = 0;
      NSString *nextMonthRepayMentString = [NSString stringWithFormat:@"%.2f元", nextMonthRepayMent];

      // 7节省利息支出 ＝总利息－已支付利息
      //总利息Y＝n×a×i×（1＋i）^n/〔（1＋i）^n－1〕－a
      float totalInterest = numOfMonths * lumpLoan * monthRate * pow(1 + monthRate, numOfMonths) /
                                (pow(1 + monthRate, numOfMonths) - 1) -
                            lumpLoan;
      //已支付利息
      double interestPayed = 0;
      double temp = 0;
      for (int i = 0; i < numOfPayedMonth + 1; i++) {
        interestPayed = interestPayed + (lumpLoan - temp) * monthRate;
        temp = temp + formerMonthRepayment - (lumpLoan - temp) * monthRate;
      }
      //节省利息支出
      float savedInterest = totalInterest - interestPayed;
      NSString *savedInterestString = [NSString stringWithFormat:@"%.2f元", savedInterest];

      // 8新的最后还款期
      NSString *newLastRepaymrntTimeString =
          [self getLastReypayMentTimeWithExpectedRepaymentTime:buttonForChosingExceptTime.city_label.text
                                        andRemainingNumOfMonth:0];

      [detailTableView NaL_Matrix_array:@[
        @[ @"等额本息", @"" ],
        @[ @"原月还款额 :", formerMonthRepaymentString ],
        @[ @"原最后还款期 :", lastReypayMentTimeString ],
        @[ @"已还款总额 :", totalPayedString ],
        @[ @"已还利息额 :", interestPayedString ],
        @[ @"该月一次还款额 :", repaymentNumForOnceString ],
        @[ @"下月起月还款额 :", nextMonthRepayMentString ],
        @[ @"节省利息支出 :", savedInterestString ],
        @[ @"新的最后还款期 :", newLastRepaymrntTimeString ]
      ] andColumnsWidths:@[ @140, @140 ]];

    }
    //等额本息 && 部分提前还清
    else if (methodOfAdvanceRepayment == 2) {
      NSLog(@"等额本息&& 部分提前还清");

      if ([textFieldForAdvancedMoney.text doubleValue] <= 0) {
        YouGu_animation_Did_Start(@"请" @"输" @"入符合条件的部分提前还清金额");
      }

      // 5该月一次还款额=部分还清额＋原月还款额
      float repaymentNumForOnce = [textFieldForAdvancedMoney.text doubleValue] * 10000 + formerMonthRepayment;
      NSString *repaymentNumForOnceString = [NSString stringWithFormat:@"%.2f元", repaymentNumForOnce];

      //剩余本金=贷款总额－已还本金＝贷款总额－（已还总额－已还利息额）-
      //部分提前还清金额
      float remainingLoan = lumpLoan - (totalPayed1 - interestPayed) -
                            [textFieldForAdvancedMoney.text doubleValue] * 10000;
      NSLog(@"剩余本金==========%f", remainingLoan);
      float formerInterest = numOfMonths * lumpLoan * monthRate * pow(1 + monthRate, numOfMonths) /
                                 (pow(1 + monthRate, numOfMonths) - 1) -
                             lumpLoan;

      //分支2-----------------------------------------等额本息 && 部分提前还清
      //&& 缩短期限
      if (YLselectBtn3.row == 0) {
        NSLog(@"等额本息&& 部分提前还清&& 缩短期限");
        // 6下月起月还款额=a×i×（1＋i）^n/〔（1＋i）^n－1〕
        //剩余还款月数=ln(R/(R-Q*p)) / ln (1+p); 注：（R：原月还款额  p：月利率
        // Q：剩余还款本金）
        int remainingNumOfMonth =
            (log(formerMonthRepayment / (formerMonthRepayment - remainingLoan * monthRate))) /
            (log(1 + monthRate));
        float nextMonthRepayment = remainingLoan * monthRate * (pow((1 + monthRate), remainingNumOfMonth)) /
                                   (pow((1 + monthRate), remainingNumOfMonth) - 1);
        NSString *nextMonthRepaymentString = [NSString stringWithFormat:@"%.2f元", nextMonthRepayment];

        // 7节省利息支出
        /*原还款利息－现还款利息＝原还款利息－已还利息－将还利息*/
        //原还款利息 ＝n×a×i×（1＋i）^n/〔（1＋i）^n－1〕－a

        //将还款利息
        float remainningInterest = remainingNumOfMonth * remainingLoan * monthRate *
                                       pow(1 + monthRate, remainingNumOfMonth) /
                                       (pow(1 + monthRate, remainingNumOfMonth) - 1) -
                                   remainingLoan;
        float savedInterest = formerInterest - interestPayed - remainningInterest;
        NSString *savedInterestString = [NSString stringWithFormat:@"%.2f元", savedInterest];

        // 8新的最后还款期
        //提前还款时间＋将还款时间
        NSString *newLastRepaymrntTimeString =
            [self getLastReypayMentTimeWithExpectedRepaymentTime:buttonForChosingExceptTime.city_label.text
                                          andRemainingNumOfMonth:remainingNumOfMonth - 1];

        [detailTableView NaL_Matrix_array:@[
          @[ @"等额本息", @"" ],
          @[ @"原月还款额 :", formerMonthRepaymentString ],      // 1
          @[ @"原最后还款期 :", lastReypayMentTimeString ],     // 2
          @[ @"已还款总额 :", totalPayedString ],                // 3
          @[ @"已还利息额 :", interestPayedString ],             // 4
          @[ @"该月一次还款额 :", repaymentNumForOnceString ], // 5
          @[ @"下月起月还款额 :", nextMonthRepaymentString ],  // 6
          @[ @"节省利息支出 :", savedInterestString ],          // 7
          @[ @"新的最后还款期 :", newLastRepaymrntTimeString ]
        ] andColumnsWidths:@[ @140, @140 ]]; // 8
      }

      //分支3-等额本息 && 部分提前还清 && 期限不变
      else {
        NSLog(@"等额本息&& 部分提前还清&& 期限不变");
        // 6下月起月还款额
        //下月起月还款额=a×i×（1＋i）^n/〔（1＋i）^n－1〕
        //剩余还款月数
        int remainingNumOfMonth = numOfMonths - numOfPayedMonth - 1;

        NSLog(@"剩余还款月数=====%d", remainingNumOfMonth);
        float nextMonthRepayment = remainingLoan * monthRate * pow(1 + monthRate, remainingNumOfMonth) /
                                   (pow(1 + monthRate, remainingNumOfMonth) - 1);
        NSString *nextMonthRepaymentString = [NSString stringWithFormat:@"%.2f元", nextMonthRepayment];

        // 7节省利息支出＝/*原还款利息－现还款利息＝原还款利息－已还利息－将还利息*/
        //剩余利息Y＝n×a×i×（1＋i）^n/〔（1＋i）^n－1〕－a
        // 剩余还款利息
        float remainningInterest = remainingNumOfMonth * remainingLoan * monthRate *
                                       pow(1 + monthRate, remainingNumOfMonth) /
                                       (pow(1 + monthRate, remainingNumOfMonth) - 1) -
                                   remainingLoan;

        //已还利息额
        double interestPayed1 = 0;
        double temp = 0;
        for (int i = 0; i < numOfPayedMonth + 1; i++) {
          interestPayed1 = interestPayed1 + (lumpLoan - temp) * monthRate;
          temp = temp + formerMonthRepayment - (lumpLoan - temp) * monthRate;
        }

        float savedInterest = formerInterest - interestPayed1 - remainningInterest;
        NSString *savedInterestString = [NSString stringWithFormat:@"%.2f元", savedInterest];

        // 8新的最后还款期?
        /*原最后还款日期*/

        [detailTableView NaL_Matrix_array:@[
          @[ @"等额本息", @"" ],
          @[ @"原月还款额 :", formerMonthRepaymentString ],      // 1
          @[ @"原最后还款期 :", lastReypayMentTimeString ],     // 2
          @[ @"已还款总额 :", totalPayedString ],                // 3
          @[ @"已还利息额 :", interestPayedString ],             // 4
          @[ @"该月一次还款额 :", repaymentNumForOnceString ], // 5
          @[ @"下月起月还款额 :", nextMonthRepaymentString ],  // 6
          @[ @"节省利息支出 :", savedInterestString ],          // 7
          @[ @"新的最后还款期 :", lastReypayMentTimeString ]
        ] andColumnsWidths:@[ @140, @140 ]]; // 8
      }
    }

  }

  //等额本金
  else {
    NSLog(@"等额本金");
    //首月还款额
    float repaymentOfFirstMonth = lumpLoan / numOfMonths + lumpLoan * monthRate;
    NSString *repaymentOfFirstMonthString = [NSString stringWithFormat:@"%.2f元", repaymentOfFirstMonth];

    //每月递减
    float monthDecress = lumpLoan / numOfMonths * monthRate;
    NSString *monthDecressStr = [NSString stringWithFormat:@"%.2f元", monthDecress];

    // 3已还款总额
    /*已还款总额＝月还本金额 * 已还款月数 ＋已还款月数／2*月还本金*月利率*/
    //还款月数
    int numberOfPayedMonth =
        [self getPayedMonthsWithFirstRepaymentTime:buttonForChosingFirstTime.city_label.text
                                andExpectedPayTime:buttonForChosingExceptTime.city_label.text];
    float totalPayed = lumpLoan / numOfMonths * numberOfPayedMonth + lumpLoan * monthRate * numberOfPayedMonth -
                       numberOfPayedMonth / 2 * lumpLoan / numOfMonths * monthRate;
    NSString *totalPayedString = [NSString stringWithFormat:@"%.2f元", totalPayed];

    // 4已还利息额
    //已还利息额=(还款月数＋1)＊贷款额＊月利率／2
    float interestPayed = (numberOfPayedMonth - 1) * lumpLoan * monthRate -
                          (numberOfPayedMonth - 1) / 2 * lumpLoan / numOfMonths * monthRate;
    NSString *interestPayedString = [NSString stringWithFormat:@"%.2f元", interestPayed];

    if ([textFieldForAdvancedMoney.text doubleValue] * 10000 > (lumpLoan - (totalPayed - interestPayed))) {
      YouGu_animation_Did_Start(@"请输入符合条件的提前还款金额");
      return;
    }

    //分支4-------------------------等额本金 && 一次提前还清
    if (methodOfAdvanceRepayment == 1) {
      NSLog(@"等额本金&& 一次提前还清");
      // 2原最后还款期
      NSString *lastReypayMentTimeString =
          [self getLastReypayMentTimeWithFirstRepaymentTime:buttonForChosingFirstTime.city_label.text
                                                 andTimeNum:numOfLoanPeriod];

      // 5该月一次还款额
      //该月一次还款额=预期还款月的月还款额＋剩余本金
      float thisRepayment = lumpLoan / numOfMonths * (numOfMonths - numOfPayedMonth - 1) +
                            (repaymentOfFirstMonth - numOfPayedMonth / 2 * monthRate);
      NSString *thisRepaymentString = [NSString stringWithFormat:@"%.2f元", thisRepayment];

      // 6下月起月还款额 提示用户“已一次还清”

      // 7节省利息支出
      /*节省利息支出＝原总利息－已支付利息*/
      float savedInterest = (numOfMonths - numOfPayedMonth - 1) * lumpLoan * monthRate / 2;
      NSString *savedInterestString = [NSString stringWithFormat:@"%.2f元", savedInterest];

      // 8新的最后还款期
      NSString *newlastReypayMentTimeString =
          [self getLastReypayMentTimeWithExpectedRepaymentTime:buttonForChosingExceptTime.city_label.text
                                        andRemainingNumOfMonth:0];

      [detailTableView NaL_Matrix_array:@[
        @[ @"等额本金", @"" ],
        @[ @"首月还款额 :", repaymentOfFirstMonthString ],
        @[ @"每月递减", monthDecressStr ],
        @[ @"原最后还款期 :", lastReypayMentTimeString ],
        @[ @"已还款总额 :", totalPayedString ],
        @[ @"已还利息额 :", interestPayedString ],
        @[ @"该月一次还款额 :", thisRepaymentString ],
        @[ @"下月起月还款额 :", @"0元" ],
        @[ @"节省利息支出 :", savedInterestString ],
        @[ @"新的最后还款期 :", newlastReypayMentTimeString ]
      ] andColumnsWidths:@[ @140, @140 ]];
    }

    //等额本金 && 部分提前还清
    else if (methodOfAdvanceRepayment == 2) {
      NSLog(@"等额本金 && 部分提前还清");
      if ([textFieldForAdvancedMoney.text doubleValue] <= 0) {
        YouGu_animation_Did_Start(@"请" @"输" @"入符合条件的部分提前还清金额");
      }

      // 5该月一次还款额
      //该月一次还款额＝该月应还款额＋部分还清金额
      float repaymentOfMonth = (repaymentOfFirstMonth - numOfPayedMonth / 2 * monthRate) +
                               [textFieldForAdvancedMoney.text doubleValue] * 10000;
      NSString *repaymentOfMonthString = [NSString stringWithFormat:@"%.2f元", repaymentOfMonth];

      //分支5------------------------------等额本金 && 部分提前还清 && 期限不变
      if ((YLselectBtn3.row == 1) || (YLselectBtn3.row == 0)) {

        NSLog(@"等额本金 && 部分提前还清 && 期限不变");
        // 6下月起月还款额
        //贷款剩余本金
        float remainningLoan = lumpLoan / numOfMonths * (numOfMonths - numOfPayedMonth - 1) -
                               [textFieldForAdvancedMoney.text doubleValue] * 10000;
        float nextMonthRepayment =
            remainningLoan / (numOfMonths - numOfPayedMonth - 1) + remainningLoan * monthRate;
        NSString *nextMonthRepaymentString = [NSString stringWithFormat:@"%.2f元", nextMonthRepayment];

        // 7节省利息支出
        float savedInterest = (numOfMonths - numOfPayedMonth - 1) *
                              [textFieldForAdvancedMoney.text doubleValue] * 10000 * monthRate / 2;
        NSString *savedInterestString = [NSString stringWithFormat:@"%.2f元", savedInterest];

        // 2原最后还款期
        NSString *lastReypayMentTimeString =
            [self getLastReypayMentTimeWithFirstRepaymentTime:buttonForChosingFirstTime.city_label.text
                                                   andTimeNum:numOfLoanPeriod];

        // 8新的最后还款期
        //新的最后还款期＝原最后还款期

        [detailTableView NaL_Matrix_array:@[
          @[ @"等额本金", @"" ],
          @[ @"原月还款额 :", repaymentOfFirstMonthString ],    // 1
          @[ @"原最后还款期 :", lastReypayMentTimeString ],    // 2
          @[ @"已还款总额 :", totalPayedString ],               // 3
          @[ @"已还利息额 :", interestPayedString ],            // 4
          @[ @"该月一次还款额 :", repaymentOfMonthString ],   // 5
          @[ @"下月起月还款额 :", nextMonthRepaymentString ], // 6
          @[ @"节省利息支出 :", savedInterestString ],         // 7
          @[ @"新的最后还款期 :", lastReypayMentTimeString ]
        ] andColumnsWidths:@[ @140, @140 ]]; // 8
      }
    }
  }
}

//由期望提前还款日期和剩余还款月数得到最后还款期限
- (NSString *)getLastReypayMentTimeWithExpectedRepaymentTime:(NSString *)dateString1
                                      andRemainingNumOfMonth:(int)num2 {
  timeArray2 = [dateString1 componentsSeparatedByString:@"-"];
  if ([timeArray2 count] == 3) {
    int lastRepaymentTimeYearInt = [timeArray2[0] intValue] + (num2 / 12);
    int lastRepaymentTimeMonthInt = [timeArray2[1] intValue] + (num2 % 12);
    if (lastRepaymentTimeMonthInt > 12) {
      lastRepaymentTimeYearInt++;
      lastRepaymentTimeMonthInt = lastRepaymentTimeMonthInt - 12;
    }
    NSString *newLastRepaymentTimeString =
        [NSString stringWithFormat:@"%d年%d月%d日", lastRepaymentTimeYearInt,
                                   lastRepaymentTimeMonthInt, [timeArray2[2] intValue]];

    return newLastRepaymentTimeString;
  }
  return nil;
}

//由首次还款时间和贷款期限的timeNum获取最后还款期限
- (NSString *)getLastReypayMentTimeWithFirstRepaymentTime:(NSString *)dateString1
                                               andTimeNum:(int)timeNum1 {
  timeArray1 = [dateString1 componentsSeparatedByString:@"-"];
  if ([timeArray1 count] == 3) {
    int lastRepaymentTimeInt1 = [timeArray1[0] intValue] + (timeNum1 + 1) * 5;

    int lastRepaymentTimeInt2 = [timeArray1[1] intValue] - 1;
    if ([timeArray1[1] intValue] == 1) {
      lastRepaymentTimeInt1 = lastRepaymentTimeInt1 - 1;
      lastRepaymentTimeInt2 = lastRepaymentTimeInt2 + 12;
    }

    NSString *lastRepaymentTimeString =
        [NSString stringWithFormat:@"%d年%d月%d日", lastRepaymentTimeInt1, lastRepaymentTimeInt2,
                                   [timeArray1[2] intValue]];
    return lastRepaymentTimeString;
  }
  return nil;
}

///计算已还款的月份
- (int)getPayedMonthsWithFirstRepaymentTime:(NSString *)dateString1
                         andExpectedPayTime:(NSString *)dateString2 {
  timeArray1 = [dateString1 componentsSeparatedByString:@"-"];

  timeArray2 = [dateString2 componentsSeparatedByString:@"-"];

  if ([timeArray1 count] == 3 && [timeArray2 count] == 3) {
    int month = ([timeArray2[0] intValue] - [timeArray1[0] intValue]) * 12 +
                ([timeArray2[1] intValue] - [timeArray1[1] intValue]);

    return month;
  }
  return 0;
}

/// 获取  贷款期限（即还款月数）
- (int)getMonthsWith:(int)num {
  return (num + 1) * 5 * 12;
}

///该方法用于获取商业贷款年利率(传入贷款期限的Num 0，1，2，3，4，5，...)
- (float)getMonthRateOfConmercialLoan:(int)num {
  if (num == 0) {
    /// 五年
    double Rate_float = (double)self.Benchmark_rate_5Below;

    return [self notRounding:Rate_float afterPoint:2];
  } else {
    ///五年以上
    double Rate_float = (double)self.Benchmark_rate_5Above;

    return [self notRounding:Rate_float afterPoint:2];
  }
  // return self.Benchmark_rate_5Below;
}

//格式话小数 四舍五入类型
- (double)notRounding:(double)price afterPoint:(int)position {
  double sum = (int)roundf(pow(10, position)) * price;
  double result = roundf(sum) / ((int)roundf(pow(10, position)) * 1.0);
  return result;
}

///该方法用于获取公积金贷款月利率
- (float)getMonthRateOfPublicpublicReserveFundLoan:(int)num {
  if (num == 0) {
    /// 五年
    double Rate_float = (double)self.Fund_rate_5Below;
    return [self notRounding:Rate_float afterPoint:2];
  } else {
    ///五年以上
    double Rate_float = self.Fund_rate_5Above;

    return [self notRounding:Rate_float afterPoint:2];
  }
}

#pragma mark 重置按钮点击事件
- (void)reset {
  [YLselectBtn1 my_init_btn];
  YLselectBtn1.row = 0;

  [YLselectBtn2 my_init_btn];
  YLselectBtn2.row = 0;

  textFieldForTotalLoan.text = @"";

  ButtonForChosingYear.city_label.text = @"5年";

  buttonForChosingFirstTime.city_label.text = [self stringFromDate:[NSDate date]];

  buttonForChosingExceptTime.city_label.text = [self stringFromDate:[NSDate date]];

  textFieldForMultiple.text = @"1.0";

  button1.selected = NO;
  button2.selected = YES;
  methodOfAdvanceRepayment = 1;

  textFieldForAdvancedMoney.text = @"";

  [YLselectBtn3 my_init_btn];
  YLselectBtn3.row = 0;

  [detailTableView NaL_Matrix_array:@[
    @[ @"等额本息", @"" ],
    @[ @"原月还款额 :", @"元" ],
    @[ @"原最后还款期 :", @"" ],
    @[ @"已还款总额 :", @"元" ],
    @[ @"已还利息额 :", @"元" ],
    @[ @"该月一次还款额 :", @"元" ],
    @[ @"下月起月还款额 :", @"元" ],
    @[ @"节省利息支出 :", @"元" ],
    @[ @"新的最后还款期 :", @"" ]
  ] andColumnsWidths:@[ @140, @140 ]];
}

#pragma mark - 房屋面积、房屋总价、房屋差价三个输入框的代理方法 实现输对输入数字长度的控制
- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string {
  //对总位数的限制
  int maxNumOfChars = 7;
  NSMutableString *newtxt = [NSMutableString stringWithString:textField.text];
  [newtxt replaceCharactersInRange:range withString:string];

  //对小数点后位数的限制
  NSMutableString *futureString = [NSMutableString stringWithString:textField.text];
  [futureString insertString:string atIndex:range.location];
  NSInteger flag = 0;
  const NSInteger limitedNum = 2;
  for (int i = (int)futureString.length - 1; i >= 0; i--) {
    if ([futureString characterAtIndex:i] == '.') {
      if (flag > limitedNum) {
        return NO; //不返回???
      }
      break; //???
    }
  }
  return ([newtxt length] <= maxNumOfChars);
}

//输入框被点击时调用该方法，用于控制输入框的显示高度
- (void)textFieldDidBeginEditing:(UITextField *)textField {
  if (textField.tag == 100) {
    self.contentOffset = CGPointMake(0, 0);
  }
  if (textField.tag == 200) {
    self.contentOffset = CGPointMake(0, 250);
  }
  if (textField.tag == 300) {
    self.contentOffset = CGPointMake(0, 260);
  }
}

@end
