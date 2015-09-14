//
//  baidu_push_bind_to_YouGu.m
//  优顾理财
//
//  Created by Mac on 14-9-11.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

void baidu_push_bind_to_YouGu_User() {
  [[WebServiceManager sharedManager]
      The_registNotify_Salary_range_completion:^(NSDictionary *dic) {
        NSLog(@"注册上推送接口：%@,%@", dic, dic[@"messag"
            @"e"]);
      }];

  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  //    NSString * appid=[defaults objectForKey:BPushRequestAppIdKey];
  NSString *userid = [defaults objectForKey:BPushRequestUserIdKey];
  NSString *channelid = [defaults objectForKey:BPushRequestChannelIdKey];

  if ([YouGu_User_USerid intValue] > 0) {
    [[WebServiceManager sharedManager]
          baidu_Push:userid
        andChannelId:channelid
          completion:^(NSDictionary *dic) {
            if (!YouGu_defaults_array(@"YouGOU_bindChannel")) {
              if ([dic[@"status"] isEqualToString:@"0000"]) {
                YouGu_defaults_double(@"1", @"YouGOU_bindChannel");
              } else {
                YouGu_defaults_double(@"0", @"YouGOU_bindChannel");
              }
            }
          }];
  }
}
