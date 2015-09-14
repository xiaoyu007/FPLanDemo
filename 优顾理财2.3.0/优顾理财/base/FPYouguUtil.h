//
//  FPYouguUtil.h
//  优顾理财
//
//  Created by Mac on 15/6/29.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileChangelUtil.h"
@interface FPYouguUtil : NSObject
#pragma mark - 用户基本数据
/** 得到ak */
+ (NSString *)getAK;
+ (NSString *)appid;
/** 返回当前是否已经登录 */
+ (BOOL)isLogined;
+ (UserListItem *)getUserListItem;
////是否要push动画
+ (void)isPushAnimtion:(BOOL)isAnimtion;
+ (BOOL)getPushAnimtion;

+ (NSString *)getUserID;
/** 得到当前的会话id */
+ (NSString *)getSesionID;
+ (void)setSesionID:(NSString *)sesionId;

/** 得到当前用户昵称 */
+ (NSString *)getUserNickName;
+ (void)setUserNickName:(NSString *)nickname;

/** 得到当前用户名称 */
+ (NSString *)getUserName;

/** 得到当前用户签名 */
+ (NSString *)getSignture;
+ (void)setSignture:(NSString *)signture;

/** 得到当前用户头像 */
+ (NSString *)getHeadpic;
+ (void)setHeadpic:(NSString *)pic;

+ (NSString *)getCorTime;
/**
 保存用户属性，对于传入的key，自动附加用户id，这样每个用户的属性保存在不同地方，不互相冲突
 */
+ (void)saveUserPreferenceObject:(NSObject *)object forKey:(NSString *)key;

/**
 返回用户属性值，对于传入的key，自动附加用户id，这样每个用户的属性保存在不同地方，不互相冲突
 */
+ (id)getUserPreferenceObjectForKey:(NSString *)key;
#pragma mark - 数据解析
//过滤后台请求回来的数据，是否为空nil；
+ (NSString *)ishave_blank:(NSString *)string;
+ (BOOL)isStringWithBlank:(NSString *)string;
+ (BOOL)isIos7;
////登录成功
+ (void)OnLoginSuccess;
//判断手机是否绑定     绑定：去关联银行卡页    未绑定：去开户首页
+ (void)bindMobile;
///清除缓存数据
+ (void)clearOutLogin;
///是否是开市时间
+ (BOOL)isOpening;
///是否需要自动下载刷新
+ (BOOL)isAutoRefrashList:(NSString *)channlid;
//是否存在某张图片
+ (BOOL)ishasExistPic:(NSString *)pic_url;
#pragma mark color 变uiimage
+ (UIImage *)createImageWithColor:(UIColor *)color;
#pragma mark---------推送开关是否开启---------
+ (BOOL)hasNotificationsEnabled;
/**
 *  判断有无网络
 */
+ (BOOL)isExistNetwork;
+(BOOL)isNetworkWIFI;
//网络具体状态
+ (BOOL)getNetworkStatus;
///是否0101 弹框
+ (void)setAlterViewIsExist:(BOOL)exist;
+ (BOOL)isAlterViewStaute;

/**延迟指定的秒数，执行block代码块 */
+ (void)performBlockOnMainThread:(void (^)())block
                withDelaySeconds:(float)delayInSeconds;
+ (void)performBlockOnGlobalThread:(void (^)())block
                  withDelaySeconds:(float)delayInSeconds;

@end
