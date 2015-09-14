//
//  RevampTradeViewController.m
//  优顾理财
//
//  Created by jhss on 15-4-19.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPRevampTradeViewController.h"
#import "NetLoadingWaitView.h"
#import "NSString+validate.h"

@interface FPRevampTradeViewController () <UITextFieldDelegate>
- (IBAction)navBackBtn:(id)sender;
- (IBAction)preentBtn:(id)sender;

@end

@implementation FPRevampTradeViewController {
  //导航按钮
  IBOutlet UIButton *navBtn;
  //提交按钮
  IBOutlet UIButton *presentBtn;
  //之前的密码
  IBOutlet UITextField *beforePassword;
  //新密码
  IBOutlet UITextField *newsPassword;
  //确认密码
  IBOutlet UITextField *affirmPassword;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  self.childView.userInteractionEnabled = NO;

  [navBtn setImage:[UIImage imageNamed:@"返回小箭头.png"] forState:UIControlStateNormal];
  [navBtn setImage:[UIImage imageNamed:@"返回小箭头.png"] forState:UIControlStateHighlighted];
  navBtn.imageEdgeInsets = UIEdgeInsetsMake(15, 20, 15, 20);

  UIImage *highlightImage = [FPYouguUtil createImageWithColor:btnAccordingToTheNormal];
  [navBtn setBackgroundImage:highlightImage forState:UIControlStateHighlighted];

  presentBtn.layer.cornerRadius = 18;
  presentBtn.layer.masksToBounds = YES;
  presentBtn.backgroundColor = [Globle colorFromHexRGB:@"f07533"];
  [presentBtn setBackgroundImage:highlightImage forState:UIControlStateHighlighted];

  beforePassword.layer.borderColor = [Globle colorFromHexRGB:textfieldBordColor].CGColor;
  beforePassword.layer.borderWidth = 0.5f;
  beforePassword.delegate = self;
  beforePassword.clearButtonMode = UITextFieldViewModeAlways;
  beforePassword.secureTextEntry = YES;
  beforePassword.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
  beforePassword.leftView.userInteractionEnabled = NO;
  beforePassword.leftViewMode = UITextFieldViewModeAlways;
  beforePassword.keyboardType = UIKeyboardTypeNumberPad;

  newsPassword.layer.borderColor = [Globle colorFromHexRGB:textfieldBordColor].CGColor;
  newsPassword.layer.borderWidth = 0.5f;
  newsPassword.delegate = self;
  newsPassword.clearButtonMode = UITextFieldViewModeAlways;
  newsPassword.secureTextEntry = YES;
  newsPassword.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
  newsPassword.leftView.userInteractionEnabled = NO;
  newsPassword.leftViewMode = UITextFieldViewModeAlways;
  newsPassword.keyboardType = UIKeyboardTypeNumberPad;

  affirmPassword.layer.borderColor = [Globle colorFromHexRGB:textfieldBordColor].CGColor;
  affirmPassword.layer.borderWidth = 0.5f;
  affirmPassword.delegate = self;
  affirmPassword.clearButtonMode = UITextFieldViewModeAlways;
  affirmPassword.secureTextEntry = YES;
  affirmPassword.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
  affirmPassword.leftView.userInteractionEnabled = NO;
  affirmPassword.leftViewMode = UITextFieldViewModeAlways;
  affirmPassword.keyboardType = UIKeyboardTypeNumberPad;
}
#pragma mark-----textFieldDelegate
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

  [beforePassword resignFirstResponder];
  [newsPassword resignFirstResponder];
  [affirmPassword resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

  [textField resignFirstResponder];
  return YES;
}
- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string {
  NSString *toBeString =
      [textField.text stringByReplacingCharactersInRange:range withString:string];
  ///之前密码输入框
  if (textField == beforePassword) {
    if (![NSString validataNumberInput:toBeString]) {
      return NO;
    }
    if ([toBeString length] > 6) {
      textField.text = [toBeString substringToIndex:6];
      return NO;
    }
  }
  /**
   *  新的密码
   */
  if (textField == newsPassword) {
    if (![NSString validataNumberInput:toBeString]) {
      return NO;
    }
    if ([toBeString length] > 6) {
      textField.text = [toBeString substringToIndex:6];
      return NO;
    }
  }
  /**
   *  确认密码
   */
  if (textField == affirmPassword) {
    if (![NSString validataNumberInput:toBeString]) {
      return NO;
    }
    if ([toBeString length] > 6) {
      textField.text = [toBeString substringToIndex:6];
      return NO;
    }
  }
  return YES;
}
- (IBAction)navBackBtn:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)preentBtn:(id)sender {
  [beforePassword resignFirstResponder];
  [newsPassword resignFirstResponder];
  [affirmPassword resignFirstResponder];
  //需要进行判断1.新密码和确认密码相同，且新密码不能和当前密码相同
  /**
   *  当前密码
   */
  if ([beforePassword.text length] == 0) {
     YouGu_animation_Did_Start(@"请输入当前密码");
    return;
  }
  /**
   *  新的密码
   */
  if ([newsPassword.text length] == 0) {
    YouGu_animation_Did_Start(@"请输入新密码");
    return;
  } else if ([newsPassword.text length] != 6) {
    YouGu_animation_Did_Start(@"交易密码为6位数字，请重新输入");
    return;
  }else if ([newsPassword.text integerValue] == [beforePassword.text integerValue]) {
    YouGu_animation_Did_Start(@"不能和之前的密码一致");
    return;
  }
  /**
   *  确认密码
   */
  if ([affirmPassword.text length] == 0) {
    YouGu_animation_Did_Start(@"请再次输入新密码");
    return;
  }else if ([newsPassword.text integerValue] != [affirmPassword.text integerValue]) {
    YouGu_animation_Did_Start(@"两" @"次输入的密码不一致，请重新输入");
    return;
  }
  //发送消息
  [self sendRequestWithUpDatePwd];
}
- (void)sendRequestWithUpDatePwd {
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }

  [NetLoadingWaitView startAnimating];
  [[WebServiceManager sharedManager]
      sendRequestWithUpDatePwdUserId:YouGu_User_USerid
                            oldPwdId:beforePassword.text
                         AndNewPwdId:newsPassword.text
                      withCompletion:^(id response) {
                        if (response &&
                            [[response objectForKey:@"status"] isEqualToString:@"0000"]) {

                          [NetLoadingWaitView stopAnimating];
                          //提示语，动画
                          YouGu_animation_Did_Start(@"修改成功");
                          [self.navigationController popViewControllerAnimated:YES];

                        } else {
                          [NetLoadingWaitView stopAnimating];
                          NSString *message =
                              [NSString stringWithFormat:@"%@", [response objectForKey:@"message"]];
                          if (!message || [message length] == 0 ||
                              [message isEqualToString:@"(null)"]) {
                            message = networkFailed;
                          }
                          if (response &&
                              [response[@"status"] isEqualToString:@"0101"]){
                          }else{
                            YouGu_animation_Did_Start(message);
                          }                          return;
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
