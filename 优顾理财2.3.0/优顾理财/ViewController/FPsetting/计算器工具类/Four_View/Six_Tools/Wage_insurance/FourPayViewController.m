//
//  FourPayViewController.m
//  优顾理财
//
//  Created by Mac on 14/10/20.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//  工资保险

#import "FourPayViewController.h"

//解析对象
#import "Tools_data_object.h"


@implementation FourPayViewController
@synthesize title_label;

@synthesize Socail_array;
@synthesize Pay_array;

@synthesize Pay_Rate_array;
@synthesize Pay_Tax_makeup;

- (void)viewDidLoad {
  [super viewDidLoad];
  Socail_base_Whether = NO;
  Since_tax_point = 3500;

  Socail_array = [[NSMutableArray alloc] initWithCapacity:0];
  Pay_array = [[NSMutableArray alloc] initWithCapacity:0];

  Pay_Rate_array = [[NSMutableArray alloc] initWithCapacity:0];
  Pay_Tax_makeup = [[NSMutableArray alloc] initWithCapacity:0];

  // Do any additional setup after loading the view.
  [self.topNavView setMainLableString:@"工资保险"];
  self.content_view.contentSize = CGSizeMake(self.view.width, 600);

  NSString* path_1 =
      [[NSBundle mainBundle] pathForResource:@"city.plist" ofType:nil];
  YG_Citys = [[NSMutableArray alloc] initWithContentsOfFile:path_1];

  YG_Tax = @[@"税前工资", @"税后工资"];
  // top

  self.title_label = [[NSString alloc] initWithFormat:@"税后工资"];

  if (YouGu_fileExistsAtPath(pathInCacheDirectory(@"Socail_array.plist"))) {
    NSDictionary* dic =
        [NSDictionary dictionaryWithContentsOfFile:pathInCacheDirectory(
                                                       @"Socail_array.plist")];

    [self Social_Security_reData_analysis:dic];
  } else {
    NSString* path_1 =
        [[NSBundle mainBundle] pathForResource:@"Socail_array.plist"
                                        ofType:nil];

    NSDictionary* dic = [NSDictionary dictionaryWithContentsOfFile:path_1];

    [self Social_Security_reData_analysis:dic];
  }

  if (YouGu_fileExistsAtPath(pathInCacheDirectory(@"Pay_array.plist"))) {
    NSDictionary* dic = [NSDictionary
        dictionaryWithContentsOfFile:pathInCacheDirectory(@"Pay_array.plist")];

    [self Wage_Insurance_reData_analysis:dic];
  } else {
    NSString* path_1 =
        [[NSBundle mainBundle] pathForResource:@"Pay_array.plist" ofType:nil];

    NSDictionary* dic = [NSDictionary dictionaryWithContentsOfFile:path_1];

    [self Wage_Insurance_reData_analysis:dic];
  }

  // city
  UILabel* city_lable = [[UILabel alloc]
      initWithFrame:CGRectMake(0, 20, self.view.width / 3, 30)];
  city_lable.text = @"城市:";
  city_lable.textColor = [Globle colorFromHexRGB:@"595959"];
  city_lable.backgroundColor = [UIColor clearColor];
  city_lable.textAlignment = NSTextAlignmentRight;
  city_lable.font = [UIFont systemFontOfSize:15];
  [self.content_view addSubview:city_lable];

  city_textfield_btn = [[Textfield_btn alloc]
      initWithFrame:CGRectMake(self.view.width / 3 + 10, 20,
                               self.view.width * 2 / 5, 33)];
  city_textfield_btn.city_label.text = @"北京";
  [city_textfield_btn.click_btn addTarget:self
                                   action:@selector(click_btn:)
                         forControlEvents:UIControlEventTouchUpInside];
  [self.content_view addSubview:city_textfield_btn];

  //税前工资和税后工资
  Pre_tax_btn = [[Textfield_btn alloc]
      initWithFrame:CGRectMake(50, 70, self.view.width / 2 - 60, 33)];
  Pre_tax_btn.city_label.text = @"税前工资";
  [Pre_tax_btn.click_btn addTarget:self
                            action:@selector(Pre_tax_btn:)
                  forControlEvents:UIControlEventTouchUpInside];
  [self.content_view addSubview:Pre_tax_btn];

  tax_money_field = [[ExpressTextField alloc]
      initWithFrame:CGRectMake(self.view.width / 2, 70, self.view.width / 3,
                               33)];
  tax_money_field.layer.cornerRadius = 5;
  tax_money_field.tag = 1000;
  tax_money_field.layer.borderWidth = 1.0f;
  [tax_money_field.layer
      setBorderColor:[Globle colorFromHexRGB:@"e5e5e5"].CGColor];
  tax_money_field.textColor = [Globle colorFromHexRGB:@"8c8c8c"];
  tax_money_field.contentVerticalAlignment =
      UIControlContentVerticalAlignmentCenter;
  tax_money_field.textAlignment = NSTextAlignmentRight;
  tax_money_field.keyboardType = UIKeyboardTypeNumberPad;
  tax_money_field.delegate = self;
  [tax_money_field setSpaceInTheEnd];
  [self.content_view addSubview:tax_money_field];

  UILabel* sign_label =
      [[UILabel alloc] initWithFrame:CGRectMake(self.view.width * 5 / 6, 70,
                                                self.view.width / 6, 30)];
  sign_label.text = @"元";
  sign_label.textColor = [Globle colorFromHexRGB:@"595959"];
  sign_label.backgroundColor = [UIColor clearColor];
  sign_label.textAlignment = NSTextAlignmentLeft;
  sign_label.font = [UIFont systemFontOfSize:13];
  [self.content_view addSubview:sign_label];

  //计算
  UIButton* Operation_btn = [UIButton buttonWithType:UIButtonTypeCustom];
  Operation_btn.frame =
      CGRectMake(self.view.width / 4, 120, self.view.width / 2, 30);
  Operation_btn.layer.cornerRadius = 5;
  [Operation_btn addTarget:self
                    action:@selector(Calculation)
          forControlEvents:UIControlEventTouchUpInside];
  [Operation_btn setTitle:@"计算" forState:UIControlStateNormal];
  UIImage* highlightImage = [FPYouguUtil createImageWithColor:buttonHighLightColor];
  [Operation_btn setBackgroundImage:highlightImage
                           forState:UIControlStateHighlighted];
  Operation_btn.titleLabel.textAlignment = NSTextAlignmentCenter;
  Operation_btn.titleLabel.font = [UIFont systemFontOfSize:15];
  [self.content_view addSubview:Operation_btn];

  result_tableView =
      [[NALMatrixTableView alloc] initWithFrame:CGRectMake(50, 170, 220, 90)
                                         andArray:@[
                                           @[ @" ", @"结果" ],
                                           @[ @"缴纳个税", @"元" ],
                                           @[ @"税后工资", @"元" ]
                                         ]
                                 andColumnsWidths:@[ @80, @140 ]];
  [self.content_view addSubview:result_tableView];

  UIView* line_View =
      [[UIView alloc] initWithFrame:CGRectMake(10, 270, 300, 1)];
  line_View.backgroundColor = [Globle colorFromHexRGB:@"dfdfdf"];
  [self.content_view addSubview:line_View];

  UILabel* sign_label_3 =
      [[UILabel alloc] initWithFrame:CGRectMake(10, 280, 300, 30)];
  sign_label_3.text = @"社保和公积金缴纳明细（参数可调整）";
  sign_label_3.backgroundColor = [UIColor clearColor];
  sign_label_3.textColor = [Globle colorFromHexRGB:@"bc0019"];
  sign_label_3.textAlignment = NSTextAlignmentLeft;
  sign_label_3.font = [UIFont systemFontOfSize:15];
  [self.content_view addSubview:sign_label_3];

  UILabel* sign_label_4 =
      [[UILabel alloc] initWithFrame:CGRectMake(10, 320, 100, 30)];
  sign_label_4.text = @"缴纳基数:社保";
  sign_label_4.textColor = [Globle colorFromHexRGB:@"595959"];
  sign_label_4.backgroundColor = [UIColor clearColor];
  sign_label_4.textAlignment = NSTextAlignmentLeft;
  sign_label_4.font = [UIFont systemFontOfSize:15];
  [self.content_view addSubview:sign_label_4];

  tax_Social_field =
      [[ExpressTextField alloc] initWithFrame:CGRectMake(105, 320, 60, 30)];
  tax_Social_field.layer.cornerRadius = 5;
  tax_Social_field.layer.borderWidth = 1.0f;
  tax_Social_field.tag = 2000;
  tax_Social_field.keyboardType = UIKeyboardTypeNumberPad;
  tax_Social_field.contentVerticalAlignment =
      UIControlContentVerticalAlignmentCenter;
  tax_Social_field.textAlignment = NSTextAlignmentCenter;
  tax_Social_field.layer.borderColor =
      [Globle colorFromHexRGB:@"e5e5e5"].CGColor;
  tax_Social_field.textColor = [Globle colorFromHexRGB:@"8c8c8c"];
  tax_Social_field.delegate = self;
  [tax_Social_field setSpaceAtStart];
  [self.content_view addSubview:tax_Social_field];

  UILabel* sign_label_5 =
      [[UILabel alloc] initWithFrame:CGRectMake(165, 320, 70, 30)];
  sign_label_5.text = @"元  公积金";
  sign_label_5.textColor = [Globle colorFromHexRGB:@"595959"];
  sign_label_5.backgroundColor = [UIColor clearColor];
  sign_label_5.textAlignment = NSTextAlignmentLeft;
  sign_label_5.font = [UIFont systemFontOfSize:15];
  [self.content_view addSubview:sign_label_5];

  tax_Social_field_Fund =
      [[ExpressTextField alloc] initWithFrame:CGRectMake(235, 320, 60, 30)];
  tax_Social_field_Fund.layer.cornerRadius = 5;
  tax_Social_field_Fund.layer.borderWidth = 1.0f;
  tax_Social_field_Fund.contentVerticalAlignment =
      UIControlContentVerticalAlignmentCenter;
  tax_Social_field_Fund.textAlignment = NSTextAlignmentCenter;
  tax_Social_field_Fund.keyboardType = UIKeyboardTypeNumberPad;
  tax_Social_field_Fund.tag = 3000;
  tax_Social_field_Fund.layer.borderColor =
      [Globle colorFromHexRGB:@"e5e5e5"].CGColor;
  tax_Social_field_Fund.textColor = [Globle colorFromHexRGB:@"8c8c8c"];
  tax_Social_field_Fund.delegate = self;
  [tax_Social_field setSpaceAtStart];
  [self.content_view addSubview:tax_Social_field_Fund];

  UILabel* sign_label_6 =
      [[UILabel alloc] initWithFrame:CGRectMake(295, 320, 20, 30)];
  sign_label_6.text = @"元";
  sign_label_6.textColor = [Globle colorFromHexRGB:@"595959"];
  sign_label_6.backgroundColor = [UIColor clearColor];
  sign_label_6.textAlignment = NSTextAlignmentLeft;
  sign_label_6.font = [UIFont systemFontOfSize:15];
  [self.content_view addSubview:sign_label_6];

  Detail_tableView = [[NALMatrixTableView alloc]
         initWithFrame:CGRectMake(5, 360, 310, 100)
              andArray:@[
                @[ @"缴纳比例", @"比例%", @"金额" ],
                @[ @"住房公积金", @"％", @"元" ],
                @[ @"医疗保险", @"％", @"元" ],
                @[ @"养老保险", @"％", @"元" ],
                @[ @"失业保险", @"％", @"元" ],
                @[ @"工伤保险", @"％", @"元" ],
                @[ @"生育保险", @"％", @"元" ],
                @[ @"总和", @"--", @"元" ]
              ]
      andColumnsWidths:@[ @100, @100, @110 ]];
  [self.content_view addSubview:Detail_tableView];

  [self Fund_API];
  [self requeste];

  sign_label_3.textColor = [Globle colorFromHexRGB:@"bc0019"];

  tax_money_field.keyboardAppearance = UIKeyboardAppearanceDefault;
  tax_money_field.textColor = [Globle colorFromHexRGB:@"8c8c8c"];
  tax_money_field.layer.borderColor =
      [Globle colorFromHexRGB:@"e5e5e5"].CGColor;
  tax_Social_field.keyboardAppearance = UIKeyboardAppearanceDefault;
  tax_Social_field.textColor = [Globle colorFromHexRGB:@"8c8c8c"];
  tax_Social_field.layer.borderColor =
      [Globle colorFromHexRGB:@"e5e5e5"].CGColor;
  tax_Social_field_Fund.keyboardAppearance = UIKeyboardAppearanceDefault;
  tax_Social_field_Fund.textColor = [Globle colorFromHexRGB:@"8c8c8c"];
  tax_Social_field_Fund.layer.borderColor =
      [Globle colorFromHexRGB:@"e5e5e5"].CGColor;

  city_lable.textColor = [Globle colorFromHexRGB:@"595959"];
  sign_label.textColor = [Globle colorFromHexRGB:@"595959"];
  sign_label_4.textColor = [Globle colorFromHexRGB:@"595959"];
  sign_label_5.textColor = [Globle colorFromHexRGB:@"595959"];
  sign_label_6.textColor = [Globle colorFromHexRGB:@"595959"];

  Operation_btn.backgroundColor = [Globle colorFromHexRGB:@"2f8ef2"];
}
- (BOOL)textField:(UITextField*)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString*)string {
  if (textField.tag == 1000) {
    int MAX_CHARS = 9;

    NSMutableString* newtxt = [NSMutableString stringWithString:textField.text];

    [newtxt replaceCharactersInRange:range withString:string];

    return ([newtxt length] <= MAX_CHARS);
  } else if (textField.tag == 2000 || textField.tag == 3000) {
    int MAX_CHARS = 5;

    NSMutableString* newtxt = [NSMutableString stringWithString:textField.text];

    [newtxt replaceCharactersInRange:range withString:string];

    return ([newtxt length] <= MAX_CHARS);
  }
  return YES;
}

- (void)Fund_API {
  [[WebServiceManager sharedManager]
      The_socialInsurance_completion:^(NSDictionary* dic) {
        if (dic && [dic[@"status"] isEqualToString:@"0000"]) {
          //保存社保，的值
          [dic writeToFile:pathInCacheDirectory(@"Socail_array.plist")
                atomically:YES];

          [self Social_Security_reData_analysis:dic];
        }
      }];
}

- (void)Social_Security_reData_analysis:(NSDictionary*)dic {
  NSMutableArray* Social_Security_array =
      [Tools_Social_Security_object Social_Security_reData_analysis:dic];

  if ([Social_Security_array count] > 0) {
    [Socail_array removeAllObjects];
    [Socail_array addObjectsFromArray:Social_Security_array];
    [YG_Citys removeAllObjects];
    for (Tools_Social_Security_object* social_object in Socail_array) {
      [YG_Citys addObject:social_object.cityName];
    }
  }
}

//请求数据
- (void)requeste {
  [[WebServiceManager sharedManager]
      The_Wage_Insurance_completion:^(NSDictionary* dic) {
        if (dic && [dic[@"status"] isEqualToString:@"0000"]) {
          //保存，工资交税区间
          [dic writeToFile:pathInCacheDirectory(@"Pay_array.plist")
                atomically:YES];

          [self Wage_Insurance_reData_analysis:dic];
        }
      }];
}

- (void)Wage_Insurance_reData_analysis:(NSDictionary*)dic {
  Since_tax_point = [dic[@"taxBase"] intValue];

  NSMutableArray* Salary_pay_array =
      [Tools_Salary_range_object Wage_Insurance_reData_analysis:dic];

  if ([Salary_pay_array count] > 0) {
    [Pay_array removeAllObjects];
    [Pay_array addObjectsFromArray:Salary_pay_array];

    [Pay_Rate_array removeAllObjects];
    [Pay_Tax_makeup removeAllObjects];

    for (Tools_Salary_range_object* salary_object in Pay_array) {
      [Pay_Tax_makeup addObject:salary_object.Tax_Return];

      [Pay_Rate_array addObject:salary_object.Tax_Scale];
    }
  }
}

//个税  （税前算）
- (double)Count:(double)Pre_tax andBase:(double)base {
  double c = Pre_tax - base;
  return [self Addition_and_subtraction_tax:c
                                    andRate:Pay_Rate_array
                             andTax_reserve:Pay_Tax_makeup];
}

//多个数字的，加减
- (double)Addition_and_subtraction_tax:(double)pre_tax
                               andRate:(NSArray*)rate
                        andTax_reserve:(NSArray*)tax_reserve {
  double result = 0;
  for (int i = 0; i < [tax_reserve count]; i++) {
    double mid_num = (pre_tax - 3500) * [rate[i] doubleValue] -
                     [tax_reserve[i] doubleValue];

    if (mid_num > result) {
      result = mid_num;
    }
  }

  return result;
}

//税后， 算，税前工资
- (double)Count_after:(double)after_tax {
  double c = after_tax;

  return [self After_Addition_and_subtraction_tax:c
                                          andRate:Pay_Tax_makeup
                                   andTax_reserve:Pay_Rate_array];
}

//多个数字的，加减
- (double)After_Addition_and_subtraction_tax:(double)after_tax
                                     andRate:(NSArray*)rate
                              andTax_reserve:(NSArray*)tax_reserve {
  if (after_tax < 3500) {
    return 0.0f;
  }
  double result = 0;
  for (int i = 0; i < [tax_reserve count]; i++) {
    double mid_num = (after_tax - 3500 - [rate[i] doubleValue]) /
                     (1 - [tax_reserve[i] doubleValue]);

    if (mid_num > result) {
      result = mid_num;
    }
  }
  return result + 3500 - after_tax;
}

#pragma mark -  计算
//计算
- (void)Calculation {
  if ([tax_money_field.text doubleValue] <= 0) {
    YouGu_animation_Did_Start(@"请输入工资金额");
    return;
  }

  if ([tax_Social_field.text length] == 0 &&
      [tax_Social_field_Fund.text length] == 0) {
    Socail_base_Whether = NO;
  }

  if (tax_pickerView.selected_num == 0) {
    if (Socail_base_Whether == NO) {
      Tools_Social_Security_object* socail_object =
          [self Get_City_Socail_object:city_textfield_btn.city_label.text];

      if ([tax_money_field.text doubleValue] >
          [socail_object.socialMax doubleValue]) {
        tax_Social_field.text = socail_object.socialMax;
        tax_Social_field_Fund.text = socail_object.socialMax;
      } else {
        tax_Social_field.text = tax_money_field.text;
        tax_Social_field_Fund.text = tax_money_field.text;
      }
    }

    //社保比例，值
    double Socail_str =
        [self Social_Security_is_calculated:city_textfield_btn.city_label.text
                            andSocail_Value:tax_Social_field.text
                             andSocail_Fund:tax_Social_field_Fund.text];

    //税前， 算 税后
    double field_tax = [tax_money_field.text doubleValue];
    if (field_tax > 0) {
      double tax = [self Count:field_tax andBase:Socail_str];

      NSString* tax_str = [NSString stringWithFormat:@"%0.2lf元", tax];

      NSString* total_wages =
          [NSString stringWithFormat:@"%0.2lf元", field_tax - Socail_str - tax];

      [result_tableView NaL_Matrix_array:@[
        @[ @" ", @"结果" ],
        @[ @"缴纳个税", tax_str ],
        @[ title_label, total_wages ]
      ] andColumnsWidths:@[ @80, @140 ]];
    }
  } else {
    //税前， 算 税后
    double field_tax = [tax_money_field.text doubleValue];
    if ([tax_money_field.text intValue] > 0) {
      double tax = [self Count_after:field_tax];

      NSString* tax_str = [NSString stringWithFormat:@"%0.2lf元", tax];

      double rate = [self Sum_Rate:city_textfield_btn.city_label.text];

      Tools_Social_Security_object* socail_object =
          [self Get_City_Socail_object:city_textfield_btn.city_label.text];

      double total_wages_double =
          (field_tax + tax + [socail_object.medicalExt doubleValue]) /
          (1 - rate);

      NSString* total_wages =
          [NSString stringWithFormat:@"%0.2lf元", total_wages_double];

      if (total_wages_double > [socail_object.socialMax doubleValue]) {
        if (Socail_base_Whether == NO) {
          tax_Social_field.text =
              [NSString stringWithFormat:@"%0.0lf",
                                         [socail_object.socialMax doubleValue]];
          tax_Social_field_Fund.text =
              [NSString stringWithFormat:@"%0.0lf",
                                         [socail_object.socialMax doubleValue]];
        }
        //社保比例，值
        double sum_social = [self
            Social_Security_is_calculated:city_textfield_btn.city_label.text
                          andSocail_Value:tax_Social_field.text
                           andSocail_Fund:tax_Social_field_Fund.text];

        total_wages_double = tax + field_tax + sum_social;
        total_wages =
            [NSString stringWithFormat:@"%0.2lf元", total_wages_double];
      } else {
        if (Socail_base_Whether == NO) {
          tax_Social_field.text =
              [NSString stringWithFormat:@"%d", [total_wages intValue]];
          tax_Social_field_Fund.text =
              [NSString stringWithFormat:@"%d", [total_wages intValue]];
        }
        //社保比例，值
        [self Social_Security_is_calculated:city_textfield_btn.city_label.text
                            andSocail_Value:tax_Social_field.text
                             andSocail_Fund:tax_Social_field_Fund.text];
      }

      [result_tableView NaL_Matrix_array:@[
        @[ @" ", @"结果" ],
        @[ @"缴纳个税", tax_str ],
        @[ title_label, total_wages ]
      ] andColumnsWidths:@[ @80, @140 ]];
    }
  }
}

///  获取用户，不同城市，个人保险比例和
- (float)Sum_Rate:(NSString*)cityName {
  Tools_Social_Security_object* socail_object =
      [self Get_City_Socail_object:cityName];

  return [socail_object.houseRate doubleValue] +
         [socail_object.medicalRate doubleValue] +
         [socail_object.oldRate doubleValue] +
         [socail_object.workRate doubleValue] +
         [socail_object.injuryRate doubleValue] +
         [socail_object.birthRate doubleValue];
}

//计算保险  的各值
- (double)Social_Security_is_calculated:(NSString*)cityName
                        andSocail_Value:(NSString*)Value
                         andSocail_Fund:(NSString*)Socail_fund {
  Tools_Social_Security_object* socail_object =
      [self Get_City_Socail_object:cityName];

  //住房公积金
  NSString* Housing_Rate = [NSString
      stringWithFormat:@"%2.2f%%", [socail_object.houseRate doubleValue] * 100];
  NSString* Housing_Fund = [NSString
      stringWithFormat:@"%0.2f元", [socail_object.houseRate doubleValue] *
                                       [Socail_fund doubleValue]];

  if ([Housing_Fund doubleValue] > [socail_object.houseUp doubleValue]) {
    Housing_Fund = [NSString stringWithFormat:@"%@元", socail_object.houseUp];
  }

  if ([Housing_Fund doubleValue] < [socail_object.houseDown doubleValue]) {
    Housing_Fund = [NSString stringWithFormat:@"%@元", socail_object.houseDown];
  }

  //医疗基金
  NSString* Medical_Rate =
      [NSString stringWithFormat:@"%2.2f%%",
                                 [socail_object.medicalRate doubleValue] * 100];
  NSString* Medical_Fund = [NSString
      stringWithFormat:@"%0.2f元", [socail_object.medicalRate doubleValue] *
                                           [Value doubleValue] +
                                       [socail_object.medicalExt intValue]];

  if ([Medical_Fund doubleValue] > [socail_object.medicalUp doubleValue]) {
    Medical_Fund = [NSString
        stringWithFormat:@"%0.2lf元", [socail_object.medicalUp doubleValue] +
                                          [socail_object.medicalExt intValue]];
  }
  if ([Medical_Fund doubleValue] < [socail_object.medicalDown doubleValue]) {
    Medical_Fund = [NSString
        stringWithFormat:@"%0.2lf元", [socail_object.medicalDown doubleValue] +
                                          [socail_object.medicalExt intValue]];
  }

  //养老保险
  NSString* Old_Rate = [NSString
      stringWithFormat:@"%2.2f%%", [socail_object.oldRate doubleValue] * 100];
  NSString* Old_Fund = [NSString
      stringWithFormat:@"%0.2f元", [socail_object.oldRate doubleValue] *
                                       [Value doubleValue]];
  if ([Old_Fund doubleValue] > [socail_object.oldUp doubleValue]) {
    Old_Fund = [NSString stringWithFormat:@"%@元", socail_object.oldUp];
  }
  if ([Old_Fund doubleValue] < [socail_object.oldDown doubleValue]) {
    Old_Fund = [NSString stringWithFormat:@"%@元", socail_object.oldDown];
  }

  //失业保险
  NSString* Work_Rate = [NSString
      stringWithFormat:@"%2.2f%%", [socail_object.workRate doubleValue] * 100];
  NSString* Work_Fund = [NSString
      stringWithFormat:@"%0.2f元", [socail_object.workRate doubleValue] *
                                       [Value doubleValue]];
  if ([Work_Fund doubleValue] > [socail_object.workUp doubleValue]) {
    Work_Fund = [NSString stringWithFormat:@"%@元", socail_object.workUp];
  }
  if ([Work_Fund doubleValue] < [socail_object.workDown doubleValue]) {
    Work_Fund = [NSString stringWithFormat:@"%@元", socail_object.workDown];
  }

  //工伤保险
  NSString* injury_Rate =
      [NSString stringWithFormat:@"%2.2f%%",
                                 [socail_object.injuryRate doubleValue] * 100];
  NSString* injury_Fund = [NSString
      stringWithFormat:@"%0.2f元", [socail_object.injuryRate doubleValue] *
                                       [Value doubleValue]];
  if ([injury_Fund doubleValue] > [socail_object.injuryUp doubleValue]) {
    injury_Fund = [NSString stringWithFormat:@"%@元", socail_object.injuryUp];
  }
  if ([injury_Fund doubleValue] < [socail_object.injuryDown doubleValue]) {
    injury_Fund = [NSString stringWithFormat:@"%@元", socail_object.injuryDown];
  }

  //生育保险
  NSString* birth_Rate = [NSString
      stringWithFormat:@"%2.2f%%", [socail_object.birthRate doubleValue] * 100];
  NSString* birth_Fund = [NSString
      stringWithFormat:@"%0.2f元", [socail_object.birthRate doubleValue] *
                                       [Value doubleValue]];
  if ([birth_Fund doubleValue] > [socail_object.birthUp doubleValue]) {
    birth_Fund = [NSString stringWithFormat:@"%@元", socail_object.birthUp];
  }
  if ([birth_Fund doubleValue] < [socail_object.birthDown doubleValue]) {
    birth_Fund = [NSString stringWithFormat:@"%@元", socail_object.birthDown];
  }

  NSString* The_Sum_Socail = [NSString
      stringWithFormat:@"%0.2f元",
                       [Housing_Fund doubleValue] + [Medical_Fund doubleValue] +
                           [Old_Fund doubleValue] + [Work_Fund doubleValue] +
                           [injury_Fund doubleValue] +
                           [birth_Fund doubleValue]];

  [Detail_tableView NaL_Matrix_array:@[
    @[ @"缴纳比例", @"比例%", @"金额" ],
    @[ @"住房公积金", Housing_Rate, Housing_Fund ],
    @[ @"医疗保险", Medical_Rate, Medical_Fund ],
    @[ @"养老保险", Old_Rate, Old_Fund ],
    @[ @"失业保险", Work_Rate, Work_Fund ],
    @[ @"工伤保险", injury_Rate, injury_Fund ],
    @[ @"生育保险", birth_Rate, birth_Fund ],
    @[ @"总和", @"--", The_Sum_Socail ]
  ] andColumnsWidths:@[ @100, @100, @110 ]];

  return [The_Sum_Socail doubleValue];
}

//获取，固定城市 中获取，tools_socail_object
- (Tools_Social_Security_object*)Get_City_Socail_object:(NSString*)city {
  if ([Socail_array count] > 0) {
    for (Tools_Social_Security_object* socail_object in Socail_array) {
      if ([city isEqualToString:socail_object.cityName]) {
        return socail_object;
      }
    }
  }
  return nil;
}

#pragma mark -  自定义textfield  delegate

- (void)textFieldDidBeginEditing:(UITextField*)textField {
  if (textField.tag == 2000 || textField.tag == 3000) {
    Socail_base_Whether = YES;
    self.content_view.contentOffset = CGPointMake(0, 200);
  }
}

#pragma mark -  自定义textfield
- (void)click_btn:(UIButton*)sender {
  if (defaultPickerView == nil) {
    defaultPickerView = [[My_PickerView alloc] initWithFrame:self.view.bounds];
    defaultPickerView.Main_datePicker.tag = 3000;
    defaultPickerView.Title_datePicker.text = @"城市";
    defaultPickerView.delegate = self;
    [defaultPickerView.pickerArray addObjectsFromArray:YG_Citys];
    [self.view addSubview:defaultPickerView];
  } else {
    [defaultPickerView.pickerArray addObjectsFromArray:YG_Citys];
    defaultPickerView.hidden = NO;
  }
}

- (void)Show_PickerView_Time:(NSString*)time
                      andTag:(NSInteger)Tag
                andSelectRow:(NSInteger)row {
  if (Tag == 3000) {
    city_textfield_btn.city_label.text = time;
  } else if (Tag == 4000) {
    Pre_tax_btn.city_label.text = time;

    self.title_label = @"税前工资";
    if ([time isEqualToString:@"税前工资"]) {
      self.title_label = @"税后工资";
    }

    [result_tableView NaL_Matrix_array:@[
      @[ @" ", @"结果" ],
      @[ @"缴纳个税", @"元" ],
      @[ title_label, @"元" ]
    ] andColumnsWidths:@[ @80, @140 ]];
  }
}

- (void)Pre_tax_btn:(UIButton*)sender {
  if (tax_pickerView == nil) {
    tax_pickerView = [[My_PickerView alloc] initWithFrame:self.view.bounds];
    tax_pickerView.Main_datePicker.tag = 4000;
    tax_pickerView.Title_datePicker.text = @"税前后工资";
    tax_pickerView.delegate = self;
    [tax_pickerView.pickerArray addObjectsFromArray:YG_Tax];
    [self.view addSubview:tax_pickerView];

    if ([YG_Tax count] >= 1) {
      self.title_label = @"税前工资";
      if ([YG_Tax[0] isEqualToString:@"税前工资"]) {
        self.title_label = @"税后工资";
      }

      [result_tableView NaL_Matrix_array:@[
        @[ @" ", @"结果" ],
        @[ @"缴纳个税", @"元" ],
        @[ title_label, @"元" ]
      ] andColumnsWidths:@[ @80, @140 ]];
    }
  } else {
    tax_pickerView.hidden = NO;
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
