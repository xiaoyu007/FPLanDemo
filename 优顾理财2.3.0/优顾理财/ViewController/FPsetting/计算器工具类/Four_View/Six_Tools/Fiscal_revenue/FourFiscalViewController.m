//
//  FourFiscalViewController.m
//  优顾理财
//
//  Created by Mac on 14/10/20.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//  理财收益

#import "FourFiscalViewController.h"


@implementation FourFiscalViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  [self.topNavView setMainLableString:@"理财收益"];
  self.content_view.contentSize = CGSizeMake(self.view.width, 450);

  //投资金额
  UILabel* city_lable =
      [[UILabel alloc] initWithFrame:CGRectMake(50, 30, 80, 30)];
  city_lable.text = @"投资金额 :";
  city_lable.backgroundColor = [UIColor clearColor];
  city_lable.textAlignment = NSTextAlignmentRight;
  city_lable.textColor = [Globle colorFromHexRGB:textNameColor];
  city_lable.font = [UIFont systemFontOfSize:15];
  [self.content_view addSubview:city_lable];

  Investment_Money =
      [[ExpressTextField alloc] initWithFrame:CGRectMake(140, 30, 100, 30)];
  Investment_Money.layer.cornerRadius = 5;
  Investment_Money.layer.borderWidth = 1.0f;
  Investment_Money.tag = 3000;
  Investment_Money.contentVerticalAlignment =
      UIControlContentVerticalAlignmentCenter;
  Investment_Money.keyboardType = UIKeyboardTypeNumberPad;
  Investment_Money.delegate = self;
  [Investment_Money setSpaceAtStart];
  [self.content_view addSubview:Investment_Money];

  UILabel* sign_label_1 =
      [[UILabel alloc] initWithFrame:CGRectMake(250, 30, 20, 30)];
  sign_label_1.text = @"元";
  sign_label_1.backgroundColor = [UIColor clearColor];
  sign_label_1.textColor = [Globle colorFromHexRGB:textNameColor];
  sign_label_1.textAlignment = NSTextAlignmentLeft;
  sign_label_1.font = [UIFont systemFontOfSize:15];
  [self.content_view addSubview:sign_label_1];

  //年化收益率
  UILabel* city_lable_2 =
      [[UILabel alloc] initWithFrame:CGRectMake(40, 80, 90, 30)];
  city_lable_2.text = @"年化收益率 :";
  city_lable_2.textColor = [Globle colorFromHexRGB:textNameColor];
  city_lable_2.backgroundColor = [UIColor clearColor];
  city_lable_2.textAlignment = NSTextAlignmentRight;
  city_lable_2.font = [UIFont systemFontOfSize:15];
  [self.content_view addSubview:city_lable_2];

  Rate_year_Input =
      [[ExpressTextField alloc] initWithFrame:CGRectMake(140, 80, 100, 30)];
  Rate_year_Input.layer.cornerRadius = 5;
  Rate_year_Input.layer.borderWidth = 1.0f;
  Rate_year_Input.tag = 4000;
  Rate_year_Input.contentVerticalAlignment =
      UIControlContentVerticalAlignmentCenter;
  Rate_year_Input.keyboardType = UIKeyboardTypeDecimalPad;
  Rate_year_Input.delegate = self;
  [Rate_year_Input setSpaceAtStart];
  [self.content_view addSubview:Rate_year_Input];

  UILabel* sign_label_2 =
      [[UILabel alloc] initWithFrame:CGRectMake(250, 80, 20, 30)];
  sign_label_2.text = @"%";
  sign_label_2.backgroundColor = [UIColor clearColor];
  sign_label_2.textColor = [Globle colorFromHexRGB:textNameColor];
  sign_label_2.textAlignment = NSTextAlignmentLeft;
  sign_label_2.font = [UIFont systemFontOfSize:15];
  [self.content_view addSubview:sign_label_2];

  //投资期限
  UILabel* city_lable_3 =
      [[UILabel alloc] initWithFrame:CGRectMake(50, 130, 80, 30)];
  city_lable_3.text = @"投资期限 :";
  city_lable_3.backgroundColor = [UIColor clearColor];
  city_lable_3.textAlignment = NSTextAlignmentRight;
  city_lable_3.textColor = [Globle colorFromHexRGB:textNameColor];
  city_lable_3.font = [UIFont systemFontOfSize:15];
  [self.content_view addSubview:city_lable_3];

  Investment_period_Input =
      [[ExpressTextField alloc] initWithFrame:CGRectMake(140, 130, 100, 30)];
  Investment_period_Input.layer.cornerRadius = 5;
  Investment_period_Input.layer.borderWidth = 1.0f;
  Investment_period_Input.tag = 5000;
  Investment_period_Input.contentVerticalAlignment =
      UIControlContentVerticalAlignmentCenter;
  Investment_period_Input.keyboardType = UIKeyboardTypeNumberPad;
  Investment_period_Input.delegate = self;
  [Investment_period_Input setSpaceAtStart];
  [self.content_view addSubview:Investment_period_Input];

  UILabel* sign_label_3 =
      [[UILabel alloc] initWithFrame:CGRectMake(250, 130, 20, 30)];
  sign_label_3.text = @"天";
  sign_label_3.textColor = [Globle colorFromHexRGB:textNameColor];
  sign_label_3.backgroundColor = [UIColor clearColor];
  sign_label_3.textAlignment = NSTextAlignmentLeft;
  sign_label_3.font = [UIFont systemFontOfSize:15];
  [self.content_view addSubview:sign_label_3];

  //计算
  UIButton* Operation_btn = [UIButton buttonWithType:UIButtonTypeCustom];
  Operation_btn.frame = CGRectMake(55, 180, 100, 30);
  Operation_btn.backgroundColor = [Globle colorFromHexRGB:@"2f8ef2"];
  Operation_btn.layer.cornerRadius = 5;
  [Operation_btn setTitle:@"计算" forState:UIControlStateNormal];
  [Operation_btn addTarget:self
                    action:@selector(Calculation)
          forControlEvents:UIControlEventTouchUpInside];
  Operation_btn.titleLabel.textAlignment = NSTextAlignmentCenter;
  Operation_btn.titleLabel.font = [UIFont systemFontOfSize:15];
  UIImage* highlightImage = [FPYouguUtil createImageWithColor:buttonHighLightColor];
  [Operation_btn setBackgroundImage:highlightImage
                           forState:UIControlStateHighlighted];
  [self.content_view addSubview:Operation_btn];

  //重置
  UIButton* Operation_btn_2 = [UIButton buttonWithType:UIButtonTypeCustom];
  Operation_btn_2.frame = CGRectMake(165, 180, 100, 30);
  Operation_btn_2.backgroundColor = [Globle colorFromHexRGB:@"2f8ef2"];
  Operation_btn_2.layer.cornerRadius = 5;
  [Operation_btn_2 setTitle:@"重置" forState:UIControlStateNormal];
  [Operation_btn_2 setBackgroundImage:highlightImage
                             forState:UIControlStateHighlighted];
  [Operation_btn_2 addTarget:self
                      action:@selector(Reset)
            forControlEvents:UIControlEventTouchUpInside];
  Operation_btn_2.titleLabel.textAlignment = NSTextAlignmentCenter;
  Operation_btn_2.titleLabel.font = [UIFont systemFontOfSize:15];
  [self.content_view addSubview:Operation_btn_2];

  //  计算理财收益
  Detail_tableView =
      [[NALMatrixTableView alloc] initWithFrame:CGRectMake(50, 230, 220, 30)
                                         andArray:@[
                                           @[ @" ", @"结果" ],
                                           @[ @"收益金额", @"元" ],
                                           @[ @"合计", @"元" ]
                                         ]
                                 andColumnsWidths:@[ @80, @140 ]];
  [self.content_view addSubview:Detail_tableView];

  //对比 活期利息
  Contrast_tableView = [[NALMatrixTableView alloc]
         initWithFrame:CGRectMake(30, 330, 270, 30)
              andArray:@[
                @[ @"活期参照", @"结果" ],
                @[ @"同期限银行存款活期利息收入", @"元" ],
                @[ @"收益金额是同期限活期利息的", @"倍" ]
              ]
      andColumnsWidths:@[ @190, @80 ]];
  [self.content_view addSubview:Contrast_tableView];

  if (YouGu_fileExistsAtPath(
          pathInCacheDirectory(@"DepositRate_array.plist"))) {
    NSDictionary* dic = [NSDictionary
        dictionaryWithContentsOfFile:pathInCacheDirectory(
                                         @"DepositRate_array.plist")];

    [self Current_DepositRate:dic];
  } else {
    NSString* path_2 =
        [[NSBundle mainBundle] pathForResource:@"BankName.plist" ofType:nil];
    NSDictionary* dic = [NSDictionary dictionaryWithContentsOfFile:path_2];
    [self Current_DepositRate:dic];
  }
  [self DepositRate];

  city_lable.textColor = [Globle colorFromHexRGB:textNameColor];
  sign_label_1.textColor = [Globle colorFromHexRGB:textNameColor];
  city_lable_2.textColor = [Globle colorFromHexRGB:textNameColor];
  sign_label_2.textColor = [Globle colorFromHexRGB:textNameColor];
  city_lable_3.textColor = [Globle colorFromHexRGB:textNameColor];
  sign_label_3.textColor = [Globle colorFromHexRGB:textNameColor];

  Investment_Money.keyboardAppearance = UIKeyboardAppearanceDefault;
  Investment_Money.textColor = [Globle colorFromHexRGB:textfieldContentColor];
  Investment_Money.layer.borderColor =
      [Globle colorFromHexRGB:textfieldBordColor].CGColor;
  Rate_year_Input.keyboardAppearance = UIKeyboardAppearanceDefault;
  Rate_year_Input.textColor = [Globle colorFromHexRGB:textfieldContentColor];
  Rate_year_Input.layer.borderColor =
      [Globle colorFromHexRGB:textfieldBordColor].CGColor;
  Investment_period_Input.keyboardAppearance = UIKeyboardAppearanceDefault;
  Investment_period_Input.textColor =
      [Globle colorFromHexRGB:textfieldContentColor];
  Investment_period_Input.layer.borderColor =
      [Globle colorFromHexRGB:textfieldBordColor].CGColor;

  Operation_btn.backgroundColor = [Globle colorFromHexRGB:@"2f8ef2"];
  Operation_btn_2.backgroundColor = [Globle colorFromHexRGB:@"2f8ef2"];
}

- (BOOL)textField:(UITextField*)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString*)string {
  int MAX_CHARS = 9;
  if (textField.tag == 5000) {
    MAX_CHARS = 4;
  } else if (textField.tag == 4000) {
    MAX_CHARS = 5;
  }

  NSMutableString* newtxt = [NSMutableString stringWithString:textField.text];

  [newtxt replaceCharactersInRange:range withString:string];

  return ([newtxt length] <= MAX_CHARS);
}

//= 存款利息利率
#pragma mark -  存款利息利率
- (void)DepositRate {
  [[WebServiceManager sharedManager]
      The_depositRate_completion:^(NSDictionary* dic) {
        if (dic && [dic[@"status"] isEqualToString:@"0000"]) {
          //存款利息利率 保存 本地
          [dic writeToFile:pathInCacheDirectory(@"DepositRate_array.plist")
                atomically:YES];

          [self Current_DepositRate:dic];
        } else {
          NSString* message = dic[@"message"];
          if (message) {
            if (dic &&
                [dic[@"status"] isEqualToString:@"0101"]){
            }else{
              YouGu_animation_Did_Start(message);
            }
          } else {
            YouGu_animation_Did_Start(networkFailed);
          }
        }
      }];
}

- (void)Current_DepositRate:(NSDictionary*)dic {
  NSMutableArray* Bank_array = [[NSMutableArray alloc] initWithCapacity:0];
  NSArray* depositRate_array = dic[@"depositList"];
  for (NSDictionary* bank_dic in depositRate_array) {
    [Bank_array
        addObject:YouGu_ishave_blank(bank_dic[@"bankName"])];

    if ([bank_dic[@"bankName"] isEqualToString:@"基准利率"]) {
      // 获取  基准活期利率
      Datum_Current_Rate =
          [bank_dic[@"currentDepositRate"] doubleValue];
    }
  }
  //储蓄银行
  [Bank_array writeToFile:pathInCacheDirectory(@"BankName.plist")
               atomically:YES];
}

#pragma mark -  计算按钮
//计算
- (void)Calculation {
  if ([Investment_Money.text intValue] > 0 &&
      [Rate_year_Input.text doubleValue] > 0 &&
      [Investment_period_Input.text doubleValue] > 0) {
    //收益金额
    double Income_amount_float = [Investment_Money.text intValue] * 0.01 *
                                 [Rate_year_Input.text doubleValue] *
                                 [Investment_period_Input.text intValue] / 365;
    NSString* Income_amount =
        [NSString stringWithFormat:@"%0.3lf元", Income_amount_float];
    if (Income_amount_float > 100000000) {
      Income_amount = [NSString
          stringWithFormat:@"%0.3lf亿元", Income_amount_float / 100000000.0];
    } else if (Income_amount_float > 10000) {
      Income_amount = [NSString
          stringWithFormat:@"%0.3lf万元", Income_amount_float / 10000.0];
    }
    double Income_Sum_double =
        [Investment_Money.text intValue] *
        (1 +
         0.01 * [Rate_year_Input.text doubleValue] *
             [Investment_period_Input.text intValue] / 365);
    //合计
    NSString* Income_Sum =
        [NSString stringWithFormat:@"%0.3lf元", Income_Sum_double];
    if (Income_Sum_double > 100000000) {
      Income_Sum = [NSString
          stringWithFormat:@"%0.3lf亿元", Income_Sum_double / 100000000.0];
    } else if (Income_Sum_double > 10000) {
      Income_Sum = [NSString
          stringWithFormat:@"%0.3lf万元", Income_Sum_double / 10000.0];
    }

    [Detail_tableView NaL_Matrix_array:@[
      @[ @" ", @"结果" ],
      @[ @"收益金额", Income_amount ],
      @[ @"合计", Income_Sum ]
    ] andColumnsWidths:@[ @80, @140 ]];

    // 活期利息
    double Current_interest_float =
        Datum_Current_Rate * [Investment_Money.text intValue] *
        [Investment_period_Input.text intValue] * 0.01 / 360;
    NSString* Current_interest =
        [NSString stringWithFormat:@"%0.3lf元", Current_interest_float];
    if (Current_interest_float > 100000000) {
      Current_interest = [NSString
          stringWithFormat:@"%0.3lf亿元", Current_interest_float / 100000000.0];
    } else if (Current_interest_float > 10000) {
      Current_interest = [NSString
          stringWithFormat:@"%0.3lf万元", Current_interest_float / 10000.0];
    }

    double Contrast_multiples_double =
        Income_amount_float / Current_interest_float;
    // 对比倍数
    NSString* Contrast_multiples =
        [NSString stringWithFormat:@"%0.3lf倍", Contrast_multiples_double];
    if (Contrast_multiples_double > 100000000) {
      Contrast_multiples =
          [NSString stringWithFormat:@"%0.3lf亿倍",
                                     Contrast_multiples_double / 100000000.0];
    } else if (Contrast_multiples_double > 10000) {
      Contrast_multiples = [NSString
          stringWithFormat:@"%0.3lf万倍", Contrast_multiples_double / 10000.0];
    }
    // Current_interest_float == 0时
    if (Current_interest_float == 0) {
      Current_interest = @"-- 元";
      Contrast_multiples = @"-- 倍";
    }
    [Contrast_tableView NaL_Matrix_array:@[
      @[ @"活期参照", @"结果" ],
      @[ @"同期限银行存款活期利息收入", Current_interest ],
      @[ @"收益金额是同期限活期利息的", Contrast_multiples ]
    ] andColumnsWidths:@[ @190, @80 ]];
  } else {
    if ([Investment_Money.text doubleValue] == 0) {
      YouGu_animation_Did_Start(@"请输入投资金额");
    } else if ([Rate_year_Input.text doubleValue] == 0) {
      YouGu_animation_Did_Start(@"请输入产品年化收益率");
    } else {
      YouGu_animation_Did_Start(@"请输入投资期限");
    }
  }
}

#pragma mark -  重置
// 重置
- (void)Reset {
  Investment_Money.text = @"";
  Rate_year_Input.text = @"";
  Investment_period_Input.text = @"";

  [Detail_tableView NaL_Matrix_array:@[
    @[ @" ", @"结果" ],
    @[ @"收益金额", @"元" ],
    @[ @"合计", @"元" ]
  ] andColumnsWidths:@[ @80, @140 ]];

  [Contrast_tableView NaL_Matrix_array:@[
    @[ @"活期参照", @"结果" ],
    @[ @"同期限银行存款活期利息收入", @"元" ],
    @[ @"收益金额是同期限活期利息的", @"倍" ]
  ] andColumnsWidths:@[ @190, @80 ]];
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
