//
//  BaiDuPush.m
//  优顾理财
//
//  Created by Mac on 15/8/4.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "BaiDuPush.h"
@implementation BaiDuPushRequester

- (void)jsonToObject:(NSDictionary *)dic {
  [super jsonToObject:dic];
}
@end
@implementation BaiDuPush
/** 推送绑定baidu */
+ (void)pushBindUserUseridWithBaiduUid:(NSString *)baiduUid
                      withBaiduChannel:(NSString *)baiduChannel
                          withCallback:(HttpRequestCallBack *)callback
{
  NSString *akString = [FPYouguUtil getAK];
  NSString *sessionIdString = [FPYouguUtil getSesionID];
  if(sessionIdString==nil || [sessionIdString length]< 3 )
    return;
  NSString *userID = [FPYouguUtil getUserID];
  if(userID==nil || [userID isEqualToString:@"-1"])
    return;
  NSString *uaString =[CommonFunc textFromBase64String:Iphone_model()];
  NSString *url = [NSString stringWithFormat:@"%@/bind/pushuser/userrecode/binduser/%@/%@/%@/%@/%@/%@/%@",IP_HTTP_daidu_PUSH, akString, sessionIdString, userID, baiduUid, baiduChannel ,uaString,CheckNetWork()];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:url
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[BaiDuPush class]
             withHttpRequestCallBack:callback];
}

///绑定用户
+ (void)pushBindUserWithToken:(NSString *)token
                 withCallback:(HttpRequestCallBack *)callback
{
  NSString *akString = [FPYouguUtil getAK];
  NSString *userID = [FPYouguUtil getUserID];
  if(userID==nil || [userID isEqualToString:@"-1"])
    return;
  
  NSString *url = [NSString stringWithFormat:@"%@/bind/pushuser/userrecode/bind?uid=%@&ak=%@&token=%@",IP_HTTP_daidu_PUSH,userID,akString,token];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:url
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[BaiDuPushRequester class]
             withHttpRequestCallBack:callback];
}
///解绑用户
+ (void)pushDelBindUserWithCallback:(HttpRequestCallBack *)callback
{
  NSString *path = [NSString
                    stringWithFormat:@"%@/bind/pushuser/userrecode/delbind/%@/%@/%@",
                    IP_HTTP_daidu_PUSH,ak_version,YouGu_User_sessionid,
                    YouGu_User_USerid];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[BaiDuPushRequester class]
             withHttpRequestCallBack:callback];
}

//给后台传送Token
+(void)sendApplePushToken {
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }

  NSString *token =
  [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleToken"];
  if (token && token.length > 0) {
    HttpRequestCallBack *callback = [[HttpRequestCallBack alloc] init];
    callback.onSuccess = ^(NSObject *obj) {
    };
    [BaiDuPush pushBindUserWithToken:token withCallback:callback];
  }
}
@end
