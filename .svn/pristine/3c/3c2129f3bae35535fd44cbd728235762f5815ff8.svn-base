//
//  AppDelegate.m
//  优顾理财
//
//  Created by Mac on 14-2-19.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"

#import "AutoRegistrationSimple.h"
//  从新进入app，自动刷新
#import "Enter_App_Refresh.h"
#import "my_ViewController.h"
//提示动画
#import "BPush.h"
#import "BaiDuPush.h"
#import "OnLoginRequest.h"
#import <AudioToolbox/AudioToolbox.h>
#import "ALLChannelData.h"
#import "OffDownloadObject.h"
#import "UIViewController+RecursiveDescription.h"

static BOOL internetActive = YES;
static NetworkStatus hostReachState=NotReachable;

@implementation AppDelegate {
  NSTimer *timer;
}

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [FPYouguUtil isPushAnimtion:YES];
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  [application setStatusBarStyle:UIStatusBarStyleLightContent];
  self.window.backgroundColor = [UIColor whiteColor];
  [self.window makeKeyAndVisible];
  
  if (isIos7Version==1) {
    [[UITextField appearance]setTintColor:[Globle colorFromHexRGB:@"84929e"]];
    [[UITextView appearance]setTintColor:[Globle colorFromHexRGB:@"84929e"]];
  }
 
  
  //创建文件夹
  YouGu_NSFileManager_Path(@"com.xmly");
  YouGu_NSFileManager_Path(@"Collection.xmly");
  YouGu_NSFileManager_Path(@"ALL_images_thing.xmly");
  // pv，日志文件夹
  YouGu_NSFileManager_Path(@"Logo_PIC.xmly");

  //友盟统计
  [self umengTrack];
  // share_SDK的初始化
  [self Creat_SDK_share];
  //离线下载
  [OffDownloadObject offDownload];

  if (YouGu_defaults(@"YouGu_adfv") == nil) {
    HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
    callBack.onSuccess = ^(NSObject *obj) {
      YouGu_defaults_double(@"1", @"YouGu_adfv");
      NSLog(@"首次激活通知后台:%@", ((ActivateNotify *)obj).message);
    };
    callBack.onError = ^(BaseRequestObject *err, NSException *ex) {
    };
    callBack.onFailed = ^{
    };
    [ActivateNotify getActivateNotifyWithcallBack:callBack];
  }
  if (YouGu_defaults(@"first_enter_app") == nil) {
    YouGu_defaults_double(@YES, @"first_enter_app");
    // 默认字体字号
    YouGu_defaults_double(@"18", @"font_text_webview");
  } else {
    // 进入新闻首页后，推送信息，正常恢复
    YouGu_defaults_double(@"0", @"hidden_push_data");
  }

  //开启网络状况的监听
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(reachabilityChanged:)
                                               name:kReachabilityChangedNotification
                                             object:nil];
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
    hostReach = [Reachability reachabilityWithHostName:TEST_NET_STATUS_HOST];
    internetActive = hostReach.isReachable;
    hostReachState = [hostReach currentReachabilityStatus];
    hostReach.reachableBlock = ^(Reachability *reachability) {
      dispatch_async(dispatch_get_main_queue(), ^{
        internetActive = YES;
        hostReachState = [hostReach currentReachabilityStatus];
      });
    };
    hostReach.unreachableBlock = ^(Reachability *reachability) {
      dispatch_async(dispatch_get_main_queue(), ^{
        internetActive = NO;
        hostReachState = NotReachable;
      });
    };
    [hostReach startNotifier]; //开始监听,会启动一个run loop
  });

  //    统计用户下载量，及首次启动量
  [self app_startapp_log];
  //每次从新启动时，都启动自动刷新
  Enter_app_refresh();
  [self CreatMainViewController];
  //百度云推送
  [BPush setupChannel:launchOptions];
  [BPush setDelegate:self];
  //如果需要支持 iOS8,请加上这些代码并在 iOS6 中编译
  if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
    UIUserNotificationType myTypes =
        UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
    UIUserNotificationSettings *settings =
        [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
  } else {
    UIRemoteNotificationType myTypes =
        UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
  };

  //    应用未启动，点击消息中心信息，直接跳转
  NSDictionary *remoteNotification = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
  if (remoteNotification) {
    [self refrash_push:application and_Notification:remoteNotification];
  }
  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
  self.rvc = [[RootViewController alloc] init];
  [self.main_viewController.view addSubview:self.rvc.view];
  [self.main_viewController.view bringSubviewToFront:self.rvc.view];
  NSLog(@"启用定时器");
  timer = [NSTimer scheduledTimerWithTimeInterval:5.0f
                                           target:self
                                         selector:@selector(removeSplashScreen)
                                         userInfo:nil
                                          repeats:NO];

  NSLog(@"结束定时器");
  return YES;
}

- (void)removeSplashScreen {
  [self.rvc removeFromParentViewController];
  [self.rvc.view removeFromSuperview];

  NSLog(@"移除屏幕");
}
//如果需要支持 iOS8,请加上这些代码
- (void)application:(UIApplication *)application
    didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
  // register to receive notifications
  [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application
    didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
  NSString *token = [NSString stringWithFormat:@"%@", deviceToken];
  if (token && token.length >= 72) {
    token = [[[NSString stringWithFormat:@"%@", deviceToken] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]]
        stringByReplacingOccurrencesOfString:@" "
                                  withString:@""];
    ///保存推送Token
    if (token && token.length > 0) {
      [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"AppleToken"];
      [[NSUserDefaults standardUserDefaults] synchronize];
      ///将token上传后台
      [BaiDuPush sendApplePushToken];
    }
  }
  //     NSLog(@"test:%@",deviceToken);
  [BPush registerDeviceToken:deviceToken];
  [BPush bindChannel];
}

// 必须,如果正确调用了 setDelegate,在 bindChannel 之后,结果在这个回调中返回。
// 若绑定失败,请进行重新绑定,确保至少绑定成功一次
- (void)onMethod:(NSString *)method response:(NSDictionary *)data {
  NSLog(@"ddddd:%@", data);
  if ([BPushRequestMethod_Bind isEqualToString:method]) {
    NSDictionary *res = [[NSDictionary alloc] initWithDictionary:data];
    NSString *appid = [res valueForKey:BPushRequestAppIdKey];
    NSString *userid = [res valueForKey:BPushRequestUserIdKey];
    NSString *channelid = [res valueForKey:BPushRequestChannelIdKey];
    NSString *requestid = [res valueForKey:BPushRequestRequestIdKey];

    YouGu_defaults_double(appid, BPushRequestAppIdKey);
    YouGu_defaults_double(userid, BPushRequestUserIdKey);
    YouGu_defaults_double(channelid, BPushRequestChannelIdKey);
    YouGu_defaults_double(requestid, BPushRequestRequestIdKey);

    if ([YouGu_User_USerid intValue] > 0) {
      //绑定百度用户
      HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
      callBack.onSuccess = ^(NSObject *obj) {
        NSLog(@"绑定百度用户：%@", ((BaiDuPush *)obj).message);
      };
      [BaiDuPush pushBindUserUseridWithBaiduUid:userid
                               withBaiduChannel:channelid
                                   withCallback:callBack];
    }
  } else if ([BPushRequestMethod_Unbind isEqualToString:method]) {
    //      绑定失败后，重新绑定
    [BPush bindChannel];
  }
}

- (void)application:(UIApplication *)application
    didReceiveRemoteNotification:(NSDictionary *)userInfo {
  //  系统震动，效果
  if (application.applicationState == UIApplicationStateActive) {
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
  }
  [self refrash_push:application and_Notification:userInfo];
}

//推送信息处理
- (void)refrash_push:(UIApplication *)application and_Notification:(NSDictionary *)userInfo {
  NSLog(@"userinfo:%@", userInfo);
  if (!userInfo) {
    return;
  }
  if (!_app_userinfo) {
    self.app_userinfo = [[NSMutableDictionary alloc] init];
  }
  [self.app_userinfo removeAllObjects];
  [self.app_userinfo addEntriesFromDictionary:userInfo];

  NSNumber *number = userInfo[@"type"];
  //  NSNumber *msgtype = userInfo[@"msgtype"];
  if (number == nil)
    return;
  BPushTypeMNCG type = (BPushTypeMNCG)[number integerValue];
  if (application.applicationState == UIApplicationStateActive) {
    [BpushModelDeal BPushTextAnimationWithMessgate:userInfo];
  } else if (application.applicationState == UIApplicationStateInactive) {
    if (type == BPushStockPricesEarlyWarning || type == BPushMarketTransaction) {
      [BpushModelDeal saveStockWarningData:userInfo];
    }
    NSString *loginSuccess = [FPYouguUtil getSesionID];
    if ([loginSuccess length] > 0) {
      [self sendNotification:userInfo];
    }
  }
  //显示收到的信息
  [BPush handleNotification:userInfo];
}
//发送通知登陆（由通知进入APP，则显示通知相应程序）
- (void)sendNotification:(NSDictionary *)dic {
  [[NSNotificationCenter defaultCenter] postNotificationName:NotifactionLoginSuccess
                                                      object:nil
                                                    userInfo:dic];
}

///******************************************************************************
// 函数名称 : -(void)alertView:(UIAlertView *)alertView
// clickedButtonAtIndex:(NSInteger)buttonIndex;
// 函数描述 :UIAlertView 代理方法
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (alertView.tag == 10000) {
    if (buttonIndex == 1) {
      //[[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];
      NSString *urlStr =
          [NSString stringWithFormat:@"itms-apps://itunes.apple.com/us/app/id%@?mt=8", [FPYouguUtil appid]];
      NSURL *url = [NSURL URLWithString:urlStr];
      [[UIApplication sharedApplication] openURL:url];
    }
  } else if (alertView.tag == 1000) {
    if (buttonIndex == 1) {
      NSString *loginSuccess = [FPYouguUtil getSesionID];
      if ([loginSuccess length] > 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NotifactionLoginSuccess
                                                            object:nil
                                                          userInfo:self.app_userinfo];
      }
    }
  } else if (alertView.tag == 9000) {
    [FPYouguUtil setAlterViewIsExist:NO];
    [FPYouguUtil clearOutLogin];
    [AppDelegate popToRootViewController:NO];
    [Login_ViewController checkLoginStatusWithCallback:^(BOOL logonSuccess) {
      if (logonSuccess) {
        NSLog(@"遇到0101以后，用户重新登录");
      }
    }];
  }
}
#pragma mark - 自动检测网络，然后判断，是否存在用户信息，
//监听到网络状态改变
- (void)reachabilityChanged:(NSNotification *)note {
  Reachability *curReach = [note object];
  hostReachState = [curReach currentReachabilityStatus];
  if (curReach.isReachable) {
    internetActive = YES;
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
  } else {
    internetActive = NO;
  }
  NSLog(@"network is %@", internetActive ? @"OK" : @"not OK");
}
//处理连接改变后的情况
- (void)updateInterfaceWithReachability:(Reachability *)curReach {
  //对连接改变做出响应的处理动作。
  NetworkStatus status = [curReach currentReachabilityStatus];
  if (status == ReachableViaWiFi) {
    [FPYouguUtil performBlockOnGlobalThread:^{
      // wi_fi 情况下，离线下载
      [OffDownloadObject unCompleteChannleDownLoad];
      //从新获取所有频道
      [ALLChannelData getAllChannelObject];
    } withDelaySeconds:0.1];
  } else {
    printf("\n无网络\n");
  }
}
- (void)dealloc {
  [self.window removeAllSubviews];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
///******************************************************************************
// 函数名称 : -(void)umengTrack
// 函数描述 : 友盟统计，基本参数的记录
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/
- (void)umengTrack {
  [MobClick setAppVersion:XcodeAppVersion];
  [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:(ReportPolicy)REALTIME channelId:nil];
  [MobClick updateOnlineConfig]; //在线参数配置

  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(onlineConfigCallBack:)
                                               name:UMOnlineConfigDidFinishedNotification
                                             object:nil];
}
- (void)onlineConfigCallBack:(NSNotification *)note {
  // //nslog(@"online config has fininshed and note = %@", note.userInfo);
}
#pragma mark - 提示动画
///******************************************************************************
// 函数名称 :-(void)YouGu_animation_Did_Start:(NSString *)text
// 函数描述 : 提示动画
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/
- (void)YouGu_animation_Did_Start:(NSString *)text {
  AnimationLabelAlterView *animation_alter = [AnimationLabelAlterView shareManager];
  [AnimationLabelAlterView YouGu_animation_Did_Start:text];
  [animation_alter sendSubviewToBack:self.window];
}
#pragma mark - share_SDK的初始化
///******************************************************************************
// 函数名称 : -(void)Creat_SDK_share
// 函数描述 : share_SDK的初始化
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/
- (void)Creat_SDK_share {
  [ShareSDK registerApp:@"aa5622129dc"];
  //    [ShareSDK registerApp:@"api20"];
  //禁止SSO
  [ShareSDK ssoEnabled:YES];
  //
  [ShareSDK connectSinaWeiboWithAppKey:@"1858600669"
                             appSecret:@"39852aa67cb2bcc0bb0f4015696c240c"
                           redirectUri:@"http://weibo.com/youguu"];

  [ShareSDK connectTencentWeiboWithAppKey:@"801425986"
                                appSecret:@"4bf8f91f056a2f625e7f2f2f8b97e343"
                              redirectUri:@"http://www.youguu.com/"];

  [ShareSDK connectQQWithQZoneAppKey:@"100537419"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
  [ShareSDK connectQZoneWithAppKey:@"100537419"
                         appSecret:@"157732d6de02233736e740df6e5bc03b"
                 qqApiInterfaceCls:[QQApiInterface class]
                   tencentOAuthCls:[TencentOAuth class]];

  [ShareSDK connectWeChatWithAppId:@"wx4d05717c5557aacb"
                         appSecret:@"5d49eee10dbc8c552cbe8d7cfbff4c12"
                         wechatCls:[WXApi class]];
}

#pragma mark - 添加app-log的startapp的统计
- (void)app_startapp_log {
  //    //添加APP_LOG数据库
  [[AutoRegistrationSimple sharedManager] app_startapp_log];
}
///******************************************************************************
// 函数名称 : -(void)Creat_yuguu_viewcontroller
// 函数描述 : 导入主要，视图控制器，
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************
- (void)CreatMainViewController {
  [[UIApplication sharedApplication] setStatusBarHidden:NO];
  //    //导航条上第一个视图控制器
  _main_viewController = [[FPMainViewController alloc] init];
  my_ViewController *nac = [[my_ViewController alloc] initWithRootViewController:_main_viewController];
  [self.window setRootViewController:nac];
  nac.navigationBarHidden = YES;
}
///******************************************************************************
// 函数名称 : - (void)applicationWillEnterForeground:(UIApplication
// *)application
// 函数描述 : 从后台启动
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************
- (void)applicationWillEnterForeground:(UIApplication *)application {
  if ([FPYouguUtil isExistNetwork]) {
    [FPYouguUtil performBlockOnGlobalThread:^{
      // wi_fi 情况下，离线下载
      [OffDownloadObject unCompleteChannleDownLoad];
      //从新获取所有频道
      [ALLChannelData getAllChannelObject];
    } withDelaySeconds:0.1];
  }
  //统计用户下载量，及首次启动量
  [self app_startapp_log];

  //获取当前时间戳
  YouGu_defaults_double(TodayTimeToString(), @"enter_app_time");
  YouGu_NSNotificationCenter_Sent(@"isAutoRefresh");
}
#pragma mark - sso
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
  return [ShareSDK handleOpenURL:url wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
  return [ShareSDK handleOpenURL:url
               sourceApplication:sourceApplication
                      annotation:annotation
                      wxDelegate:self];
}
/**
 这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
 */
- (void)applicationDidBecomeActive:(UIApplication *)application {
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
  //    计算 登录时长
  [[AutoRegistrationSimple sharedManager] onlinetime_log];
}
#pragma mark - UIViewController   PUSH 和 POP 方法
+ (void)pushViewControllerFromRight:(UIViewController *)viewController {
  [AppDelegate pushViewController:viewController];
};

+ (void)pushViewControllerFromBottom:(UIViewController *)viewController {
  AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;

  UINavigationController *navigationController = app.main_viewController.navigationController;

  CATransition *transition = [CATransition animation];
  transition.duration = 0.35f;
  transition.type = kCATransitionMoveIn;
  transition.subtype = kCATransitionFromTop;
  [navigationController.view.layer addAnimation:transition forKey:kCATransition];
  [navigationController pushViewController:viewController animated:NO];
}

+ (void)pushViewController:(UIViewController *)toViewController {
  AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
  UINavigationController *navigationController = app.main_viewController.navigationController;
  [navigationController pushViewController:toViewController animated:YES];
}
+ (void)popViewController:(BOOL)animated {
  AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
  [app.main_viewController.navigationController popViewControllerAnimated:animated];
  NSLog(@"popViewController, current view controller hierarchy: \n %@",
        [app.main_viewController.navigationController recursiveDescription]);
}
///向下弹走页面
+ (void)popViewControllerToBottom {
  AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
  UINavigationController *navigationController = app.main_viewController.navigationController;
  CATransition *transition = [CATransition animation];
  transition.duration = 0.35f;
  transition.type = kCATransitionReveal;
  transition.subtype = kCATransitionFromBottom;
  [navigationController.view.layer addAnimation:transition forKey:kCATransition];
  [navigationController popViewControllerAnimated:NO];
  NSLog(@"popViewController, current view controller hierarchy: \n %@",
        [app.main_viewController.navigationController recursiveDescription]);
}

+ (void)popToViewController:(UIViewController *)viewController aminited:(BOOL)animated {
  AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
  [app.main_viewController.navigationController popToViewController:viewController
                                                           animated:animated];
  NSLog(@"popToViewController, current view controller hierarchy: \n %@",
        [app.main_viewController.navigationController recursiveDescription]);
}
+ (void)popToRootViewController:(BOOL)animated {
  AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
  [app.main_viewController.navigationController popToRootViewControllerAnimated:animated];
}
+ (void)addAlertView {
  if (![FPYouguUtil isAlterViewStaute]) {
    [FPYouguUtil setAlterViewIsExist:YES];
    UIAlertView *alertView =
        [[UIAlertView alloc] initWithTitle:@"账号异常"
                                   message:@"登录状态已失效，请重新登录"
                                  delegate:(AppDelegate *)([UIApplication sharedApplication].delegate)
                         cancelButtonTitle:@"确认"
                         otherButtonTitles:nil, nil];
    alertView.tag = 9000;
    [alertView show];
  }
}

- (BOOL)isExistNetwork {
  return internetActive;
}

-(NetworkStatus)getNetworkStatus
{
  return hostReachState;
}

@end
