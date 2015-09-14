//
//  OpenAcountFirstStepViewController.m
//  优顾理财
//
//  Created by Mac on 15/3/18.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPOpenAcountFirstStepViewController.h"
#import "FPConnectBankCardVC.h"
#import "FPBankStepViewController.h"
#import "NetLoadingWaitView.h"
#import "UIButton+Block.h"
#import "OnLoginRequest.h"

#define timeLength 59
#define NUMBERS @"0123456789\n"
@interface FPOpenAcountFirstStepViewController ()<UITextFieldDelegate> {
  //开户
  IBOutlet UILabel* openLabel;
  //下一步
  IBOutlet UIButton* nextButton;
  ///返回导航按钮
  IBOutlet UIButton* navBtn;
  ///开户第一步文本@“开户第一步”
  IBOutlet UILabel* firstStepLabel;
  ///开户第二步文本@“关联银行卡”
  IBOutlet UILabel* secondStepLabel;

  ///开户第三步文本@“开户完成”
  IBOutlet UILabel* thirdStepLabel;

  ///手机号输入框
  IBOutlet UITextField* phoneNoTextField;

  ///获取验证码按钮
  IBOutlet UIButton* getIdentifyingCodeBtn;

  ///验证码输入框
  IBOutlet UITextField* typeIdentifyingCodeTextField;

  ///温馨提示
  IBOutlet UILabel* promptLabel0;

  IBOutlet UIView* midView;
  ///验证码时间
  int countDown;

  NSTimer* timer;
  ///按下态颜色
  UIImage* highLightImage;

  /** 开户步骤*/
  FPBankStepViewController* bankStep;
}
///重新验证
@property(nonatomic, strong) UILabel* authLabel;
///验证码倒计时时间
@property(nonatomic, strong) UILabel* authTimeLabel;
///开户流水号
@property(nonatomic, strong) NSString* serialno;
///短信验证码
@property(nonatomic, strong) NSString* checkcode;
///银行卡ID
@property(nonatomic, assign) NSString* userbankid;
@end

@implementation FPOpenAcountFirstStepViewController
//移除当前界面
- (void)removeCurrentView {
  [self removeFromParentViewController];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  self.childView.userInteractionEnabled = NO;

  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(removeCurrentView)
                                               name:@"remove_before_view"
                                             object:nil];

  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(removeCurrentView)
                                               name:@"remove_open_view"
                                             object:nil];
  highLightImage = [FPYouguUtil createImageWithColor:btnAccordingToTheNormal];
  [nextButton setBackgroundImage:highLightImage
                        forState:UIControlStateHighlighted];

  phoneNoTextField.delegate = self;
  typeIdentifyingCodeTextField.delegate = self;

  [navBtn addTarget:self
                action:@selector(navigationBtn)
      forControlEvents:UIControlEventTouchUpInside];
  [navBtn setImage:[UIImage imageNamed:@"返回小箭头.png"]
          forState:UIControlStateNormal];
  [navBtn setImage:[UIImage imageNamed:@"返回小箭头.png"]
          forState:UIControlStateHighlighted];
  navBtn.imageEdgeInsets = UIEdgeInsetsMake(15, 20, 15, 20);
  UIImage* highlightImage =
      [FPYouguUtil createImageWithColor:btnAccordingToTheNormal];
  [navBtn setBackgroundImage:highlightImage forState:UIControlStateHighlighted];

  ///手机号码输入
  phoneNoTextField.layer.borderWidth = 1;
  phoneNoTextField.layer.borderColor =
      [[Globle colorFromHexRGB:@"c7c7c7"] CGColor];
  phoneNoTextField.keyboardType = UIKeyboardTypeNumberPad;
  phoneNoTextField.leftView =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
  phoneNoTextField.leftView.userInteractionEnabled = NO;
  phoneNoTextField.leftViewMode = UITextFieldViewModeAlways;
  phoneNoTextField.clearButtonMode = UITextFieldViewModeAlways;
  phoneNoTextField.tag = 11;
  ///输入验证码
  typeIdentifyingCodeTextField.layer.borderWidth = 1;
  typeIdentifyingCodeTextField.layer.borderColor =
      [[Globle colorFromHexRGB:@"c7c7c7"] CGColor];
  typeIdentifyingCodeTextField.leftView =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
  typeIdentifyingCodeTextField.leftView.userInteractionEnabled = NO;
  typeIdentifyingCodeTextField.leftViewMode = UITextFieldViewModeAlways;
  typeIdentifyingCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
  typeIdentifyingCodeTextField.clearButtonMode = UITextFieldViewModeAlways;

  typeIdentifyingCodeTextField.tag = 10;

  openLabel.textColor = (UIColor*)[[Globle colorFromHexRGB:@"F07533"] CGColor];
  [nextButton
      setTitleColor:(UIColor*)[[Globle colorFromHexRGB:@"F07533"] CGColor]
           forState:UIControlStateNormal];
  firstStepLabel.textColor =
      (UIColor*)[[Globle colorFromHexRGB:@"F07533"] CGColor];
  secondStepLabel.textColor =
      (UIColor*)[[Globle colorFromHexRGB:@"CFCFCF"] CGColor];
  thirdStepLabel.textColor =
      (UIColor*)[[Globle colorFromHexRGB:@"CFCFCF"] CGColor];
  promptLabel0.textColor =
      (UIColor*)[[Globle colorFromHexRGB:@"84929e"] CGColor];

  /**  开户三步骤的背景颜色类*/
  bankStep = [[FPBankStepViewController alloc]
      initWithNibName:@"FPBankStepViewController"
               bundle:nil];
  [self.view addSubview:bankStep.view];
  bankStep.view.userInteractionEnabled = NO;

  ///验证码
  self.authLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 4, 91, 14)];
  self.authLabel.textAlignment = NSTextAlignmentCenter;
  self.authLabel.textColor = [UIColor whiteColor];
  self.authLabel.font = [UIFont systemFontOfSize:13];
  [getIdentifyingCodeBtn addSubview:self.authLabel];

  //网络状态初始值
  requesting = NO;

  __weak FPOpenAcountFirstStepViewController* weakSelf = self;
  [getIdentifyingCodeBtn setOnButtonPressedHandler:^{

    FPOpenAcountFirstStepViewController* strongSelf = weakSelf;

    if (strongSelf) {
      [strongSelf getIdentifyingCodeBtn];
    }

  }];

  ///计时
  self.authTimeLabel =
      [[UILabel alloc] initWithFrame:CGRectMake(0, 21, 91, 12)];
  self.authTimeLabel.textAlignment = NSTextAlignmentCenter;
  self.authTimeLabel.textColor = [UIColor whiteColor];
  self.authTimeLabel.font = [UIFont systemFontOfSize:12];
  [getIdentifyingCodeBtn addSubview:self.authTimeLabel];
}

//验证码触发事件
- (void)getIdentifyingCodeBtn {
  [phoneNoTextField resignFirstResponder];
  [typeIdentifyingCodeTextField resignFirstResponder];
  //手机号判断
  if ([phoneNoTextField.text length] == 0) {
    YouGu_animation_Did_Start(@"请输入手机号");
    return;
  }
  if (![SimuControl lengalPhoneNumber:phoneNoTextField.text]) {
    [getIdentifyingCodeBtn setBackgroundImage:highLightImage
                                     forState:UIControlStateHighlighted];
    YouGu_animation_Did_Start(@"请输入正确的手机号");
    return;
  }
  //网络正在请求中
  if (requesting) {
    return;
  }

  //发送请求数据
  [self requestCaptchaWithNum:0];
}

//请求数据
- (void)requestCaptchaWithNum:(NSInteger)num {
  NSLog(@"kaihu---------------kaihu-----");
  
  if (num >= 3) {
    return;
  }
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }

  [NetLoadingWaitView startAnimating];
  requesting = YES;
  HttpRequestCallBack* callBack = [[HttpRequestCallBack alloc] init];
  __weak FPOpenAcountFirstStepViewController* weakSelf = self;
  callBack.onCheckQuitOrStopProgressBar = ^{
    FPOpenAcountFirstStepViewController* strongObj = weakSelf;
    if (strongObj) {
      requesting = NO;
      [NetLoadingWaitView stopAnimating];
      return NO;
    } else {
      return YES;
    }
  };
  callBack.onSuccess = ^(NSObject* obj) {
    FPOpenAcountFirstStepViewController* strongObj = weakSelf;
    if (strongObj) {
      [strongObj getIdentifyingCodeBtnClick];
    }
  };
  callBack.onFailed = ^{
    [self requestCaptchaWithNum:(num + 1)];
    [BaseRequester defaultFailedHandler]();
  };
  [GetVerificationCode getVerificationCodeWithPhoneNum:phoneNoTextField.text
                                          WithcallBack:callBack];
}

- (void)getIdentifyingCodeBtnClick {
  [getIdentifyingCodeBtn setEnabled:NO];
  [getIdentifyingCodeBtn setBackgroundColor:[Globle colorFromHexRGB:@"939393"]];
  [getIdentifyingCodeBtn setTitle:@" " forState:UIControlStateNormal];

  [self.authLabel setAlpha:1];
  [self.authTimeLabel setAlpha:1];
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
        [getIdentifyingCodeBtn setTitle:@"获取验证码"
                               forState:UIControlStateNormal];
        [getIdentifyingCodeBtn
            setBackgroundColor:[Globle colorFromHexRGB:@"f07533"]];
        [getIdentifyingCodeBtn setEnabled:YES];
        [self.authLabel setAlpha:0];
        [self.authTimeLabel setAlpha:0];

      });
    } else {
      NSString* str = @"重新验证";
      NSString* strTime = [NSString stringWithFormat:@"( %d″)", timeout];
      dispatch_async(dispatch_get_main_queue(), ^{
        //设置界面的按钮显示
        [self.authLabel setText:str];
        [self.authTimeLabel setText:strTime];
      });
      timeout--;
    }
  });
  dispatch_resume(_timer);
}

#pragma mark---textFieldDelegate
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
  [phoneNoTextField resignFirstResponder];
  [typeIdentifyingCodeTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
  [textField resignFirstResponder];
  return YES;
}
- (BOOL)textField:(UITextField*)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString*)string {
  NSString* toBeString =
      [textField.text stringByReplacingCharactersInRange:range
                                              withString:string];

  if (textField == phoneNoTextField) {
    if (toBeString.length > 11) {
      return NO;
    }
  }

  if (textField == typeIdentifyingCodeTextField) {
    if (toBeString.length > 6) {
      return NO;
    }
  }

  NSCharacterSet* cs;
  if (textField == phoneNoTextField ||
      textField == typeIdentifyingCodeTextField) {
    cs = [[NSCharacterSet
        characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString* filtered = [[string componentsSeparatedByCharactersInSet:cs]
        componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if (!basicTest) {
      return NO;
    }
  }

  //其他的类型不需要检测，直接写入
  return YES;
}

- (IBAction)nextBtn:(id)sender {
  [phoneNoTextField resignFirstResponder];
  [typeIdentifyingCodeTextField resignFirstResponder];

  //输入限定条件
  if ([phoneNoTextField.text length] == 0) {
    YouGu_animation_Did_Start(@"请输入手机号");
    return;
  } else if (![SimuControl lengalPhoneNumber:phoneNoTextField.text]) {
    YouGu_animation_Did_Start(@"请输入正确的手机号");
    return;
  } else if ([typeIdentifyingCodeTextField.text length] == 0) {
    YouGu_animation_Did_Start(@"请输入验证码");
    return;
  } else if (![SimuControl
                 validateSixNumberIdentityCard:typeIdentifyingCodeTextField
                                                   .text]) {
    YouGu_animation_Did_Start(@"验证码输入有误");
    return;
  } else if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }  //解析数据
  HttpRequestCallBack* callBack = [[HttpRequestCallBack alloc] init];
  __weak FPOpenAcountFirstStepViewController* weakSelf = self;

  callBack.onSuccess = ^(NSObject* obj) {
    FPOpenAcountFirstStepViewController* strongSelf = weakSelf;
    if (strongSelf) {
      HttpRequestCallBack* callback = [[HttpRequestCallBack alloc] init];
      callback.onSuccess = ^(NSObject* obj) {
        //手机绑定成功
        [SimuControl bingMobileWithType:1];

        FPConnectBankCardVC* connVC = [[FPConnectBankCardVC alloc] init];

        /**  绑定的手机号*/
        connVC.iphoneNumber = phoneNoTextField.text;

        [AppDelegate pushViewControllerFromRight:connVC];
      };
      [BindMobilePhone BindMobilePhone:phoneNoTextField.text
                          WithcallBack:callback];
    }
  };
  [VerificationNumber Verification_REGISTERPIN:phoneNoTextField.text
                               andVerification:typeIdentifyingCodeTextField.text
                                       andType:@"1"
                                  WithcallBack:callBack];
}

- (void)navigationBtn {
  [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
