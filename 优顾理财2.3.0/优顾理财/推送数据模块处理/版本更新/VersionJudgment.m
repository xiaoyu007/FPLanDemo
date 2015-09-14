//
//  VersionJudgment.m
//  优顾理财
//
//  Created by Mac on 15/7/28.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "VersionJudgment.h"
#import "AppUpdateInfo.h"

@implementation VersionJudgment
#pragma mark
#pragma mark------版本更新相关------
/*
 *功能：苹果商店升级函数（从苹果商店上，取得升级消息）
 */
- (void)onCheckVersion {
  NSDictionary* infoDic = [[NSBundle mainBundle] infoDictionary];
  NSString* currentVersion = infoDic[@"CFBundleVersion"];

  NSString* URL =
      [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",
                                 [FPYouguUtil appid]];
  NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
  [request setURL:[NSURL URLWithString:URL]];
  [request setHTTPMethod:@"POST"];
  NSHTTPURLResponse* urlResponse = nil;
  NSError* error = nil;
  NSData* recervedData = [NSURLConnection sendSynchronousRequest:request
                                               returningResponse:&urlResponse
                                                           error:&error];

  NSString* results = [[NSString alloc] initWithBytes:[recervedData bytes]
                                               length:[recervedData length]
                                             encoding:NSUTF8StringEncoding];
  if (results == nil || [results length] == 0)
    return;
  NSDictionary* dic = [results objectFromJSONString];
  // NSLog(@"%@",dic);
  NSArray* infoArray = dic[@"results"];
  if ([infoArray count]) {
    NSDictionary* releaseInfo = infoArray[0];
    NSString* lastVersion = releaseInfo[@"version"];
    if (![lastVersion isEqualToString:currentVersion]) {
      // trackViewURL = [releaseInfo objectForKey:@"trackVireUrl"];
      UIAlertView* alert = [[UIAlertView alloc]
              initWithTitle:@"升级提示"
                    message:@" \"优顾炒股\" "
                    @"已推出了新版，便于您使用体验，请升级。"
                   delegate:(AppDelegate*)([UIApplication sharedApplication]
                                               .delegate)
          cancelButtonTitle:@"取消"
          otherButtonTitles:@"升级", nil];
      alert.tag = 10000;
      [alert show];
    }
  }
}
/*
 *功能：版本服务器升级函数（从公司的版本服务器上，取得升级消息）
 */
- (void)onCheckVersionForSevers {
  HttpRequestCallBack* callback = [[HttpRequestCallBack alloc] init];
  __weak VersionJudgment* weakSelf = self;
  callback.onSuccess = ^(NSObject* obj) {

    VersionJudgment* strongSelf = weakSelf;
    if (strongSelf) {
      AppUpdateInfo* appUpdateInfo = (AppUpdateInfo*)obj;
      [strongSelf bindAppUpdateInfo:appUpdateInfo];
    }
  };
  [AppUpdateInfo checkLatestAppVersion:callback];
}

- (void)bindAppUpdateInfo:(AppUpdateInfo*)appUpdateInfo {
  if ([appUpdateInfo.status isEqualToString:ALREADY_LATEST_APP]) {
    //最新版本
    NSLog(@"已经是最新版本了");
  } else {
    //普通升级
    NSString* titel =
        [NSString stringWithFormat:@"发现新版本%@", appUpdateInfo.version];
    UIAlertView* alert = [[UIAlertView alloc]
            initWithTitle:titel
                  message:appUpdateInfo.message
                 delegate:(AppDelegate*)([UIApplication sharedApplication]
                                             .delegate)
        cancelButtonTitle:@"下次再说"
        otherButtonTitles:@"立即更新", nil];
    alert.tag = 10000;
    [alert show];
  }
}
//进入主界面(首页弹窗)
- (void)showMainPageViewController {
  NSLog(@"⭐️启动完成，开始版本检测");
  //更新检测
  [self performSelector:@selector(onCheckVersionForSevers)
             withObject:Nil
             afterDelay:1];
}
@end
