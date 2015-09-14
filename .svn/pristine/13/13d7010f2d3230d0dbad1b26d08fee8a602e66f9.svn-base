//
//  AutoRegistrationSimple.m
//  优顾理财
//
//  Created by Mac on 14-2-26.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "AutoRegistrationSimple.h"

static AutoRegistrationSimple *Auto_Reg_sharedManager = nil;

@implementation AutoRegistrationSimple

+ (AutoRegistrationSimple *)sharedManager {
  @synchronized([AutoRegistrationSimple class]) {
    if (!Auto_Reg_sharedManager)
      Auto_Reg_sharedManager = [[self alloc] init];
    return Auto_Reg_sharedManager;
  }
  return nil;
}

+ (id)alloc {
  @synchronized([AutoRegistrationSimple class]) {
    NSAssert(
        Auto_Reg_sharedManager == nil,
        @"Auto_Reg_sharedManager_Attempted to allocated a second instance");
    Auto_Reg_sharedManager = [super alloc];
    return Auto_Reg_sharedManager;
  }
  return nil;
}

#pragma mark - logon，log 日志
// logon ,log 日志
- (void)logon_log {
  //    //获取系统当前的时间戳
  NSString *enter_app_time = TodayTimeToString();
  if (YouGu_User_USerid && enter_app_time) {
    NSDictionary *logon_dic = @{@"ak" : ak_version, @"uid" :
        YouGu_User_USerid, @"vt" : enter_app_time};
    if (logon_dic) {
      [[SQL_Data_Log_server sharedManager] saveUser:@"logonstat"
                                     andDescription:logon_dic];
    }
  }
}

///******************************************************************************
// 函数名称 : -(void)app_startapp_log
// 函数描述 : startapp 统计，
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************

#pragma mark - 添加app-log的startapp的统计
//添加app——log的startapp的统计
- (void)app_startapp_log {
  //添加APP_LOG数据库
  NSDictionary *d_dic = (NSDictionary *)[self news_data_iphone];
  if (d_dic) {
    [[SQL_Data_Log_server sharedManager] saveUser:@"startapp"
                                   andDescription:d_dic];
  }
}

#pragma mark - 获取启动次数的数据
//获取启动次数的数据
- (NSDictionary *)news_data_iphone {
  //获取系统当前的时间戳
  NSString *first_enter_time = TodayTimeToString();
  //    获取手机唯一码
  NSString *getDeviceID = GetDeviceID();
  //    获得手机型号
  NSString *iphone_model = Iphone_model();
  //    获得手机屏幕尺寸size
  NSString *iphone_size = Iphone_Size();
  //    获得手机操作系统os
  NSString *iphone_os = Iphone_OS();
  //    获得手机卡运营商的名称
  NSString *carrierName = CarrierName();
  //   获得手机上网方式
  NSString *checkNetWork = CheckNetWork();
  //    是否激活，激活为1，激活过了为-1
  NSString *J_Hou = nil;
  if ([[NSUserDefaults standardUserDefaults] objectForKey:@"Not_JI_HOU"] ==
      nil) {
    J_Hou = @"1";
    [[NSUserDefaults standardUserDefaults]
        setObject:@YES
           forKey:@"Not_JI_HOU"];
    [[NSUserDefaults standardUserDefaults] synchronize];
  } else {
    J_Hou = @"-1";
  }
  //    确保上传的log 每个都有值
  if (first_enter_time && getDeviceID && iphone_model && iphone_size &&
      iphone_os && carrierName && checkNetWork && J_Hou) {
    NSDictionary *d_dic = @{@"ak" : ak_version, @"vt" : first_enter_time,
        @"ucode" : getDeviceID, @"dm" : iphone_model,
        @"sr" : iphone_size, @"os" : iphone_os,
        @"op" : carrierName, @"net" : checkNetWork,
        @"ac" : J_Hou};

    return d_dic;
  }
  return nil;
}

#pragma mark - 进入后台，按“home”可以重新启动
//进入后台，按“home”可以重新启动
- (void)onlinetime_log {
  //    获取上次进入的时间
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  //    获取当前时间戳
  NSString *enter_app_time = [defaults objectForKey:@"enter_app_time"];
  NSString *exit_app_time = TodayTimeToString();

  NSDictionary *log_on_time_dic = @{@"ak" : ak_version, @"sessionid" :
      YouGu_User_sessionid, @"uid" : YouGu_User_USerid,
      @"st" : enter_app_time, @"et" : exit_app_time};
  [[SQL_Data_Log_server sharedManager] saveUser:@"onlinetime"
                                 andDescription:log_on_time_dic];
}

@end
