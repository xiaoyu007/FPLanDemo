//
//  FourForeignViewController.m
//  优顾理财
//
//  Created by Mac on 14/10/20.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//  外汇

#import "FourForeignViewController.h"

#import "Tools_data_object.h"


@implementation FourForeignViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  [self.topNavView setMainLableString:@"外汇兑换计算"];
  self.content_view.contentSize = CGSizeMake(self.view.width, 350);

  self.YG_Currency_array = [[NSMutableArray alloc] initWithCapacity:0];
  self.YG_exchange_rate = [[NSMutableArray alloc] initWithCapacity:0];

  if (YouGu_fileExistsAtPath(
          pathInCacheDirectory(@"Forex_currency_and_Names.plist"))) {
    NSDictionary* dic = [NSDictionary
        dictionaryWithContentsOfFile:pathInCacheDirectory(
                                         @"Forex_currency_and_Names.plist")];

    [self The_Currency_general_category:dic];
  } else {
    NSString* path_1 =
        [[NSBundle mainBundle] pathForResource:@"Four_Foreign.plist"
                                        ofType:nil];

    NSDictionary* dic = [NSDictionary dictionaryWithContentsOfFile:path_1];

    [self The_Currency_general_category:dic];
  }

  if (YouGu_fileExistsAtPath(
          pathInCacheDirectory(@"Foreign_Exchange_Rate_Interface.plist"))) {
    NSDictionary* dic = [NSDictionary
        dictionaryWithContentsOfFile:
            pathInCacheDirectory(@"Foreign_Exchange_Rate_Interface.plist")];

    [self Foreign_Exchange_Rate:dic];
  } else {
    NSString* path_1 =
        [[NSBundle mainBundle] pathForResource:@"Foreign_Exchange_Rate.plist"
                                        ofType:nil];

    NSDictionary* dic = [NSDictionary dictionaryWithContentsOfFile:path_1];

    [self Foreign_Exchange_Rate:dic];
  }

  //持有外币
  UILabel* city_lable_2 =
      [[UILabel alloc] initWithFrame:CGRectMake(50, 20, 80, 30)];
  city_lable_2.text = @"持有外币 :";
  city_lable_2.backgroundColor = [UIColor clearColor];
  city_lable_2.textColor = [Globle colorFromHexRGB:textNameColor];
  city_lable_2.textAlignment = NSTextAlignmentRight;
  city_lable_2.font = [UIFont systemFontOfSize:15];
  [self.content_view addSubview:city_lable_2];

  Hold_textfield_btn =
      [[Textfield_btn alloc] initWithFrame:CGRectMake(140, 20, 100, 30)];
  Hold_textfield_btn.city_label.text = @"美元";
  [Hold_textfield_btn.click_btn addTarget:self
                                   action:@selector(Hold_click_btn:)
                         forControlEvents:UIControlEventTouchUpInside];
  [self.content_view addSubview:Hold_textfield_btn];

  //兑换货币
  UILabel* city_lable_3 =
      [[UILabel alloc] initWithFrame:CGRectMake(50, 70, 80, 30)];
  city_lable_3.text = @"兑换货币 :";
  city_lable_3.textColor = [Globle colorFromHexRGB:textNameColor];
  city_lable_3.backgroundColor = [UIColor clearColor];
  city_lable_3.textAlignment = NSTextAlignmentRight;
  city_lable_3.font = [UIFont systemFontOfSize:15];
  [self.content_view addSubview:city_lable_3];

  Exchange_textfield_btn =
      [[Textfield_btn alloc] initWithFrame:CGRectMake(140, 70, 100, 30)];
  Exchange_textfield_btn.city_label.text = @"人民币";
  [Exchange_textfield_btn.click_btn addTarget:self
                                       action:@selector(Exchange_click_btn:)
                             forControlEvents:UIControlEventTouchUpInside];
  [self.content_view addSubview:Exchange_textfield_btn];

  //两者互换
  UIButton* Exchange_btn = [UIButton buttonWithType:UIButtonTypeCustom];
  [Exchange_btn addTarget:self
                   action:@selector(Exchange_btn:)
         forControlEvents:UIControlEventTouchUpInside];
  [Exchange_btn setImage:[UIImage imageNamed:@"转换"]
                forState:UIControlStateNormal];
  Exchange_btn.frame = CGRectMake(250, 40, 40, 40);
  [self.content_view addSubview:Exchange_btn];

  //持有货币金额
  UILabel* city_lable_4 =
      [[UILabel alloc] initWithFrame:CGRectMake(30, 120, 100, 30)];
  city_lable_4.text = @"持有货币金额 :";
  city_lable_4.backgroundColor = [UIColor clearColor];
  city_lable_4.textColor = [Globle colorFromHexRGB:textNameColor];
  city_lable_4.textAlignment = NSTextAlignmentRight;
  city_lable_4.font = [UIFont systemFontOfSize:15];
  [self.content_view addSubview:city_lable_4];

  textfield_Currency_holdings =
      [[ExpressTextField alloc] initWithFrame:CGRectMake(140, 120, 100, 30)];
  textfield_Currency_holdings.layer.cornerRadius = 5;
  textfield_Currency_holdings.layer.borderWidth = 1.0f;
  textfield_Currency_holdings.contentVerticalAlignment =
      UIControlContentVerticalAlignmentCenter;
  textfield_Currency_holdings.keyboardType = UIKeyboardTypeNumberPad;
  textfield_Currency_holdings.delegate = self;
  [textfield_Currency_holdings setSpaceAtStart];
  [self.content_view addSubview:textfield_Currency_holdings];

  sign_label_2 = [[UILabel alloc] initWithFrame:CGRectMake(240, 120, 80, 30)];
  sign_label_2.text = @"美元";
  sign_label_2.backgroundColor = [UIColor clearColor];
  sign_label_2.textColor = [Globle colorFromHexRGB:textNameColor];
  sign_label_2.textAlignment = NSTextAlignmentCenter;
  sign_label_2.font = [UIFont systemFontOfSize:15];
  [self.content_view addSubview:sign_label_2];

  //计算
  UIButton* Operation_btn = [UIButton buttonWithType:UIButtonTypeCustom];
  Operation_btn.frame =
      CGRectMake(self.view.width / 4, 170, self.view.width / 2, 30);
  Operation_btn.backgroundColor = [Globle colorFromHexRGB:@"2f8ef2"];
  Operation_btn.layer.cornerRadius = 5;
  [Operation_btn setTitle:@"兑换" forState:UIControlStateNormal];
  UIImage* highlightImage = [FPYouguUtil createImageWithColor:buttonHighLightColor];
  [Operation_btn setBackgroundImage:highlightImage
                           forState:UIControlStateHighlighted];
  [Operation_btn addTarget:self
                    action:@selector(Calculation)
          forControlEvents:UIControlEventTouchUpInside];
  Operation_btn.titleLabel.textAlignment = NSTextAlignmentCenter;
  Operation_btn.titleLabel.font = [UIFont systemFontOfSize:15];
  [self.content_view addSubview:Operation_btn];

  Detail_tableView = [[NALMatrixTableView alloc]
         initWithFrame:CGRectMake(10, 220, 300, 60)
              andArray:@[
                @[ @" ", @"金额", @"币种" ],
                @[ @"兑换的货币金额", @"", @"人民币" ]
              ]
      andColumnsWidths:@[ @110, @110, @80 ]];
  [self.content_view addSubview:Detail_tableView];

  ///  外汇和名称
  [self The_Forex_currency_and_Names_Dictionary];
  ///  汇率值
  [self The_Foreign_Exchange_Rate_Interface];

  city_lable_2.textColor = [Globle colorFromHexRGB:textNameColor];
  city_lable_3.textColor = [Globle colorFromHexRGB:textNameColor];
  city_lable_4.textColor = [Globle colorFromHexRGB:textNameColor];
  sign_label_2.textColor = [Globle colorFromHexRGB:textNameColor];

  textfield_Currency_holdings.keyboardAppearance = UIKeyboardAppearanceDefault;
  textfield_Currency_holdings.textColor = [UIColor blackColor];
  textfield_Currency_holdings.layer.borderColor =
      [Globle colorFromHexRGB:textfieldBordColor].CGColor;

  Operation_btn.backgroundColor = [Globle colorFromHexRGB:@"2f8ef2"];
}
- (BOOL)textField:(UITextField*)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString*)string {
  int MAX_CHARS = 9;

  NSMutableString* newtxt = [NSMutableString stringWithString:textField.text];

  [newtxt replaceCharactersInRange:range withString:string];

  return ([newtxt length] <= MAX_CHARS);
}

//获取外汇和名称
- (void)The_Forex_currency_and_Names_Dictionary {
  [[WebServiceManager sharedManager]
      The_Forex_currency_and_Names_Dictionary_completion:^(NSDictionary* dic) {
        if (dic && [dic[@"status"] isEqualToString:@"0000"]) {
          //存款利息利率 保存 本地
          [dic writeToFile:pathInCacheDirectory(
                               @"Forex_currency_and_Names.plist")
                atomically:YES];

          [self The_Currency_general_category:dic];
        }
      }];
}
//货币总类
- (void)The_Currency_general_category:(NSDictionary*)dic {
  NSMutableArray* array = [Tools_Foreign_object Foreign_reData_analysis:dic];

  [self.YG_Currency_array removeAllObjects];
  [self.YG_Currency_array addObjectsFromArray:array];
}

//各种汇率值
- (void)The_Foreign_Exchange_Rate_Interface {
  [[WebServiceManager sharedManager]
      The_Foreign_Exchange_Rate_Interface_completion:^(NSDictionary* dic) {

        if (dic && [dic[@"status"] isEqualToString:@"0000"]) {
          //存款利息利率 保存 本地
          [dic writeToFile:pathInCacheDirectory(
                               @"Foreign_Exchange_Rate_Interface.plist")
                atomically:YES];

          [self Foreign_Exchange_Rate:dic];
        }

      }];
}

//每两种货币 之间的货币，兑换比率
- (void)Foreign_Exchange_Rate:(NSDictionary*)dic {
  NSMutableArray* array = [Tools_Foreign_Exchange_Rate_object
      Foreign_Exchange_Rate_reData_analysis:dic];

  [self.YG_exchange_rate removeAllObjects];
  [self.YG_exchange_rate addObjectsFromArray:array];
}

#pragma mark -  计算按钮
//计算
- (void)Calculation {
  if ([textfield_Currency_holdings.text intValue] <= 0) {
    YouGu_animation_Did_Start(@"请输入持有的货币金额");
    return;
  }

  for (Tools_Foreign_Exchange_Rate_object* Rate_object in self
           .YG_exchange_rate) {
    if ([Hold_textfield_btn.city_label.text
            isEqualToString:Exchange_textfield_btn.city_label.text]) {
      [Detail_tableView NaL_Matrix_array:@[
        @[ @" ", @"金额", @"币种" ],
        @[
          @"兑换的货币金额",
          textfield_Currency_holdings.text,
          Exchange_textfield_btn.city_label.text
        ]
      ] andColumnsWidths:@[ @110, @110, @80 ]];
      return;
    }

    if ([Hold_textfield_btn.city_label.text
            isEqualToString:Rate_object.first_foreign_name] &&
        [Exchange_textfield_btn.city_label.text
            isEqualToString:Rate_object.second_foreign_name]) {
      NSString* sum = [NSString
          stringWithFormat:@"%0.2lf",
                           [textfield_Currency_holdings.text intValue] *
                               [Rate_object.result_Rate doubleValue]];

      [Detail_tableView NaL_Matrix_array:@[
        @[ @" ", @"金额", @"币种" ],
        @[ @"兑换的货币金额",
           sum,
           Exchange_textfield_btn.city_label.text ]
      ] andColumnsWidths:@[ @110, @110, @80 ]];
    }
  }
}

#pragma mark - 按钮，选择
- (void)Exchange_btn:(UIButton*)sender {
  NSString* tt = [Hold_textfield_btn.city_label.text copy];

  Hold_textfield_btn.city_label.text = Exchange_textfield_btn.city_label.text;
  Exchange_textfield_btn.city_label.text = tt;

  sign_label_2.text = Hold_textfield_btn.city_label.text;
  [Detail_tableView NaL_Matrix_array:@[
    @[ @" ", @"金额", @"币种" ],
    @[ @"兑换的货币金额", @"", Exchange_textfield_btn.city_label.text ]
  ] andColumnsWidths:@[ @110, @110, @80 ]];
}

#pragma mark -  按钮，点击
- (void)Hold_click_btn:(UIButton*)sender {
  if (Hold_PickerView == nil) {
    Hold_PickerView = [[My_PickerView alloc] initWithFrame:self.view.bounds];
    Hold_PickerView.Main_datePicker.tag = 2000;
    Hold_PickerView.Title_datePicker.text = @"货币种类";
    Hold_PickerView.delegate = self;
    [Hold_PickerView.pickerArray addObjectsFromArray:self.YG_Currency_array];
    [self.view addSubview:Hold_PickerView];

    if ([self.YG_Currency_array count] >= 1) {
      Hold_textfield_btn.city_label.text =
          self.YG_Currency_array[0];
      sign_label_2.text = self.YG_Currency_array[0];
    }
  } else {
    [Hold_PickerView.pickerArray addObjectsFromArray:self.YG_Currency_array];
    Hold_PickerView.hidden = NO;
  }
}

- (void)Exchange_click_btn:(UIButton*)sender {
  if (Exchange_pickerView == nil) {
    Exchange_pickerView =
        [[My_PickerView alloc] initWithFrame:self.view.bounds];
    Exchange_pickerView.Main_datePicker.tag = 3000;
    Exchange_pickerView.Title_datePicker.text = @"货币种类";
    Exchange_pickerView.delegate = self;
    [Exchange_pickerView.pickerArray
        addObjectsFromArray:self.YG_Currency_array];
    [self.view addSubview:Exchange_pickerView];

    if ([self.YG_Currency_array count] >= 1) {
      Exchange_textfield_btn.city_label.text =
          self.YG_Currency_array[0];

      [Detail_tableView NaL_Matrix_array:@[
        @[ @" ", @"金额", @"币种" ],
        @[ @"兑换的货币金额",
           @"",
            self.YG_Currency_array[0]]
      ] andColumnsWidths:@[ @110, @110, @80 ]];
    }
  } else {
    [Exchange_pickerView.pickerArray
        addObjectsFromArray:self.YG_Currency_array];
    Exchange_pickerView.hidden = NO;
  }
}

- (void)Show_PickerView_Time:(NSString*)time
                      andTag:(NSInteger)Tag
                andSelectRow:(NSInteger)row {
  if (Tag == 2000) {
    Hold_textfield_btn.city_label.text = time;
    sign_label_2.text = time;
  } else if (Tag == 3000) {
    Exchange_textfield_btn.city_label.text = time;

    [Detail_tableView NaL_Matrix_array:@[
      @[ @" ", @"金额", @"币种" ],
      @[ @"兑换的货币金额", @"", time ]
    ] andColumnsWidths:@[ @110, @110, @80 ]];
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
