//
//  GesturePasswordController.m
//  GesturePassword
//
//  Created by hb on 14-8-23.
//  Copyright (c) 2014年 黑と白の印记. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "FPGesturePasswordController.h"

#import "KeychainItemWrapper/KeychainItemWrapper.h"

#define passwordErrMaxNum 5

@interface FPGesturePasswordController ()

@property(nonatomic, strong) FPGesturePasswordView *gesturePasswordView;

@end

@implementation FPGesturePasswordController {
  NSString *previousString;
  NSString *password;
}

@synthesize gesturePasswordView;

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}
- (id)initWithCallback:(CertificationSuccess)callback {
  self = [super init];
  if (self) {
    currentCallback = callback;
  }
  return self;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  previousString = [NSString string];
  KeychainItemWrapper *keychin =
      [[KeychainItemWrapper alloc] initWithIdentifier:@"YouGuuGesture"
                                          accessGroup:nil];
  password = [keychin objectForKey:(__bridge id)kSecValueData];
  if (self.pageType == GesturePasswordPageTypeChangePasswod) { //修改密码
    if ([password isEqualToString:@""]) {
      //(还未设置过密码)
    } else {
      //验证过程
      [self change];
    }
  } else {
    //设置密码
    if ([password isEqualToString:@""] ||
        self.pageType == GesturePasswordPageTypeFtSetting) {
      //重置过程
      [self reset];
    } else {
      if (self.pageType == GesturePasswordPageTypeRevokePassword) {
        //撤销
        [self revokeGesturePassword];
      } else {
        //验证过程
        [self verify];
      }
    }
  }
  [self createNavigationBar];
}
/** 创建导航栏 */
- (void)createNavigationBar {
  gesNavBar = [[[NSBundle mainBundle] loadNibNamed:@"FPGestureNavigationBar"
                                             owner:self
                                           options:nil] firstObject];
  [self.view addSubview:gesNavBar];
  gesNavBar.origin = CGPointMake(0, statusBarHeight);
  [gesNavBar.backButton addTarget:self
                           action:@selector(goBack)
                 forControlEvents:UIControlEventTouchUpInside];
  //标题
  if (self.pageType == GesturePasswordPageTypeFtSetting ||
      self.pageType == GesturePasswordPageTypeSeSetting) {
    gesNavBar.pageTitleLabel.text = @"设置手势密码";
  } else if (self.pageType == GesturePasswordPageTypeChangePasswod) {
    gesNavBar.pageTitleLabel.text = @"验证手势密码";
  } else if (self.pageType == GesturePasswordPageTypeLogonVer) {
    gesNavBar.hidden = YES;
  }else if (self.pageType == GesturePasswordPageTypeRevokePassword){
    gesNavBar.pageTitleLabel.text = @"关闭手势密码";
  }
}
/** 返回上一界面 */
- (void)goBack {
  [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 验证手势密码
- (void)revokeGesturePassword {
  gesturePasswordView = [[FPGesturePasswordView alloc]
      initWithFrame:[UIScreen mainScreen].bounds
       withPageType:GesturePasswordPageTypeRevokePassword];
  [gesturePasswordView.tentacleView setRerificationDelegate:self];
  [gesturePasswordView.tentacleView
      setStyle:GesturePasswordPageTypeVerPassword];
  [gesturePasswordView setGesturePasswordDelegate:self];
  [self.view addSubview:gesturePasswordView];
}
- (void)verify {
  gesturePasswordView = [[FPGesturePasswordView alloc]
      initWithFrame:[UIScreen mainScreen].bounds
       withPageType:GesturePasswordPageTypeVerPassword];
  [gesturePasswordView.tentacleView setRerificationDelegate:self];
  [gesturePasswordView.tentacleView
      setStyle:GesturePasswordPageTypeVerPassword];
  [gesturePasswordView setGesturePasswordDelegate:self];
  [self.view addSubview:gesturePasswordView];
}

#pragma mark - 重置手势密码
- (void)reset {
  gesturePasswordView = [[FPGesturePasswordView alloc]
      initWithFrame:[UIScreen mainScreen].bounds
       withPageType:GesturePasswordPageTypeFtSetting];
  [gesturePasswordView.tentacleView setResetDelegate:self];
  [gesturePasswordView.tentacleView setStyle:GesturePasswordPageTypeFtSetting];
  [gesturePasswordView setGesturePasswordDelegate:self];
  [gesturePasswordView.forgetButton setHidden:YES];
  [gesturePasswordView.changeButton setHidden:YES];
  [self.view addSubview:gesturePasswordView];
}

#pragma mark - 判断是否已存在手势密码
- (BOOL)exist {
  KeychainItemWrapper *keychin =
      [[KeychainItemWrapper alloc] initWithIdentifier:@"YouGuuGesture"
                                          accessGroup:nil];
  password = [keychin objectForKey:(__bridge id)kSecValueData];
  if ([password isEqualToString:@""])
    return NO;
  return YES;
}

#pragma mark - 清空记录
- (void)clear {
  KeychainItemWrapper *keychin =
      [[KeychainItemWrapper alloc] initWithIdentifier:@"YouGuuGesture"
                                          accessGroup:nil];
  [keychin resetKeychainItem];
}

#pragma mark - 改变手势密码
- (void)change {
  gesturePasswordView = [[FPGesturePasswordView alloc]
      initWithFrame:[UIScreen mainScreen].bounds
       withPageType:GesturePasswordPageTypeChangePasswod];
  [gesturePasswordView.tentacleView setRerificationDelegate:self];
  [gesturePasswordView.tentacleView
      setStyle:GesturePasswordPageTypeChangePasswod];
  [gesturePasswordView setGesturePasswordDelegate:self];
  [self.view addSubview:gesturePasswordView];
}

#pragma mark - 忘记手势密码
- (void)forget {
  gesturePasswordView = [[FPGesturePasswordView alloc]
      initWithFrame:[UIScreen mainScreen].bounds
       withPageType:GesturePasswordPageTypeVerPassword];
  [gesturePasswordView.tentacleView setRerificationDelegate:self];
  [gesturePasswordView.tentacleView
      setStyle:GesturePasswordPageTypeVerPassword];
  [gesturePasswordView setGesturePasswordDelegate:self];
  [self.view addSubview:gesturePasswordView];
}

- (BOOL)verification:(NSString *)result {
  if ([result isEqualToString:password]) {
    [gesturePasswordView.state
        setTextColor:[UIColor colorWithRed:0.f
                                     green:225.0f / 255.0f
                                      blue:205.0f / 255.0f
                                     alpha:1.f]];
    [gesturePasswordView.state setText:@"登录成功"];
    [self resetFailNum];
    [self dismissViewControllerAnimated:YES completion:nil];
    //修改密码
    if (self.pageType == GesturePasswordPageTypeRevokePassword ||
        self.pageType == GesturePasswordPageTypeChangePasswod) {
      //清除记录
      currentCallback(YES);
      if (self.pageType == GesturePasswordPageTypeRevokePassword) {
        [self releasePageView];
      }
    }
    return YES;
  }
  if ([result length] < 1) {
    return NO;
  }
  [gesturePasswordView.tentacleView enterArgin];
  [gesturePasswordView.state setTextColor:[UIColor colorWithRed:1.0f
                                                          green:83.0f / 255.0f
                                                           blue:83.0f / 255.0f
                                                          alpha:1.f]];
  [self gestuerPasswodError];
  return NO;
}
/** 手势密码错误逻辑 */
- (void)gestuerPasswodError {
  NSUserDefaults *myUser = [NSUserDefaults standardUserDefaults];
  NSInteger errNum = [myUser integerForKey:@"passwordErrorNum"];
  if (errNum) {
    errNum++;
    //是否超过了错误次数
    if (errNum >= passwordErrMaxNum) {
      UIAlertView *alertView = [[UIAlertView alloc]
              initWithTitle:@"手势密码已失效"
                    message:@"请"
                    @"重新登录优顾理财，登录后可在我的"
                    @"-账户中心-密码管理中管理手势。"
                   delegate:self
          cancelButtonTitle:@"重新登录"
          otherButtonTitles:nil];
      [alertView show];
      return;
    }
  } else {
    //首次错误
    errNum = 1;
  }
  [myUser setInteger:errNum forKey:@"passwordErrorNum"];
  [myUser synchronize];
  [gesturePasswordView.state
      setText:[NSString
                  stringWithFormat:@"密码错了，还可以输入%ld次",
              (long)(passwordErrMaxNum - errNum)]];
}
- (void)alertView:(UIAlertView *)alertView
    clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (buttonIndex == 0) {
    //首页登录手势密码
    [self dismissViewControllerAnimated:YES completion:^{
      if (self.pageType == GesturePasswordPageTypeLogonVer) {
      } else {
        if (currentCallback) {
          currentCallback(NO);
        }
      }
    }];
    [FPYouguUtil clearOutLogin];
    //跳转登录页(登录成功，密码管理关闭)
    [Login_ViewController loginAgainWithCallback:^(BOOL logonSuccess) {
      if (logonSuccess) {
        //清除错误次数数据
        [[NSUserDefaults standardUserDefaults] setInteger:0
                                                   forKey:@"passwordErrorNum"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        //清除记录
        KeychainItemWrapper *keychin =
        [[KeychainItemWrapper alloc] initWithIdentifier:@"YouGuuGesture"
                                            accessGroup:nil];
        [keychin resetKeychainItem];
        // switch
        [SimuControl saveObjectWithObject:@"" withKey:@"userGesturePassword"];
//        [NSNotificationCenter defaultCenter]
      }
    }];
  }
}
/** 重置错误次数 */
- (void)resetFailNum {
  //清除错误次数数据
  [[NSUserDefaults standardUserDefaults] setInteger:0
                                             forKey:@"passwordErrorNum"];
  [[NSUserDefaults standardUserDefaults] synchronize];
}
- (BOOL)resetPassword:(NSString *)result {
  if ([previousString isEqualToString:@""]) {
    [gesturePasswordView.tentacleView enterArgin];
    if (_pageType == GesturePasswordPageTypeChangePasswod||_pageType == GesturePasswordPageTypeFtSetting) {
      if ([result length] < 4) {
        [gesturePasswordView.state
         setTextColor:[UIColor colorWithRed:1.0f
                                      green:83.0f / 255.0f
                                       blue:83.0f / 255.0f
                                      alpha:1.f]];
        [gesturePasswordView.state setText:@"最少连接4个点，请重新输入"];
        [gesturePasswordView resetSmallPassword];
        return NO;
      }
    }
    previousString = result;
    [gesturePasswordView.state setTextColor:[UIColor colorWithRed:0.f
                                                            green:225.0f / 255.f
                                                             blue:205.0f / 255.f
                                                            alpha:1.f]];
    [gesturePasswordView.state setText:@"再次绘制解锁图案"];
    gesturePasswordView.currentPageType = GesturePasswordPageTypeSeSetting;
    return YES;
  } else {
    if ([result isEqualToString:previousString]) {
      KeychainItemWrapper *keychin =
          [[KeychainItemWrapper alloc] initWithIdentifier:@"YouGuuGesture"
                                              accessGroup:nil];
      [keychin setObject:@"<帐号>" forKey:(__bridge id)kSecAttrAccount];
      [keychin setObject:result forKey:(__bridge id)kSecValueData];
      //保存手势密码
      [SimuControl saveObjectWithObject:result withKey:@"userGesturePassword"];
      [gesturePasswordView.state
          setTextColor:[UIColor colorWithRed:0.f
                                       green:226.0f / 255.f
                                        blue:205.0f / 255.f
                                       alpha:1.f]];
      //完全释放时才呈现
      [self dismissViewControllerAnimated:YES completion:^{
      }];
      [self presentSettingPage];
      return YES;
    } else {
      [gesturePasswordView.tentacleView inputContentFailed];
      [gesturePasswordView.state
          setTextColor:[UIColor colorWithRed:1.0f
                                       green:83.0f / 255.0f
                                        blue:83.0f / 255.0f
                                       alpha:1.f]];
      [gesturePasswordView.state
          setText:@"与" @"上" @"次绘制不一致，请重新绘制"];
      return NO;
    }
  }
}
/**
 *  iOS6延时呈现
 */
- (void)presentSettingPage{
  if (currentCallback) {
    currentCallback(YES);
  }
}
- (void)resetState {
  previousString = @"";
}
/** 释放界面 */
- (void)releaseViewController {
  if (self.pageType == GesturePasswordPageTypeLogonVer) {
    //只清理信息
    [FPYouguUtil clearOutLogin];
  }else if(self.pageType == GesturePasswordPageTypeVerPassword){
    NSLog(@"修改手势密码");
  }
  //首页登录手势密码
  [self dismissViewControllerAnimated:YES completion:nil];
  [AppDelegate addAlertView];
//  [[NSNotificationCenter defaultCenter]postNotificationName:@"logoutAccount" object:nil];
}
- (void)releasePageView {
  //清除记录
  [self clear];
  // switch
  [SimuControl saveObjectWithObject:@"" withKey:@"userGesturePassword"];
}

@end
