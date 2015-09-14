//
//  FPShareSDKUtil.h
//  优顾理财
//
//  Created by Mac on 15/8/7.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>
typedef void (^FPShareResult)(SSAuthState state);
typedef void(^FPShareUserInfoResult) (BOOL result, id<ISSPlatformUser> userInfo);
@interface FPShareSDKUtil : NSObject
+ (id<ISSAuthOptions>)getAuthOptions;
///绑定第三方平台
+ (void)authWithType:(ShareType)type
             options:(id<ISSAuthOptions>)options
              result:(FPShareResult)result;
//取消微博账号绑定
+(void)cancelAuthWithType:(ShareType)type;
///获取第三方平台用户信息
+ (void)getUserInfoWithType:(ShareType)shareType
                authOptions:(id<ISSAuthOptions>)authOptions
                     result:(FPShareUserInfoResult)resultValue;
///是否绑定过微博
+ (BOOL)hasAuthorizedWithType:(ShareType)type;
#pragma mark - 默认内容
//默认内容
+(id<ISSContent>)getShareContent;
#pragma mark - 分享框设计
//分享框设计
+(id<ISSShareOptions>)getShareOptions;
#pragma mark - 分享到不同平台的方法
+(void)contentShareTotype:(ShareType)aType;
@end
