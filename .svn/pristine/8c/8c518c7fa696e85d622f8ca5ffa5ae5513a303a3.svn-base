//
//  AutoRegistrationSimple.h
//  优顾理财
//
//  Created by Mac on 14-2-26.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import <Foundation/Foundation.h>
//    //log日志统计
#import "SQL_Data_Log_server.h"

@interface AutoRegistrationSimple : NSObject
+ (AutoRegistrationSimple *)sharedManager;
////自动注册
//-(void)registration_auto;
// logon ,log 日志
- (void)logon_log;

#pragma mark - 添加app-log的startapp的统计
//添加app——log的startapp的统计
- (void)app_startapp_log;

//进入后台，按“home”可以从新启动
- (void)onlinetime_log;
@end
