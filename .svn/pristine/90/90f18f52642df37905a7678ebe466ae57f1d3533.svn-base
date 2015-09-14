//
//  AppUpdateInfo.m
//  SimuStock
//
//  Created by Mac on 14-9-9.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "AppUpdateInfo.h"
@implementation AppUpdateInfo

- (void)jsonToObject:(NSDictionary *)dic {
  [super jsonToObject:dic];
  self.version = dic[@"version"];
}
/**
 检查是否有最新版本
 */
+ (void)checkLatestAppVersion:(HttpRequestCallBack *)callback {
  NSString *URL =
      [NSString stringWithFormat:@"%@jhss/member/doupdate/{ak}",IP_HTTP_USER];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:URL
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[AppUpdateInfo class]
             withHttpRequestCallBack:callback];
}

@end
