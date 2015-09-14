//
//  RetrieveTradePwSecondViewController.m
//  优顾理财
//
//  Created by jhss on 15-4-19.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPRetrieveTradePwSecondViewController.h"

@interface FPRetrieveTradePwSecondViewController ()
- (IBAction)navBtn:(id)sender;
- (IBAction)finishBtn:(id)sender;

@end

@implementation FPRetrieveTradePwSecondViewController {

  IBOutlet UITextField *tradeTextField;
  IBOutlet UITextField *againTradeTextField;
  IBOutlet UIButton *navBtn;
  IBOutlet UIButton *finishBtn;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  self.childView.userInteractionEnabled = NO;

  tradeTextField.layer.borderColor = [Globle colorFromHexRGB:textfieldBordColor].CGColor;
  tradeTextField.layer.borderWidth = 1;
  tradeTextField.keyboardType = UIKeyboardTypeNumberPad;
  tradeTextField.clearButtonMode = UITextFieldViewModeAlways;
  tradeTextField.secureTextEntry = YES;
  tradeTextField.leftView =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
  tradeTextField.leftView.userInteractionEnabled = NO;
  tradeTextField.leftViewMode = UITextFieldViewModeAlways;


  againTradeTextField.layer.borderColor =
      [Globle colorFromHexRGB:textfieldBordColor].CGColor;
  againTradeTextField.layer.borderWidth = 1;
  againTradeTextField.keyboardType = UIKeyboardTypeNumberPad;
  againTradeTextField.clearButtonMode = UITextFieldViewModeAlways;
  againTradeTextField.secureTextEntry = YES;
  againTradeTextField.leftView =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
  againTradeTextField.leftView.userInteractionEnabled = NO;
  againTradeTextField.leftViewMode = UITextFieldViewModeAlways;


  [navBtn setImage:[UIImage imageNamed:@"返回小箭头.png"]
          forState:UIControlStateNormal];
  [navBtn setImage:[UIImage imageNamed:@"返回小箭头.png"]
          forState:UIControlStateHighlighted];
  navBtn.imageEdgeInsets = UIEdgeInsetsMake(15, 20, 15, 20);
  UIImage *highlightImage =
      [FPYouguUtil createImageWithColor:btnAccordingToTheNormal];
  [navBtn setBackgroundImage:highlightImage forState:UIControlStateHighlighted];

  [finishBtn setBackgroundImage:highlightImage
                       forState:UIControlStateHighlighted];
}
#pragma mark-----textFieldDelegate
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

  [tradeTextField resignFirstResponder];
  [againTradeTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

  [textField resignFirstResponder];
  return YES;
}

- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
  NSString *toBeString =
  [textField.text stringByReplacingCharactersInRange:range
                                          withString:string];
  /** 提示输入数字*/
  NSCharacterSet *cs;
  if (textField == tradeTextField||textField==againTradeTextField) {
    cs = [[NSCharacterSet
           characterSetWithCharactersInString:@"0123456789\n"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]
                          componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if (!basicTest) {
      
      return NO;
    }else
    {
      
      if (toBeString.length > 6) {
        textField.text = [toBeString substringToIndex:6];
        return NO;
      }else{
        
        return YES;
      }
    }
    
  }
  
  return YES;
}
- (IBAction)navBtn:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)finishBtn:(id)sender {
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  } else if ((![self validateIdentityCard:tradeTextField.text]) ||
             (![self validateIdentityCard:againTradeTextField.text])) {
    YouGu_animation_Did_Start(@"必须为六位数字");
    return;
  } else if ([tradeTextField.text integerValue] !=
             [againTradeTextField.text integerValue]) {

    YouGu_animation_Did_Start(@"两次的密码不一样，请重新输入");
    return;
  } else {
    //发送数据请求
    [self sendRetrieveTradePw];
  }
}
//数字智能是六位数字
- (BOOL)validateIdentityCard:(NSString *)identityCard {
  BOOL flag;
  if (identityCard.length <= 0) {
    flag = NO;
    return flag;
  }
  NSString *regex2 = @"^\\d{6}$";
  NSPredicate *identityCardPredicate =
      [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex2];
  if ([identityCardPredicate evaluateWithObject:identityCard]) {
    return YES;
  }

  return NO;
}

- (void)sendRetrieveTradePw {

    [[WebServiceManager sharedManager]sendRequestWithRetrieveTradeCodeUserId:YouGu_User_USerid PwdId:tradeTextField.text phoneId:_phoneNum AndVertifyCode:_authStr withCompletion:^(NSDictionary *dic) {
                                if (dic &&
                                    [dic[@"status"]
                                        isEqualToString:@"0000"] == YES) {

                                  YouGu_animation_Did_Start(@"找回成功");

                                  [[NSNotificationCenter defaultCenter]
                                      postNotificationName:@"remove_before_view"
                                                    object:self
                                                  userInfo:nil];
                                  [self.navigationController popViewControllerAnimated:YES];
                                  [self removeFromParentViewController];

                                } else {

                                  YouGu_animation_Did_Start(
                                      dic[@"message"]);
                                  return;
                                }

                              }];
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
