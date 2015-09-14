//
//  PutInIdentifyingCodeViewController.m
//  优顾理财
//
//  Created by Mac on 15/3/19.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPPutInIdentifyingCodeViewController.h"
#import "FPSetPasswordViewController.h"
#import "FPBankStepViewController.h"
#import "NetLoadingWaitView.h"
#import "UIButton+Block.h"

@interface FPPutInIdentifyingCodeViewController () <UITextFieldDelegate>

@end

@implementation FPPutInIdentifyingCodeViewController {
  ///“下一步”按钮
  IBOutlet UIView *nextBtn;
  ///验证码输入框
  IBOutlet UITextField *writeTextField;
  ///返回按钮
  IBOutlet UIButton *backBtn;
  ///下一步按钮
  IBOutlet UIButton *nextButton;
  ///开户三步图
  FPBankStepViewController *bankStep;
}
///移除当前界面
- (void)removeCurrentView {

  [self removeFromParentViewController];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  //接收完成页通知移除当前页面
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(removeCurrentView)
                                               name:@"remove_before_view"
                                             object:nil];

  self.childView.userInteractionEnabled = NO;
  UIImage *highLightImage =
      [FPYouguUtil createImageWithColor:btnAccordingToTheNormal];
  [backBtn setBackgroundImage:highLightImage
                     forState:UIControlStateHighlighted];
  [backBtn addTarget:self
                action:@selector(backBtn)
      forControlEvents:UIControlEventTouchUpInside];

  [nextButton setBackgroundImage:highLightImage
                        forState:UIControlStateHighlighted];

  __weak FPPutInIdentifyingCodeViewController *weakAuthSelf = self;
  [nextButton setOnButtonPressedHandler:^{
    
    FPPutInIdentifyingCodeViewController *strongSelf = weakAuthSelf;
    if (strongSelf) {
      [strongSelf nextBtnClick];
    }
  }];

  
  
  

  writeTextField.delegate = self;
  writeTextField.layer.borderWidth = 1;
  writeTextField.layer.borderColor =
      [[Globle colorFromHexRGB:@"c7c7c7"] CGColor];
  writeTextField.leftView =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
  writeTextField.leftView.userInteractionEnabled = NO;
  writeTextField.leftViewMode = UITextFieldViewModeAlways;
  writeTextField.clearButtonMode = UITextFieldViewModeAlways;
  writeTextField.keyboardType = UIKeyboardTypeNumberPad;

  ///开户三步图片
  bankStep = [[FPBankStepViewController alloc] initWithNibName:@"FPBankStepViewController" bundle:nil];
  [self.view addSubview:bankStep.view];
  bankStep.view.userInteractionEnabled = NO;
  bankStep.secondStepBGView.layer.borderColor = [Globle colorFromHexRGB:customFilledColor].CGColor;
  bankStep.secondStepInterView.backgroundColor = [Globle colorFromHexRGB:customFilledColor];
  //温馨提示
  NSString *tipStr = @"支付系统由第三方支付机构快钱提供，请在上方填写快钱机构的验证码，以确保开户成功";
  NSMutableAttributedString *attributedString =
      [[NSMutableAttributedString alloc] initWithString:tipStr];
  ;
  NSMutableParagraphStyle *paragraphStyle =
      [[NSMutableParagraphStyle alloc] init];
  [paragraphStyle setLineSpacing:3];
  [attributedString addAttribute:NSParagraphStyleAttributeName
                           value:paragraphStyle
                           range:NSMakeRange(0, tipStr.length)];
  [attributedString addAttribute:NSForegroundColorAttributeName value:[Globle colorFromHexRGB:customFilledColor] range:[tipStr rangeOfString:@"快钱"]];
  _tipLabel.attributedText = attributedString;
}

///发送验证信息
- (void)uthPhoneTextFieldNumber {
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  if (writeTextField.text.length == 0) {
    YouGu_animation_Did_Start(@"请输入验证码");
    return;
  }
 if (![SimuControl
             validateSixNumberIdentityCard:writeTextField
             .text]) {
    YouGu_animation_Did_Start(@"验证码输入有误");
    return;
  }
  [NetLoadingWaitView startAnimating];
  [[WebServiceManager sharedManager]
      sendRequestWithOpenAcountFirstStepUserId:YouGu_User_USerid
                                    userbankid:self.bankCardId
                             serialnoAccountId:self.openNumber
                                andCheckcodeId:writeTextField.text
                                withCompletion:^(NSDictionary *dic) {
                                  if (dic && [[dic objectForKey:@"status"]
                                                 isEqualToString:@"0000"]) {
                                    
                                    [NetLoadingWaitView stopAnimating];
                                    
                                    //如果成功就进入设置密码界面
                                    FPSetPasswordViewController *setPassVC = [
                                        [FPSetPasswordViewController alloc] init];

                                    [AppDelegate pushViewControllerFromRight:setPassVC];

                                  }
                                  else {
                                    
                                    [NetLoadingWaitView stopAnimating];
                                    
                                    NSString *message = [NSString
                                        stringWithFormat:
                                            @"%@",
                                            [dic objectForKey:@"message"]];
                                    if (!message || [message length] == 0 ||
                                        [message isEqualToString:@"(null)"]) {
                                      message = networkFailed;
                                      YouGu_animation_Did_Start(message);
                                    }
                                    if (dic &&
                                        [dic[@"status"] isEqualToString:@"0101"]){
                                    }else{
                                      YouGu_animation_Did_Start(message);
                                    }
                                  }
                                }];
}
#pragma mark---textFieldDelegate
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [writeTextField resignFirstResponder];
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
  if (textField == writeTextField) {
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

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

//提交效验，，成功后关联银行卡成功，，，如果失败返回失败的消息
- (void)nextBtnClick {
  [writeTextField resignFirstResponder];
  //验证码信息验证
  [self uthPhoneTextFieldNumber];
}
- (void)backBtn {
  [self.navigationController popViewControllerAnimated:YES];
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
