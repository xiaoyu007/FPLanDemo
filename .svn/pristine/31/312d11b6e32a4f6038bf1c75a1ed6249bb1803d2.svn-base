//
//  FPBuyAndRedeemTipVC.m
//  优顾理财
//
//  Created by Mac on 15/7/23.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPBuyAndRedeemTipVC.h"

#define NUMBERS @"0123456789\n"

@implementation FPBuyAndRedeemTipVC

- (void)viewDidLoad {
  [super viewDidLoad];
  [_tipBGView.layer setMasksToBounds:YES];
  [_tipBGView.layer setCornerRadius:5.0f];

  [_cancelButton.layer setMasksToBounds:YES];
  [_cancelButton.layer setCornerRadius:15.0f];

  [_confirmButton.layer setMasksToBounds:YES];
  [_confirmButton.layer setCornerRadius:15.0f];

  UIImage *highlightImage =
      [FPYouguUtil createImageWithColor:[Globle colorFromHexRGB:@"0000000" withAlpha:0.3f]];
  [_cancelButton setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
  [_confirmButton setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
}
/** 提示框的标题和内容及输入框 */
- (void)showTipWithTitle:(NSString *)title
               withMoney:(NSString *)monenyTitle
             withContent:(NSString *)content
           withTextField:(NSString *)textFieldTitle
      withCancelBtnTitle:(NSString *)cancelTitle
     withConfirmBtnTitle:(NSString *)confirmTitle
            withCallback:(TextFieldCallback)callback {
  //  [[NSNotificationCenter defaultCenter]addObserver:self
  //  selector:@selector(isResignFirstResponder) name:@"resignFirstResponder" object:nil];
  currentCallback = callback;
  _titleLabel.text = title;
  _moneyLabel.text = monenyTitle;
  //购买产品
  _contentLabel.text = content;
  //交易密码输入框
  _textTradeField.clearButtonMode = UITextFieldViewModeAlways;
  _textTradeField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
  _textTradeField.leftView.userInteractionEnabled = NO;
  _textTradeField.leftViewMode = UITextFieldViewModeAlways;
  _textTradeField.keyboardType = UIKeyboardTypeNumberPad;

  _textTradeField.delegate = self;

  _confirmButton.layer.cornerRadius = 15;
  _confirmButton.layer.masksToBounds = YES;
  _cancelButton.layer.cornerRadius = 15;
  _cancelButton.layer.masksToBounds = YES;
  [_cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
  [_confirmButton setTitle:confirmTitle forState:UIControlStateNormal];
}
- (IBAction)cancelButtonClicked:(id)sender {
  [_textTradeField resignFirstResponder];
}

- (IBAction)confirmButtonClicked:(id)sender {
  [_textTradeField resignFirstResponder];
}
#pragma mark - textFieldDelegate

- (void)animationView {
  [UIView beginAnimations:nil context:nil];                 //设置一个动画
  [UIView setAnimationDuration:0.3];                        //设置持续的时间
  [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut]; //设置动画
  self.view.transform = CGAffineTransformMakeTranslation(0, 0.0f);
  [UIView commitAnimations]; //提交动画
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [_textTradeField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
  [self animationView];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
  [UIView beginAnimations:nil context:nil];                 //设置一个动画
  [UIView setAnimationDuration:0.3];                        //设置持续的时间
  [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut]; //设置动画
  self.view.transform = CGAffineTransformMakeTranslation(0, -120.0f);
  [UIView commitAnimations]; //提交动画
}
- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string {
  NSString *toBeString =
      [textField.text stringByReplacingCharactersInRange:range withString:string];

  /** 提示输入数字*/
  NSCharacterSet *cs;
  if (textField == _textTradeField) {
    cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if (!basicTest) {

      return NO;
    }
    if (toBeString.length > 6) {
      textField.text = [toBeString substringToIndex:6];
      return NO;
    } else {
      currentCallback(toBeString);
      return YES;
    }
  }

  return YES;
}
@end
