//
//  OnLoginRequest.m
//  优顾理财
//
//  Created by Mac on 15/7/28.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "OnLoginRequest.h"
#import "YGImageDown.h"
#import "OnLoginRequestItem.h"

#import "OpenUDID.h"
#import "SvUDIDTools.h"
#import <AdSupport/ASIdentifierManager.h>
@implementation OnLoginRequest

@end

@implementation LoginAuthentication
- (void)jsonToObject:(NSDictionary*)dic {
  [super jsonToObject:dic];
  UserListItem* item = [[UserListItem alloc] init];
  [item jsonToObject:dic];
  ///保存当前用户登录信息
  [FileChangelUtil saveUserListItem:item];
}
#pragma mark - 用户登入验证
//用户登入验证
+ (void)Login_Authentication:(NSString*)username
                  AndUserpwd:(NSString*)userpwd
                WithcallBack:(HttpRequestCallBack*)callback {
  NSString* path = [NSString
      stringWithFormat:@"%@/jhss/member/dologonnew/%@/%@/%@?flag=%@",
                       IP_HTTP_USER, ak_version, username, userpwd, @"-1"];
  JsonFormatRequester* request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[LoginAuthentication class]
             withHttpRequestCallBack:callback];
}
@end

@implementation VerificationNumber
//  验证码 验证
+ (void)Verification_REGISTERPIN:(NSString*)phone_number
                 andVerification:(NSString*)verification
                         andType:(NSString*)type
                    WithcallBack:(HttpRequestCallBack*)callback {
  phone_number = [CommonFunc base64StringFromText:phone_number];
  verification = [CommonFunc base64StringFromText:verification];
  type = [CommonFunc base64StringFromText:type];
  NSString* path = [NSString
      stringWithFormat:@"%@/jhss/sms/authsmscode/%@/%@/%@", IP_HTTP_USER,
                       phone_number, verification, type];
  JsonFormatRequester* request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[VerificationNumber class]
             withHttpRequestCallBack:callback];
}
@end

@implementation BindMobilePhone
//  绑定手机号码
+ (void)BindMobilePhone:(NSString*)phoneNum
           WithcallBack:(HttpRequestCallBack*)callback {
  NSString* path =
      [NSString stringWithFormat:@"%@/jhss/member/doBindingPhone/%@/%@",
                                 IP_HTTP_USER, phoneNum, YouGu_User_USerid];
  JsonFormatRequester* request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[BindMobilePhone class]
             withHttpRequestCallBack:callback];
}
@end

@implementation GetVerificationCode

//手机号注册，，，获取验证码
+ (void)getVerificationCodeWithPhoneNum:(NSString*)phoneNum
                           WithcallBack:(HttpRequestCallBack*)callback {
  phoneNum = [CommonFunc base64StringFromText:phoneNum];
  NSString *path =
  [NSString stringWithFormat:@"%@/jhss/sms/makeRegisterPin/%@/%@",
   IP_HTTP_USER, phoneNum, @"1"];
  JsonFormatRequester* request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[GetVerificationCode class]
             withHttpRequestCallBack:callback];
}
@end
///找回密码时，获取验证码
@implementation ModifyPasswordCode

//找回密码，，，获取验证码
+ (void)getModifyPasswordCode:(NSString*)phoneNum
                 WithcallBack:(HttpRequestCallBack*)callback {
  NSString* path =
      [NSString stringWithFormat:@"%@/jhss/sms/makeForgotPwdPin/%@/%@",
                                 IP_HTTP_USER, phoneNum, @"2"];
  JsonFormatRequester* request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[ModifyPasswordCode class]
             withHttpRequestCallBack:callback];
}
@end

@implementation PhoneGetNewPassword

#pragma mark - 修改用户密码
//修改用户密码（手机找回密码）
+ (void)getPhoneGetNewPassword:(NSString*)phoneNum
                    AndUserpwd:(NSString*)userpwd
                  WithcallBack:(HttpRequestCallBack*)callback {
  NSString* path =
      [NSString stringWithFormat:@"%@/jhss/member/doRetrievePwd/%@/%@?flag=%@",
                                 IP_HTTP_USER, phoneNum, userpwd, @"-1"];
  JsonFormatRequester* request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[PhoneGetNewPassword class]
             withHttpRequestCallBack:callback];
}
@end


@implementation BindAuthentication

#pragma mark - 绑定已有账号(用户登录之后）
+ (void)getBindAuthentication:(NSString*)openid
                     andToken:(NSString*)token
             andThirdnickname:(NSString*)thirdname
                      andtype:(NSString*)type
                 WithcallBack:(HttpRequestCallBack*)callback {
  //过滤首尾空格
  thirdname = [CommonFunc base64StringFromText:thirdname];

  NSString* path = [NSString
      stringWithFormat:@"%@/jhss/member/" @"bindMyAccount?token=%@&openid=%@&"
                       @"thirdNickname=%@&type=%@",
                       IP_HTTP_USER, token, openid, thirdname, type];
  JsonFormatRequester* request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[BindAuthentication class]
             withHttpRequestCallBack:callback];
}
@end

@implementation UnbindMobilePhone

//  解绑手机号码
+ (void)getUnbindMobilePhoneWithPhoneNum:(NSString*)phoneNum
                            WithcallBack:(HttpRequestCallBack*)callback {
  phoneNum = [CommonFunc base64StringFromText:phoneNum];

  NSString* path =
      [NSString stringWithFormat:@"%@/jhss/member/doUnbindingPhone/%@/%@",
                                 IP_HTTP_USER, phoneNum, YouGu_User_USerid];
  JsonFormatRequester* request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[UnbindMobilePhone class]
             withHttpRequestCallBack:callback];
}
@end

@implementation UserBaseInfoItem
- (void)jsonToObject:(NSDictionary*)dic {
  [super jsonToObject:dic];
  NSString* sessionId = [FPYouguUtil getSesionID];
  UserListItem* item = [[UserListItem alloc] init];
  [item jsonToObject:dic];
  item.sessionid = sessionId;
  [FileChangelUtil saveUserListItem:item];

  self.array = [[NSMutableArray alloc] init];
  NSArray* dArray = dic[@"bindArray"];
  NSMutableArray* mArray = [[NSMutableArray alloc] init];
  [dArray enumerateObjectsUsingBlock:^(NSDictionary* mdic, NSUInteger idx,
                                       BOOL* stop) {
    UserBindThirdItem* thirdItem = [[UserBindThirdItem alloc] init];
    thirdItem.BindType = [mdic[@"type"] intValue];
    thirdItem.BindOpenid = mdic[@"openid"];
    thirdItem.BindThridName = mdic[@"thirdNickname"];
    [mArray addObject:thirdItem];
  }];
  [self.array addObjectsFromArray:mArray];
}
//  3.6.3	查询用户个人信息
+ (void)ShowMyLnfoWithcallBack:(HttpRequestCallBack*)callback {
  NSString* path = [NSString
      stringWithFormat:@"%@/jhss/member/showmyinfo/%@/%@/%@", IP_HTTP_USER,
                       ak_version, YouGu_User_sessionid, YouGu_User_USerid];
  JsonFormatRequester* request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[UserBaseInfoItem class]
             withHttpRequestCallBack:callback];
}
@end

@implementation ModificationUserInfo
- (void)jsonToObject:(NSDictionary*)dic {
  [super jsonToObject:dic];
  self.imageUrl = dic[@"headpic"];
  //保存，最新的，用户头像url
  if (self.imageUrl && self.imageUrl.length > 0) {
    [FPYouguUtil setHeadpic:self.imageUrl];
//    [[YGImageDown sharedManager] add_image:imageUrl
//                                completion:^(UIImage* img){
//
//                                }];
  }
}
//修改用户信息（头像、昵称、个人签名）
+ (void)getModificationUserInfoWithData:(NSData*)picdata
                              andSysPic:(NSString*)syspicUrl
                            andNickname:(NSString*)newNickname
                            andSignture:(NSString*)newSignature
                           WithcallBack:(HttpRequestCallBack*)callback {
  syspicUrl = [CommonFunc base64StringFromText:syspicUrl];
  newNickname = [CommonFunc base64StringFromText:newNickname];
  newSignature = [CommonFunc base64StringFromText:newSignature];

  NSString* path = [NSString
      stringWithFormat:@"%@/jhss/member/uploaduserpic/%@/%@/", IP_HTTP_USER,
                       ak_version, [FPYouguUtil getSesionID]];
  NSMutableDictionary* dicionary = [[NSMutableDictionary alloc] init];
  dicionary[@"nickname"] = newNickname;
  dicionary[@"sex"] = @"1";
  dicionary[@"userid"] = [FPYouguUtil getUserID];
  dicionary[@"signature"] = newSignature;

  if (picdata.length > 0) {
    JhssPostData* fileData = [[JhssPostData alloc] init];
    fileData.data = picdata;
    fileData.contentType = @"image/jpeg";
    fileData.filename = @"pic.jpg";
    dicionary[@"pic"] = fileData;
  } else {
    dicionary[@"syspic"] = syspicUrl;
  }
  JsonFormatRequester* request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"POST_M"
               withRequestParameters:dicionary
              withRequestObjectClass:[ModificationUserInfo class]
             withHttpRequestCallBack:callback];
}
@end

@implementation ForgotPasswordRequest
//忘记密码
+ (void)getForgotPasswordRequestWithPhoneNum:(NSString*)phoneNum
                                  andUserpwd:(NSString*)userpwd
                             andVerification:(NSString*)verification
                                WithcallBack:(HttpRequestCallBack*)callback {
  phoneNum = [CommonFunc base64StringFromText:phoneNum];
  userpwd = [CommonFunc base64StringFromText:userpwd];
  verification = [CommonFunc base64StringFromText:verification];

  NSDictionary* dic = @{
    @"ak" : ak_version,
    @"phone" : phoneNum,
    @"userpwd" : userpwd,
    @"verifyCode" : verification,
    @"imei" : GetDeviceID(),
    @"ua" : Iphone_model(),
    @"size" : Iphone_Size(),
    @"os" : Iphone_OS(),
    @"network" : checkNetWorkNoTip(),
    @"operators" : CarrierName()
  };

  NSString* path =
      [NSString stringWithFormat:@"%@/jhss/member/phoneRegister", IP_HTTP_USER];
  JsonFormatRequester* request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"POST"
               withRequestParameters:dic
              withRequestObjectClass:[ForgotPasswordRequest class]
             withHttpRequestCallBack:callback];
}
@end

@implementation OldpwdToNewpwd

//修改用户密码(通过旧密码，修改新密码)
+ (void)getOldpwdToNewpwdWithOldpwd:(NSString*)oldpwd
                          andNewpwd:(NSString*)userpwd
                      AndConfirmpwd:(NSString*)confirmpwd
                       WithcallBack:(HttpRequestCallBack*)callback {
  oldpwd = [CommonFunc base64StringFromText:oldpwd];
  confirmpwd = [CommonFunc base64StringFromText:confirmpwd];
  userpwd = [CommonFunc base64StringFromText:userpwd];

  NSString* path = [NSString
      stringWithFormat:@"%@/jhss/member/doeditpwd/%@/%@/%@/%@/%@/%@?flag=%@",
                       IP_HTTP_USER, ak_version, YouGu_User_sessionid,
                       YouGu_User_USerid, userpwd, confirmpwd, oldpwd, @"-1"];
  JsonFormatRequester* request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[OldpwdToNewpwd class]
             withHttpRequestCallBack:callback];
}
@end

@implementation PhoneVerification

//手机绑定验证
+ (void)sendPhoneVerificationWithUserId:(NSString*)userId
                           WithcallBack:(HttpRequestCallBack*)callback {
  NSString* path = [NSString
      stringWithFormat:@"%@/jhss/member/authIsBindingPhone", IP_HTTP_USER];
  JsonFormatRequester* request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[PhoneVerification class]
             withHttpRequestCallBack:callback];
}
@end

///激活 上送 接口
@implementation ActivateNotify
-(void)jsonToObject:(NSDictionary *)dic
{
  [super jsonToObject:dic];
}
+(void)getActivateNotifyWithcallBack:(HttpRequestCallBack*)callback
{
  NSString* adfa = @"";
  if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled] ==
      YES) {
    adfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
  }
  NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
  dic[@"ak"] = ak_version;
  dic[@"userid"] = YouGu_User_USerid;
  dic[@"udid"] = [SvUDIDTools getMacAddress];
  dic[@"app"]= [FPYouguUtil appid];
  dic[@"idfa"] = adfa;
  dic[@"opendudid"] = [OpenUDID value];
  dic[@"activateFlag"] = @"1";
  
  NSString* path = [NSString
                    stringWithFormat:@"%@/stat/promote/activateNotify", @"http://192.168.1.188:8888"];
  JsonFormatRequester* request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"POST"
               withRequestParameters:dic
              withRequestObjectClass:[PhoneVerification class]
             withHttpRequestCallBack:callback];
}
@end

@implementation FindTradePassword

+ (void)findTradePasswordWithPhoneNumber:(NSString *)phoneNumber
                            withCallBack:(HttpRequestCallBack *)callback{
  phoneNumber = [CommonFunc base64StringFromText:phoneNumber];
  
  NSString *path =
  [NSString stringWithFormat:@"%@/jhss/sms/getPin?phone=%@&type=%@",
   IP_HTTP_USER, phoneNumber, @"10"];
  
  JsonFormatRequester* request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[FindTradePassword class]
             withHttpRequestCallBack:callback];
}

@end
