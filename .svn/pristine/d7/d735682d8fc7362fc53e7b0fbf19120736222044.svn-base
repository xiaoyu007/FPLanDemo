//
//  FPpublicRequest.m
//  优顾理财
//
//  Created by Mac on 15/7/30.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

@implementation FPpublicRequest

@end

@implementation DelBindBPush
/*
 *  百度云推送,解绑
 *
 *
 */
+(void)getDelBindBPushWithcallBack:(HttpRequestCallBack*)callback{
  NSString* path = [NSString
                    stringWithFormat:@"%@/bind/pushuser/userrecode/delbind/%@/%@/%@",
                    IP_HTTP_daidu_PUSH, ak_version, YouGu_User_sessionid,
                    YouGu_User_USerid];
  JsonFormatRequester* request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[DelBindBPush class]
             withHttpRequestCallBack:callback];
}
@end