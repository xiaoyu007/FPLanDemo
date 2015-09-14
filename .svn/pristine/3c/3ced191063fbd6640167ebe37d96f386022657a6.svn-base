//
//  PhoneBindAccountVC.m
//  优顾理财
//
//  Created by Mac on 14-7-31.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "PhoneBindAccountVC.h"
#import "NetLoadingWaitView.h"
#import "NextPhoneBindAccountVC.h"
#import "UIButton+Block.h"
#import "OnLoginRequest.h"
#import "NSString+validate.h"

@implementation PhoneBindAccountVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  [self CreatNavBarWithTitle:@"手机快速注册"];
  //输入手机号
  phoneNumber = [[UITextField alloc] initWithFrame:CGRectMake(20, 70, 160, 30)];
  [phoneNumber setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
  phoneNumber.placeholder = @"请输入手机号";           //默认显示的字
  phoneNumber.font = [UIFont systemFontOfSize:14.0f];
  phoneNumber.autocorrectionType = UITextAutocorrectionTypeNo;
  phoneNumber.autocapitalizationType = UITextAutocapitalizationTypeNone;
  phoneNumber.returnKeyType = UIReturnKeyDone;
  phoneNumber.keyboardType = UIKeyboardTypeNumberPad;
  phoneNumber.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
  phoneNumber.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
  phoneNumber.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  phoneNumber.delegate = self;
  [self.childView addSubview:phoneNumber];

  //验证码button
  getAuthCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
  getAuthCodeButton.userInteractionEnabled = NO;
  getAuthCodeButton.frame = CGRectMake(190, 70, 100, 30);
  getAuthCodeButton.alpha = 0.8;
  getAuthCodeButton.backgroundColor = [Globle colorFromHexRGB:@"b2e2fe"];
  getAuthCodeButton.titleLabel.font = [UIFont systemFontOfSize:15];
  [getAuthCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
  getAuthCodeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
  [getAuthCodeButton setTitleColor:[Globle colorFromHexRGB:@"086dae"]
                          forState:UIControlStateNormal];

  getAuthCodeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
  getAuthCodeButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  [self.childView addSubview:getAuthCodeButton];

  requesting = NO;
  __weak PhoneBindAccountVC *weakSelf = self;
  [getAuthCodeButton setOnButtonPressedHandler:^{

    PhoneBindAccountVC *strongSelf = weakSelf;
    if (strongSelf) {
      [strongSelf requestCaptchaWithNum:0];
    }

  }];

  //验证码textView
  authCodeTextFeild = [[UITextField alloc] initWithFrame:CGRectMake(20, 120, 280, 30)];
  [authCodeTextFeild setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
  authCodeTextFeild.placeholder = @"请输入验证码";           //默认显示的字
  authCodeTextFeild.font = [UIFont systemFontOfSize:14.0f];
  authCodeTextFeild.autocorrectionType = UITextAutocorrectionTypeNo;
  authCodeTextFeild.autocapitalizationType = UITextAutocapitalizationTypeNone;
  authCodeTextFeild.returnKeyType = UIReturnKeyDone;
  authCodeTextFeild.keyboardType = UIKeyboardTypeNumberPad;
  authCodeTextFeild.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
  authCodeTextFeild.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
  authCodeTextFeild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

  authCodeTextFeild.delegate = self;
  [self.childView addSubview:authCodeTextFeild];

  //下一步
  nextStepButton = [UIButton buttonWithType:UIButtonTypeCustom];
  nextStepButton.frame = CGRectMake(20, 170, 280, 34);
  nextStepButton.alpha = 0.8;
  nextStepButton.backgroundColor = [Globle colorFromHexRGB:@"f65f5b"];
  nextStepButton.userInteractionEnabled = YES;
  [nextStepButton setTitle:@"下一步" forState:UIControlStateNormal];
  UIImage *highlightImage = [FPYouguUtil createImageWithColor:buttonHighLightColor];
  [nextStepButton setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
  [nextStepButton addTarget:self
                     action:@selector(nextStep:)
           forControlEvents:UIControlEventTouchUpInside];
  [self.childView addSubview:nextStepButton];
  //标题
  UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 220, 280, 20)];
  titleLabel.font = [UIFont systemFontOfSize:10];
  titleLabel.textAlignment = NSTextAlignmentLeft;
  titleLabel.text = @"温馨提示：手机号仅用于登录或找回密码";
  titleLabel.backgroundColor = [UIColor clearColor];
  titleLabel.textColor = [Globle colorFromHexRGB:@"5a5a5a"];
  [self.childView addSubview:titleLabel];

  animation_alter = [[AnimationLabelAlterView alloc] initWithFrame:CGRectMake(0, 50, 320, 30)];
  [self.childView addSubview:animation_alter];
}
- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - NEWS_Nav_View 自定义导航条  按钮delegate 点击函数
- (void)leftButtonPress {
  [self.view endEditing:NO];
  [self.navigationController popViewControllerAnimated:YES];
  //    [self dismissModalViewControllerAnimated:YES];
}
- (void)nextStep:(UIButton *)button {
  //手机号输入限定条件
  if ([phoneNumber.text length] == 0) {
    YouGu_animation_Did_Start(@"请输入手机号");
    return;
  } else if (![NSString validataPhoneNumber:phoneNumber.text]) {
    YouGu_animation_Did_Start(@"请输入正确的手机号");
    return;
  }
  
  if ([authCodeTextFeild.text length] == 0) {
    YouGu_animation_Did_Start(@"请输入验证码");
    return;
  } else if ([authCodeTextFeild.text length] != 6) {
    YouGu_animation_Did_Start(@"验证码输入有误");
    return;
  }else if (![SimuControl
              validateSixNumberIdentityCard:authCodeTextFeild
              .text]) {
    YouGu_animation_Did_Start(@"验证码输入有误");
    return;
  }
  //判断网络
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  //解析数据
  HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
  __weak PhoneBindAccountVC *weakSelf = self;
  callBack.onSuccess = ^(NSObject *obj) {
    PhoneBindAccountVC *strongSelf = weakSelf;
    if (strongSelf) {
      NextPhoneBindAccountVC *next_phone_VC =
          [[NextPhoneBindAccountVC alloc] initPhone:phoneNumber.text
                                    andVerification:authCodeTextFeild.text];
      [AppDelegate pushViewControllerFromRight:next_phone_VC];
    }
  };
  [VerificationNumber Verification_REGISTERPIN:phoneNumber.text
                               andVerification:authCodeTextFeild.text
                                       andType:@"1"
                                  WithcallBack:callBack];
  //键盘回收
  [phoneNumber resignFirstResponder];
  [authCodeTextFeild resignFirstResponder];
}

- (void)requestCaptchaWithNum:(NSInteger)num {
  getAuthCodeButton.userInteractionEnabled = NO;
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    getAuthCodeButton.userInteractionEnabled = YES;
    return;
  }
  if (requesting) {
    return;
  }
  //收回键盘
  [phoneNumber resignFirstResponder];
  [authCodeTextFeild resignFirstResponder];
  //手机号正确与否判断
  if (![SimuControl lengalPhoneNumber:phoneNumber.text]) {
    YouGu_animation_Did_Start(@"请输入正确的手机号");
    return;
  }
  [NetLoadingWaitView startAnimating];
  requesting = YES;
  HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
  __weak PhoneBindAccountVC *weakSelf = self;
  callBack.onCheckQuitOrStopProgressBar = ^{
    PhoneBindAccountVC *strongObj = weakSelf;
    if (strongObj) {
      requesting = NO;
      getAuthCodeButton.userInteractionEnabled = YES;
      [NetLoadingWaitView stopAnimating];
      return NO;
    } else {
      return YES;
    }
  };
  callBack.onSuccess = ^(NSObject *obj) {
    
    PhoneBindAccountVC *strongObj = weakSelf;
    if (strongObj) {
      [strongObj getIdentifyingCodeBtnClick];
    }
    
  };
  callBack.onFailed = ^{
    [BaseRequester defaultFailedHandler]();
  };
  [GetVerificationCode getVerificationCodeWithPhoneNum:phoneNumber.text WithcallBack:callBack];
}

- (void)getIdentifyingCodeBtnClick {
  [getAuthCodeButton setEnabled:NO];
  [getAuthCodeButton setTitle:@" " forState:UIControlStateNormal];
  
  __block int timeout = 60;  //倒计时时间
  dispatch_queue_t queue =
  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  dispatch_source_t _timer =
  dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
  dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0),
                            1.0 * NSEC_PER_SEC, 0);  //每秒执行
  dispatch_source_set_event_handler(_timer, ^{
    if (timeout <= 0) {  //倒计时结束，关闭
      dispatch_source_cancel(_timer);
      dispatch_async(dispatch_get_main_queue(), ^{
        //设置界面的按钮显示
        [getAuthCodeButton setTitle:@"获取验证码"
                           forState:UIControlStateNormal];
        [getAuthCodeButton setTitleColor:[Globle colorFromHexRGB:@"086ade"] forState:UIControlStateNormal];
        [getAuthCodeButton setEnabled:YES];
      });
    } else {
      dispatch_async(dispatch_get_main_queue(), ^{
        //更改按钮名称，提示下载状态
        [getAuthCodeButton
         setTitle:[NSString stringWithFormat:@"重新获取(%ld)", (long)timeout]
         forState:UIControlStateNormal];
        [getAuthCodeButton setTitleColor:[Globle colorFromHexRGB:@"939393"] forState:UIControlStateNormal];
      });
      timeout--;
    }
  });
  dispatch_resume(_timer);
}

#pragma mark
#pragma mark-------textField协议函数----------
- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string {
  if ([string isEqualToString:@"\n"]) {
    return YES;
  }
  //此处容易出问题
  NSString *toBeString =
      [textField.text stringByReplacingCharactersInRange:range withString:string];
  
  ///手机号输入框
  if (textField == phoneNumber) {
    if (![NSString validataNumberInput:toBeString]) {
      return NO;
    }
    if ([toBeString length] > 10) {
      //更改显示效果，设置为输入就可以验证
      if ([toBeString length] > 10) {
        textField.text = [toBeString substringToIndex:11];
        getAuthCodeButton.userInteractionEnabled = YES;
        getAuthCodeButton.alpha = 1.0;
        return NO;
      } else {
        return YES;
      }
    } else {
      getAuthCodeButton.userInteractionEnabled = NO;
      getAuthCodeButton.alpha = 0.8f;
    }
  }
  ///验证码输入框
  if (textField == authCodeTextFeild) {
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

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
