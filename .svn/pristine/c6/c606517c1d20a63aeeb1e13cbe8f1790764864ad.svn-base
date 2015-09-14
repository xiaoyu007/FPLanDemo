//
//  The_second-hand_housing_tax_View.m
//  优顾理财
//
//  Created by Mac on 14/10/22.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//  二手房贷款

#import "SecondHandHouseTaxView.h"
#import "NALMatrixTableView.h"
#import "ZJSwitch.h"
#import "ExpressTextField.h"

@implementation SecondHandHouseTaxView {
  ///房屋面积
  ExpressTextField *textFieldForSquare;

  ///房屋价格
  ExpressTextField *textFieldForPrice;

  ///房屋差价
  ExpressTextField *textFieldForPriceDifferent;

  ///房产性质
  YL_SelectionButton *YLseletionButton;

  ///房产购置满五年
  ZJSwitch *switch0;

  ///买房家庭首次购房
  ZJSwitch *switch1;

  ///卖房家庭唯一住房
  ZJSwitch *switch2;

  ///表格
  NALMatrixTableView *table;

  ///表格中的数据
  NSArray *tableArray;
}
- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.contentSize = CGSizeMake(self.width, 900);

    [self start];
  }
  return self;
}

///实现界面整体UI布局
- (void)start { ///房屋面积
  UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, 80, 30)];
  label1.backgroundColor = [UIColor clearColor];
  label1.text = @"房屋面积 :";
  label1.textColor = [Globle colorFromHexRGB:textNameColor];
  label1.textAlignment = NSTextAlignmentRight;
  label1.font = [UIFont systemFontOfSize:15];
  [self addSubview:label1];

  textFieldForSquare = [[ExpressTextField alloc] initWithFrame:CGRectMake(140, 20, 100, 30)];
  textFieldForSquare.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  textFieldForSquare.layer.cornerRadius = 5;
  textFieldForSquare.layer.borderWidth = 1.0f;
  textFieldForSquare.keyboardType = UIKeyboardTypeDecimalPad;
  textFieldForSquare.layer.borderColor = [Globle colorFromHexRGB:textfieldBordColor].CGColor;
  textFieldForSquare.delegate = self;
  [textFieldForSquare setSpaceAtStart];
  [self addSubview:textFieldForSquare];

  UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(250, 20, 50, 30)];
  label2.text = @"平方米";
  label2.backgroundColor = [UIColor clearColor];
  label2.textAlignment = NSTextAlignmentLeft;
  label2.font = [UIFont systemFontOfSize:15];
  [self addSubview:label2];

  ///房屋总价
  UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(50, 70, 80, 30)];
  label3.backgroundColor = [UIColor clearColor];
  label3.text = @"房屋总价 :";
  label3.textAlignment = NSTextAlignmentRight;
  label3.font = [UIFont systemFontOfSize:15];
  [self addSubview:label3];

  textFieldForPrice = [[ExpressTextField alloc] initWithFrame:CGRectMake(140, 70, 100, 30)];
  textFieldForPrice.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  textFieldForPrice.layer.cornerRadius = 5;
  textFieldForPrice.layer.borderWidth = 1.0f;
  textFieldForPrice.keyboardType = UIKeyboardTypeDecimalPad;
  textFieldForPrice.layer.borderColor = [Globle colorFromHexRGB:textfieldBordColor].CGColor;
  textFieldForPrice.delegate = self;
  [textFieldForPrice setSpaceAtStart];
  [self addSubview:textFieldForPrice];

  UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(250, 70, 30, 30)];
  label4.text = @"万元";
  label4.backgroundColor = [UIColor clearColor];
  label4.textAlignment = NSTextAlignmentLeft;
  label4.font = [UIFont systemFontOfSize:15];
  [self addSubview:label4];

  ///房屋差价
  UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(50, 120, 80, 30)];
  label5.backgroundColor = [UIColor clearColor];
  label5.text = @"房屋差价 :";
  label5.textAlignment = NSTextAlignmentRight;
  label5.font = [UIFont systemFontOfSize:15];
  [self addSubview:label5];

  textFieldForPriceDifferent = [[ExpressTextField alloc] initWithFrame:CGRectMake(140, 120, 100, 30)];
  textFieldForPriceDifferent.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  textFieldForPriceDifferent.layer.cornerRadius = 5;
  textFieldForPriceDifferent.layer.borderWidth = 1.0f;
  textFieldForPriceDifferent.keyboardType = UIKeyboardTypeDecimalPad;
  textFieldForPriceDifferent.layer.borderColor = [Globle colorFromHexRGB:textfieldBordColor].CGColor;
  textFieldForPriceDifferent.delegate = self;
  [textFieldForPriceDifferent setSpaceAtStart];
  [self addSubview:textFieldForPriceDifferent];

  UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(250, 120, 30, 30)];
  label6.text = @"万元";
  label6.backgroundColor = [UIColor clearColor];
  label6.textAlignment = NSTextAlignmentLeft;
  label6.font = [UIFont systemFontOfSize:15];
  [self addSubview:label6];

  ///房产性质
  UILabel *label7 = [[UILabel alloc] initWithFrame:CGRectMake(50, 175, 80, 30)];
  label7.backgroundColor = [UIColor clearColor];
  label7.text = @"房产性质 :";
  label7.textAlignment = NSTextAlignmentRight;
  label7.font = [UIFont systemFontOfSize:15];
  [self addSubview:label7];

  NSArray *array1 = @[ @"普通住宅", @"非普通住宅", @"经济适用房" ];
  YLseletionButton = [[YL_SelectionButton alloc] initWithFrame:CGRectMake(90, 165, 100, 120)
                                                      andTitle:nil
                                                       andType:2
                                                      andArray:array1];
  [self addSubview:YLseletionButton];

  ///房产购置满五年
  UILabel *label8 = [[UILabel alloc] initWithFrame:CGRectMake(50, 300, 130, 30)];
  label8.backgroundColor = [UIColor clearColor];
  label8.text = @"房产购置满五年 :";
  label8.textAlignment = NSTextAlignmentRight;
  label8.font = [UIFont systemFontOfSize:15];
  [self addSubview:label8];

  switch0 = [[ZJSwitch alloc] initWithFrame:CGRectMake(185, 300, 60, 10)];
  switch0.on = NO;
  [self addSubview:switch0];

  ///买房家庭首次购房
  UILabel *label9 = [[UILabel alloc] initWithFrame:CGRectMake(50, 355, 130, 20)];
  label9.backgroundColor = [UIColor clearColor];
  label9.text = @"买房家庭首次购房 :";
  label9.textAlignment = NSTextAlignmentRight;
  label9.font = [UIFont systemFontOfSize:15];
  [self addSubview:label9];

  switch1 = [[ZJSwitch alloc] initWithFrame:CGRectMake(185, 350, 60, 10)];
  switch1.on = NO;
  [self addSubview:switch1];

  //卖房家庭唯一住房
  UILabel *label10 = [[UILabel alloc] initWithFrame:CGRectMake(50, 400, 130, 30)];
  label10.backgroundColor = [UIColor clearColor];
  label10.text = @"卖房家庭唯一住房 :";
  label10.textAlignment = NSTextAlignmentRight;
  label10.font = [UIFont systemFontOfSize:15];
  [self addSubview:label10];

  switch2 = [[ZJSwitch alloc] initWithFrame:CGRectMake(185, 402, 60, 10)];
  switch2.on = NO;
  [self addSubview:switch2];

  //计算
  UIButton *calculationButton = [UIButton buttonWithType:UIButtonTypeCustom];
  calculationButton.frame = CGRectMake(55, 450, 100, 30);
  calculationButton.backgroundColor = [Globle colorFromHexRGB:@"2f8ef2"];
  calculationButton.layer.cornerRadius = 5;
  UIImage *highlightImage = [FPYouguUtil createImageWithColor:buttonHighLightColor];
  [calculationButton setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
  [calculationButton setTitle:@"计算" forState:UIControlStateNormal];
  calculationButton.titleLabel.textAlignment = NSTextAlignmentCenter;
  calculationButton.titleLabel.font = [UIFont systemFontOfSize:15];
  [calculationButton addTarget:self
                        action:@selector(calculate)
              forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:calculationButton];

  //重置
  UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
  resetButton.frame = CGRectMake(165, 450, 100, 30);
  resetButton.backgroundColor = [Globle colorFromHexRGB:@"2f8ef2"];
  resetButton.layer.cornerRadius = 5;
  [resetButton setTitle:@"重置" forState:UIControlStateNormal];
  resetButton.titleLabel.textAlignment = NSTextAlignmentCenter;
  resetButton.titleLabel.font = [UIFont systemFontOfSize:15];
  [resetButton addTarget:self action:@selector(reset) forControlEvents:UIControlEventTouchUpInside];
  [resetButton setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
  [self addSubview:resetButton];

  //分割线
  UIView *breakLine = [[UIView alloc] initWithFrame:CGRectMake(20, 499, 280, 1)];
  breakLine.backgroundColor = [Globle colorFromHexRGB:@"d9d9d9"];
  [self addSubview:breakLine];

  ///计算结果表格
  tableArray = @[
    @[ @"税收项目 :", @"金额" ],
    @[ @"契税 :", @"元" ],
    @[ @"营业税 :", @"元" ],
    @[ @"个人所得税 :", @"元" ],
    @[ @"工本费 :", @"元" ],
    @[ @"综合地价款 :", @"元" ],
    @[ @"合计 :", @"元" ]
  ];
  table = [[NALMatrixTableView alloc] initWithFrame:CGRectMake(20, 520, 280, 30)
                                           andArray:tableArray
                                   andColumnsWidths:@[ @90, @190 ]];
  [self addSubview:table];

  //    //结果表格上的详情按钮
  //    UIButton *button1=[[UIButton alloc]initWithFrame:CGRectMake(255, 520,
  //    40, 30)];
  //    button1.backgroundColor=[UIColor clearColor];
  //    [button1 setTitle:@"详情" forState:UIControlStateNormal];
  //    [button1 setTitleColor:[Globle colorFromHexRGB:@"2f8ef2"]
  //    forState:UIControlStateNormal];
  //    button1.titleLabel.font=[UIFont systemFontOfSize: 13];
  //    [self addSubview: button1];
  //    [button1 release];
  //
  //    UIButton *button2=[[UIButton alloc]initWithFrame:CGRectMake(255, 550,
  //    40, 30)];
  //    button2.backgroundColor=[UIColor clearColor];
  //    [button2 setTitle:@"详情" forState:UIControlStateNormal];
  //    [button2 setTitleColor:[Globle colorFromHexRGB:@"2f8ef2"]
  //    forState:UIControlStateNormal];
  //    button2.titleLabel.font=[UIFont systemFontOfSize: 13];
  //    [self addSubview: button2];
  //    [button2 release];
  //
  //    UIButton *button3=[[UIButton alloc]initWithFrame:CGRectMake(255, 580,
  //    40, 30)];
  //    button3.backgroundColor=[UIColor clearColor];
  //    [button3 setTitle:@"详情" forState:UIControlStateNormal];
  //    [button3 setTitleColor:[Globle colorFromHexRGB:@"2f8ef2"]
  //    forState:UIControlStateNormal];
  //    button3.titleLabel.font=[UIFont systemFontOfSize: 13];
  //    [self addSubview: button3];
  //    [button3 release];
  //
  //    UIButton *button4=[[UIButton alloc]initWithFrame:CGRectMake(255, 610,
  //    40, 30)];
  //    button4.backgroundColor=[UIColor clearColor];
  //    [button4 setTitle:@"详情" forState:UIControlStateNormal];
  //    [button4 setTitleColor:[Globle colorFromHexRGB:@"2f8ef2"]
  //    forState:UIControlStateNormal];
  //    button4.titleLabel.font=[UIFont systemFontOfSize: 13];
  //    [self addSubview: button4];
  //    [button4 release];
  //
  //    UIButton *button5=[[UIButton alloc]initWithFrame:CGRectMake(255, 635,
  //    40, 30)];
  //    button5.backgroundColor=[UIColor clearColor];
  //    [button5 setTitle:@"详情" forState:UIControlStateNormal];
  //    [button5 setTitleColor:[Globle colorFromHexRGB:@"2f8ef2"]
  //    forState:UIControlStateNormal];
  //    button5.titleLabel.font=[UIFont systemFontOfSize: 13];
  //    [self addSubview: button5];
  //    [button5 release];
  //
  //    UIButton *button6=[[UIButton alloc]initWithFrame:CGRectMake(255, 665,
  //    40, 30)];
  //    button6.backgroundColor=[UIColor clearColor];
  //    [button6 setTitle:@"详情" forState:UIControlStateNormal];
  //    [button6 setTitleColor:[Globle colorFromHexRGB:@"2f8ef2"]
  //    forState:UIControlStateNormal];
  //    button6.titleLabel.font=[UIFont systemFontOfSize: 13];
  //    [self addSubview: button6];
  //    [button6 release];

  ///工具说明
  UILabel *label11 = [[UILabel alloc] initWithFrame:CGRectMake(20, 700, 280, 150)];
  label11.backgroundColor = [UIColor clearColor];
  label11.text = @"工具说明 "
      @":\n二手房交易税费计算器可以计算买卖双方在买卖二手房时中所涉及到的主要" @"税费数额,"
      @"适用于北京、上海、广东、深圳等城市的二手房买卖交易税费计算。";
  label11.numberOfLines = 5;
  label11.textColor = [Globle colorFromHexRGB:@"a3a3a3"];
  label11.textAlignment = NSTextAlignmentLeft;
  label11.font = [UIFont systemFontOfSize:15];
  [self addSubview:label11];

  //白天模式/夜间模式
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

  textFieldForSquare.layer.borderColor = [Globle colorFromHexRGB:textfieldBordColor].CGColor;
  textFieldForSquare.textColor = [Globle colorFromHexRGB:textfieldContentColor];
  textFieldForSquare.keyboardAppearance = UIKeyboardAppearanceDefault;

  textFieldForPrice.layer.borderColor = [Globle colorFromHexRGB:textfieldBordColor].CGColor;
  textFieldForPrice.textColor = [Globle colorFromHexRGB:textfieldContentColor];
  textFieldForPrice.keyboardAppearance = UIKeyboardAppearanceDefault;

  textFieldForPriceDifferent.layer.borderColor = [Globle colorFromHexRGB:textfieldBordColor].CGColor;
  textFieldForPriceDifferent.textColor = [Globle colorFromHexRGB:textfieldContentColor];
  textFieldForPriceDifferent.keyboardAppearance = UIKeyboardAppearanceDefault;

  [switch0 setThumbTintColor:[UIColor lightGrayColor]];
  [switch0 setTintColor:[UIColor colorWithRed:0.80f green:0.80f blue:0.80f alpha:1.00f]];
  [switch0 setOnTintColor:[UIColor colorWithRed:0.21f green:0.54f blue:1.00f alpha:1.00f]];

  [switch1 setThumbTintColor:[UIColor lightGrayColor]];
  [switch1 setTintColor:[UIColor colorWithRed:0.80f green:0.80f blue:0.80f alpha:1.00f]];
  [switch1 setOnTintColor:[UIColor colorWithRed:0.21f green:0.54f blue:1.00f alpha:1.00f]];

  [switch2 setThumbTintColor:[UIColor lightGrayColor]];
  [switch2 setTintColor:[UIColor colorWithRed:0.80f green:0.80f blue:0.80f alpha:1.00f]];
  [switch2 setOnTintColor:[UIColor colorWithRed:0.21f green:0.54f blue:1.00f alpha:1.00f]];

  // breakLine.backgroundColor = [UIColor darkGrayColor];

  calculationButton.backgroundColor =
      [UIColor colorWithRed:0.20f green:0.55f blue:0.98f alpha:1.00f];
  resetButton.backgroundColor = [UIColor colorWithRed:0.20f green:0.55f blue:0.98f alpha:1.00f];
}

#pragma mark - 计算按钮
- (void)calculate {
  //首先判断输入框中内容是否输入完整，不完整则弹出提示
  if ([textFieldForSquare.text doubleValue] <= 0) {
    YouGu_animation_Did_Start(@"请输入房屋面积") return;
  }
  if ([textFieldForPrice.text doubleValue] <= 0) {
    YouGu_animation_Did_Start(@"请输入房屋总价") return;
  }
  if ([textFieldForPriceDifferent.text doubleValue] <= 0) {
    YouGu_animation_Did_Start(@"请输入贷款差价") return;
  }
  if ((YLseletionButton.row == 2) && (switch0.on == NO)) {
    YouGu_animation_Did_Start(@"经济适用房未满5年不能交易");
    return;
  }

  ///合计
  double total;
  NSString *totalString;

  ///契税
  double contractTax;
  NSString *contractTaxString;

  ///营业税
  double salesTax;
  NSString *salesTaxString;

  ///个人所得税
  double personalIncomeTax;
  NSString *personalIncomeTaxString;

  ///工本费
  double flatCost;
  NSString *flatCostString;

  ///综合地价款
  double integratedPrice;
  NSString *integratedPriceString;

  //契税
  /*
    1）（普通住宅｜｜经济适用房）   &&  首次购房   &&
    90平以上－－－－－－－－－－－－－－－－总房价＊1.5%；
    2）（普通住宅｜｜经济适用房）   &&  首次购房   &&
    90平及以下－－－－－－－－－－－－－－－总房价＊1%；
    3）
    非普宅收－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－--总房价＊3%；
    4）
    买房家庭非首次购房－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－总房价＊3%，
  */
  if ((!(YLseletionButton.row == 1)) && (switch1.on == YES) && ([textFieldForSquare.text doubleValue] > 90)) {
    contractTax = [textFieldForPrice.text doubleValue] * 1.5 / 100 * 10000;
  } else if ((!(YLseletionButton.row == 1)) && (switch1.on == YES) &&
             ([textFieldForSquare.text doubleValue] <= 90)) {
    contractTax = [textFieldForPrice.text doubleValue] * 1.0 / 100 * 10000;
  } else if ((YLseletionButton.row == 1) || (switch1.on == NO)) {
    contractTax = [textFieldForPrice.text doubleValue] * 3.0 / 100 * 10000;
  } else {
    contractTax = 0;
  }
  contractTaxString = [NSString stringWithFormat:@"%.2lf元", contractTax];

  //营业税
  /*
    1)（普通住宅｜｜经济适用房）     &&
    房产证未满五年－－－－－－－－－－－－－差价＊5.5%；
    2）（普通住宅｜｜经济适用房）     &&
    房产证满五年－－－－－－－－－－－－－－－0元；
    3) 非普通住宅  &&
    房产证未满五年－－－－－－－－－－－－－－－－－－－－－－－总房价的5.5%；
    4） 非普通住宅  &&    房产证满五年－－－－－－－－－－－－－－－－－－－－
    －－－－房产交易盈利部分＊5.5%；
  */
  if ((YLseletionButton.row != 1) && (switch0.on == NO)) {
    salesTax = [textFieldForPriceDifferent.text doubleValue] / 100 * 5.5 * 10000;
  } else if ((YLseletionButton.row != 1) && (switch0.on == YES)) {
    salesTax = 0;
  } else if ((YLseletionButton.row == 1) && (switch0.on == YES)) {
    salesTax = [textFieldForPriceDifferent.text doubleValue] * 5.5 / 100 * 10000;
  } else {
    salesTax = [textFieldForPrice.text doubleValue] * 5.5 / 100 * 10000;
  }
  salesTaxString = [NSString stringWithFormat:@"%.2lf元", salesTax];
  //

  //个人所得税
  /*
   1）卖房家庭唯一住房    &&   满5年－－－－－－－－－－－－－－－－－－－0；
   2）除 1）以外的其他情况－－－－－－－－－－－－－－－－－－－－－－－
   成交价＊1%
  */
  if ((switch2.on == YES) && (switch0.on == YES)) {
    personalIncomeTax = 0;
  } else {
    personalIncomeTax = [textFieldForPriceDifferent.text doubleValue] * 20 / 100 * 10000;
  }
  personalIncomeTaxString = [NSString stringWithFormat:@"%.2f元", personalIncomeTax];

  //工本费
  /*
   1）普通住宅－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－92+36
   2）非普通住宅 －－－－－－－－－－－－－－－－－－－－－－－－－－－－ 550+36
   3）经济适用房－－－－－－－－－－－－－－－－－－－－－－－－－－－－－ 92+36
   */
  if (YLseletionButton.row == 1) {
    flatCost = 92 + 36;
  } else if (YLseletionButton.row == 2) {
    flatCost = 550 + 36;
  } else {
    flatCost = 92 + 36;
  }
  flatCostString = [NSString stringWithFormat:@"%.2lf元", flatCost];

  //综合地价款
  /*
   1）普通住宅－－－－－－－－－－－－－－－－－－－－－－－－－－－－－0；
   2）非普通住宅 －－－－－－－－－－－－－－－－－－－－－－－－－－－  0；
   3）经济适用房&&满五年－－－－－－－－－－－－－－－－－－－－－－－
   成交价＊10%；
   4）经济适用房&&未满五年－－－－－－－－－－－－－－－－－－－－－－ 不能交易
   */

  if ((YLseletionButton.row == 2) && (switch0.on == YES)) {
    integratedPrice = [textFieldForPrice.text doubleValue] * 10 / 100 * 10000;
  } else {
    integratedPrice = 0;
  }
  integratedPriceString = [NSString stringWithFormat:@"%.2lf元", integratedPrice];

  //合计
  /*
   合计＝契税＋营业税＋个人所得税＋印花税＋工本费＋综合地价款
   */
  total = contractTax + salesTax + personalIncomeTax + flatCost + integratedPrice;
  totalString = [NSString stringWithFormat:@"%.2lf元", total];

  //把计算结果添加到表格中
  if ((YLseletionButton.row == 2) && (switch0.on == NO)) {
    tableArray = @[
      @[ @"税收项目 :", @"金额" ],
      @[ @"契税 :", @"元" ],
      @[ @"营业税 :", @"元" ],
      @[ @"个人所得税 :", @"元" ],
      @[ @"工本费 :", @"元" ],
      @[ @"综合地价款 :", @"元" ],
      @[ @"合计 :", @"元" ]
    ];
    [table NaL_Matrix_array:tableArray andColumnsWidths:@[ @90, @190 ]];
  } else {
    tableArray = @[
      @[ @"税收项目 :", @"金额" ],
      @[ @"契税 :", contractTaxString ],
      @[ @"营业税 :", salesTaxString ],
      @[ @"个人所得税 :", personalIncomeTaxString ],
      @[ @"工本费 :", flatCostString ],
      @[ @"综合地价款 :", integratedPriceString ],
      @[ @"合计 :", totalString ]
    ];
    [table NaL_Matrix_array:tableArray andColumnsWidths:@[ @90, @190 ]];
  }
}

#pragma mark - 重置按钮点击事件
- (void)reset {
  textFieldForSquare.text = @"";
  textFieldForPrice.text = @"";
  textFieldForPriceDifferent.text = @"";

  [YLseletionButton my_init_btn];

  switch0.on = NO;
  switch1.on = NO;
  switch2.on = NO;
  tableArray = @[
    @[ @"税收项目 :", @"金额" ],
    @[ @"契税 :", @"元" ],
    @[ @"营业税 :", @"元" ],
    @[ @"个人所得税 :", @"元" ],
    @[ @"工本费 :", @"元" ],
    @[ @"综合地价款 :", @"元" ],
    @[ @"合计 :", @"元" ]
  ];

  [table NaL_Matrix_array:tableArray andColumnsWidths:@[ @90, @190 ]];
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
    flag++;
  }

  return ([newtxt length] <= maxNumOfChars);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
