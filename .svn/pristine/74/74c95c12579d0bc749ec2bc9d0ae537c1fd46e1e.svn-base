//
//  TipViewController.m
//  优顾理财
//
//  Created by Mac on 15-4-28.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "TipViewController.h"

#define NUMBERS @"0123456789\n"
@interface TipViewController () <UITextFieldDelegate>

@end

@implementation TipViewController{
  UITextField *textTradeField;
  UIView *orangeView;
  UILabel *moneyLabel;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [_tipBGView.layer setMasksToBounds:YES];
  [_tipBGView.layer setCornerRadius:5.0f];

  [_cancelButton.layer setMasksToBounds:YES];
  [_cancelButton.layer setCornerRadius:15.0f];

  [_confirmButton.layer setMasksToBounds:YES];
  [_confirmButton.layer setCornerRadius:15.0f];

  UIImage *highlightImage = [FPYouguUtil
      createImageWithColor:[Globle colorFromHexRGB:@"0000000" withAlpha:0.3f]];
  [_cancelButton setBackgroundImage:highlightImage
                           forState:UIControlStateHighlighted];
  [_confirmButton setBackgroundImage:highlightImage
                            forState:UIControlStateHighlighted];
}

- (void)showTipWithTitle:(NSString *)title
             withContent:(NSString *)content
      withCancelBtnTitle:(NSString *)cancelTitle
     withConfirmBtnTitle:(NSString *)confirmTitle {
  
  tipType = CusTipTypeVerificate;
  
  CGRect frame = _contentLabel.frame;
  _titleLabel.text = title;

  CGSize contentSize = [content sizeWithFont:[UIFont systemFontOfSize:14.0f]
                           constrainedToSize:CGSizeMake(frame.size.width, 100)];
  _contentLabel.frame = CGRectMake(frame.origin.x, frame.origin.y,
                                   frame.size.width, contentSize.height);
  _contentLabel.text = content;
  _contentLabel.textAlignment = NSTextAlignmentCenter;

  CGRect bgFrame = _tipBGView.frame;
  _tipBGView.frame =
      CGRectMake(bgFrame.origin.x, bgFrame.origin.y, bgFrame.size.width,
                 131.0f + contentSize.height);
  [_cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
  [_confirmButton setTitle:confirmTitle forState:UIControlStateNormal];
}
- (void)showTipWithTitle:(NSString *)title
             withContent:(NSString *)content
      withCancelBtnTitle:(NSString *)cancelTitle{
  
  tipType = CusTipTypeVerificate;
  
  CGRect frame = _contentLabel.frame;
  _titleLabel.text = title;
  
  CGSize contentSize = [content sizeWithFont:[UIFont systemFontOfSize:14.0f]
                           constrainedToSize:CGSizeMake(frame.size.width, 100)];
  _contentLabel.frame = CGRectMake(frame.origin.x, frame.origin.y,
                                   frame.size.width, contentSize.height);
  _contentLabel.text = content;
  _contentLabel.textAlignment = NSTextAlignmentCenter;
  
  CGRect bgFrame = _tipBGView.frame;
  _tipBGView.frame =
  CGRectMake(bgFrame.origin.x, bgFrame.origin.y, bgFrame.size.width,
             131.0f + contentSize.height);
  [_cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
  
 _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  _cancelBtn.frame = CGRectMake(90, 13,96 ,30);
  [_cancelBtn setBackgroundColor:[Globle colorFromHexRGB:@"f07533"]];
  [_cancelBtn setTitle:cancelTitle forState:UIControlStateNormal];
  [_grayView addSubview:_cancelBtn];
  _cancelBtn.layer.cornerRadius = 15;
  _cancelBtn.layer.masksToBounds = YES;
  _cancelButton.hidden = YES;
  _confirmButton.hidden = YES;
  
  
  
  
}



/** 提示框的标题和内容及输入框 */
- (void)showTipWithTitle:(NSString *)title
               withMoney:(NSString *)monenyTitle
             withContent:(NSString *)content
           withTextField:(NSString *)textFieldTitle
      withCancelBtnTitle:(NSString *)cancelTitle
     withConfirmBtnTitle:(NSString *)confirmTitle
            withCallback:(TextFieldCallback)callback {
  
  tipType = CusTipTypePurchase;
  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(isResignFirstResponder) name:@"resignFirstResponder" object:nil];
  currentCallback = callback;
  _tipBGView.frame = CGRectMake(20, 133 + 20, self.view.size.width - 40, 261);
  _titleLabel.frame = CGRectMake(0, 20, _tipBGView.size.width, 17);
  _titleLabel.text = title;
  _titleLabel.textAlignment = NSTextAlignmentCenter;
  orangeView.frame = CGRectMake(0, 48.5, _tipBGView.size.width, 0.5);
  orangeView.backgroundColor = [Globle colorFromHexRGB:@"f07533"];
  [_tipBGView addSubview:orangeView];

  moneyLabel = [[UILabel alloc] init];
  moneyLabel.frame = CGRectMake(0, 71, _tipBGView.size.width, 24);
  moneyLabel.text = monenyTitle;
  moneyLabel.font = [UIFont systemFontOfSize:24];
  moneyLabel.textAlignment = NSTextAlignmentCenter;
  [_tipBGView addSubview:moneyLabel];

  //购买产品
  _contentLabel.frame = CGRectMake(20, 112.5, _tipBGView.size.width - 40, 35);
  _contentLabel.text = content;
  _contentLabel.textColor = [UIColor grayColor];
  _contentLabel.textAlignment = NSTextAlignmentCenter;
  _contentLabel.font = [UIFont systemFontOfSize:13];
  _contentLabel.numberOfLines = 0;
  [_tipBGView addSubview:_contentLabel];

  //交易密码输入框
  textTradeField = [[UITextField alloc]
      initWithFrame:CGRectMake(20, 151, _tipBGView.size.width - 40, 35)];
  textTradeField.backgroundColor =
      [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
  textTradeField.placeholder = @" 交易密码";
  textTradeField.secureTextEntry = YES;
  textTradeField.clearButtonMode = UITextFieldViewModeAlways;
  textTradeField.leftView =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
  textTradeField.leftView.userInteractionEnabled = NO;
  textTradeField.leftViewMode = UITextFieldViewModeAlways;
  textTradeField.keyboardType = UIKeyboardTypeNumberPad;
  textTradeField.delegate = self;
  [_tipBGView addSubview:textTradeField];

  _confirmButton.frame = CGRectMake(155, 11, 96, 35);
  _cancelButton.frame = CGRectMake(32, 11, 96, 35);
  _confirmButton.layer.cornerRadius = 17.5;
  _confirmButton.layer.masksToBounds = YES;
  _cancelButton.layer.cornerRadius = 17.5;
  _cancelButton.layer.masksToBounds = YES;
  [_cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
  [_confirmButton setTitle:confirmTitle forState:UIControlStateNormal];
}
#pragma mark---textFieldDelegate
-(void)isResignFirstResponder
{

  [textTradeField resignFirstResponder];
  [UIView beginAnimations:nil context:nil]; //设置一个动画
  [UIView setAnimationDuration:0.3];        //设置持续的时间
  [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut]; //设置动画
  _tipBGView.frame = CGRectMake(20,(windowHeight-261)/2, windowWidth - 40, 261);
  [UIView commitAnimations]; //提交动画
}
- (void)animationView {
  [UIView beginAnimations:nil context:nil]; //设置一个动画
  [UIView setAnimationDuration:0.3];        //设置持续的时间
  [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut]; //设置动画
  _tipBGView.frame = CGRectMake(20,(windowHeight-261)/2, windowWidth - 40, 261);
  [UIView commitAnimations]; //提交动画
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  if (tipType == CusTipTypePurchase) {
    [textTradeField resignFirstResponder];
    [self animationView];
  }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

  [textField resignFirstResponder];
  [self animationView];
  return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {

  [UIView beginAnimations:nil context:nil]; //设置一个动画
  [UIView setAnimationDuration:0.3];        //设置持续的时间
  [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut]; //设置动画
//  _tipBGView.frame = CGRectMake(20, 100, self.view.size.width - 40, 261);
  _tipBGView.frame= CGRectMake(20,(windowHeight-261)/2-50, windowWidth - 40, 261);
  [UIView commitAnimations]; //提交动画
}
- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string {

  NSString *toBeString =
      [textField.text stringByReplacingCharactersInRange:range
                                              withString:string];

  /** 提示输入数字*/
  NSCharacterSet *cs;
  if (textField == textTradeField) {
    cs = [[NSCharacterSet
        characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]
        componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if (!basicTest) {

      return NO;
    }
    if (toBeString.length > 6) {
      textField.text = [toBeString substringToIndex:6];
      return NO;
    }else{
      currentCallback(toBeString);
      return YES;
    }
  }
  

  return YES;
}

@end
