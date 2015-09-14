//
//  Enter_App_Refresh.m
//  优顾理财
//
//  Created by moulin wang on 13-10-11.
//  Copyright (c) 2013年 Ling YU. All rights reserved.
//

#import "Enter_App_Refresh.h"

void Enter_app_refresh() {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NewsChannelList * allObject = [FileChangelUtil loadAllNewsChannelList];

  if (allObject.channels.count>0) {
    for (NewsChannelItem * onlyObject in allObject.channels) {
      NSString *channlid_num =
          [NSString stringWithFormat:@"start_time_%@", onlyObject.channleID];
      [defaults setObject:@"0" forKey:channlid_num];
    }
  } else {
    //    是否自动刷新   刷新初始化，及可以从新自动刷新
    [defaults setObject:@"0" forKey:@"start_time_1"];
    [defaults setObject:@"0" forKey:@"start_time_2"];
    [defaults setObject:@"0" forKey:@"start_time_3"];
    [defaults setObject:@"0" forKey:@"start_time_4"];
    [defaults setObject:@"0" forKey:@"start_time_25"];
    [defaults synchronize];
  }
  //    开始计入 从新登入的log
  New_login();
}

#pragma mark - 是否重新启动程序
//是否，重新启动程序
void New_login() {
  //    启动应用是的时间
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  //获取系统当前的时间戳
  NSString *enter_app_time = TodayTimeToString();
  if (enter_app_time) {
    [defaults setObject:enter_app_time forKey:@"enter_app_time"];
    [defaults synchronize];
  }
}
