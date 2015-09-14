//
//  NextPhoneBindAccountVC.m
//  优顾理财
//
//  Created by Mac on 14-8-1.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "NextPhoneBindAccountVC.h"
#import "NetLoadingWaitView.h"
#import "OnLoginRequest.h"
#import "NSString+validate.h"

@implementation NextPhoneBindAccountVC
@synthesize phone_Number, verification_str;
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}
- (id)initPhone:(NSString *)phone andVerification:(NSString *)verification {
  self = [super init];
  if (self) {
    self.phone_Number = phone;
    self.verification_str = verification;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.

  [self CreatNavBarWithTitle:@"手机快速注册"];

  UILabel *detailLabel =
      [[UILabel alloc] initWithFrame:CGRectMake(20, 70, 280, 20)];
  detailLabel.font = [UIFont systemFontOfSize:15];
  detailLabel.textAlignment = NSTextAlignmentLeft;
  detailLabel.text = @"验证成功，请设置您的登录密码";
  detailLabel.backgroundColor = [UIColor clearColor];
  detailLabel.textColor = [Globle colorFromHexRGB:@"454545"];
  [self.childView addSubview:detailLabel];

  //左侧label
  //密码
  UILabel *passwordLabel =
      [[UILabel alloc] initWithFrame:CGRectMake(20, 110, 80, 30)];
  passwordLabel.text = @"密      码：";
  passwordLabel.textAlignment = NSTextAlignmentLeft;
  passwordLabel.textColor = [Globle colorFromHexRGB:@"000000"];
  passwordLabel.font = [UIFont systemFontOfSize:15];
  passwordLabel.backgroundColor = [UIColor clearColor];
  [self.childView addSubview:passwordLabel];

  //确认密码
  UILabel *confirmPasswordLabel =
      [[UILabel alloc] initWithFrame:CGRectMake(20, 160, 80, 30)];
  confirmPasswordLabel.textColor = [Globle colorFromHexRGB:@"000000"];
  confirmPasswordLabel.textAlignment = NSTextAlignmentLeft;
  confirmPasswordLabel.text = @"确认密码：";
  confirmPasswordLabel.backgroundColor = [UIColor clearColor];
  confirmPasswordLabel.font = [UIFont systemFontOfSize:15];
  [self.childView addSubview:confirmPasswordLabel];

  // textview

  passwordTextField =
      [[UITextField alloc] initWithFrame:CGRectMake(100, 110, 200, 30)];
  [passwordTextField setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
  passwordTextField.placeholder = @"6-16位字母或数字"; //默认显示的字
  passwordTextField.font = [UIFont systemFontOfSize:16.0f];
  passwordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
  passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
  passwordTextField.returnKeyType = UIReturnKeyDone;
  passwordTextField.keyboardType = UIKeyboardTypeDefault;
  passwordTextField.clearButtonMode =
      UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
  passwordTextField.contentHorizontalAlignment =
      UIControlContentHorizontalAlignmentCenter;
  passwordTextField.contentVerticalAlignment =
      UIControlContentVerticalAlignmentCenter;
  passwordTextField.delegate = self;
  [passwordTextField setSecureTextEntry:YES];
  [self.childView addSubview:passwordTextField];

  oncePassWordTextField =
      [[UITextField alloc] initWithFrame:CGRectMake(100, 160, 200, 30)];
  [oncePassWordTextField
      setBorderStyle:UITextBorderStyleRoundedRect];             //外框类型
  oncePassWordTextField.placeholder = @"请再次输入密码"; //默认显示的字
  oncePassWordTextField.font = [UIFont systemFontOfSize:16.0f];
  oncePassWordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
  oncePassWordTextField.autocapitalizationType =
      UITextAutocapitalizationTypeNone;
  [oncePassWordTextField setSecureTextEntry:YES];
  oncePassWordTextField.returnKeyType = UIReturnKeyDone;
  oncePassWordTextField.keyboardType = UIKeyboardTypeDefault;
  oncePassWordTextField.clearButtonMode =
      UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
  oncePassWordTextField.contentHorizontalAlignment =
      UIControlContentHorizontalAlignmentCenter;
  oncePassWordTextField.contentVerticalAlignment =
      UIControlContentVerticalAlignmentCenter;
  oncePassWordTextField.delegate = self;
  [self.childView addSubview:oncePassWordTextField];

  //完成
  UIButton *finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
  finishButton.frame = CGRectMake(20, 210, 280, 34);
  finishButton.alpha = 0.8;
  finishButton.backgroundColor = [Globle colorFromHexRGB:@"f65f5b"];
  ;
  [finishButton setTitle:@"完成" forState:UIControlStateNormal];
  UIImage *highlightImage =
      [FPYouguUtil createImageWithColor:buttonHighLightColor];
  [finishButton setBackgroundImage:highlightImage
                          forState:UIControlStateHighlighted];
  [finishButton addTarget:self
                   action:@selector(finish:)
         forControlEvents:UIControlEventTouchUpInside];
  [self.childView addSubview:finishButton];

  animation_alterView = [[AnimationLabelAlterView alloc]
      initWithFrame:CGRectMake(0, 50, 320, 30)];
  [self.childView addSubview:animation_alterView];

  self.view.backgroundColor = [UIColor colorWithRed:240 / 255.0f
                                              green:240 / 255.0f
                                               blue:240 / 255.0f
                                              alpha:1.0];
}
#pragma mark - NEWS_Nav_View 自定义导航条  按钮delegate 点击函数
- (void)leftButtonPress {
  [self.view endEditing:NO];
  [self.navigationController popViewControllerAnimated:YES];
}
- (void)finish:(UIButton *)sender {
  if ([passwordTextField.text length] < 6 ||
      [oncePassWordTextField.text length] < 6) {
    YouGu_animation_Did_Start(@"密码由6-"
                              @"16位字母或数字组成，请重新输入");
    return;
  }

  if ([passwordTextField.text isEqualToString:oncePassWordTextField.text] ==
      YES) {
    [NetLoadingWaitView startAnimating];

    HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
    __weak NextPhoneBindAccountVC *weakSelf = self;
    callBack.onCheckQuitOrStopProgressBar = ^{
      NextPhoneBindAccountVC *strongObj = weakSelf;
      if (strongObj) {
        [NetLoadingWaitView stopAnimating];
        return NO;
      } else {
        return YES;
      }
    };
    callBack.onSuccess = ^(NSObject *obj) {
      NextPhoneBindAccountVC *strongSelf = weakSelf;
      if (strongSelf) {
        [strongSelf Login_Authentication];
      }
    };
    [ForgotPasswordRequest
        getForgotPasswordRequestWithPhoneNum:self.phone_Number
                                  andUserpwd:passwordTextField.text
                             andVerification:self.verification_str
                                WithcallBack:callBack];
  } else {
    YouGu_animation_Did_Start(@"两"
                              @"次输入的密码不一致，请重新输入");
  }
}
///验证成功后，做登录操作
- (void)Login_Authentication {
  HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
  __weak NextPhoneBindAccountVC *weakSelf = self;
  callBack.onSuccess = ^(NSObject *obj) {
    NextPhoneBindAccountVC *strongSelf = weakSelf;
    if (strongSelf) {
      ///登录成功
      [FPYouguUtil OnLoginSuccess];
      [AppDelegate popToRootViewController:NO];
    }
  };
  [LoginAuthentication Login_Authentication:self.phone_Number
                                 AndUserpwd:passwordTextField.text
                               WithcallBack:callBack];
}
- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string {
  if ([string isEqualToString:@"\n"]) {
    return YES;
  }
  //此处容易出问题
  NSString *toBeString =
      [textField.text stringByReplacingCharactersInRange:range
                                              withString:string];
  /// 输入限制
  if (![NSString validataPasswordOnInput:toBeString]) {
    return NO;
  }
  if ([toBeString length] > 16) {
    //更改显示效果，设置为输入就可以验证
    textField.text = [toBeString substringToIndex:16];
    return NO;
  } else {
    return YES;
  }
}
@end
