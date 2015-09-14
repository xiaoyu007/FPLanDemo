//
//  baidu_push_bind_to_YouGu.m
//  优顾理财
//
//  Created by Mac on 14-9-11.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "BpushBindToYouguuUser.h"
#import "BPush.h"
#import "BaiDuPush.h"
#import "OnLoginRequest.h"

void BpushBindToYouguuUser() {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSString *userid = [defaults objectForKey:BPushRequestUserIdKey];
  NSString *channelid = [defaults objectForKey:BPushRequestChannelIdKey];
  if ([YouGu_User_USerid intValue] > 0) {
    //绑定百度用户
    HttpRequestCallBack* callBack = [[HttpRequestCallBack alloc] init];
    callBack.onSuccess = ^(NSObject* obj) {
      NSLog(@"绑定百度用户：%@", ((BaiDuPush *)obj).message);
    };
    callBack.onError = ^(BaseRequestObject *err, NSException *ex) {
    };
    callBack.onFailed = ^{
    };
    [BaiDuPush pushBindUserUseridWithBaiduUid:userid withBaiduChannel:channelid withCallback:callBack];
  }
}

