//
//  NormalRegistVC.m
//  优顾理财
//
//  Created by Mac on 14-8-1.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "NormalRegistVC.h"
//自定义的uifieldview 的正则表达式
#import "RegexKitLite.h"
#import "OnLoginRequestItem.h"

@implementation NormalRegistVC

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
  [self CreatNavBarWithTitle:@"普通用户注册"];

  //左侧label
  //用户名
  UILabel *nickname_Label = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, 80, 30)];
  nickname_Label.text = @"用  户  名：";
  nickname_Label.textAlignment = NSTextAlignmentLeft;
  nickname_Label.textColor = [Globle colorFromHexRGB:@"000000"];
  nickname_Label.font = [UIFont systemFontOfSize:15];
  nickname_Label.backgroundColor = [UIColor clearColor];
  [self.childView addSubview:nickname_Label];

  //密码
  UILabel *passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 120, 80, 30)];
  passwordLabel.text = @"密      码：";
  passwordLabel.textAlignment = NSTextAlignmentLeft;
  passwordLabel.textColor = [Globle colorFromHexRGB:@"000000"];
  passwordLabel.font = [UIFont systemFontOfSize:15];
  passwordLabel.backgroundColor = [UIColor clearColor];
  [self.childView addSubview:passwordLabel];

  //确认密码
  UILabel *confirmPasswordLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 170, 80, 30)];
  confirmPasswordLabel.textColor = [Globle colorFromHexRGB:@"000000"];
  confirmPasswordLabel.textAlignment = NSTextAlignmentLeft;
  confirmPasswordLabel.text = @"确认密码：";
  confirmPasswordLabel.backgroundColor = [UIColor clearColor];
  confirmPasswordLabel.font = [UIFont systemFontOfSize:15];
  [self.childView addSubview:confirmPasswordLabel];

  //邮箱
  UILabel *Email_Label = [[UILabel alloc] initWithFrame:CGRectMake(20, 220, 80, 30)];
  Email_Label.textColor = [Globle colorFromHexRGB:@"000000"];
  Email_Label.textAlignment = NSTextAlignmentLeft;
  Email_Label.text = @"邮      箱：";
  Email_Label.backgroundColor = [UIColor clearColor];
  Email_Label.font = [UIFont systemFontOfSize:15];
  [self.childView addSubview:Email_Label];

  // textview
  nickname_TextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 70, 200, 30)];
  [nickname_TextField setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
  nickname_TextField.placeholder = @"3-12位任意字符";               //默认显示的字
  nickname_TextField.font = [UIFont systemFontOfSize:16.0f];
  nickname_TextField.autocorrectionType = UITextAutocorrectionTypeNo;
  nickname_TextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
  nickname_TextField.returnKeyType = UIReturnKeyDone;
  nickname_TextField.keyboardType = UIKeyboardTypeEmailAddress;
  nickname_TextField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
  nickname_TextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
  nickname_TextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  nickname_TextField.delegate = self;
  [self.childView addSubview:nickname_TextField];

  passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 120, 200, 30)];
  [passwordTextField setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
  passwordTextField.placeholder = @"6-16位字母或数字";             //默认显示的字
  passwordTextField.font = [UIFont systemFontOfSize:16.0f];
  passwordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
  passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
  passwordTextField.returnKeyType = UIReturnKeyDone;
  passwordTextField.secureTextEntry = YES;
  passwordTextField.tag = 5000;
  passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
  //    passwordTextField.keyboardType=UIKeyboardTypeEmailAddress;
  passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
  passwordTextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
  passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  passwordTextField.delegate = self;
  [self.childView addSubview:passwordTextField];

  oncePassWordTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 170, 200, 30)];
  [oncePassWordTextField setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
  oncePassWordTextField.placeholder = @"请再次输入密码";        //默认显示的字
  oncePassWordTextField.font = [UIFont systemFontOfSize:16.0f];
  ;
  oncePassWordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
  oncePassWordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
  oncePassWordTextField.returnKeyType = UIReturnKeyDone;
  oncePassWordTextField.keyboardType = UIKeyboardTypeASCIICapable;
  //    oncePassWordTextField.keyboardType=UIKeyboardTypeEmailAddress;
  oncePassWordTextField.secureTextEntry = YES;
  oncePassWordTextField.tag = 6000;
  oncePassWordTextField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
  oncePassWordTextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
  oncePassWordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  oncePassWordTextField.delegate = self;
  [self.childView addSubview:oncePassWordTextField];

  Emaile_TextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 220, 200, 30)];
  [Emaile_TextField setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
  Emaile_TextField.placeholder = @"请输入常用邮箱";        //默认显示的字
  Emaile_TextField.font = [UIFont systemFontOfSize:16.0f];
  Emaile_TextField.autocorrectionType = UITextAutocorrectionTypeNo;
  Emaile_TextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
  Emaile_TextField.returnKeyType = UIReturnKeyDone;
  // Emaile_TextField.keyboardType=UIKeyboardTypeEmailAddress;
  Emaile_TextField.keyboardType = UIKeyboardTypeEmailAddress;
  Emaile_TextField.tag = 7000;
  Emaile_TextField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
  Emaile_TextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
  Emaile_TextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  Emaile_TextField.delegate = self;
  [self.childView addSubview:Emaile_TextField];

  //完成
  UIButton *finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
  finishButton.frame = CGRectMake(20, 270, 280, 34);
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

//注册按钮
- (void)finish:(UIButton *)sender {
  NSString *nickname = [FPYouguUtil ishave_blank:nickname_TextField.text];
  NSString *password = [FPYouguUtil ishave_blank:passwordTextField.text];
  HttpRequestCallBack *callback = [[HttpRequestCallBack alloc] init];
  __weak NormalRegistVC *weakSelf = self;
  callback.onSuccess = ^(NSObject *obj) {
    NormalRegistVC *strongSelf = weakSelf;
    if (strongSelf) {
      ///注册成功，以后登入账户
    }
  };
  [RegistrationRequestItem getRegisWithNickname:nickname
                                    andpassword:password
                                   withCallback:callback];
}
///注册成功，以后登入账户
- (void)loginSuccessUserAccount:(NSString *)nickname andPassword:(NSString *)password {
  HttpRequestCallBack *callback = [[HttpRequestCallBack alloc] init];
  __weak NormalRegistVC *weakSelf = self;
  callback.onSuccess = ^(NSObject *obj) {
    NormalRegistVC *strongSelf = weakSelf;
    if (strongSelf) {
      ///登录成功
      [FPYouguUtil OnLoginSuccess];
      [AppDelegate popToRootViewController:NO];
    }
  };
  [OnLoginRequestItem getOnLoginWithNickName:nickname andpassword:password withCallback:callback];
}

- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string {
  if (textField.tag == 5000 || textField.tag == 6000) {
    if ([string length] == 0) {
      return YES;
    } else {
      if ([textField.text length] + [string length] - range.length > 12) {
        return NO;
      } else {
        if ([string isMatchedByRegex:@"[a-zA-Z0-9_]"] == NO) {
          return NO;
        }
        return YES;
      }
    }
  }
  if (textField.tag == 7000) {
    if ([string length] == 0) {
      return YES;
    } else {
      if ([string isMatchedByRegex:@"[a-zA-Z0-9_.@]"] == NO) {
        return NO;
      }
      return YES;
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
