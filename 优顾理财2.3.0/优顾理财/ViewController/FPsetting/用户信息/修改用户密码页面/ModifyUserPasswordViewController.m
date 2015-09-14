
//
//  Modify_User_password_ViewController.m
//  优顾理财
//
//  Created by Mac on 14-9-3.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "ModifyUserPasswordViewController.h"
//自定义的uifieldview 的正则表达式
#import "RegexKitLite.h"
#import "OnLoginRequest.h"

@interface ModifyUserPasswordViewController () {
  //减少全局变量的个数，优化内存。合理命名变量名和方法名，增强代码的可读性和自说明能力
  UITextField* TextfieldForOldPassword;
  UITextField* textfieldForNewPassword;
  UITextField* textFieldForConfigingNewPassword;

  UserLoadingView* viewWhenLoading;
}
@end

@implementation ModifyUserPasswordViewController

- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}
#pragma mark - pv, 初始化
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [MobClick beginLogPageView:@"Change_password_view"];
  [[PV_view_sql sharedManager] PV_DB_DATA:@"Change_password_view"];
}
- (void)viewWillDisappear:(BOOL)animated {
  [MobClick endLogPageView:@"Change_password_view"];
  [super viewWillDisappear:animated];
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
  [textField resignFirstResponder];
  [self finish];
  return YES;
}

- (void)tappedBackGroundView {
  [TextfieldForOldPassword resignFirstResponder];
  [textfieldForNewPassword resignFirstResponder];
  [textFieldForConfigingNewPassword resignFirstResponder];
}

//????这个方法是做什么的
- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer
       shouldReceiveTouch:(UITouch*)touch {
  UIView* view = [touch view];

  if ([view isKindOfClass:[UIControl class]]) {
    return NO;
  }
  return YES;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.

  //在view上添加一个视图作为其他视图的父视图
  UIView* content_View = [[UIView alloc] initWithFrame:self.view.bounds];
  [self.view addSubview:content_View];

  //根据设备调整导航条
  if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
    UIView* viewForIOS7 =
        [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    viewForIOS7.backgroundColor = [UIColor blackColor];
    [self.view addSubview:viewForIOS7];

    content_View.frame =
        CGRectMake(0, 20, 320, self.view.frame.size.height - 20);
  }

  //给LXActionSheetView添加响应事件
  UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc]
      initWithTarget:self
              action:@selector(tappedBackGroundView)];
  tapGesture.delegate = self;
  [content_View addGestureRecognizer:tapGesture];

  TopNavView* topNavView =
      [[TopNavView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
  topNavView.mainLableString = @"修改用户密码";
  [topNavView setMainLableString:@"修改用户密码"];
  topNavView.delegate = self;
  [content_View addSubview:topNavView];

  //用户名
  UILabel* label0 = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 80, 30)];
  label0.text = @"用  户  名：";
  label0.textAlignment = NSTextAlignmentLeft;
  label0.textColor = [Globle colorFromHexRGB:@"000000"];
  label0.font = [UIFont systemFontOfSize:15];
  label0.backgroundColor = [UIColor clearColor];
  [content_View addSubview:label0];

  UILabel* labelForUserName =
      [[UILabel alloc] initWithFrame:CGRectMake(100, 60, 200, 30)];
  labelForUserName.text = [FPYouguUtil getUserName];
  labelForUserName.textAlignment = NSTextAlignmentLeft;
  labelForUserName.textColor = [Globle colorFromHexRGB:@"000000"];
  labelForUserName.font = [UIFont systemFontOfSize:15];
  labelForUserName.backgroundColor = [UIColor clearColor];
  [content_View addSubview:labelForUserName];

  //旧密码
  UILabel* label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 110, 80, 30)];
  label1.text = @"旧  密  码：";
  label1.textAlignment = NSTextAlignmentLeft;
  label1.textColor = [Globle colorFromHexRGB:@"000000"];
  label1.font = [UIFont systemFontOfSize:15];
  label1.backgroundColor = [UIColor clearColor];
  [content_View addSubview:label1];

  TextfieldForOldPassword =
      [[UITextField alloc] initWithFrame:CGRectMake(100, 110, 200, 30)];
  [TextfieldForOldPassword
      setBorderStyle:UITextBorderStyleRoundedRect];           //外框类型
  TextfieldForOldPassword.placeholder = @"6-16位字母或数字";  //默认显示的字
  TextfieldForOldPassword.font = [UIFont systemFontOfSize:16.0f];
  TextfieldForOldPassword.autocorrectionType = UITextAutocorrectionTypeNo;
  TextfieldForOldPassword.autocapitalizationType =
      UITextAutocapitalizationTypeNone;
  TextfieldForOldPassword.returnKeyType = UIReturnKeyDone;
  TextfieldForOldPassword.secureTextEntry = YES;
  TextfieldForOldPassword.tag = 5000;
  TextfieldForOldPassword.keyboardType = UIKeyboardTypeASCIICapable;
  TextfieldForOldPassword.clearButtonMode =
      UITextFieldViewModeWhileEditing;  //编辑时会出现个修改X
  TextfieldForOldPassword.contentHorizontalAlignment =
      UIControlContentHorizontalAlignmentCenter;
  TextfieldForOldPassword.contentVerticalAlignment =
      UIControlContentVerticalAlignmentCenter;
  TextfieldForOldPassword.delegate = self;
  [content_View addSubview:TextfieldForOldPassword];

  //新密码
  UILabel* label2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 160, 80, 30)];
  label2.text = @"新  密  码：";
  label2.textAlignment = NSTextAlignmentLeft;
  label2.textColor = [Globle colorFromHexRGB:@"000000"];
  label2.font = [UIFont systemFontOfSize:15];
  label2.backgroundColor = [UIColor clearColor];
  [content_View addSubview:label2];

  textfieldForNewPassword =
      [[UITextField alloc] initWithFrame:CGRectMake(100, 160, 200, 30)];
  [textfieldForNewPassword
      setBorderStyle:UITextBorderStyleRoundedRect];           //外框类型
  textfieldForNewPassword.placeholder = @"6-16位字母或数字";  //默认显示的字
  textfieldForNewPassword.font = [UIFont systemFontOfSize:16.0f];
  textfieldForNewPassword.autocorrectionType = UITextAutocorrectionTypeNo;
  textfieldForNewPassword.autocapitalizationType =
      UITextAutocapitalizationTypeNone;
  textfieldForNewPassword.returnKeyType = UIReturnKeyDone;
  textfieldForNewPassword.secureTextEntry = YES;
  textfieldForNewPassword.tag = 5000;
  textfieldForNewPassword.keyboardType = UIKeyboardTypeASCIICapable;
  textfieldForNewPassword.clearButtonMode =
      UITextFieldViewModeWhileEditing;  //编辑时会出现个修改X
  textfieldForNewPassword.contentHorizontalAlignment =
      UIControlContentHorizontalAlignmentCenter;
  textfieldForNewPassword.contentVerticalAlignment =
      UIControlContentVerticalAlignmentCenter;
  textfieldForNewPassword.delegate = self;
  [content_View addSubview:textfieldForNewPassword];

  //确认密码
  UILabel* label3 = [[UILabel alloc] initWithFrame:CGRectMake(20, 210, 80, 30)];
  label3.textColor = [Globle colorFromHexRGB:@"000000"];
  label3.textAlignment = NSTextAlignmentLeft;
  label3.text = @"确认密码：";
  label3.backgroundColor = [UIColor clearColor];
  label3.font = [UIFont systemFontOfSize:15];
  [content_View addSubview:label3];

  textFieldForConfigingNewPassword =
      [[UITextField alloc] initWithFrame:CGRectMake(100, 210, 200, 30)];
  [textFieldForConfigingNewPassword
      setBorderStyle:UITextBorderStyleRoundedRect];  //外框类型
  textFieldForConfigingNewPassword.placeholder =
      @"请再次输入密码";  //默认显示的字
  textFieldForConfigingNewPassword.font = [UIFont systemFontOfSize:16.0f];
  textFieldForConfigingNewPassword.autocorrectionType =
      UITextAutocorrectionTypeNo;
  textFieldForConfigingNewPassword.autocapitalizationType =
      UITextAutocapitalizationTypeNone;
  textFieldForConfigingNewPassword.returnKeyType = UIReturnKeyDone;
  textFieldForConfigingNewPassword.keyboardType = UIKeyboardTypeEmailAddress;
  textFieldForConfigingNewPassword.secureTextEntry = YES;
  textFieldForConfigingNewPassword.tag = 6000;
  textFieldForConfigingNewPassword.clearButtonMode =
      UITextFieldViewModeWhileEditing;  //编辑时会出现个修改X
  textFieldForConfigingNewPassword.contentHorizontalAlignment =
      UIControlContentHorizontalAlignmentCenter;
  textFieldForConfigingNewPassword.contentVerticalAlignment =
      UIControlContentVerticalAlignmentCenter;
  textFieldForConfigingNewPassword.delegate = self;
  [content_View addSubview:textFieldForConfigingNewPassword];

  UIButton* buttonForOK = [UIButton buttonWithType:UIButtonTypeCustom];
  buttonForOK.frame = CGRectMake(20, 260, 280, 34);
  buttonForOK.alpha = 0.8;
  buttonForOK.layer.cornerRadius = 5;
  buttonForOK.backgroundColor = [Globle colorFromHexRGB:@"f65f5b"];
  ;
  [buttonForOK setTitle:@"完成" forState:UIControlStateNormal];
  UIImage* highlightImage = [FPYouguUtil createImageWithColor:buttonHighLightColor];
  [buttonForOK setBackgroundImage:highlightImage
                         forState:UIControlStateHighlighted];
  [buttonForOK addTarget:self
                  action:@selector(finish)
        forControlEvents:UIControlEventTouchUpInside];
  [content_View addSubview:buttonForOK];

  //上传头像是，屏蔽界面
  viewWhenLoading = [[UserLoadingView alloc] initWithFrame:content_View.bounds];
  viewWhenLoading.hidden = YES;
  viewWhenLoading.alter_lable.text = @"正在修改";
  viewWhenLoading.userInteractionEnabled = YES;
  [content_View addSubview:viewWhenLoading];

  //夜间模式／白天模式
  self.view.backgroundColor = [UIColor colorWithRed:240 / 255.0f
                                              green:240 / 255.0f
                                               blue:240 / 255.0f
                                              alpha:1.0];
  label0.textColor = [Globle colorFromHexRGB:@"000000"];
  labelForUserName.textColor = [Globle colorFromHexRGB:@"000000"];
  label1.textColor = [Globle colorFromHexRGB:@"000000"];
  label2.textColor = [Globle colorFromHexRGB:@"000000"];
  label3.textColor = [Globle colorFromHexRGB:@"000000"];

  TextfieldForOldPassword.backgroundColor = [UIColor colorWithRed:246 / 255.0f
                                                            green:246 / 255.0f
                                                             blue:246 / 255.0f
                                                            alpha:1.0f];
  [[TextfieldForOldPassword layer]
      setBorderColor:[UIColor colorWithRed:213 / 255.0f
                                     green:213 / 255.0f
                                      blue:213 / 255.0f
                                     alpha:1.0f]
                         .CGColor];
  TextfieldForOldPassword.textColor = [UIColor blackColor];
  TextfieldForOldPassword.keyboardAppearance = UIKeyboardAppearanceDefault;

  textfieldForNewPassword.backgroundColor = [UIColor colorWithRed:246 / 255.0f
                                                            green:246 / 255.0f
                                                             blue:246 / 255.0f
                                                            alpha:1.0f];
  [[textfieldForNewPassword layer]
      setBorderColor:[UIColor colorWithRed:213 / 255.0f
                                     green:213 / 255.0f
                                      blue:213 / 255.0f
                                     alpha:1.0f]
                         .CGColor];
  textfieldForNewPassword.textColor = [UIColor blackColor];
  textfieldForNewPassword.keyboardAppearance = UIKeyboardAppearanceDefault;

  textFieldForConfigingNewPassword.backgroundColor =
      [UIColor colorWithRed:246 / 255.0f
                      green:246 / 255.0f
                       blue:246 / 255.0f
                      alpha:1.0f];
  [[textfieldForNewPassword layer]
      setBorderColor:[UIColor colorWithRed:213 / 255.0f
                                     green:213 / 255.0f
                                      blue:213 / 255.0f
                                     alpha:1.0f]
                         .CGColor];
  textFieldForConfigingNewPassword.textColor = [UIColor blackColor];
  textFieldForConfigingNewPassword.keyboardAppearance =
      UIKeyboardAppearanceDefault;
}

#pragma mark - NEWS_Nav_View 自定义导航条  按钮delegate 点击函数
- (void)leftButtonPress {
  [self.view endEditing:NO];
  [self.navigationController popViewControllerAnimated:YES];
  //    [self dismissModalViewControllerAnimated:YES];
}

- (void)finish {
  if ([TextfieldForOldPassword.text length] > 0 &&
      [textfieldForNewPassword.text length] >= 6 &&
      [textfieldForNewPassword.text
          isEqualToString:textFieldForConfigingNewPassword.text] &&
      ![TextfieldForOldPassword.text
          isEqualToString:textfieldForNewPassword.text]) {
    viewWhenLoading.hidden = NO;

    HttpRequestCallBack* callBack = [[HttpRequestCallBack alloc] init];
    __weak ModifyUserPasswordViewController* weakSelf = self;
    callBack.onCheckQuitOrStopProgressBar = ^{
      ModifyUserPasswordViewController* strongObj = weakSelf;
      if (strongObj) {
        viewWhenLoading.hidden = YES;
        return NO;
      } else {
        return YES;
      }
    };
    callBack.onSuccess = ^(NSObject* obj) {
      ModifyUserPasswordViewController* strongSelf = weakSelf;
      if (strongSelf) {
        //            提示语, 动画
        YouGu_animation_Did_Start(@"账户已过期，请重新登陆！");
        [AppDelegate popViewController:YES];
        [Login_ViewController loginAgainWithCallback:^(BOOL logonSuccess){
        }];
      }
    };
    [OldpwdToNewpwd
        getOldpwdToNewpwdWithOldpwd:TextfieldForOldPassword.text
                          andNewpwd:textfieldForNewPassword.text
                      AndConfirmpwd:textFieldForConfigingNewPassword.text
                       WithcallBack:callBack];
  } else {
    if ([TextfieldForOldPassword.text length] == 0) {
      YouGu_animation_Did_Start(@"旧密码不可以为空");
    } else if ([TextfieldForOldPassword.text length] < 6) {
      YouGu_animation_Did_Start(@"旧密码不少于6个字符");
    } else if ([TextfieldForOldPassword.text length] > 16) {
      YouGu_animation_Did_Start(@"旧密码不能多于16个字符");
    }
    if ([textfieldForNewPassword.text length] == 0) {
      YouGu_animation_Did_Start(@"新密码不可以为空");
    } else if ([textfieldForNewPassword.text length] < 6) {
      YouGu_animation_Did_Start(@"新密码不少于6个字符");
    } else if ([textfieldForNewPassword.text length] > 16) {
      YouGu_animation_Did_Start(@"新密码不能多于16个字符");
    }
    if ([TextfieldForOldPassword.text
            isEqualToString:textfieldForNewPassword.text]) {
      YouGu_animation_Did_Start(@"输" @"入"
                                       @"的新密码与旧密码一致，请重新输入");
      textfieldForNewPassword.text = @"";
      textFieldForConfigingNewPassword.text = @"";
    }
    if ([textfieldForNewPassword.text
            isEqualToString:textFieldForConfigingNewPassword.text] == NO) {
      YouGu_animation_Did_Start(@"新密码与确认密码不一致");
    }
  }
}

- (BOOL)textField:(UITextField*)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString*)string {
  //最大字符数
  //    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage];

  if (textField.tag == 5000 || textField.tag == 6000) {
    if ([string length] == 0) {
      return YES;
    } else {
      if ([textField.text length] + [string length] - range.length > 16) {
        return NO;
      } else {
        if ([string isMatchedByRegex:@"[a-zA-Z0-9_]"] == NO) {
          return NO;
        }
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
