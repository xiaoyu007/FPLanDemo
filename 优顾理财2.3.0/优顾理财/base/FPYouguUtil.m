//
//  FPYouguUtil.m
//  优顾理财
//
//  Created by Mac on 15/6/29.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "SQLDataHtmlstring.h"
#import "KeychainItemWrapper.h"

#import "OnLoginRequest.h"
#import "BpushBindToYouguuUser.h"
#import "AutoRegistrationSimple.h"
#import "UserDataSaveToDefault.h"
///资讯自动刷新
#import "Enter_App_Refresh.h"
/**
 *  是否开市
 */
#import "YouGuOpendingStatus.h"

@implementation FPYouguUtil
#pragma mark - 系统数据
+ (BOOL)isExistNetwork {
  AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  return [appDelegate isExistNetwork];
}
+(BOOL)isNetworkWIFI
{
  AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  return  ([appDelegate getNetworkStatus]==ReachableViaWiFi) ;
}
+ (BOOL)getNetworkStatus {
  AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  return [appDelegate getNetworkStatus];
}


#pragma mark - 用户基本数据
//版本信息: 前2位+最后4位 = 020400 = 2.4.0
+ (NSString *)getAK {
  return @"0210020010200";
}
+ (NSString *)appid {
  return @"718149570";
}
+ (BOOL)isLogined {
  return ![@"-1" isEqualToString:[FPYouguUtil getUserID]];
}
+ (UserListItem *)getUserListItem {
  UserListItem *item = [FileChangelUtil loadUserListItem];
  if (item) {
    return item;
  }
  return nil;
}

////是否要push动画
+ (void)isPushAnimtion:(BOOL)isAnimtion {
  [[NSUserDefaults standardUserDefaults] setBool:isAnimtion forKey:@"PushAnimtion"];
}
+ (BOOL)getPushAnimtion {
  NSNumber *ispush = [[NSUserDefaults standardUserDefaults] objectForKey:@"PushAnimtion"];
  return [ispush boolValue];
}

+ (NSString *)getUserID {
  UserListItem *item = [FPYouguUtil getUserListItem];
  if (item && item.userId.length > 0) {
    return item.userId;
  }
  return @"-1";
}

+ (NSString *)getSesionID {
  UserListItem *item = [FPYouguUtil getUserListItem];
  if (item && item.sessionid.length > 0) {
    return item.sessionid;
  }
  return @"-1";
}
+ (void)setSesionID:(NSString *)sesionId {
  UserListItem *item = [FPYouguUtil getUserListItem];
  item.nickName = sesionId;
  [FileChangelUtil saveUserListItem:item];
}

+ (NSString *)getUserNickName {
  UserListItem *item = [FPYouguUtil getUserListItem];
  if (item && item.nickName.length > 0) {
    return item.nickName;
  }
  return @"";
}
+ (void)setUserNickName:(NSString *)nickname {
  UserListItem *item = [FPYouguUtil getUserListItem];
  item.nickName = nickname;
  [FileChangelUtil saveUserListItem:item];
}

+ (NSString *)getUserName {
  UserListItem *item = [FPYouguUtil getUserListItem];
  if (item && item.userName.length > 0) {
    return item.userName;
  }
  return @"";
}

+ (NSString *)getSignture {
  UserListItem *item = [FPYouguUtil getUserListItem];
  if (item && item.signature.length > 0) {
    return item.signature;
  }
  return @"";
}
+ (void)setSignture:(NSString *)signture {
  UserListItem *item = [FPYouguUtil getUserListItem];
  item.signature = signture;
  [FileChangelUtil saveUserListItem:item];
}

+ (NSString *)getHeadpic {
  UserListItem *item = [FPYouguUtil getUserListItem];
  if (item && item.headPic.length > 0) {
    return item.headPic;
  }
  return @"";
}
+ (void)setHeadpic:(NSString *)pic {
  UserListItem *item = [FPYouguUtil getUserListItem];
  item.headPic = pic;
  [FileChangelUtil saveUserListItem:item];
}

+ (NSString *)getCorTime {
  NSDate *date = [NSDate date];
  NSTimeInterval a = [date timeIntervalSince1970] * 1000;
  // NSString *timeString = [NSString stringWithFormat:@"%f", a];
  int64_t dTime = [@(a) longLongValue];                           // 将double转为int64_t型
  NSString *curTime = [NSString stringWithFormat:@"%llu", dTime]; // 输出int64_t型
  return curTime;
}
/**
 返回用户属性值，对于传入的key，自动附加用户id，这样每个用户的属性保存在不同地方，不互相冲突
 */
+ (id)getUserPreferenceObjectForKey:(NSString *)key {
  NSString *keyWithUid = [key stringByAppendingString:[FPYouguUtil getUserID]];
  return [[NSUserDefaults standardUserDefaults] objectForKey:keyWithUid];
}

/**
 保存用户属性，对于传入的key，自动附加用户id，这样每个用户的属性保存在不同地方，不互相冲突
 */
+ (void)saveUserPreferenceObject:(NSObject *)object forKey:(NSString *)key {
  NSString *keyWithUid = [key stringByAppendingString:[FPYouguUtil getUserID]];
  NSUserDefaults *preference = [NSUserDefaults standardUserDefaults];
  [preference setObject:object forKey:keyWithUid];
  [preference synchronize];
}
/**
 *
 *  //数据解析
 *
 **/
#pragma mark - 数据解析
//过滤后台请求回来的数据，是否为空nil；
+ (NSString *)ishave_blank:(NSString *)string {
  if (string) {
    string = [NSString stringWithFormat:@"%@", string];
    if ([string isEqualToString:@"<null>"]) {
      return @"";
    }
    return string;
  }
  return @"";
}
+ (BOOL)isStringWithBlank:(NSString *)string {
  NSString *str = [FPYouguUtil ishave_blank:string];
  return str.length > 0 ? NO : YES;
}
+ (BOOL)isIos7 {
  BOOL ISios7 = [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0;
  return ISios7;
}

////登录成功
+ (void)OnLoginSuccess {
  //后台的用户，id绑定一下
  BpushBindToYouguuUser();
  //log——log日志，logon
  [[AutoRegistrationSimple sharedManager] logon_log];
  ///登陆成功标记为1
  [SimuControl OnLoginWithType:1];
  [FPYouguUtil bindMobile];
  ///登入成功后，消息中心回调
  [UserDataSaveToDefault sendNotificationCenter];
  //每次从新启动时，都启动自动刷新liqun
  Enter_app_refresh();
  //提示语
  YouGu_animation_Did_Start(@"登录成功");
}
//判断手机是否绑定     绑定：去关联银行卡页    未绑定：去开户首页
+ (void)bindMobile {
  HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
  callBack.onSuccess = ^(NSObject *obj) {
    [SimuControl bingMobileWithType:1];
  };
  callBack.onError = ^(BaseRequestObject *err, NSException *ex) {
  };
  callBack.onFailed = ^{
  };
  [PhoneVerification sendPhoneVerificationWithUserId:[FPYouguUtil getUserID] WithcallBack:callBack];
}

+ (void)clearOutLogin {
  ///退出登录后给赋值为0，清空登录记录（如果已经登录则是1）
  [SimuControl OnLoginWithType:0];
  ///退出登录后给原用户绑定手机状态赋为初值（0）
  [SimuControl bingMobileWithType:0];

  [FileChangelUtil saveUserListItem:nil];

  //   清楚收藏列表的数据库
  [[NewsWithDidCollect sharedManager]delegateAllNewsID];
//  [[SQLDataHtmlstring sharedManager] deleteUser_ALL_WithId];

  //用户信息刷新
  [[PraiseObject sharedManager] reloadPraiseArray];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginNotificationCenter" object:nil];
  //      游客，评论再次出现
  [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"visitor_User"];
  [FPYouguUtil clearGesture];
}
/** 清除手势 */
+ (void)clearGesture {
  [SimuControl saveObjectWithObject:@"" withKey:@"userGesturePassword"];
  KeychainItemWrapper *keychin =
      [[KeychainItemWrapper alloc] initWithIdentifier:@"YouGuuGesture" accessGroup:nil];
  [keychin resetKeychainItem];
}
///是否是开市时间
+ (BOOL)isOpening {
  return  [[YouGuOpendingStatus instance] getExchangeStatus] == TradeOpenning;
}
///是否需要自动下载刷新
+ (BOOL)isAutoRefrashList:(NSString *)channlid {
  NSString *channlid_Key = YouGu_StringWithFormat_double(@"start_time_", channlid);
  long long previousTime = [YouGu_defaults(channlid_Key) longLongValue];
  BOOL isRefrash =
      [TodayTimeToString() longLongValue] - previousTime > 30 * 60 * 1000;
  return isRefrash;
}
//是否存在某张图片
+ (BOOL)ishasExistPic:(NSString *)pic_url {
  //    先判断本地是否存在有 这张logo图片
  NSString *pic_string = [NSString stringWithFormat:@"Logo_PIC.xmly/%@", pic_url];
  BOOL is_have_1 = [[NSFileManager defaultManager] fileExistsAtPath:pathInCacheDirectory(pic_string)];
  if (is_have_1 == YES) {
    return YES;
  } else {
    //        看看工程里是否存在这张logo图片
    NSString *path_1 = [[NSBundle mainBundle] pathForResource:pic_url ofType:nil];
    BOOL ishas = [[NSFileManager defaultManager] fileExistsAtPath:path_1];

    if (ishas == YES) {
      //            将工程中的图片保存在本地中
      [[NSFileManager defaultManager] copyItemAtPath:path_1
                                              toPath:pathInCacheDirectory(pic_string)
                                               error:nil];
      return YES;
    }
  }
  return NO;
}
#pragma mark color 变image
+ (UIImage *)createImageWithColor:(UIColor *)color {
  CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
  UIGraphicsBeginImageContext(rect.size);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(context, [color CGColor]);
  CGContextFillRect(context, rect);

  UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return theImage;
}
#pragma mark---------推送开关是否开启---------
+ (BOOL)hasNotificationsEnabled {
  NSString *iOSversion = [[UIDevice currentDevice] systemVersion];
  NSString *prefix = [[iOSversion componentsSeparatedByString:@"."] firstObject];
  float versionVal = [prefix floatValue];

  if (versionVal >= 8) {
    NSLog(@"%@", [[UIApplication sharedApplication] currentUserNotificationSettings]);
    // The output of this log shows that the app is registered for PUSH so
    // should receive them
    if ([[UIApplication sharedApplication] currentUserNotificationSettings].types != UIUserNotificationTypeNone) {
      return YES;
    }
  } else {
    UIRemoteNotificationType types = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
    if (types != UIRemoteNotificationTypeNone) {
      return YES;
    }
  }
  return NO;
}
+ (void)setAlterViewIsExist:(BOOL)exist {
  [[NSUserDefaults standardUserDefaults] setBool:exist forKey:@"AlterViewIsExist"];
  [[NSUserDefaults standardUserDefaults]synchronize];
}

+ (BOOL)isAlterViewStaute {
  return [[NSUserDefaults standardUserDefaults] boolForKey:@"AlterViewIsExist"];
}

#pragma mark - 主线程延迟处理
+ (void)performBlockOnMainThread:(void (^)())block withDelaySeconds:(float)delayInSeconds {
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
  dispatch_after(popTime, dispatch_get_main_queue(), block);
}

#pragma mark - 分线程延迟处理
+ (void)performBlockOnGlobalThread:(void (^)())block withDelaySeconds:(float)delayInSeconds {
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
  dispatch_after(popTime, dispatch_get_global_queue(0, 0), block);
}

@end
