//
//  OnLoginRequestItem.m
//  优顾理财
//
//  Created by Mac on 15/7/21.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "OnLoginRequestItem.h"

@implementation OnLoginRequestItem
- (void)jsonToObject:(NSDictionary*)dic {
  [super jsonToObject:dic];
  self.userListItem = [[UserListItem alloc] init];
  [self.userListItem jsonToObject:dic];
  ///保存用户信息
  [FileChangelUtil saveUserListItem:self.userListItem];
}
+ (void)getOnLoginWithNickName:(NSString*)nickname
                   andpassword:(NSString*)password
                withCallback:(HttpRequestCallBack *)callback {
  NSString * name = [CommonFunc base64StringFromText:nickname];
  NSString * pwd = [CommonFunc base64StringFromText:password];
  NSString* path = [NSString
      stringWithFormat:@"%@/jhss/member/dologonnew/%@/%@/%@?flag=%@",
                       IP_HTTP_USER, ak_version, name, pwd, @"-1"];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[OnLoginRequestItem class]
             withHttpRequestCallBack:callback];
}
@end
@implementation RegistrationRequestItem

+ (void)getRegisWithNickname:(NSString*)nickname
                 andpassword:(NSString*)password
              withCallback:(HttpRequestCallBack *)callback {
  NSString* path = [NSString
      stringWithFormat:@"%@/jhss/member/doFormRegister", IP_HTTP_USER];
  NSDictionary* dic = @{
    @"ak" : ak_version,
    @"username" : nickname,
    @"userpwd" : password,
    @"nickname" : nickname,
    @"imei" : GetDeviceID(),
    @"ua" : Iphone_model(),
    @"size" : Iphone_Size(),
    @"os" : Iphone_OS(),
    @"network" : checkNetWorkNoTip(),
    @"operators" : CarrierName()
  };
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"POST"
               withRequestParameters:dic
              withRequestObjectClass:[RegistrationRequestItem class]
             withHttpRequestCallBack:callback];
}
@end

@implementation UserBindThirdItem
- (void)jsonToObject:(NSDictionary*)dic {
  self.BindType = [dic[@"type"] intValue];
  self.BindOpenid = dic[@"openid"];
  self.BindThridName = dic[@"thirdNickname"];
}
@end
@implementation UserPersonalInfo
- (void)jsonToObject:(NSDictionary*)dic {
  [super jsonToObject:dic];
  self.thirdArray = [[NSMutableArray alloc] init];
  self.userListItem = [[UserListItem alloc] init];
  [self.userListItem jsonToObject:dic];
  ///保存用户信息
  [FileChangelUtil saveUserListItem:self.userListItem];

  NSArray* bindArray = dic[@"bindArray"];
  [bindArray enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx,
                                          BOOL* stop) {
    UserBindThirdItem* thirdItem = [[UserBindThirdItem alloc] init];
    [thirdItem jsonToObject:obj];
    [self.thirdArray addObject:thirdItem];
  }];
}
+ (void)getUserPersonalInfowithCallback:(HttpRequestCallBack *)callback {
  NSString* path = [NSString
      stringWithFormat:@"%@/jhss/member/showmyinfo/%@/%@/%@", IP_HTTP_USER,
                       ak_version, YouGu_User_sessionid, YouGu_User_USerid];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[UserPersonalInfo class]
             withHttpRequestCallBack:callback];
}
@end
///判断是否注册过了，这个第三方帐号
@implementation JudgeThirdItem
- (void)jsonToObject:(NSDictionary*)dic {
  [super jsonToObject:dic];
  self.userListItem = [[UserListItem alloc] init];
  [self.userListItem jsonToObject:dic];
  ///保存用户信息
  [FileChangelUtil saveUserListItem:self.userListItem];
}

+ (void)getJudgeThirdItem:(NSString*)openid
                  andType:(NSString*)type
                 andToken:(NSString*)token
           withCallback:(HttpRequestCallBack *)callback {
  NSString* path =
      [NSString stringWithFormat:@"%@/jhss/member/doThirdPartAuth/%@/%@/%@/%@",
                                 IP_HTTP_USER, ak_version, openid, type, token];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[JudgeThirdItem class]
             withHttpRequestCallBack:callback];
}
@end
///绑定自动注册用户
@implementation AutoBindRegistItem
-(void)jsonToObject:(NSDictionary *)dic
{
  [super jsonToObject:dic];
  self.userListItem = [[UserListItem alloc]init];
  [self.userListItem jsonToObject:dic];
  ///保存用户信息
  [FileChangelUtil saveUserListItem:self.userListItem];
}
+ (void)getAutoBindRegistItemWith:(NSString*)openid
                 andThirdnickname:(NSString*)thirdname
                      AndNickname:(NSString*)nickname
                           andPic:(NSString*)pic_url
                          andtype:(NSString*)type
                   withCallback:(HttpRequestCallBack *)callback {
  NSString* path = [NSString
      stringWithFormat:@"%@/jhss/member/bindRandomAccount", IP_HTTP_USER];
  type = [CommonFunc base64StringFromText:type];
  openid = [CommonFunc base64StringFromText:openid];
  thirdname = [thirdname stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
  nickname = [nickname stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
  nickname = [CommonFunc base64StringFromText:nickname];
  NSDictionary* dic = @{
    @"ak" : ak_version,
    @"openid" : openid,
    @"type" : type,
    @"thirdNickname" : nickname,
    @"nickname":nickname,
    @"imei" : GetDeviceID(),
    @"ua" : Iphone_model(),
    @"size" : Iphone_Size(),
    @"os" : Iphone_OS(),
    @"network" : checkNetWorkNoTip(),
    @"operators" : CarrierName(),
    @"headpic" : pic_url
  };
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"POST"
               withRequestParameters:dic
              withRequestObjectClass:[AutoBindRegistItem class]
             withHttpRequestCallBack:callback];
}

@end