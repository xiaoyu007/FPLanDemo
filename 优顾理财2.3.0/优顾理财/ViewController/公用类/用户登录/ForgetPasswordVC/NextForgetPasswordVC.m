//
//  NextForgetPasswordVC.m
//  优顾理财
//
//  Created by Mac on 14-8-4.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "NextForgetPasswordVC.h"
#import "OnLoginRequest.h"
#import "NetLoadingWaitView.h"
#import "OnLoginRequestItem.h"
#import "FileChangelUtil.h"
#import "UserDataSaveToDefault.h"
#import "NSString+validate.h"

@implementation NextForgetPasswordVC
@synthesize phone_Number;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (id)initPhone:(NSString *)phone_number {
  self = [super init];
  if (self) {
    self.phone_Number = phone_number;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  [self CreatNavBarWithTitle:@"密码重置"];

  UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, 280, 20)];
  detailLabel.font = [UIFont systemFontOfSize:15];
  detailLabel.textAlignment = NSTextAlignmentLeft;
  detailLabel.text = @"请重新设置新密码";
  detailLabel.backgroundColor = [UIColor clearColor];
  detailLabel.textColor = [Globle colorFromHexRGB:@"454545"];
  [self.childView addSubview:detailLabel];

  //左侧label
  //密码
  UILabel *passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 110, 80, 30)];
  passwordLabel.text = @"新  密  码：";
  passwordLabel.textAlignment = NSTextAlignmentLeft;
  passwordLabel.textColor = [Globle colorFromHexRGB:@"000000"];
  passwordLabel.font = [UIFont systemFontOfSize:15];
  passwordLabel.backgroundColor = [UIColor clearColor];
  [self.childView addSubview:passwordLabel];

  //确认密码
  UILabel *confirmPasswordLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 160, 80, 30)];
  confirmPasswordLabel.textColor = [Globle colorFromHexRGB:@"000000"];
  confirmPasswordLabel.textAlignment = NSTextAlignmentLeft;
  confirmPasswordLabel.text = @"确认密码：";
  confirmPasswordLabel.backgroundColor = [UIColor clearColor];
  confirmPasswordLabel.font = [UIFont systemFontOfSize:15];
  [self.childView addSubview:confirmPasswordLabel];

  // textview

  passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 110, 200, 30)];
  [passwordTextField setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
  passwordTextField.placeholder = @"6-16位字母或数字";             //默认显示的字
  passwordTextField.font = [UIFont systemFontOfSize:16.0f];
  passwordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
  passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
  passwordTextField.secureTextEntry = YES;
  passwordTextField.returnKeyType = UIReturnKeyDone;
  passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
  passwordTextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
  passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

  passwordTextField.delegate = self;
  [self.childView addSubview:passwordTextField];

  oncePassWordTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 160, 200, 30)];
  [oncePassWordTextField setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
  oncePassWordTextField.placeholder = @"请再次输入密码";        //默认显示的字
  oncePassWordTextField.font = [UIFont systemFontOfSize:16.0f];
  oncePassWordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
  oncePassWordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
  oncePassWordTextField.returnKeyType = UIReturnKeyDone;
  oncePassWordTextField.secureTextEntry = YES;
  oncePassWordTextField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
  oncePassWordTextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
  oncePassWordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  oncePassWordTextField.delegate = self;

  [self.childView addSubview:oncePassWordTextField];

  //完成
  UIButton *finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
  finishButton.frame = CGRectMake(20, 210, 280, 34);
  finishButton.alpha = 0.8;
  finishButton.backgroundColor = [Globle colorFromHexRGB:@"f65f5b"];
  ;
  [finishButton setTitle:@"完成" forState:UIControlStateNormal];
  UIImage *highlightImage = [FPYouguUtil createImageWithColor:buttonHighLightColor];
  [finishButton setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
  [finishButton addTarget:self
                   action:@selector(finish:)
         forControlEvents:UIControlEventTouchUpInside];
  [self.childView addSubview:finishButton];

  animation_alterView = [[AnimationLabelAlterView alloc] initWithFrame:CGRectMake(0, 50, 320, 30)];
  [self.childView addSubview:animation_alterView];

  self.view.backgroundColor =
      [UIColor colorWithRed:240 / 255.0f green:240 / 255.0f blue:240 / 255.0f alpha:1.0];
}
#pragma mark - NEWS_Nav_View 自定义导航条  按钮delegate 点击函数
- (void)leftButtonPress {
  [self.view endEditing:NO];
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)finish:(UIButton *)sender {
  //新密码
  NSString *newPwd = passwordTextField.text;
  //确认密码
   NSString *confirmPwd = oncePassWordTextField.text;
  
  if ([newPwd length] == 0) {
   YouGu_animation_Did_Start(@"请输入密码");
    return;
  } else if ([newPwd length] < 6) {
    YouGu_animation_Did_Start(@"密码由6-16位字母或数字组成，请重新输入");
    return;
  }
  
  if ([confirmPwd length] == 0) {
    YouGu_animation_Did_Start(@"请输入确认密码");
    return;
  } else if (![newPwd isEqualToString:confirmPwd]) {
    YouGu_animation_Did_Start(@"两次输入的密码不一致，请重新输入");
    return;
  }
  //判断有没有网络
  if (![FPYouguUtil isExistNetwork]) {
     YouGu_animation_Did_Start(networkFailed);
    return;
  }
  HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
  __weak NextForgetPasswordVC *weakSelf = self;
  callBack.onSuccess = ^(NSObject *obj) {
    NextForgetPasswordVC *strongSelf = weakSelf;
    if (strongSelf) {
      PhoneGetNewPassword *item = (PhoneGetNewPassword *)obj;
      YouGu_animation_Did_Start(item.message);
      [strongSelf loginProcess];
    }
  };
  [PhoneGetNewPassword getPhoneGetNewPassword:self.phone_Number
                                   AndUserpwd:passwordTextField.text
                                 WithcallBack:callBack];
  
  
}
/** 执行登录操作 */
- (void)loginProcess {
  HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
  __weak NextForgetPasswordVC *weakSelf = self;
  callBack.onCheckQuitOrStopProgressBar = ^{
    NextForgetPasswordVC *strongSelf = weakSelf;
    if (strongSelf) {
      return NO;
    } else {
      return YES;
    }
  };
  callBack.onSuccess = ^(NSObject *obj) {
    NextForgetPasswordVC *strongSelf = weakSelf;
    if (strongSelf) {
      OnLoginRequestItem *item = (OnLoginRequestItem *)obj;
      //已经绑定过了，直接登陆(并保存用户数据）
      [FileChangelUtil saveUserListItem:item.userListItem];
      ///登录成功
      [FPYouguUtil OnLoginSuccess];
      [AppDelegate popToRootViewController:YES];
    }
  };
  [OnLoginRequestItem getOnLoginWithNickName:phone_Number
                                 andpassword:oncePassWordTextField.text
                                withCallback:callBack];
}

- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
  if ([string isEqualToString:@"\n"]) {
    return YES;
  }
  //此处容易出问题
  NSString *toBeString =
  [textField.text stringByReplacingCharactersInRange:range withString:string];
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
