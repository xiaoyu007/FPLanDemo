//
//  OnLoginRequestItem.h
//  优顾理财
//
//  Created by Mac on 15/7/21.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "BaseRequestObject.h"
#import "UserListItem.h"
#import "JsonFormatRequester.h"
@interface OnLoginRequestItem : JsonRequestObject
///用户信息
@property(nonatomic, strong) UserListItem* userListItem;
+ (void)getOnLoginWithNickName:(NSString*)nickname
                   andpassword:(NSString*)password
                withCallback:(HttpRequestCallBack *)callback;
@end
@interface RegistrationRequestItem : JsonRequestObject
+ (void)getRegisWithNickname:(NSString*)nickname
                 andpassword:(NSString*)password
              withCallback:(HttpRequestCallBack *)callback;
@end
/** 用户类型 */
typedef NS_ENUM(NSUInteger, UserBindType) {

  /** QQ注册账号（不可解绑） */
  UserBindTypeQQ = 2,

  /** 新浪微博注册账号（不可解绑） */
  UserBindTypeSinaWeibo = 3,

  /** 手机号注册账号（不可解绑） */
  UserBindTypePhoneRegister = 4,

  /** 微信注册账号（不可解绑） */
  UserBindTypeWeixinRegister = 7,

  /** 手机号绑定已有账号(可更改，不可解绑) */
  UserBindTypeBindPhone2Exist = 1,

  /** QQ绑定已有账号(可解绑) */
  UserBindTypeBindQQ2Exist = 5,

  /** 新浪绑定已有账号(可解绑) */
  UserBindTypeBindSinaWeibo2Exist = 6,

  /** 微信绑定已有账号(可解绑) */
  UserBindTypeBindWeixin2Exist = 8,

};
@interface UserBindThirdItem : JsonRequestObject
@property(nonatomic, assign) UserBindType BindType;
@property(nonatomic, strong) NSString* BindOpenid;
@property(nonatomic, strong) NSString* BindThridName;
@end
@interface UserPersonalInfo : JsonRequestObject
@property(nonatomic, strong) UserListItem* userListItem;
@property(nonatomic, strong) NSMutableArray* thirdArray;
@end
@interface JudgeThirdItem : JsonRequestObject
@property(nonatomic, strong) UserListItem* userListItem;
+ (void)getJudgeThirdItem:(NSString*)openid
                  andType:(NSString*)type
                 andToken:(NSString*)token
           withCallback:(HttpRequestCallBack *)callback;
@end
@interface AutoBindRegistItem : JsonRequestObject
@property(nonatomic, strong) UserListItem* userListItem;
+ (void)getAutoBindRegistItemWith:(NSString*)openid
                 andThirdnickname:(NSString*)thirdname
                      AndNickname:(NSString*)nickname
                           andPic:(NSString*)pic_url
                          andtype:(NSString*)type
                   withCallback:(HttpRequestCallBack *)callback;
@end