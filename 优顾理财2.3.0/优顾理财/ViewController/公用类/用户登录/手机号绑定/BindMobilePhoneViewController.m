//
//  BindMobilePhoneViewController.m
//  优顾理财
//
//  Created by Mac on 14-8-11.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "BindMobilePhoneViewController.h"
#import "OnLoginRequestItem.h"
#import "UIButton+Block.h"
#import "NetLoadingWaitView.h"
#import "OnLoginRequest.h"
#import "NSString+validate.h"

@implementation BindMobilePhoneViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

#pragma mark - pv, 选择正确的pvjiem
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [MobClick beginLogPageView:@"Phone_Bind_Mobile_view"];
  [[PV_view_sql sharedManager] PV_DB_DATA:@"Phone_Bind_Mobile_view"];
}
- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [MobClick endLogPageView:@"Phone_Bind_Mobile_view"];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  //  [self nextStep:nextStepButton];
  return YES;
}

- (void)tappedBackGroundView {
  [phoneNumber resignFirstResponder];
  [authCodeTextFeild resignFirstResponder];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch {
  UIView *view = [touch view];

  if ([view isKindOfClass:[UIControl class]]) {
    return NO;
  }
  return YES;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.

  [self CreatNavBarWithTitle:@"手机号绑定"];

  //输入手机号
  phoneNumber = [[UITextField alloc] initWithFrame:CGRectMake(20, 70, windowWidth - 160.0f, 30)];
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
  requesting = NO;
  getAuthCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
  //  getAuthCodeButton.userInteractionEnabled = NO;
  getAuthCodeButton.frame = CGRectMake(windowWidth - 130.0f, 70, 100, 30);
  getAuthCodeButton.alpha = 0.8;
  getAuthCodeButton.layer.cornerRadius = 5;
  getAuthCodeButton.backgroundColor = [Globle colorFromHexRGB:@"b2e2fe"];
  getAuthCodeButton.titleLabel.font = [UIFont systemFontOfSize:15];
  [getAuthCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
  getAuthCodeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
  [getAuthCodeButton setTitleColor:[Globle colorFromHexRGB:@"086dae"]
                          forState:UIControlStateNormal];

  __weak BindMobilePhoneViewController *weakAuthSelf = self;
  [getAuthCodeButton setOnButtonPressedHandler:^{
    BindMobilePhoneViewController *strongSelf = weakAuthSelf;
    if (strongSelf) {
      [strongSelf captchaBtnClicked];
    }
  }];

  getAuthCodeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
  getAuthCodeButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  [self.childView addSubview:getAuthCodeButton];
  //验证码textView
  authCodeTextFeild = [[UITextField alloc] initWithFrame:CGRectMake(20, 120, windowWidth - 40.0f, 30)];
  [authCodeTextFeild setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
  authCodeTextFeild.placeholder = @"请输入验证码";           //默认显示的字
  authCodeTextFeild.font = [UIFont fontWithName:@"AppleGothic" size:14.0];
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
  nextStepButton.layer.cornerRadius = 5;
  nextStepButton.backgroundColor = [Globle colorFromHexRGB:@"f65f5b"];
  nextStepButton.userInteractionEnabled = YES;
  [nextStepButton setTitle:@"下一步" forState:UIControlStateNormal];
  UIImage *highlightImage = [FPYouguUtil createImageWithColor:buttonHighLightColor];
  [nextStepButton setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
  __weak BindMobilePhoneViewController *weakSelf = self;
  [nextStepButton setOnButtonPressedHandler:^{

    BindMobilePhoneViewController *strongSelf = weakSelf;
    if (strongSelf) {
      [strongSelf nextBtnClick];
    }
  }];

  [self.childView addSubview:nextStepButton];
  //标题
  UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 220, 280, 20)];
  titleLabel.font = [UIFont systemFontOfSize:10];
  titleLabel.textAlignment = NSTextAlignmentLeft;
  titleLabel.text = @"温馨提示：手机号仅用于登录或找回密码";
  titleLabel.backgroundColor = [UIColor clearColor];
  titleLabel.textColor = [Globle colorFromHexRGB:@"5a5a5a"];
  [self.childView addSubview:titleLabel];

  [self Night_to_Day];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - NEWS_Nav_View 自定义导航条  按钮delegate 点击函数
- (void)leftButtonPress {
  [self.view endEditing:NO];
  [self.navigationController popViewControllerAnimated:YES];
}
- (void)nextBtnClick {
  //键盘回收
  [phoneNumber resignFirstResponder];
  [authCodeTextFeild resignFirstResponder];
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
  }
  
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }else if (![SimuControl
              validateSixNumberIdentityCard:authCodeTextFeild
              .text]) {
    YouGu_animation_Did_Start(@"验证码输入有误");
    return;
  }
  //解析数据
  [NetLoadingWaitView startAnimating];
  HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
  __weak BindMobilePhoneViewController *weakSelf = self;
  callBack.onCheckQuitOrStopProgressBar = ^{
    BindMobilePhoneViewController *strongSelf = weakSelf;
    if (strongSelf) {
      [NetLoadingWaitView stopAnimating];
      return NO;
    } else {
      return YES;
    }
  };

  callBack.onSuccess = ^(NSObject *obj) {
    BindMobilePhoneViewController *strongSelf = weakSelf;
    if (strongSelf) {
      HttpRequestCallBack *callback = [[HttpRequestCallBack alloc] init];
      callback.onSuccess = ^(NSObject *obj) {
        //提示语，动画
        YouGu_animation_Did_Start(@"手机号绑定成功");

        UserBindThirdItem *thirdItem = [[UserBindThirdItem alloc] init];
        thirdItem.BindType = 1;
        thirdItem.BindOpenid = phoneNumber.text;
        thirdItem.BindThridName = phoneNumber.text;

        [[NSNotificationCenter defaultCenter]
            postNotificationName:@"bind_moblie_phone_viewController_refrash"
                          object:thirdItem];

        [AppDelegate popViewController:YES];
      };
      [BindMobilePhone BindMobilePhone:phoneNumber.text WithcallBack:callback];
    }
  };
  [VerificationNumber Verification_REGISTERPIN:phoneNumber.text
                               andVerification:authCodeTextFeild.text
                                       andType:@"1"
                                  WithcallBack:callBack];
}

- (void)captchaBtnClicked {
  if (requesting) {
    return;
  }
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }

  //收回键盘
  [phoneNumber resignFirstResponder];
  [authCodeTextFeild resignFirstResponder];
  //手机号正确与否判断
  if (![SimuControl lengalPhoneNumber:phoneNumber.text]) {
    //提示语，动画
    YouGu_animation_Did_Start(@"请输入正确的手机号");
    return;
  }
  //点击就重置了button
  requesting = YES;
  HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
  __weak BindMobilePhoneViewController *weakSelf = self;
  callBack.onCheckQuitOrStopProgressBar = ^{
    BindMobilePhoneViewController *strongObj = weakSelf;
    if (strongObj) {
      requesting = NO;
      return NO;
    } else {
      return YES;
    }
  };
  callBack.onError = ^(BaseRequestObject *err, NSException *exc){
    [BaseRequester defaultErrorHandler](err, exc);
  };
  callBack.onSuccess = ^(NSObject *obj) {
    //开始计时
    BindMobilePhoneViewController* strongObj = weakSelf;
    if (strongObj) {
      [strongObj changeButton];
    }  };
  callBack.onFailed = ^{
    [BaseRequester defaultFailedHandler]();
  };
  [GetVerificationCode getVerificationCodeWithPhoneNum:phoneNumber.text WithcallBack:callBack];
}

- (void)authReset {
  //收回键盘
  [phoneNumber resignFirstResponder];
  [authCodeTextFeild resignFirstResponder];
  //  在获取验证码的时候，按钮不可点击
  getAuthCodeButton.userInteractionEnabled = NO;
  [getAuthCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
}
//计时
- (void)changeButton {
  time = 60;
  [self startTime];
}

- (void)updateBtn {
  NSInteger startBGTimer = [[NSUserDefaults standardUserDefaults] integerForKey:@"startTimerData"];
  NSInteger endBgTimer = [[NSUserDefaults standardUserDefaults] integerForKey:@"endTimerData"];
  if (endBgTimer - startBGTimer > time && endBgTimer - startBGTimer > 0) {
    [self stopTime];
    [self authReset];
    [self setTimeZero];
    return;
  } else {
    time = time - endBgTimer + startBGTimer;
    [self setTimeZero];
  }
  
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    [self stopTime];
    [self authReset];
    return;
  }

  if (time == 60) {
    getAuthCodeButton.backgroundColor = [UIColor grayColor];
    //按钮状态
    [getAuthCodeButton setTitleColor:[Globle colorFromHexRGB:@"ffffff"]
                            forState:UIControlStateNormal];
  }
  //更改按钮名称，提示下载状态
  [getAuthCodeButton setTitle:[NSString stringWithFormat:@"重新获取(%ld)", (long)time]
                     forState:UIControlStateNormal];
  time--;
  if (time < 0) {
    [self stopTime];
    [self authReset];
    getAuthCodeButton.backgroundColor = [Globle colorFromHexRGB:@"b2e2fe"];
    [getAuthCodeButton setTitleColor:[Globle colorFromHexRGB:@"086dae"]
                            forState:UIControlStateNormal];
    [getAuthCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    getAuthCodeButton.userInteractionEnabled = YES;
  } else {
    getAuthCodeButton.userInteractionEnabled = NO;
  }
}

//定时器关闭与开启
- (void)stopTime {
  if (timer != nil) {
    if ([timer isValid]) {
      [timer invalidate];
      timer = nil;
    }
  }
}
//时间差清零
- (void)setTimeZero {
  //记录进入前台时间
  [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"startTimerData"];
  [[NSUserDefaults standardUserDefaults] setInteger:0.0 forKey:@"endTimerData"];
  [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)startTime {
  //重置
  [self setTimeZero];
  if (timer && [timer isValid]) {
    return;
  }
  timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                           target:self
                                         selector:@selector(updateBtn)
                                         userInfo:nil
                                          repeats:YES];
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

/**
 *
 *  //消息中心
 *
 **/
#pragma mark - 消息中心，回调，夜间、白天和无图、有图

//夜间模式和白天模式
- (void)Night_to_Day {
  self.view.backgroundColor =
      [UIColor colorWithRed:240 / 255.0f green:240 / 255.0f blue:240 / 255.0f alpha:1.0];

  phoneNumber.backgroundColor =
      [UIColor colorWithRed:246 / 255.0f green:246 / 255.0f blue:246 / 255.0f alpha:1.0f];
  [[phoneNumber layer]
      setBorderColor:
          [UIColor colorWithRed:213 / 255.0f green:213 / 255.0f blue:213 / 255.0f alpha:1.0f].CGColor];
  phoneNumber.textColor = [UIColor blackColor];
  phoneNumber.keyboardAppearance = UIKeyboardAppearanceDefault;

  authCodeTextFeild.backgroundColor =
      [UIColor colorWithRed:246 / 255.0f green:246 / 255.0f blue:246 / 255.0f alpha:1.0f];
  [[authCodeTextFeild layer]
      setBorderColor:
          [UIColor colorWithRed:213 / 255.0f green:213 / 255.0f blue:213 / 255.0f alpha:1.0f].CGColor];
  authCodeTextFeild.textColor = [UIColor blackColor];
  authCodeTextFeild.keyboardAppearance = UIKeyboardAppearanceDefault;
}
@end
