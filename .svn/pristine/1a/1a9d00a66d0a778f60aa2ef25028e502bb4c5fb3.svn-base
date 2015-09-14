//
//  BaiDuPush.h
//  优顾理财
//
//  Created by Mac on 15/8/4.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "BaseRequestObject.h"
#import "JsonFormatRequester.h"
@interface BaiDuPushRequester:JsonRequestObject
@end
@interface BaiDuPush : JsonRequestObject
/** 推送绑定baidu */
+ (void)pushBindUserUseridWithBaiduUid:(NSString *)baiduUid
                      withBaiduChannel:(NSString *)baiduChannel
                          withCallback:(HttpRequestCallBack *)callback;
///绑定用户
+ (void)pushBindUserWithToken:(NSString *)token
                 withCallback:(HttpRequestCallBack *)callbac;

///解绑用户
+ (void)pushDelBindUserWithCallback:(HttpRequestCallBack *)callback;

///给后台传送AppleToken
+(void)sendApplePushToken;
@end
