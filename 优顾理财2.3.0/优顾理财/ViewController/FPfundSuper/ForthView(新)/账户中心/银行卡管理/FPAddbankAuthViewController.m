//
//  AddbankAuthViewController.m
//  优顾理财
//
//  Created by jhss on 15-4-26.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPAddbankAuthViewController.h"
#import "NetLoadingWaitView.h"

@implementation FPAddbankAuthViewController {

  IBOutlet UIButton *navBtn;
  IBOutlet UIButton *presentBtn;
  IBOutlet UITextField *authTextField;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  self.childView.userInteractionEnabled = NO;

  authTextField.layer.borderColor = [Globle colorFromHexRGB:@"cfcfcf"].CGColor;
  authTextField.layer.borderWidth = 1;
  authTextField.delegate = self;
  authTextField.keyboardType = UIKeyboardTypeNumberPad;
  authTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
  authTextField.leftView.userInteractionEnabled = NO;
  authTextField.leftViewMode = UITextFieldViewModeAlways;
  authTextField.clearButtonMode = UITextFieldViewModeAlways;

  [navBtn setImage:[UIImage imageNamed:@"返回小箭头.png"] forState:UIControlStateNormal];
  [navBtn setImage:[UIImage imageNamed:@"返回小箭头.png"] forState:UIControlStateHighlighted];
  navBtn.imageEdgeInsets = UIEdgeInsetsMake(15, 20, 15, 20);
  UIImage *highlightImage =
      [FPYouguUtil createImageWithColor:[Globle colorFromHexRGB:@"000000" withAlpha:0.1f]];
  [navBtn setBackgroundImage:highlightImage forState:UIControlStateHighlighted];

  UIImage *highLightImage =
      [FPYouguUtil createImageWithColor:[Globle colorFromHexRGB:@"000000" withAlpha:0.1f]];
  [presentBtn setBackgroundImage:highLightImage forState:UIControlStateHighlighted];
  presentBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
}
- (IBAction)navBtn:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
}
///验证码提交
- (IBAction)presentBtn:(id)sender {
  [authTextField resignFirstResponder];
  ///发送数据请求
  [self SendAddBankAuth];
}
- (void)SendAddBankAuth {
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  if (authTextField.text.length == 0) {
    YouGu_animation_Did_Start(@"请输入验证码");
    return;
  }
 if (![SimuControl
             validateSixNumberIdentityCard:authTextField
             .text]) {
    YouGu_animation_Did_Start(@"验证码输入有误");
    return;
  }
  [NetLoadingWaitView startAnimating];
  [[WebServiceManager sharedManager]
      sendRequestWithOpenAcountFirstStepUserId:YouGu_User_USerid
                                    userbankid:_userBankidStr
                             serialnoAccountId:_serianoStr
                                andCheckcodeId:authTextField.text
                                withCompletion:^(NSDictionary *dic) {
                                  if (dic && [dic[@"status"] isEqualToString:@"0000"]) {
                                    [NetLoadingWaitView stopAnimating];
                                    //提示语，动画
                                    YouGu_animation_Did_Start(@"添加银行卡成功");
                                    [self refreshBankLists];
                                    [[NSNotificationCenter defaultCenter]postNotificationName:@"remove_to_before_VC" object:self userInfo:nil];
                                    [AppDelegate popViewController:YES];
                                  } else {
                                    [NetLoadingWaitView stopAnimating];

                                    NSString *message =
                                        [NSString stringWithFormat:@"%@", dic[@"message"]];
                                    if (!message || [message length] == 0 || [message isEqualToString:@"(null)"]) {
                                      message = networkFailed;
                                    }
                                    if (dic &&
                                        [dic[@"status"] isEqualToString:@"0101"]){
                                    }else{
                                      YouGu_animation_Did_Start(message);
                                    }
                                    if (dic && [dic[@"status"] isEqualToString:@"1002"]) {
                                      YouGu_animation_Did_Start(message);
                                      [self.navigationController popViewControllerAnimated:YES];
                                    }
                                  }
                                }];
}
///刷新银行卡列表(众禄bug，添加完银行卡需刷一次)
- (void)refreshBankLists {
  [[WebServiceManager sharedManager]
      sendRequestWithAccountCenterUserId:YouGu_User_USerid
                          withCompletion:^(NSDictionary *main_dic) {
                            if (main_dic && [main_dic[@"status"] isEqualToString:@"0000"]) {
                              // 解析银行卡列表
                            } else {
                              NSString *message =
                                  [NSString stringWithFormat:@"%@", main_dic[@"message"]];
                              if (!message || [message length] == 0 || [message isEqualToString:@"(null)"]) {
                                message = networkFailed;
                              }
                              if (main_dic &&
                                  [main_dic[@"status"] isEqualToString:@"0101"]){
                              }else{
                                YouGu_animation_Did_Start(message);
                              }                              return;
                            }
                          }];
}

#pragma mark-----textFieldDelegate
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

  [authTextField resignFirstResponder];
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
  /** 提示输入数字*/
  NSCharacterSet *cs;
  if (textField == authTextField) {
    cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789\n"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if (!basicTest) {

      return NO;
    } else {

      if (toBeString.length > 6) {
        textField.text = [toBeString substringToIndex:6];
        return NO;
      } else {

        return YES;
      }
    }
  }

  return YES;
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
