
//  TheLoanPortfolioView.m
//  优顾理财
//
//  Created by Mac on 14/10/22.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//  组合贷款
#import "NALMatrixTableView.h"
#import "TheLoanPortfolioView.h"
#import "Textfield+btn.h"
#import "ExpressTextField.h"

@implementation TheLoanPortfolioView {
  ///贷款期限的选项按钮
  YL_SelectionButton *YLSeletionButton;

  ///   贷款期限 的num
  int numOfLoanPeriod;

  ///点击该button弹出贷款期限选择器
  Textfield_btn *buttonForChosingLoanPeriod;

  ///贷款期限选择器
  My_PickerView *viewForPickingLoanPeriod;

  ///贷款期限选择器中的数据
  NSArray *ArrayOfLoanPeriod;

  ///商业贷款金额输入框
  ExpressTextField *textFieldForConmercialLoan;

  ///商贷利率与基准利率倍数输入框
  ExpressTextField *textFieldForMultiple0;

  ///商贷利率与基准利率倍数输入框上的text
  NSString *text0;
  ///公积金贷款金额输入框
  ExpressTextField *textFieldForpublicReserveFund;
  ///公积金贷款金额输入框的text
  NSString *text1;
  ///公积金利率与基准利率倍数输入框
  ExpressTextField *textFieldForMultiple1;
  /// 结果表格
  NALMatrixTableView *loanPortfolioTableView;
  //表格数据
  NSArray *arrayForTable;
}
@dynamic Benchmark_rate_5Below;
@dynamic Benchmark_rate_5Above;
@dynamic Fund_rate_5Below;
@dynamic Fund_rate_5Above;

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.contentSize = CGSizeMake(self.width, 600);

    [self createUI];
  }
  return self;
}

//组合贷款页面整体UI的实现
- (void)createUI {
  //获取贷款期限的选项数据
  NSString *pathForloanPeriod =
      [[NSBundle mainBundle] pathForResource:@"贷款期限.plist" ofType:nil];
  ArrayOfLoanPeriod = [[NSArray alloc] initWithContentsOfFile:pathForloanPeriod];

  //等额本金和等额本息选择器
  NSArray *array0 = @[ @"等额本息", @"等额本金" ];
  YLSeletionButton = [[YL_SelectionButton alloc] initWithFrame:CGRectMake(0, 15, self.width, 50)
                                                      andTitle:@"还款方式 :"
                                                       andType:1
                                                      andArray:array0];
  YLSeletionButton.delegate = self;
  [self addSubview:YLSeletionButton];

  //贷款期限
  UILabel *label0 = [[UILabel alloc] initWithFrame:CGRectMake(50, 60, 80, 30)];
  label0.backgroundColor = [UIColor clearColor];
  label0.text = @"贷款期限 :";
  label0.textColor = [Globle colorFromHexRGB:textNameColor];
  label0.textAlignment = NSTextAlignmentRight;
  label0.font = [UIFont systemFontOfSize:15];
  [self addSubview:label0];

  buttonForChosingLoanPeriod = [[Textfield_btn alloc] initWithFrame:CGRectMake(140, 60, 100, 30)];
  buttonForChosingLoanPeriod.city_label.text = @"5年";
  buttonForChosingLoanPeriod.layer.borderWidth = 1.0f;
  [buttonForChosingLoanPeriod.click_btn addTarget:self
                                           action:@selector(chooseLoanPeriedButtonClick)
                                 forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:buttonForChosingLoanPeriod];

  UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(250, 60, 30, 30)];
  label1.text = @"年";
  label1.backgroundColor = [UIColor clearColor];
  label1.textAlignment = NSTextAlignmentLeft;
  label1.font = [UIFont systemFontOfSize:15];
  label1.textColor = [Globle colorFromHexRGB:textNameColor];
  [self addSubview:label1];

  //商业贷款金额
  UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 110, 120, 30)];
  label2.backgroundColor = [UIColor clearColor];
  label2.text = @"商业贷款金额 :";
  label2.textColor = [Globle colorFromHexRGB:textNameColor];
  label2.textAlignment = NSTextAlignmentRight;
  label2.font = [UIFont systemFontOfSize:15];
  [self addSubview:label2];

  textFieldForConmercialLoan = [[ExpressTextField alloc] initWithFrame:CGRectMake(140, 110, 100, 30)];
  textFieldForConmercialLoan.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  textFieldForConmercialLoan.tag = 100;
  textFieldForConmercialLoan.layer.cornerRadius = 5;
  textFieldForConmercialLoan.layer.borderWidth = 1.0f;
  textFieldForConmercialLoan.keyboardType = UIKeyboardTypeDecimalPad;
  textFieldForConmercialLoan.layer.borderColor = [Globle colorFromHexRGB:textfieldBordColor].CGColor;
  textFieldForConmercialLoan.delegate = self;
  [textFieldForConmercialLoan setSpaceAtStart];
  [self addSubview:textFieldForConmercialLoan];

  UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(250, 110, 30, 30)];
  label3.text = @"万元";
  label3.backgroundColor = [UIColor clearColor];
  label3.textColor = [Globle colorFromHexRGB:textNameColor];
  label3.textAlignment = NSTextAlignmentLeft;
  label3.font = [UIFont systemFontOfSize:15];
  [self addSubview:label3];

  //商业贷款年利率
  UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 160, 130, 30)];
  label4.backgroundColor = [UIColor clearColor];
  label4.text = @"商业贷款年利率 :";
  label4.textAlignment = NSTextAlignmentRight;
  label4.textColor = [Globle colorFromHexRGB:textNameColor];
  label4.font = [UIFont systemFontOfSize:15];
  [self addSubview:label4];

  UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(135, 160, 80, 30)];
  label5.backgroundColor = [UIColor clearColor];
  label5.text = @"基准利率的";
  label5.textColor = [Globle colorFromHexRGB:textNameColor];
  label5.font = [UIFont systemFontOfSize:15];
  [self addSubview:label5];

  textFieldForMultiple0 = [[ExpressTextField alloc] initWithFrame:CGRectMake(215, 163, 50, 30)];
  textFieldForMultiple0.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  textFieldForMultiple0.tag = 200;
  text0 = @"1.0";
  textFieldForMultiple0.text = text0;
  textFieldForMultiple0.layer.cornerRadius = 5;
  textFieldForMultiple0.layer.borderWidth = 1.0f;
  textFieldForMultiple0.keyboardType = UIKeyboardTypeDecimalPad;
  textFieldForMultiple0.layer.borderColor = [Globle colorFromHexRGB:textfieldBordColor].CGColor;
  textFieldForMultiple0.delegate = self;
  textFieldForMultiple0.textColor = [Globle colorFromHexRGB:textfieldContentColor];
  textFieldForMultiple0.textAlignment = NSTextAlignmentCenter;
  [self addSubview:textFieldForMultiple0];

  UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(270, 160, 20, 30)];
  label6.text = @"倍";
  label6.backgroundColor = [UIColor clearColor];
  label6.textColor = [Globle colorFromHexRGB:textNameColor];
  label6.textAlignment = NSTextAlignmentLeft;
  label6.font = [UIFont systemFontOfSize:15];
  [self addSubview:label6];

  //公积金贷款金额
  UILabel *label7 = [[UILabel alloc] initWithFrame:CGRectMake(10, 210, 120, 30)];
  label7.backgroundColor = [UIColor clearColor];
  label7.text = @"公积金贷款金额 :";
  label7.textColor = [Globle colorFromHexRGB:textNameColor];
  label7.textAlignment = NSTextAlignmentRight;
  label7.font = [UIFont systemFontOfSize:15];
  [self addSubview:label7];

  textFieldForpublicReserveFund = [[ExpressTextField alloc] initWithFrame:CGRectMake(140, 210, 100, 30)];
  textFieldForpublicReserveFund.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  textFieldForpublicReserveFund.tag = 300;
  textFieldForpublicReserveFund.layer.cornerRadius = 5;
  textFieldForpublicReserveFund.layer.borderWidth = 1.0f;
  textFieldForpublicReserveFund.keyboardType = UIKeyboardTypeDecimalPad;
  textFieldForpublicReserveFund.layer.borderColor = [Globle colorFromHexRGB:textfieldBordColor].CGColor;
  textFieldForpublicReserveFund.delegate = self;
  [textFieldForpublicReserveFund setSpaceAtStart];
  [self addSubview:textFieldForpublicReserveFund];

  UILabel *label8 = [[UILabel alloc] initWithFrame:CGRectMake(250, 210, 30, 30)];
  label8.text = @"万元";
  label8.backgroundColor = [UIColor clearColor];
  label8.textAlignment = NSTextAlignmentLeft;
  label8.textColor = [Globle colorFromHexRGB:textNameColor];
  label8.font = [UIFont systemFontOfSize:15];
  [self addSubview:label8];

  //公积金贷款年利率
  UILabel *label9 = [[UILabel alloc] initWithFrame:CGRectMake(0, 260, 130, 30)];
  label9.backgroundColor = [UIColor clearColor];
  label9.text = @"公积金贷款年利率 :";
  label9.textColor = [Globle colorFromHexRGB:textNameColor];
  label9.textAlignment = NSTextAlignmentRight;
  label9.font = [UIFont systemFontOfSize:15];
  [self addSubview:label9];

  UILabel *label10 = [[UILabel alloc] initWithFrame:CGRectMake(135, 260, 80, 30)];
  label10.backgroundColor = [UIColor clearColor];
  label10.text = @"基准利率的";
  label10.textColor = [Globle colorFromHexRGB:textNameColor];
  label10.font = [UIFont systemFontOfSize:15];
  [self addSubview:label10];

  textFieldForMultiple1 = [[ExpressTextField alloc] initWithFrame:CGRectMake(215, 260, 50, 30)];
  textFieldForMultiple1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  textFieldForMultiple1.tag = 400;
  text1 = @"1.0";
  textFieldForMultiple1.text = text1;
  textFieldForMultiple1.layer.cornerRadius = 5;
  textFieldForMultiple1.layer.borderWidth = 1.0f;
  textFieldForMultiple1.keyboardType = UIKeyboardTypeDecimalPad;
  textFieldForMultiple1.layer.borderColor = [Globle colorFromHexRGB:textfieldBordColor].CGColor;
  textFieldForMultiple1.delegate = self;
  textFieldForMultiple1.textAlignment = NSTextAlignmentCenter;
  [self addSubview:textFieldForMultiple1];

  UILabel *label11 = [[UILabel alloc] initWithFrame:CGRectMake(270, 260, 20, 30)];
  label11.text = @"倍";
  label11.backgroundColor = [UIColor clearColor];
  label11.textAlignment = NSTextAlignmentLeft;
  label11.textColor = [Globle colorFromHexRGB:textNameColor];
  label11.font = [UIFont systemFontOfSize:15];
  [self addSubview:label11];

  //计算
  UIButton *buttonForCalculating = [UIButton buttonWithType:UIButtonTypeCustom];
  buttonForCalculating.frame = CGRectMake(55, 310, 100, 30);
  buttonForCalculating.backgroundColor = [Globle colorFromHexRGB:@"2f8ef2"];
  buttonForCalculating.layer.cornerRadius = 5;
  [buttonForCalculating setTitle:@"计算" forState:UIControlStateNormal];
  UIImage *hightlightImage = [FPYouguUtil createImageWithColor:buttonHighLightColor];
  [buttonForCalculating setBackgroundImage:hightlightImage forState:UIControlStateHighlighted];
  buttonForCalculating.titleLabel.textAlignment = NSTextAlignmentCenter;
  buttonForCalculating.titleLabel.font = [UIFont systemFontOfSize:15];
  [buttonForCalculating addTarget:self
                           action:@selector(calculate)
                 forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:buttonForCalculating];

  //重置
  UIButton *buttonForReset = [UIButton buttonWithType:UIButtonTypeCustom];
  buttonForReset.frame = CGRectMake(165, 310, 100, 30);
  buttonForReset.backgroundColor = [Globle colorFromHexRGB:@"2f8ef2"];
  buttonForReset.layer.cornerRadius = 5;
  [buttonForReset setBackgroundImage:hightlightImage forState:UIControlStateHighlighted];
  [buttonForReset setTitle:@"重置" forState:UIControlStateNormal];
  buttonForReset.titleLabel.textAlignment = NSTextAlignmentCenter;
  buttonForReset.titleLabel.font = [UIFont systemFontOfSize:15];
  [buttonForReset addTarget:self
                     action:@selector(Reset:)
           forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:buttonForReset];

  //分割线
  UIView *viewOfBreakLine = [[UIView alloc] initWithFrame:CGRectMake(20, 359, 280, 1)];
  viewOfBreakLine.backgroundColor = [Globle colorFromHexRGB:@"d9d9d9"];
  [self addSubview:viewOfBreakLine];

  //计算结果表格

  arrayForTable = @[
    @[ @"等额本息", @"每期等额还款" ],
    @[ @"贷款总额 :", @"元" ],
    @[ @"贷款期限 :", @"期" ],
    @[ @"月均还款 :", @"元" ],
    @[ @"支付利息 :", @"元" ],
    @[ @"还款总额 :", @"元" ]
  ];

  loanPortfolioTableView = [[NALMatrixTableView alloc] initWithFrame:CGRectMake(20, 395, 280, 30)
                                                            andArray:arrayForTable
                                                    andColumnsWidths:@[ @140, @140 ]];
  [self addSubview:loanPortfolioTableView];

  //白天模式
  label0.textColor = [Globle colorFromHexRGB:textNameColor];
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

  textFieldForConmercialLoan.keyboardAppearance = UIKeyboardAppearanceDefault;
  textFieldForConmercialLoan.textColor = [Globle colorFromHexRGB:textfieldContentColor];
  textFieldForConmercialLoan.layer.borderColor = [Globle colorFromHexRGB:textfieldBordColor].CGColor;

  textFieldForMultiple0.keyboardAppearance = UIKeyboardAppearanceDefault;
  textFieldForMultiple0.textColor = [Globle colorFromHexRGB:textfieldContentColor];
  textFieldForMultiple0.layer.borderColor = [Globle colorFromHexRGB:textfieldBordColor].CGColor;

  textFieldForpublicReserveFund.keyboardAppearance = UIKeyboardAppearanceDefault;
  textFieldForpublicReserveFund.textColor = [Globle colorFromHexRGB:textfieldContentColor];
  textFieldForpublicReserveFund.layer.borderColor = [Globle colorFromHexRGB:textfieldBordColor].CGColor;

  textFieldForMultiple1.keyboardAppearance = UIKeyboardAppearanceDefault;
  textFieldForMultiple1.textColor = [Globle colorFromHexRGB:textfieldContentColor];
  textFieldForMultiple1.layer.borderColor = [Globle colorFromHexRGB:textfieldBordColor].CGColor;

  viewOfBreakLine.backgroundColor = [Globle colorFromHexRGB:@"a1a1a1"];

  buttonForCalculating.backgroundColor = [Globle colorFromHexRGB:@"2f8ef2"];
  buttonForReset.backgroundColor = [Globle colorFromHexRGB:@"2f8ef2"];
}

#pragma mark - 按钮 选择贷款期限
- (void)chooseLoanPeriedButtonClick {
  if (viewForPickingLoanPeriod == nil) {
    viewForPickingLoanPeriod = [[My_PickerView alloc] initWithFrame:[[self superview] superview].bounds];
    viewForPickingLoanPeriod.Main_datePicker.tag = 2000;
    viewForPickingLoanPeriod.Title_datePicker.text = @"贷款期限";
    viewForPickingLoanPeriod.delegate = self;
    [viewForPickingLoanPeriod.pickerArray addObjectsFromArray:ArrayOfLoanPeriod];
    [[[self superview] superview] addSubview:viewForPickingLoanPeriod];

  } else {
    viewForPickingLoanPeriod.hidden = NO;
  }
}

#pragma mark - 贷款金额输入框的代理方法 实现输入字数的控制
- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string {
  int MAX_CHARS = 9;

  NSMutableString *newtxt = [NSMutableString stringWithString:textField.text];
  [newtxt replaceCharactersInRange:range withString:string];

  return ([newtxt length] <= MAX_CHARS);
}

#pragma mark - 贷款期限控件的的代理方法，实现选择功能
- (void)Show_PickerView_Time:(NSString *)time andTag:(NSInteger)Tag andSelectRow:(NSInteger)row {

  numOfLoanPeriod = (int)row;
  buttonForChosingLoanPeriod.city_label.text = time;
}

#pragma mark -  计算逻辑
//计算
- (void)calculate {
  if ([textFieldForConmercialLoan.text doubleValue] <= 0) {
    YouGu_animation_Did_Start(@"请输入商业贷款金额");
    return;
  }

  text0 = textFieldForMultiple0.text;
  if ([text0 doubleValue] <= 0) {
    YouGu_animation_Did_Start(@"请输入商业贷款的基准利率倍数");
    return;
  }

  if ([textFieldForpublicReserveFund.text doubleValue] <= 0) {
    YouGu_animation_Did_Start(@"请输入公积金贷款金额");
    return;
  }

  text1 = textFieldForMultiple1.text;
  if ([text1 doubleValue] <= 0) {
    YouGu_animation_Did_Start(@"请输入公积金贷款的基准利率倍数");
    return;
  }

  ///商业贷款金额
  float conmercialLoan = [textFieldForConmercialLoan.text doubleValue] * 10000;

  ///商业贷款月利率
  float monthRateOfConmercialLoan = [self getYearRateOfConmercialLoan:numOfLoanPeriod] * 0.01 / 12 *
                                    [textFieldForMultiple0.text doubleValue];
  // NSLog(@"------------------------------%f",[self
  // getYearRateOfConmercialLoan:numOfLoanPeriod]);

  ///公积金贷款金额
  float publicReserveFundLoan = [textFieldForpublicReserveFund.text doubleValue] * 10000;

  ///公积金贷款月利率
  float monthRateOfPublicReserveFundLoan = [self getYearRateOfPublicpublicReserveFundLoan:numOfLoanPeriod] *
                                           0.01 / 12 * [textFieldForMultiple1.text doubleValue];
  // NSLog(@"------------------------------%f",[self
  // getYearRateOfPublicpublicReserveFundLoan:numOfLoanPeriod ]);
  // 1贷款总额
  float lumpLoan = conmercialLoan + publicReserveFundLoan;
  NSString *lumpLoanString = [NSString stringWithFormat:@"%.2f元", lumpLoan];

  /// 2贷款期限
  int numOfMonths = (numOfLoanPeriod + 1) * 5 * 12;

  NSString *numOfMonthsString = [NSString stringWithFormat:@"%d期", numOfMonths];
  ;

  //等额本息时
  if (YLSeletionButton.row == 0) {
    NSLog(@"＝＝＝＝＝＝＝＝＝＝＝＝＝＝等额本息");
    // 3月均还款
    /*
     商业贷款金额*商业贷款月利率*（1+商业贷款月利率）^还款期数／（（1＋商业贷款月利率）^还款期数-1）
     ＋
     ｛公积金贷款总金额 *公积金贷款月利率 *（1+公积金贷款月利率
     ）^还款期数／（1+公积金贷款月利率) ^还款期数－1｝
     */

    ///商业贷款月均还款
    float monthRepaymentOfConmercialLoan = conmercialLoan * monthRateOfConmercialLoan *
                                           pow(1 + monthRateOfConmercialLoan, numOfMonths) /
                                           (pow(1 + monthRateOfConmercialLoan, numOfMonths) - 1);
    // NSLog(@"=========%f",monthRepaymentOfConmercialLoan);
    ///公积金贷款月均还款
    float monthRepaymentOfPublicReserveFundLoan =
        publicReserveFundLoan * monthRateOfPublicReserveFundLoan *
        pow(1 + monthRateOfPublicReserveFundLoan, numOfMonths) /
        (pow(1 + monthRateOfPublicReserveFundLoan, numOfMonths) - 1);

    float repaymentOfMonth = monthRepaymentOfConmercialLoan + monthRepaymentOfPublicReserveFundLoan;
    NSString *repaymentOfMonthString = [NSString stringWithFormat:@"%.2f元", repaymentOfMonth];

    // 4支付利息
    /*
     ＝商业贷款支付利息＋公积金贷款支付利息
     ＝｛商业贷款月还款额＊还款期数－商业贷款金额｝＋｛公积金贷款月还款额＊还款期数－公积金贷款金额
     */
    float interestOfconmercialLoan = monthRepaymentOfConmercialLoan * numOfMonths - conmercialLoan;

    float interestOfPublicReserveFundLoan =
        monthRepaymentOfPublicReserveFundLoan * numOfMonths - publicReserveFundLoan;

    float interest = interestOfconmercialLoan + interestOfPublicReserveFundLoan;
    NSString *interestString = [NSString stringWithFormat:@"%.2f元", interest];

    // 5还款总额
    /*
     还款总额＝商业贷款还款总额＋公积金贷款还款总额
     ＝（商业贷款支付利息＋商业贷款额）＋（公积金贷款支付利息＋公积金贷款额）
     */
    float totalRepayment = conmercialLoan + publicReserveFundLoan + interest;
    NSString *totalRepaymentString = [NSString stringWithFormat:@"%.2f元", totalRepayment];

    arrayForTable = @[
      @[ @"等额本息", @"" ],
      @[ @"贷款总额 :", lumpLoanString ],
      @[ @"贷款期限 :", numOfMonthsString ],
      @[ @"月均还款 :", repaymentOfMonthString ],
      @[ @"支付利息 :", interestString ],
      @[ @"还款总额 :", totalRepaymentString ]
    ];

    //计算结果表格
    [loanPortfolioTableView NaL_Matrix_array:arrayForTable andColumnsWidths:@[ @140, @140 ]];

  }

  //等额本金
  else if (YLSeletionButton.row == 1) {
    NSLog(@"＝＝＝＝＝＝＝＝＝＝＝＝＝＝等额本金");
    // 3月均还款
    /*
     商业贷款月均还款＋公积金贷款月均还款＝
     ｛商业贷款总金额／还款期数＋商业贷款总金额＊商业贷款月利率｝
     ＋｛公积金贷款总额／还款期数＋公积金贷款总金额＊公积金贷款月利率｝
     */
    float repaymentOfMonth = conmercialLoan / numOfMonths + conmercialLoan * monthRateOfConmercialLoan +
                             publicReserveFundLoan / numOfMonths +
                             publicReserveFundLoan * monthRateOfPublicReserveFundLoan;
    NSString *repaymentOfMonthString = [NSString stringWithFormat:@"%.2f元", repaymentOfMonth];

    // 4每月递减额
    float monthDecress = conmercialLoan / numOfMonths * monthRateOfConmercialLoan;
    NSString *monthDecressStr = [NSString stringWithFormat:@"%.2f元", monthDecress];

    // 5支付利息
    /*
     支付利息＝商业贷款支付利息＋公积金贷款支付利息
     Y=（n+1）*a*i/2  （设贷款额为a，月利率为i，还款月数为n还款利息总和为Y ）
     */
    float interestOfCL = (numOfMonths + 1) * conmercialLoan * monthRateOfConmercialLoan / 2;

    float interestOfPRFL = (numOfMonths + 1) * publicReserveFundLoan * monthRateOfPublicReserveFundLoan / 2;

    float interest = interestOfCL + interestOfPRFL;
    NSString *interestString = [NSString stringWithFormat:@"%.2f元", interest];

    // 6还款总额
    /*
     商业贷款还款总额＋公积金贷款还款总额
     还款总额=（n+1）*a*i/2+a（设贷款额为a，月利率为i，还款月数为n还款利息总和为Y
     ）
     */
    float totalRepaymentOfCL = (numOfMonths + 1) * conmercialLoan * monthRateOfConmercialLoan / 2 + conmercialLoan;

    float totalRepaymentOfPRFL =
        (numOfMonths + 1) * publicReserveFundLoan * monthRateOfPublicReserveFundLoan / 2 + publicReserveFundLoan;

    float totalRepayment = totalRepaymentOfCL + totalRepaymentOfPRFL;

    NSString *totalRepaymentString = [NSString stringWithFormat:@"%.2f元", totalRepayment];

    arrayForTable = @[
      @[ @"等额本金", @"" ],
      @[ @"贷款总额 :", lumpLoanString ],
      @[ @"贷款期限 :", numOfMonthsString ],
      @[ @"首期还款 :", repaymentOfMonthString ],
      @[ @"每月递减 :", monthDecressStr ],
      @[ @"支付利息 :", interestString ],
      @[ @"还款总额 :", totalRepaymentString ]
    ];

    //计算结果表格
    [loanPortfolioTableView NaL_Matrix_array:arrayForTable andColumnsWidths:@[ @140, @140 ]];
  }
}

///该方法用于获取商业贷款月利率(传入贷款期限的Num 0，1，2，3，4，5，...)
- (float)getYearRateOfConmercialLoan:(int)num {
  if (num == 0) {
    /// 五年
    double Rate_float = (double)self.Benchmark_rate_5Below;
    return [self notRounding:Rate_float afterPoint:2];
  } else {
    ///五年以上
    double Rate_float = (double)self.Benchmark_rate_5Above;

    return [self notRounding:Rate_float afterPoint:2];
  }
}

//格式话小数 四舍五入类型
- (double)notRounding:(double)price afterPoint:(int)position {
  double sum = (int)roundf(pow(10, position)) * price;
  double result = roundf(sum) / ((int)roundf(pow(10, position)) * 1.0);
  return result;
}

/// 获取 商贷年利率倍数
- (double)getConmercialLoanMultiple {
  float multiple0 = [textFieldForConmercialLoan.text doubleValue];
  return multiple0;
}

/// 该方法用于获取还款期数
- (int)getConmercialTimesOfRepayment:(int)num {
  return (num + 1) * 5 * 12;
}

///该方法用于获取公积金贷款月利率
- (float)getYearRateOfPublicpublicReserveFundLoan:(int)num {
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

//获取 公积金贷款年利率倍数
- (double)getPublicpublicReserveFundLoanMultiple {
  float multiple1 = [textFieldForpublicReserveFund.text doubleValue];
  return multiple1;
}

#pragma mark - YLSeletionButton的代理方法，选项切换时调用

- (void)selection_btn:(int)row;
{
  NSLog(@"==================");
  if (YLSeletionButton.row == 0) {
    arrayForTable = @[
      @[ @"等额本息", @"每期等额还款" ],
      @[ @"贷款总额 :", @"元" ],
      @[ @"贷款期限 :", @"期" ],
      @[ @"月均还款 :", @"元" ],
      @[ @"支付利息 :", @"元" ],
      @[ @"还款总额 :", @"元" ]
    ];
    [loanPortfolioTableView NaL_Matrix_array:arrayForTable andColumnsWidths:@[ @140, @140 ]];
    [self addSubview:loanPortfolioTableView];
  }
  if (YLSeletionButton.row == 1) {
    arrayForTable = @[
      @[ @"等额本金", @"" ],
      @[ @"贷款总额 :", @"元" ],
      @[ @"贷款期限 :", @"期" ],
      @[ @"首期还款 :", @"元" ],
      @[ @"每月递减 :", @"元" ],
      @[ @"支付利息 :", @"元" ],
      @[ @"还款总额 :", @"元" ]
    ];
    [loanPortfolioTableView NaL_Matrix_array:arrayForTable andColumnsWidths:@[ @140, @140 ]];
    [self addSubview:loanPortfolioTableView];
  }
}

#pragma mark - 重置按钮
- (void)Reset:(UIButton *)sender {
  [YLSeletionButton my_init_btn];

  buttonForChosingLoanPeriod.city_label.text = @"五年";

  textFieldForConmercialLoan.text = @"";
  textFieldForMultiple0.text = @"1.0";
  textFieldForpublicReserveFund.text = @"";
  textFieldForMultiple1.text = @"1.0";

  arrayForTable = @[
    @[ @"等额本息", @"每期等额还款" ],
    @[ @"贷款总额 :", @"元" ],
    @[ @"贷款期限 :", @"期" ],
    @[ @"月均还款 :", @"元" ],
    @[ @"支付利息 :", @"元" ],
    @[ @"还款总额 :", @"元" ]
  ];

  [loanPortfolioTableView NaL_Matrix_array:arrayForTable andColumnsWidths:@[ @140, @140 ]];
}

//输入框被点击时调用该方法，用于控制输入框的显示高度
- (void)textFieldDidBeginEditing:(UITextField *)textField {
  if (textField.tag == 100) {
    self.contentOffset = CGPointMake(0, 100);
  }
  if (textField.tag == 200) {
    self.contentOffset = CGPointMake(0, 100);
  }
  if (textField.tag == 300) {
    self.contentOffset = CGPointMake(0, 100);
  }
  if (textField.tag == 400) {
    self.contentOffset = CGPointMake(0, 100);
  }
}

@end
