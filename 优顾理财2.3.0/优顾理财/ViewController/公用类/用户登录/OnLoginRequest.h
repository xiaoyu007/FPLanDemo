//
//  OnLoginRequest.h
//  优顾理财
//
//  Created by Mac on 15/7/28.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "BaseRequestObject.h"
#import "JsonFormatRequester.h"
@interface OnLoginRequest : JsonRequestObject

@end
@interface LoginAuthentication : JsonRequestObject
#pragma mark - 用户登入验证
//用户登入验证
+ (void)Login_Authentication:(NSString*)username
                  AndUserpwd:(NSString*)userpwd
                WithcallBack:(HttpRequestCallBack*)callback;
@end

@interface VerificationNumber : JsonRequestObject

//  验证码 验证
+ (void)Verification_REGISTERPIN:(NSString*)phone_number
                 andVerification:(NSString*)verification
                         andType:(NSString*)type
                    WithcallBack:(HttpRequestCallBack*)callback;
@end

@interface BindMobilePhone : JsonRequestObject

//  绑定手机号码
+ (void)BindMobilePhone:(NSString*)phoneNum
           WithcallBack:(HttpRequestCallBack*)callback;
@end

@interface GetVerificationCode : JsonRequestObject
//手机号注册，，，获取验证码
+ (void)getVerificationCodeWithPhoneNum:(NSString*)phoneNum
                           WithcallBack:(HttpRequestCallBack*)callback;
@end

@interface ModifyPasswordCode : JsonRequestObject
//找回密码，获取验证码
+ (void)getModifyPasswordCode:(NSString*)phoneNum
                 WithcallBack:(HttpRequestCallBack*)callback;
@end

@interface PhoneGetNewPassword : JsonRequestObject

#pragma mark - 修改用户密码
//修改用户密码（手机找回密码）
+ (void)getPhoneGetNewPassword:(NSString*)phoneNum
                    AndUserpwd:(NSString*)userpwd
                  WithcallBack:(HttpRequestCallBack*)callback;
@end

@interface BindAuthentication : JsonRequestObject
#pragma mark - 绑定已有账号(用户登录之后）
+ (void)getBindAuthentication:(NSString*)openid
                     andToken:(NSString*)token
             andThirdnickname:(NSString*)thirdname
                      andtype:(NSString*)type
                 WithcallBack:(HttpRequestCallBack*)callback;
@end

@interface UnbindMobilePhone : JsonRequestObject
//  解绑手机号码
+ (void)getUnbindMobilePhoneWithPhoneNum:(NSString*)phoneNum
                            WithcallBack:(HttpRequestCallBack*)callback;

@end

@interface UserBaseInfoItem : JsonRequestObject
@property(nonatomic, strong) NSMutableArray* array;
//  3.6.3	查询用户个人信息
+ (void)ShowMyLnfoWithcallBack:(HttpRequestCallBack*)callback;
@end

@interface ModificationUserInfo : JsonRequestObject
///返回的用户picUrl
@property(nonatomic, strong) NSString* imageUrl;
//修改用户信息（头像、昵称、个人签名）
+ (void)getModificationUserInfoWithData:(NSData*)picdata
                              andSysPic:(NSString*)syspicUrl
                            andNickname:(NSString*)newNickname
                            andSignture:(NSString*)newSignature
                           WithcallBack:(HttpRequestCallBack*)callback;
@end

@interface ForgotPasswordRequest : JsonRequestObject
//忘记密码
+ (void)getForgotPasswordRequestWithPhoneNum:(NSString*)phoneNum
                                  andUserpwd:(NSString*)userpwd
                             andVerification:(NSString*)verification
                                WithcallBack:(HttpRequestCallBack*)callback;
@end

@interface OldpwdToNewpwd : JsonRequestObject
//修改用户密码(通过旧密码，修改新密码)
+ (void)getOldpwdToNewpwdWithOldpwd:(NSString*)oldpwd
                          andNewpwd:(NSString*)userpwd
                      AndConfirmpwd:(NSString*)confirmpwd
                       WithcallBack:(HttpRequestCallBack*)callback;
@end

@interface PhoneVerification : JsonRequestObject
//手机绑定验证
+ (void)sendPhoneVerificationWithUserId:(NSString*)userId
                           WithcallBack:(HttpRequestCallBack*)callback;
@end

@interface ActivateNotify : JsonRequestObject
///激活 上送 接口
+(void)getActivateNotifyWithcallBack:(HttpRequestCallBack*)callback;


@end
/**
 *  找回交易密码
 */
@interface FindTradePassword : JsonRequestObject
/**
 *  找回交易密码
 *
 *  @param phoneNumber 手机号
 *  @param callback    回传
 */
+ (void)findTradePasswordWithPhoneNumber:(NSString *)phoneNumber
                            withCallBack:(HttpRequestCallBack *)callback;

@end
