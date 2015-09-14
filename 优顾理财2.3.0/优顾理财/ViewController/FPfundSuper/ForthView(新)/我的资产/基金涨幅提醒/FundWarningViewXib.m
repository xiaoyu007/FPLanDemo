//
//  FundWarningViewController.m
//  优顾理财
//
//  Created by Mac on 15/7/7.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FundWarningViewXib.h"
#import "ConditionsWithKeyBoardUsing.h"

@implementation FundWarningViewXib
- (void)viewDidLoad {
  [super viewDidLoad];
  [_addProfitBgView.layer setBorderWidth:0.5f];
  [_addProfitBgView.layer setBorderColor:[Globle colorFromHexRGB:@"e3e3e3"].CGColor];
  [_addProfitRateBgView.layer setBorderWidth:0.5f];
  [_addProfitRateBgView.layer setBorderColor:[Globle colorFromHexRGB:@"e3e3e3"].CGColor];
  [_lossProfitBgView.layer setBorderWidth:0.5f];
  [_lossProfitBgView.layer setBorderColor:[Globle colorFromHexRGB:@"e3e3e3"].CGColor];
  [_lossRateBgView.layer setBorderWidth:0.5f];
  [_lossRateBgView.layer setBorderColor:[Globle colorFromHexRGB:@"e3e3e3"].CGColor];

  _cuttingLineHeight.constant = 0.5f;
  _addProfitTextField.delegate = self;
  _lossProfitTextField.delegate = self;
  _profitRateAddToTextField.delegate = self;
  _profitRateLossToTextField.delegate = self;
  _fundNameLabel.attributedText =
      [self createAttristringWithFundName:_currentFundName withFundId:_currentFundId];
}
/** 创建多样化字符串 */
- (NSMutableAttributedString *)createAttristringWithFundName:(NSString *)fundName
                                                  withFundId:(NSString *)fundId {
  fundId = [NSString stringWithFormat:@"（%@）", fundId];
  NSString *string = [NSString stringWithFormat:@"%@ %@", fundName, fundId];
  NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:string];
  [attr addAttribute:NSForegroundColorAttributeName
               value:[Globle colorFromHexRGB:@"5b5f62"]
               range:[string rangeOfString:fundName]];
  [attr addAttribute:NSForegroundColorAttributeName
               value:[Globle colorFromHexRGB:@"c4ccd0"]
               range:[string rangeOfString:fundId]];
  [attr addAttribute:NSFontAttributeName
               value:[UIFont systemFontOfSize:14.0f]
               range:[string rangeOfString:fundName]];
  [attr addAttribute:NSFontAttributeName
               value:[UIFont systemFontOfSize:11.0f]
               range:[string rangeOfString:fundId]];
  return attr;
}
#pragma mark - textfield操作
- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string {
  if ([string isEqualToString:@"/n"]) {
    return NO;
  }
  if ([textField.text rangeOfString:@"."].length > 0 && [string isEqualToString:@"."]) {
    return NO;
  }
  //只接收数字
  if (![ConditionsWithKeyBoardUsing isNumbersOrPoint:string]) {
    return NO;
  }
  //此处容易出问题
  NSString *toBeString =
      [textField.text stringByReplacingCharactersInRange:range withString:string];
  //两位小数/四位整数
  if ([toBeString rangeOfString:@"."].length > 0) {
    NSString *pointStr = [toBeString substringFromIndex:[toBeString rangeOfString:@"."].location + 1];
    if (pointStr && [pointStr length] > 2) {
      return NO;
    }
  }
  if ([toBeString integerValue] > 100000000 &&
      (textField == _addProfitTextField || textField == _lossProfitTextField)) {
    return NO;
  }
  if ([toBeString integerValue] > 10000 &&
      (textField == _profitRateAddToTextField || textField == _profitRateLossToTextField)) {
    return NO;
  }
  [self switchChangingWithTextFieldChange:textField withToBeString:toBeString];
  return YES;
}
- (void)refreshSwitchStatusWithItem:(ProfitAndLossRemindItem *)item {
  _buyAccountLabel.text = [NSString stringWithFormat:@"购买金额：%@", _currentPurchaseAmount];
  _theNewestWorthLabel.text =
      [NSString stringWithFormat:@"最新净值：%0.4f元", [[item.netValue stringValue]floatValue]];
  _dailyIncreasesLabel.text = [NSString stringWithFormat:@"日涨幅：%0.2f%%", [item.dayRate floatValue]];

  //盈利
  float profit = [[item.profit stringValue] floatValue];
  if (profit > 0) {
    _addProfitTextField.text = [NSString stringWithFormat:@"%0.2f", profit];
    [self switchChangingWithTextFieldChange:_addProfitTextField
                             withToBeString:[item.profit stringValue]];
  }
  //亏损
  float lossPro = [[item.loss stringValue] floatValue];
  if (lossPro > 0) {
    _lossProfitTextField.text = [NSString stringWithFormat:@"%0.2f", lossPro];
    [self switchChangingWithTextFieldChange:_lossProfitTextField
                             withToBeString:[item.loss stringValue]];
  }
  //盈利率达
  float profitRate = [item.profitRate floatValue];
  if (profitRate > 0) {
    _profitRateAddToTextField.text = [NSString stringWithFormat:@"%0.2f", profitRate];
    [self switchChangingWithTextFieldChange:_profitRateAddToTextField
                             withToBeString:[item.profitRate stringValue]];
  }
  //亏损率达
  float lossRate = [item.lossRate floatValue];
  if (lossRate) {
    _profitRateLossToTextField.text = [NSString stringWithFormat:@"%0.2f", lossRate];
    [self switchChangingWithTextFieldChange:_profitRateLossToTextField
                             withToBeString:[item.lossRate stringValue]];
  }
}
/** 输入变化时，开关变化 */
- (void)switchChangingWithTextFieldChange:(UITextField *)textField
                           withToBeString:(NSString *)toBeString {
  if (textField == _addProfitTextField) {
    if ([toBeString length] > 0) {
      _addSwitch.on = YES;
    } else {
      _addSwitch.on = NO;
    }
  }
  if (textField == _lossProfitTextField) {
    if ([toBeString length] > 0) {
      _lossSwitch.on = YES;
    } else {
      _lossSwitch.on = NO;
    }
  }
  if (textField == _profitRateAddToTextField) {
    if ([toBeString length] > 0) {
      _addRateSwitch.on = YES;
    } else {
      _addRateSwitch.on = NO;
    }
  }
  if (textField == _profitRateLossToTextField) {
    if ([toBeString length] > 0) {
      _lossRateSwitch.on = YES;
    } else {
      _lossRateSwitch.on = NO;
    }
  }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return YES;
}
//解决键盘覆盖问题
- (void)textFieldDidBeginEditing:(UITextField *)textField {
  if ((textField == _profitRateAddToTextField || textField == _profitRateLossToTextField ||
       textField == _lossProfitTextField) &&
      self.view.frame.origin.y >= 0) {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f) {
      [UIView animateWithDuration:0.3f
                       animations:^{
                         self.view.transform = CGAffineTransformTranslate(self.view.transform, 0, -120.0f);
                       }];
    } else {
      [UIView animateWithDuration:0.0f
                       animations:^{
                         self.view.transform = CGAffineTransformTranslate(self.view.transform, 0, -120.0f);
                       }];
    }
  }
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
  if ((textField == _profitRateAddToTextField || textField == _profitRateLossToTextField ||
       textField == _lossProfitTextField) &&
      self.view.frame.origin.y < 0) {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f) {
      [UIView animateWithDuration:0.3f
                       animations:^{
                         self.view.transform = CGAffineTransformTranslate(self.view.transform, 0, 120.0f);
                       }];
    } else {
      [UIView animateWithDuration:0.0f
                       animations:^{
                         self.view.transform = CGAffineTransformTranslate(self.view.transform, 0, 120.0f);
                       }];
    }
  }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [self textFieldResignFirstResponder];
}
/** 释放输入栏 */
- (void)textFieldResignFirstResponder {
  [_addProfitTextField resignFirstResponder];
  [_lossProfitTextField resignFirstResponder];
  [_profitRateAddToTextField resignFirstResponder];
  [_profitRateLossToTextField resignFirstResponder];
}
@end
