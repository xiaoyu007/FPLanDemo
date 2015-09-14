//
//  FourForegnViewController.m
//  优顾理财
//
//  Created by jhss on 15/8/31.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FourForegnViewController.h"
#import "Tools_data_object.h"
#import "FourForegnTableViewCell.h"

#define NUMBERS @"0123456789\n"
@interface FourForegnViewController ()

@end

@implementation FourForegnViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.CurrencyArray = [[NSMutableArray alloc] initWithCapacity:0];
  self.exchangeRate = [[NSMutableArray alloc] initWithCapacity:0];

  _holdForeignTitle.userInteractionEnabled = NO;
  _exchangeForeignTitle.userInteractionEnabled = NO;
  _exchangeForeignMoney.userInteractionEnabled = NO;

  _holdForeignTitle.layer.borderWidth = 1;
  _holdForeignTitle.layer.borderColor =
      [[Globle colorFromHexRGB:@"e3e3e3"] CGColor];

  _exchangeForeignTitle.layer.borderWidth = 1;
  _exchangeForeignTitle.layer.borderColor =
      [[Globle colorFromHexRGB:@"e3e3e3"] CGColor];

  _holdForeignMoney.layer.borderWidth = 1;
  _holdForeignMoney.layer.borderColor =
      [[Globle colorFromHexRGB:@"e3e3e3"] CGColor];
  _holdForeignMoney.leftView =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
  _holdForeignMoney.leftView.userInteractionEnabled = NO;
  _holdForeignMoney.leftViewMode = UITextFieldViewModeAlways;
  _holdForeignMoney.delegate = self;

  _exchangeForeignMoney.layer.borderWidth = 1;
  _exchangeForeignMoney.layer.borderColor =
      [[Globle colorFromHexRGB:@"e3e3e3"] CGColor];

  if (YouGu_fileExistsAtPath(
          pathInCacheDirectory(@"Forex_currency_and_Names.plist"))) {
    NSDictionary *dic = [NSDictionary
        dictionaryWithContentsOfFile:pathInCacheDirectory(
                                         @"Forex_currency_and_Names.plist")];

    [self theCurrencyGeneralCategory:dic];
  } else {
    NSString *path_1 =
        [[NSBundle mainBundle] pathForResource:@"Four_Foreign.plist"
                                        ofType:nil];

    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path_1];

    [self theCurrencyGeneralCategory:dic];
  }

  if (YouGu_fileExistsAtPath(
          pathInCacheDirectory(@"Foreign_Exchange_Rate_Interface.plist"))) {
    NSDictionary *dic = [NSDictionary
        dictionaryWithContentsOfFile:
            pathInCacheDirectory(@"Foreign_Exchange_Rate_Interface.plist")];

    [self Foreign_Exchange_Rate:dic];
  } else {
    NSString *path_1 =
        [[NSBundle mainBundle] pathForResource:@"Foreign_Exchange_Rate.plist"
                                        ofType:nil];

    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path_1];

    [self Foreign_Exchange_Rate:dic];
  }
  //持有外币  按钮
  [_holdForeignBtn setTitle:self.CurrencyArray[1]
                   forState:UIControlStateNormal];
  _holdForeignBtn.contentHorizontalAlignment =
      UIControlContentHorizontalAlignmentLeft;
  _holdForeignBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
  holdClick = NO;
  [_holdForeignBtn addTarget:self
                      action:@selector(holdForeignBtnClick)
            forControlEvents:UIControlEventTouchUpInside];

  //兑换外币  按钮
  [_exchangeForeignBtn setTitle:self.CurrencyArray[0]
                       forState:UIControlStateNormal];
  _exchangeForeignBtn.contentHorizontalAlignment =
      UIControlContentHorizontalAlignmentLeft;
  _exchangeForeignBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
  exchangeForeignClick = NO;
  [_exchangeForeignBtn addTarget:self
                          action:@selector(exchangeForeignBtnClick)
                forControlEvents:UIControlEventTouchUpInside];

  _holdForeignName.text = self.CurrencyArray[1];

  [_exchangeBtn addTarget:self
                   action:@selector(exchangeBtnClick)
         forControlEvents:UIControlEventTouchUpInside];

  ///添加手势让其点击空白处银行卡列表移除
  tap = [[UITapGestureRecognizer alloc]
      initWithTarget:self
              action:@selector(removeTableView)];
  tap.delegate = self;

  [self.view addGestureRecognizer:tap];

  //创建表
  [self createtableView];

  ///  外汇和名称
  [self The_Forex_currency_and_Names_Dictionary];

  ///  汇率值
  [self The_Foreign_Exchange_Rate_Interface];
}
- (void)removeTableView {

  [_holdForeignMoney resignFirstResponder];
  foregnTableView.hidden = YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch {
  if ([NSStringFromClass([touch.view class])
          isEqualToString:@"UITableViewCellContentView"]) {
    return NO;
  } else {
    return YES;
  }
}
//  点击兑换  按钮
- (void)exchangeBtnClick {
  [_holdForeignMoney resignFirstResponder];
  if ([_holdForeignMoney.text intValue] <= 0) {
    YouGu_animation_Did_Start(@"请输入持有的货币金额");
    return;
  }
  for (Tools_Foreign_Exchange_Rate_object *Rate_object in self.exchangeRate) {
    if ([_holdForeignName.text isEqualToString:_exchangeMoneyName.text]) {
      _exchangeMoney.text = _holdForeignMoney.text;
    }
    if ([_holdForeignName.text
            isEqualToString:Rate_object.first_foreign_name] &&
        [_exchangeMoneyName.text
            isEqualToString:Rate_object.second_foreign_name]) {
      NSString *sum =
          [NSString stringWithFormat:@"%0.2lf",
                                     [_holdForeignMoney.text intValue] *
                                         [Rate_object.result_Rate doubleValue]];
      _exchangeMoney.text = sum;
    }
  }
}
//持有外币  的表
- (void)holdForeignBtnClick {
  holdClick = YES;
  foregnTableView.frame =
      CGRectMake(117, 54, self.holdForeignBtn.frame.size.width,
                 HEIGHT_OF_SCREEN - 54 - 70);
  foregnTableView.hidden = NO;
}
//兑换外币  的表
- (void)exchangeForeignBtnClick {
  exchangeForeignClick = YES;
  foregnTableView.frame =
      CGRectMake(117, 92, self.holdForeignBtn.frame.size.width,
                 HEIGHT_OF_SCREEN - 92 - 70);
  foregnTableView.hidden = NO;
}
- (void)createtableView {

  foregnTableView = [[UITableView alloc]
      initWithFrame:CGRectMake(117, 92, self.holdForeignBtn.frame.size.width,
                               HEIGHT_OF_SCREEN - 92 - 70)
              style:UITableViewStylePlain];
  foregnTableView.delegate = self;
  foregnTableView.dataSource = self;
  foregnTableView.bounces = NO;
  foregnTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  [self.view addSubview:foregnTableView];
  foregnTableView.hidden = YES;
}
#pragma mark----UItableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {

  return self.CurrencyArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  static NSString *cellId = @"FourForegnTableViewCell";
  FourForegnTableViewCell *cell = (FourForegnTableViewCell *)
      [tableView dequeueReusableCellWithIdentifier:cellId];
  if (!cell) {
    cell = [[[NSBundle mainBundle] loadNibNamed:cellId
                                          owner:self
                                        options:nil] firstObject];
  }
  cell.foregnName.text = self.CurrencyArray[indexPath.row];

  //  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  return cell;
}
- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [UIView animateWithDuration:0.3f
                   animations:^{
                     [tableView deselectRowAtIndexPath:indexPath animated:YES];
                     foregnTableView.hidden = YES;
                   }];
  if (holdClick) {
    holdClick = NO;
    [_holdForeignBtn setTitle:self.CurrencyArray[indexPath.row]
                     forState:UIControlStateNormal];
    _holdForeignName.text = self.CurrencyArray[indexPath.row];
  }
  if (exchangeForeignClick) {
    exchangeForeignClick = NO;
    [_exchangeForeignBtn setTitle:self.CurrencyArray[indexPath.row]
                         forState:UIControlStateNormal];
    _exchangeMoneyName.text = self.CurrencyArray[indexPath.row];
  }
  NSLog(@"------------------++++++++++++++++++%ld", (long)indexPath.row);
}
#pragma mark---UITextFieldDelegete
- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string {

   /** 提示输入数字*/
  NSCharacterSet *cs;
  if (textField==_holdForeignMoney) {
    cs = [[NSCharacterSet
           characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]
                          componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if (!basicTest) {
      return NO;
    }

  }
  int MAX_CHARS = 9;

  NSMutableString *newtxt = [NSMutableString stringWithString:textField.text];

  [newtxt replaceCharactersInRange:range withString:string];

  return ([newtxt length] <= MAX_CHARS);

  return YES;
}

//获取外汇和名称
- (void)The_Forex_currency_and_Names_Dictionary {
  [[WebServiceManager sharedManager]
      The_Forex_currency_and_Names_Dictionary_completion:^(NSDictionary *dic) {
        if (dic && [dic[@"status"] isEqualToString:@"0000"]) {
          //存款利息利率 保存 本地
          [dic writeToFile:pathInCacheDirectory(
                               @"Forex_currency_and_Names.plist")
                atomically:YES];

          [self theCurrencyGeneralCategory:dic];
        }
      }];
}

//货币总类
- (void)theCurrencyGeneralCategory:(NSDictionary *)dic {
  NSMutableArray *array = [Tools_Foreign_object Foreign_reData_analysis:dic];
  [self.CurrencyArray removeAllObjects];
  [self.CurrencyArray addObjectsFromArray:array];
}
//各种汇率值
- (void)The_Foreign_Exchange_Rate_Interface {
  [[WebServiceManager sharedManager]
      The_Foreign_Exchange_Rate_Interface_completion:^(NSDictionary *dic) {

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
- (void)Foreign_Exchange_Rate:(NSDictionary *)dic {
  NSMutableArray *array = [Tools_Foreign_Exchange_Rate_object
      Foreign_Exchange_Rate_reData_analysis:dic];

  [self.exchangeRate removeAllObjects];
  [self.exchangeRate addObjectsFromArray:array];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
