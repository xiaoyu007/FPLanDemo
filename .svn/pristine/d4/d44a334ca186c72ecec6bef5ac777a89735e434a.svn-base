//
//  RetrieveLoginViewController.m
//  优顾理财
//
//  Created by jhss on 15-5-12.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPRetrieveLoginViewController.h"
//自定义的uifieldview 的正则表达式
#import "RegexKitLite.h"
#import "OnLoginRequest.h"

@interface FPRetrieveLoginViewController () <UITextFieldDelegate>

@end

@implementation FPRetrieveLoginViewController {
  /**   用户名*/
  IBOutlet UILabel *userNameLabel;
  /** 旧密码背景 */
  __weak IBOutlet UIView *oldPasswordView;
  /**   用户旧密码*/
  IBOutlet UITextField *oldPassword;
  /** 新密码背景 */
  __weak IBOutlet UIView *newPasswordView;
  /**   用户新密码*/
  IBOutlet UITextField *newPassword;
  /** 确认密码背景 */
  __weak IBOutlet UIView *affirmNewPasswordView;
  /**   确认密码*/
  IBOutlet UITextField *affirmNewPassword;
  /**   完成按钮*/
  IBOutlet UIButton *finishBtn;
  /**  返回导航按钮*/
  IBOutlet UIButton *navBtn;
  //    正在加载中
  UserLoadingView *loading;

  IBOutlet UIView *backView;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  //  [self CreatNavBarWithTitle:@"修改用户密码"];
  self.childView.userInteractionEnabled = NO;
  userNameLabel.text = [FPYouguUtil getUserName];

  oldPassword.autocapitalizationType = UITextAutocapitalizationTypeNone;
  [oldPasswordView.layer setBorderWidth:0.5f];
  [oldPasswordView.layer setBorderColor:[Globle colorFromHexRGB:textfieldBordColor].CGColor];
  [oldPasswordView.layer setMasksToBounds:YES];
  [oldPasswordView.layer setCornerRadius:2.5f];
//  oldPassword.autocorrectionType = UITextAutocorrectionTypeNo;
  oldPassword.returnKeyType = UIReturnKeyDone;
  oldPassword.keyboardType = UIKeyboardTypeEmailAddress;
  oldPassword.secureTextEntry = YES;
  oldPassword.keyboardType = UIKeyboardTypeASCIICapable;
  oldPassword.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
  oldPassword.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
  oldPassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

  oldPassword.delegate = self;
  oldPassword.tag = 5000;

  newPassword.autocapitalizationType = UITextAutocapitalizationTypeNone;
  newPassword.autocorrectionType = UITextAutocorrectionTypeNo;
  [newPasswordView.layer setBorderWidth:0.5f];
  [newPasswordView.layer setBorderColor:[Globle colorFromHexRGB:textfieldBordColor].CGColor];
  [newPasswordView.layer setMasksToBounds:YES];
  [newPasswordView.layer setCornerRadius:2.5f];
  newPassword.returnKeyType = UIReturnKeyDone;
  newPassword.secureTextEntry = YES;
  newPassword.keyboardType = UIKeyboardTypeASCIICapable;
  newPassword.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
  newPassword.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
  newPassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

  newPassword.delegate = self;
  newPassword.tag = 5000;

  affirmNewPassword.autocapitalizationType = UITextAutocapitalizationTypeNone;
  [affirmNewPasswordView.layer setBorderWidth:0.5f];
  [affirmNewPasswordView.layer setBorderColor:[Globle colorFromHexRGB:textfieldBordColor].CGColor];
  [affirmNewPasswordView.layer setMasksToBounds:YES];
  [affirmNewPasswordView.layer setCornerRadius:2.5f];
  affirmNewPassword.autocorrectionType = UITextAutocorrectionTypeNo;
  affirmNewPassword.returnKeyType = UIReturnKeyDone;
  affirmNewPassword.secureTextEntry = YES;
  affirmNewPassword.keyboardType = UIKeyboardTypeASCIICapable;
  affirmNewPassword.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
  affirmNewPassword.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
  affirmNewPassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

  affirmNewPassword.delegate = self;
  affirmNewPassword.tag = 6000;

  [navBtn setImage:[UIImage imageNamed:@"返回小箭头.png"] forState:UIControlStateNormal];
  [navBtn setImage:[UIImage imageNamed:@"返回小箭头.png"] forState:UIControlStateHighlighted];
  navBtn.imageEdgeInsets = UIEdgeInsetsMake(15, 20, 15, 20);
  UIImage *highlightImage = [FPYouguUtil createImageWithColor:btnAccordingToTheNormal];
  [navBtn setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
  [navBtn addTarget:self action:@selector(navBtn) forControlEvents:UIControlEventTouchUpInside];

  [finishBtn addTarget:self
                action:@selector(finishBtn)
      forControlEvents:UIControlEventTouchUpInside];
  [finishBtn setBackgroundImage:highlightImage forState:UIControlStateHighlighted];

  loading = [[UserLoadingView alloc] initWithFrame:self.view.bounds];
  loading.hidden = YES;
  loading.alter_lable.text = @"正在修改";
  loading.userInteractionEnabled = YES;
  [self.view addSubview:loading];
}
#pragma mark - loading 代理方法
- (void)refreshNewInfo {
}
- (void)InfoManagementBtnClick {
  NoNetWorkViewController *defautVC = [[NoNetWorkViewController alloc] init];
  [AppDelegate pushViewControllerFromRight:defautVC];
}
- (void)navBtn {
  [self.navigationController popViewControllerAnimated:YES];
}
- (void)finishBtn {
   if ([oldPassword.text length] == 0) {
    YouGu_animation_Did_Start(@"当前密码不可以为空");
    return;

  } else if ([oldPassword.text length] < 6) {
    YouGu_animation_Did_Start(@"密码由6-16位字母或数字组成，请重新输入");
    return;

  } else if ([oldPassword.text length] > 16) {
    YouGu_animation_Did_Start(@"当前密码不能多于16个字符");
    return;
  }
  if ([newPassword.text length] == 0) {
    YouGu_animation_Did_Start(@"新密码不可以为空");
    return;
  } else if ([newPassword.text length] < 6) {
    YouGu_animation_Did_Start(@"密码由6-16位字母或数字组成，请重新输入");
    return;

  } else if ([newPassword.text length] > 16) {
    YouGu_animation_Did_Start(@"新密码不能多于16个字符");
    return;
  }

  if ([affirmNewPassword.text isEqualToString:newPassword.text] == NO) {
    YouGu_animation_Did_Start(@"两次输入的密码不一致，请重新输入");
    return;
  }
  if ([oldPassword.text isEqualToString:newPassword.text] == YES) {
    YouGu_animation_Did_Start(@"新密码与当前密码不能一致");
    affirmNewPassword.text = @"";
    newPassword.text = @"";
    return;
  }

  HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
  __weak FPRetrieveLoginViewController *weakSelf = self;
  callBack.onCheckQuitOrStopProgressBar = ^{
    FPRetrieveLoginViewController *strongObj = weakSelf;
    if (strongObj) {
      loading.hidden = YES;
      return NO;
    } else {
      return YES;
    }
  };
  callBack.onSuccess = ^(NSObject *obj) {
    FPRetrieveLoginViewController *strongSelf = weakSelf;
    if (strongSelf) {
      //提示语, 动画
      YouGu_animation_Did_Start(@"用户密码修改成功");
      
      [AppDelegate popViewController:YES];

    }
  };
  callBack.onError = ^(BaseRequestObject *obj, NSException *exc){
    if (obj.status&&[obj.status isEqualToString:@"1003"]) {
      [NewShowLabel setMessageContent:@"当前密码输入不正确，请重新输入"];
    }else{
      [BaseRequester defaultErrorHandler](obj, exc);
    }
  };
  [OldpwdToNewpwd getOldpwdToNewpwdWithOldpwd:oldPassword.text
                                    andNewpwd:newPassword.text
                                AndConfirmpwd:affirmNewPassword.text
                                 WithcallBack:callBack];
}
/** 弹出登录界面 */
- (void)changeToLoginPage{
  [Login_ViewController checkLoginStatusWithCallback:^(BOOL logonSuccess){
  }];
}
#pragma mark--textFieldDelegate
- (void)animationTextField {
  [affirmNewPassword resignFirstResponder];
  [UIView beginAnimations:nil context:nil];                 //设置一个动画
  [UIView setAnimationDuration:0.3];                        //设置持续的时间
  [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut]; //设置动画
  backView.frame = CGRectMake(0, 71, windowWidth, windowHeight);
  [UIView commitAnimations]; //提交动画
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [affirmNewPassword resignFirstResponder];
  [newPassword resignFirstResponder];
  [oldPassword resignFirstResponder];
  [self animationTextField];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
  if (windowHeight < 568) {
    [UIView beginAnimations:nil context:nil];                 //设置一个动画
    [UIView setAnimationDuration:0.3];                        //设置持续的时间
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut]; //设置动画
    backView.frame = CGRectMake(0, -10, windowWidth, windowHeight);
    [UIView commitAnimations]; //提交动画
  }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  [self animationTextField];
  return YES;
}
- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string {
  //最大字符数
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
