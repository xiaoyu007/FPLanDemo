//
//  PasswordManageViewController.m
//  优顾理财
//
//  Created by jhss on 15-4-13.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPPasswordManageViewController.h"

#import "FPRevampTradeViewController.h"
#import "FPRetrieveLoginViewController.h"
#import "FPRetrieveTradePwViewController.h"
#import "FPGesturePasswordController.h"
#import "KeychainItemWrapper.h"
#import "FPOpenAccountInfo.h"

@interface FPPasswordManageViewController ()
//返回上一界面
- (IBAction)navBtn:(id)sender;
//修改登陆密码
- (IBAction)lognPasswordBtn:(id)sender;

//修改手势密码
- (IBAction)alterHandPasswordBtn:(id)sender;
//手势密码打开与否
- (IBAction)handPasswordChange:(id)sender;

@property(weak, nonatomic) IBOutlet UISwitch *handSwitch;

@end

@implementation FPPasswordManageViewController {
  ///返回导航按钮
  IBOutlet UIButton *navBtn;
  ///修改登陆密码
  IBOutlet UIButton *logPasswordBtn;
  ///修改交易密码
  IBOutlet UIButton *tradePasswordBtn;
  ///找回交易密码
  IBOutlet UIButton *findTradePasswordBtn;
  ///修改手势密码
  IBOutlet UIButton *handPasswordBtn;
  /** 手势密码块背景 */
  __weak IBOutlet UIView *gesPasswordSetView;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  self.childView.userInteractionEnabled = NO;
  self.handSwitch.onTintColor =
      [UIColor colorWithRed:0.22f green:0.74f blue:0.92f alpha:1.00f];
  //保存手势密码
  if ([self isExistGesPasswordAndLogined]) {
    _handSwitch.on = YES;
    gesPasswordSetView.height = 98.0f;
  } else {
    _handSwitch.on = NO;
    gesPasswordSetView.height = 49.0f;
  }

  [navBtn setImage:[UIImage imageNamed:@"返回小箭头.png"]
          forState:UIControlStateNormal];
  [navBtn setImage:[UIImage imageNamed:@"返回小箭头.png"]
          forState:UIControlStateHighlighted];
  navBtn.imageEdgeInsets = UIEdgeInsetsMake(15, 20, 15, 20);
  UIImage *highlightImage =
      [FPYouguUtil createImageWithColor:btnAccordingToTheNormal];
  [navBtn setBackgroundImage:highlightImage forState:UIControlStateHighlighted];

  [logPasswordBtn setBackgroundImage:highlightImage
                            forState:UIControlStateHighlighted];
  //交易密码
  [tradePasswordBtn setBackgroundImage:highlightImage
                              forState:UIControlStateHighlighted];
  [tradePasswordBtn addTarget:self action:@selector(tradePasswordBtnClick) forControlEvents:UIControlEventTouchUpInside];
  
  //找回交易密码
  [findTradePasswordBtn setBackgroundImage:highlightImage
                                  forState:UIControlStateHighlighted];
  [findTradePasswordBtn addTarget:self action:@selector(findTradePasswordBtnClick) forControlEvents:UIControlEventTouchUpInside];
  
  [handPasswordBtn setBackgroundImage:highlightImage
                             forState:UIControlStateHighlighted];
  self.handSwitch.onTintColor =
      [UIColor colorWithRed:0.22f green:0.74f blue:0.92f alpha:1.00f];
}
//返回上一个界面
- (IBAction)navBtn:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
}

//修改登陆密码
- (IBAction)lognPasswordBtn:(id)sender {
    [Login_ViewController checkLoginStatusWithCallback:^(BOOL logonSuccess) {
    if (logonSuccess) {
      FPRetrieveLoginViewController *retriveLogin =
          [[FPRetrieveLoginViewController alloc] init];
      [AppDelegate pushViewControllerFromRight:retriveLogin];
    }
  }];
}
//修改交易密码
-(void)tradePasswordBtnClick {
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  [Login_ViewController checkLoginStatusWithCallback:^(BOOL logonSuccess) {
    if (logonSuccess) {
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(goToMyRevampTradeView) name:@"go_to_My_RevampTradeView" object:nil];
      [[FPOpenAccountInfo shareInstance]openAccountStatusJudgementWithFromPage:OpenAccountSwitchTypeChangeTradePassword];
      
      
    }
  }];
}
///修改交易密码
-(void)goToMyRevampTradeView{

  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  FPRevampTradeViewController *revTVC =
  [[FPRevampTradeViewController alloc] init];
  [AppDelegate pushViewControllerFromRight:revTVC];
}


//找回交易密码
- (void)findTradePasswordBtnClick{
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  [Login_ViewController checkLoginStatusWithCallback:^(BOOL logonSuccess) {
    if (logonSuccess) {
      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(goToRetrieveTradePwView) name:@"find_trade_pass_word" object:nil];
      [[FPOpenAccountInfo shareInstance]openAccountStatusJudgementWithFromPage:OpenAccountSwitchTypeFindTradePassword];
      
    }
  }];
}
///找回交易密码
-(void)goToRetrieveTradePwView{
  FPRetrieveTradePwViewController *retrive =
  [[FPRetrieveTradePwViewController alloc] init];
  [AppDelegate pushViewControllerFromRight:retrive];
}
-(void)dealloc{
  [[NSNotificationCenter defaultCenter]removeObserver:self];
}
/** 手势密码是否存在 */
- (BOOL)isExistGesPasswordAndLogined{
  NSString *gesKey = [NSString stringWithFormat:@"YouGuuGesture"];
  KeychainItemWrapper *keychin =
  [[KeychainItemWrapper alloc] initWithIdentifier:gesKey
                                      accessGroup:nil];
  NSString *password = [keychin objectForKey:(__bridge id)kSecValueData];
  if (password && [password length] > 0) {
    return YES;
  }else{
    return NO;
  }
}
//修改手势密码
- (IBAction)alterHandPasswordBtn:(id)sender {
  [Login_ViewController checkLoginStatusWithCallback:^(BOOL logonSuccess) {
    if (logonSuccess) {
      if ([self isExistGesPasswordAndLogined]) {
        FPGesturePasswordController *pass = [[FPGesturePasswordController alloc]
            initWithCallback:^(BOOL isSuccess) {
              if (isSuccess) {
                //重设密码
                [self performSelector:@selector(changePage) withObject:nil afterDelay:0.6f];
              }else{
                //关闭switch
                _handSwitch.on = NO;
                gesPasswordSetView.height = 49.0f;
              }
            }];
        pass.pageType = GesturePasswordPageTypeChangePasswod;
        [self presentViewController:pass
                           animated:YES
                         completion:nil];
      } else {
        YouGu_animation_Did_Start(@"还未设置手势密码");
      }
    }
  }];
}
- (void)changePage{
  FPGesturePasswordController *pass =
  [[FPGesturePasswordController alloc] init];
  pass.pageType = GesturePasswordPageTypeFtSetting;
  
  [self presentViewController:pass animated:YES completion:nil];
}
//手势密码打开与否
- (IBAction)handPasswordChange:(UISwitch *)sender {
  [Login_ViewController checkLoginStatusWithCallback:^(BOOL logonSuccess) {
    if (logonSuccess) {
      if (sender.on) {
        sender.on = NO;
        gesPasswordSetView.height = 49.0f;
        FPGesturePasswordController *pass =
            [[FPGesturePasswordController alloc] initWithCallback:^(BOOL isSuccess) {
              if (isSuccess) {
                sender.on = YES;
                gesPasswordSetView.height = 98.0f;
              }
            }];
        pass.pageType = GesturePasswordPageTypeFtSetting;
        [self presentViewController:pass
                           animated:YES
                         completion:^{
                         }];
      } else {
        sender.on = YES;
        FPGesturePasswordController *pass = [[FPGesturePasswordController alloc]
            initWithCallback:^(BOOL isSuccess) {
              if (isSuccess) {
                sender.on = NO;
                gesPasswordSetView.height = 49.0f;
              }
            }];
        pass.pageType = GesturePasswordPageTypeRevokePassword;
        [self presentViewController:pass
                           animated:YES
                         completion:^{
                         }];
      }
    }
  }];
}

@end
