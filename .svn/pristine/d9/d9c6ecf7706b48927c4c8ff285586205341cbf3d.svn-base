//
//  AppUpdateInfo.h
//  SimuStock
//
//  Created by Mac on 14-9-9.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "JsonFormatRequester.h"

@class HttpRequestCallBack;

// 已经是最新安装包
#define ALREADY_LATEST_APP @"0000"
// 强制升级
#define FORCE_UPDATE @"0001"
// 非强制、提示升级
#define RECOMMAND_UPDATE @"0002"

@interface AppUpdateInfo : JsonRequestObject

@property(nonatomic, strong) NSString *version;

/**
 检查是否有最新版本
 */
+ (void)checkLatestAppVersion:(HttpRequestCallBack *)callback;

@end
