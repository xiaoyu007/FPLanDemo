///
//  WebServiceManager.m
//  TrafficReport
//
//  Created by zyhang on 12/6/12.
//  Copyright (c) 2012 Jamper. All rights reserved.
//

#import "Auto_Registration_Simple.h"

static WebServiceManager *_sharedManager = nil;

@implementation WebServiceManager

+ (WebServiceManager *)sharedManager {
  @synchronized([WebServiceManager class]) {
    if (!_sharedManager)
      _sharedManager = [[self alloc] init];
    return _sharedManager;
  }
  return nil;
}

+ (id)alloc {
  @synchronized([WebServiceManager class]) {
    NSAssert(_sharedManager == nil,
             @"Attempted to allocated a second instance");
    _sharedManager = [super alloc];
    return _sharedManager;
  }
  return nil;
}

//- (void)dealloc{
//    [super dealloc];
//}

- (id)init {
  self = [super init];
  if (self) {
  }
  return self;
}

/**
 *
 *  //数据解析
 *
 **/
#pragma mark - 数据解析
//过滤后台请求回来的数据，是否为空nil；
- (NSString *)ishave_blank:(NSString *)string {
  if (string) {
    string = [NSString stringWithFormat:@"%@", string];
    if ([string isEqualToString:@"<null>"]) {
      return @"";
    }
    return string;
  }
  return @"";
}
///******************************************************************************
// 函数名称 :-(void)Data_processing:(RFResponse *)response
// completion:(YouGu_Data_Completion)completion
// 函数描述 : 网络请求数据，返回数据的处理
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/
#pragma mark -网络请求数据，返回数据的处理，
- (void)Data_processing:(RFResponse *)response
             completion:(YouGu_Data_Completion)completion {
  if (!response && !response.stringValue) //      网络访问失败
  {
    completion(1, nil);
  } else {
    NSString *string = [CommonFunc textFromBase64String:response.stringValue];

    NSDictionary *dic = [string JSONValue];

    if (dic &&
        [dic[@"status"] isEqualToString:@"0101"] ==
            YES) //   sessionid 是否，失效，失效后，登入验证，从新获取sessionid
    {
      [self LOGON_IN_username:dic];
      completion(2, dic);
      return;
    } else if (dic &&
               [dic[@"status"] isEqualToString:@"0000"] ==
                   YES) //      网络访问失败
    {
      completion(0, dic);
      return;
    } else {
      completion(1, dic);
    }
  }
}

/**
// 函数名称 : -(void)YOUGUU_ALL_Channlid
// 函数描述 : 获取所有频道，
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
*/
#pragma mark -获取所有频道，
- (void)YOUGUU_ALL_Channlid:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:@"%@/youguu/newsrest/info/channellist/%@/%@/%@",
                       IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                       YouGu_User_USerid];
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  [RFService execRequest:r
              completion:^(RFResponse *response) {

                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

///******************************************************************************
// 函数名称 : -(void)Basic_Information_andChannelid:(NSString *)channelid
// andStartnum:(int)startnum completion:(TRCompletion)completion;
// 函数描述 : //基本信息
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/
#pragma mark - 基本信息
//基本信息
- (void)Basic_Information_andChannelid:(NSString *)channlid_id
                           andStartnum:(int)startnum
                            completion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:@"%@/youguu/newsrest/info/infolist/%@/%@/%@/%@/%@/%d/%@",
                       IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                       YouGu_User_USerid, Iphone_Size(), channlid_id, startnum,
                       @"20"];
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService
      execRequest:r
       completion:^(RFResponse *response) {

         [self Data_processing:response
                    completion:^(int state, NSDictionary *dic) {
                      if (state == 0) {
                        if (startnum == 1) {
                          NSString *FileName = [NSString
                              stringWithFormat:@"NEWS_%@.json", channlid_id];
                          //          删除这篇，过去存储的文章
                          [[NSFileManager defaultManager]
                              removeItemAtPath:pathInCacheDirectory(FileName)
                                         error:nil];
                          //再保存，新的
                          //   保存新闻首页数据
                          [[Json_Data_Nsstring sharedManager]
                              json_data_chche_file:response.dataValue
                                      andfile_name:FileName];
                        }
                      }
                      completion(dic);
                      return;
                    }];
       }];
}

///******************************************************************************
// 函数名称 : -(void)WI_FI_Basic_Information:(NSString *)channlid_id
// andStartnum:(int)startnum
// completion:(TRCompletion)completion(TRCompletion)completion;
// 函数描述 : //离线下载
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/
#pragma mark - 离线下载
//基本信息
- (void)WI_FI_Basic_Information:(NSString *)channlid_id
                    andStartnum:(int)startnum
                     completion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:
          @"%@/youguu/newsrest/info/downinfolist/%@/%@/%@/%@/%@/%d/%@",
          IP_HTTP_DATA, ak_version, YouGu_User_sessionid, YouGu_User_USerid,
          Iphone_Size(), channlid_id, startnum, @"20"];
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                    resourcePathComponents:nil, nil];

  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {

                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

#pragma mark - 用户登入验证
//用户登入验证
- (void)LOGON_IN_username:(NSDictionary *)dic {
  NSString *user_name =
      [CommonFunc base64StringFromText:YouGu_defaults(@"username")];
  NSString *user_pwd =
      [CommonFunc base64StringFromText:YouGu_defaults(@"userpwd")];

  if (user_name && user_pwd && [user_name length] > 0 &&
      [user_pwd length] > 0) {
    [[WebServiceManager sharedManager]
        Login_Authentication:user_name
                  AndUserpwd:user_pwd
                  completion:^(NSDictionary *dic) {
                    if (dic && [dic[@"status"]
                                   isEqualToString:@"0000"]) {
                      [YouGu_default
                          setObject:
                              [self ishave_blank:dic[@"headpic"]]
                             forKey:@"headpic"];
                      [YouGu_default
                          setObject:
                              [self ishave_blank:dic[@"nickname"]]
                             forKey:@"nickname"];
                      [YouGu_default
                          setObject:[self ishave_blank:
                              dic[@"sessionid"]]
                             forKey:@"sid"];
                      [YouGu_default
                          setObject:[self ishave_blank:
                              dic[@"signature"]]
                             forKey:@"signature"];
                      [YouGu_default
                          setObject:
                              [self ishave_blank:dic[@"userid"]]
                             forKey:@"uid"];

                      //   刷新财知道的消息推送
                      [[NSNotificationCenter defaultCenter]
                          postNotificationName:@"Push_Cai_message"
                                        object:nil];
                      //                收藏列表刷新
                      [[NSNotificationCenter defaultCenter]
                          postNotificationName:@"Collection_refrash_data"
                                        object:nil];
                      //                刷新我的问题列表
                      [[NSNotificationCenter defaultCenter]
                          postNotificationName:@"My_question_refrash_data"
                                        object:nil];
                      //                刷新我的回答列表
                      [[NSNotificationCenter defaultCenter]
                          postNotificationName:@"My_answer_refrash_data"
                                        object:nil];
                    }
                  }];
  }
}

///******************************************************************************
// 函数名称 :-(void)Auto_Registration_completion:(TRCompletion)completion;
// 函数描述 : /用户登入    自动注册   激活
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/
#pragma mark - 用户登入    自动注册   激活
//用户登入    自动注册   激活
- (void)Auto_Registration_completion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:@"%@/jhss/member/doautoregister/%@/%@/%@/%@/%@/%@/%@/",
                       IP_HTTP_USER, ak_version, GetDeviceID(), Iphone_model(),
                       Iphone_Size(), Iphone_OS(), CheckNetWork(),
                       CarrierName()];
  path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

  NSURL *url = [NSURL URLWithString:path];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                    resourcePathComponents:nil, nil];
  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

//普通注册
- (void)General_Email_Registration:(NSString *)username
                        AndUserpwd:(NSString *)userpwd
                          andEmail:(NSString *)email_url
                        completion:(TRCompletion)completion {
  username = [CommonFunc base64StringFromText:username];
  userpwd = [CommonFunc base64StringFromText:userpwd];
  NSString *path = [NSString
      stringWithFormat:@"%@/jhss/member/doFormRegister", IP_HTTP_USER];
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders =
      @{@"ak" : ak_version};

  //    ak
  [r addParam:ak_version forKey:@"ak"];
  //    username
  [r addParam:username forKey:@"username"];
  //    userpwd
  [r addParam:userpwd forKey:@"userpwd"];
  //    nickname
  [r addParam:username forKey:@"nickname"];

  //    设备身份码
  [r addParam:GetDeviceID() forKey:@"imei"];
  //    手机机型
  [r addParam:Iphone_model() forKey:@"ua"];
  //    屏幕分辩率
  [r addParam:Iphone_Size() forKey:@"size"];
  //    操作系统版本号
  [r addParam:Iphone_OS() forKey:@"os"];
  //    上网方式
  [r addParam:CarrierName() forKey:@"network"];
  //    运营商
  [r addParam:CarrierName() forKey:@"operators"];
  ////    邮箱
  //    [r addParam:email_url forKey:@"email"];
  [RFService execRequest:r
              completion:^(RFResponse *response) {

                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

//手机号注册，，，获取验证码
- (void)GET_REGISTERPIN:(NSString *)phone_number
             completion:(TRCompletion)completion {
  phone_number = [CommonFunc base64StringFromText:phone_number];

  NSString *path =
      [NSString stringWithFormat:@"%@/jhss/sms/makeRegisterPin/%@/%@",
                                 IP_HTTP_USER, phone_number, @"1"];

  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

///找回交易密码  验证码
- (void)GET_FINDTRADEPASSWORD:(NSString *)phone_number
                   completion:(TRCompletion)completion {
  phone_number = [CommonFunc base64StringFromText:phone_number];

  NSString *path =
      [NSString stringWithFormat:@"%@/jhss/sms/getPin?phone={%@}&type={%@}",
                                 IP_HTTP, phone_number, @"10"];

  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

//找回密码，，，获取验证码
- (void)Change_password_REGISTERPIN:(NSString *)phone_number
                         completion:(TRCompletion)completion {
  phone_number = [CommonFunc base64StringFromText:phone_number];

  NSString *path =
      [NSString stringWithFormat:@"%@/jhss/sms/makeForgotPwdPin/%@/%@",
                                 IP_HTTP_USER, phone_number, @"2"];

  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

//  验证    码验证
- (void)Verification_REGISTERPIN:(NSString *)phone_number
                 andVerification:(NSString *)verification
                         andType:(NSString *)type
                      completion:(TRCompletion)completion {
  phone_number = [CommonFunc base64StringFromText:phone_number];
  verification = [CommonFunc base64StringFromText:verification];
  type = [CommonFunc base64StringFromText:type];

  NSString *path = [NSString
      stringWithFormat:@"%@/jhss/sms/authsmscode/%@/%@/%@", IP_HTTP_USER,
                       phone_number, verification, type];

  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

//  绑定手机号码
- (void)bind_Mobile_Phone:(NSString *)phone_number
               completion:(TRCompletion)completion {
  phone_number = [CommonFunc base64StringFromText:phone_number];

  NSString *path =
      [NSString stringWithFormat:@"%@/jhss/member/doBindingPhone/%@/%@",
                                 IP_HTTP_USER, phone_number, YouGu_User_USerid];

  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

//  解绑手机号码
- (void)Unbind_Mobile_Phone:(NSString *)phone_number
                 completion:(TRCompletion)completion {
  phone_number = [CommonFunc base64StringFromText:phone_number];

  NSString *path =
      [NSString stringWithFormat:@"%@/jhss/member/doUnbindingPhone/%@/%@",
                                 IP_HTTP_USER, phone_number, YouGu_User_USerid];

  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

//  3.6.3	查询用户个人信息
- (void)ShowMyLnfo_completion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:@"%@/jhss/member/showmyinfo/%@/%@/%@", IP_HTTP_USER,
                       ak_version, YouGu_User_sessionid, YouGu_User_USerid];

  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

//忘记密码
- (void)Phone_Number_Registration:(NSString *)phone_number
                       AndUserpwd:(NSString *)userpwd
                  andVerification:(NSString *)verification
                       completion:(TRCompletion)completion {
  phone_number = [CommonFunc base64StringFromText:phone_number];
  userpwd = [CommonFunc base64StringFromText:userpwd];
  verification = [CommonFunc base64StringFromText:verification];

  NSString *path =
      [NSString stringWithFormat:@"%@/jhss/member/phoneRegister", IP_HTTP_USER];

  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];

  //    ak
  [r addParam:ak_version forKey:@"ak"];
  //    phone
  [r addParam:phone_number forKey:@"phone"];
  //    userpwd
  [r addParam:userpwd forKey:@"userpwd"];
  //   验证码
  [r addParam:verification forKey:@"verifyCode"];

  //    设备身份码
  [r addParam:GetDeviceID() forKey:@"imei"];
  //    手机机型
  [r addParam:Iphone_model() forKey:@"ua"];
  //    屏幕分辩率
  [r addParam:Iphone_Size() forKey:@"size"];
  //    操作系统版本号
  [r addParam:Iphone_OS() forKey:@"os"];
  //    上网方式
  [r addParam:CarrierName() forKey:@"network"];
  //    运营商
  [r addParam:CarrierName() forKey:@"operators"];

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

#pragma mark - 修改用户密码
//修改用户密码（手机找回）
- (void)Change_password_Authentication:(NSString *)phone_Number
                            AndUserpwd:(NSString *)userpwd
                            completion:(TRCompletion)completion {
  phone_Number = [CommonFunc base64StringFromText:phone_Number];
  userpwd = [CommonFunc base64StringFromText:userpwd];

  NSString *path =
      [NSString stringWithFormat:@"%@/jhss/member/doRetrievePwd/%@/%@?flag=%@",
                                 IP_HTTP_USER, phone_Number, userpwd, @"-1"];
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

//修改用户密码(通过旧密码，修改新密码)
- (void)Oldpwd_to_Newpwd:(NSString *)oldpwd
            and_username:(NSString *)userpwd
              AndUserpwd:(NSString *)confirmpwd
              completion:(TRCompletion)completion {
  oldpwd = [CommonFunc base64StringFromText:oldpwd];
  confirmpwd = [CommonFunc base64StringFromText:confirmpwd];
  userpwd = [CommonFunc base64StringFromText:userpwd];

  NSString *path = [NSString
      stringWithFormat:@"%@/jhss/member/doeditpwd/%@/%@/%@/%@/%@/%@?flag=%@",
                       IP_HTTP_USER, ak_version, YouGu_User_sessionid,
                       YouGu_User_USerid, userpwd, confirmpwd, oldpwd, @"-1"];

  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

//修改用户密码(旧版本的用户，获取密码)
- (void)Old_User_to_New_User:(NSString *)userpwd
                  completion:(TRCompletion)completion {
  userpwd = [CommonFunc base64StringFromText:userpwd];

  NSString *path = [NSString
      stringWithFormat:@"%@/jhss/member/doeditpwd/%@/%@/%@/%@?flag=%@",
                       IP_HTTP_USER, ak_version, YouGu_User_sessionid,
                       YouGu_User_USerid, userpwd, @"-1"];

  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

#pragma mark - 第三方验证接口
- (void)DothirdPartAuth_Authentication:(NSString *)openid
                              AndToken:(NSString *)token
                               andtype:(NSString *)type
                            completion:(TRCompletion)completion {
  type = [CommonFunc base64StringFromText:type];
  openid = [CommonFunc base64StringFromText:openid];
  token = [CommonFunc base64StringFromText:token];

  NSString *path =
      [NSString stringWithFormat:@"%@/jhss/member/doThirdPartAuth/%@/%@/%@/%@",
                                 IP_HTTP_USER, ak_version, openid, type, token];
  //    NSLog(@"第三方验证接口：%@",path);
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

#pragma mark - 绑定自动注册用户
- (void)Dothird_bind_Authentication:(NSString *)openid
                   andThirdnickname:(NSString *)thirdname
                        AndNickname:(NSString *)nickname
                             andPic:(NSString *)pic_url
                            andtype:(NSString *)type
                         completion:(TRCompletion)completion {
  type = [CommonFunc base64StringFromText:type];
  openid = [CommonFunc base64StringFromText:openid];
  nickname = [CommonFunc base64StringFromText:nickname];

  NSString *path = [NSString
      stringWithFormat:@"%@/jhss/member/bindRandomAccount", IP_HTTP_USER];

  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers

  //    ak
  [r addParam:ak_version forKey:@"ak"];
  //    openid
  [r addParam:openid forKey:@"openid"];
  //    type
  [r addParam:type forKey:@"type"];
  //    thirdNickname
  [r addParam:nickname forKey:@"thirdNickname"];
  //    昵称
  [r addParam:nickname forKey:@"nickname"];

  //    设备身份码
  [r addParam:GetDeviceID() forKey:@"imei"];
  //    手机机型
  [r addParam:Iphone_model() forKey:@"ua"];
  //    屏幕分辩率
  [r addParam:Iphone_Size() forKey:@"size"];
  //    操作系统版本号
  [r addParam:Iphone_OS() forKey:@"os"];
  //    上网方式
  [r addParam:CarrierName() forKey:@"network"];
  //    运营商
  [r addParam:CarrierName() forKey:@"operators"];
  //    第三方头像
  [r addParam:pic_url forKey:@"headpic"];

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

#pragma mark - 绑定已有账号(用户登录之后）
- (void)Bind_Authentication:(NSString *)openid
                   andToken:(NSString *)token
           andThirdnickname:(NSString *)thirdname
                    andtype:(NSString *)type
                     andSid:(NSString *)sid
                     andUid:(NSString *)uid
                 completion:(TRCompletion)completion {
  type = [CommonFunc base64StringFromText:type];
  openid = [CommonFunc base64StringFromText:openid];
  token = [CommonFunc base64StringFromText:token];
  thirdname = [CommonFunc base64StringFromText:thirdname];

  NSString *path =
      [NSString stringWithFormat:@"%@/jhss/member/"
                                 @"bindMyAccount?token=%@&openid=%@&"
                                 @"thirdNickname=%@&type=%@",
                                 IP_HTTP_USER, token, openid, thirdname, type];

  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

///******************************************************************************
// 函数名称 :-(void)WX_Code:(NSString *)code andAppid:(NSString *)appid
// andSecret:(NSString *)secret completion:(TRCompletion)completion
// 函数描述 :微信获取，token 值 openid
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/
#pragma mark - 微信获取，token 值 openid
- (void)WX_Code:(NSString *)code
       andAppid:(NSString *)appid
      andSecret:(NSString *)secret
     completion:(TRCompletion)completion {
  NSString *path =
      [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/"
                                 @"access_token?appid=%@&secret=%@&code=%@&"
                                 @"grant_type=authorization_code",
                                 appid, secret, code];
  //    NSLog(@"用户登入验证：%@",path);
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}
///******************************************************************************
// 函数名称 :-(void)WX_access_token:(NSString *)token andOpenid:(NSString
// *)openid completion:(TRCompletion)completion
// 函数描述 :微信获取用户基本信息
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/
#pragma mark - 微信获取用户基本信息
- (void)WX_access_token:(NSString *)token
              andOpenid:(NSString *)openid
             completion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:
          @"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",
          token, openid];

  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];

  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

///******************************************************************************
// 函数名称 :-(void)PUSH_List_start:(int)start
// completion:(TRCompletion)completion
// 函数描述 :实名 ,消息推送列表
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/
#pragma mark - 实名 ,消息推送列表
- (void)PUSH_List_start_id:(int)start completion:(TRCompletion)completion {
  NSString *path =
      [NSString stringWithFormat:@"%@/bbs/notice/myMessage?fromId=%d&count=20",
                                 IP_HTTP_DATA, start];
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

#pragma mark - 用户登入验证
//用户登入验证
- (void)Login_Authentication:(NSString *)username
                  AndUserpwd:(NSString *)userpwd
                  completion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:@"%@/jhss/member/dologonnew/%@/%@/%@?flag=%@",
                       IP_HTTP_USER, ak_version, username, userpwd, @"-1"];

  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}
//手机绑定验证
- (void)sendRequestWithMobileId:(NSString *)userId
                 withCompletion:(TRCompletion)completion {
  NSString *path =
      [NSString stringWithFormat:@"%@/jhss/member/authIsBindingPhone", IP_HTTP];
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  NSLog(@"%@", YouGu_User_USerid);
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

///******************************************************************************
// 函数名称 :-(void)NEW_Consulting_Details_andChannelid:(NSString *)channelid
// andInfoid:(NSString *)new_id completion:(TRCompletion)completion
// 函数描述 :普通，新闻正文页，具体新闻接口（新的API接口）
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/

#pragma mark - 普通，新闻正文页，具体新闻接口（新的API接口）
//咨询详情
- (void)NEW_Consulting_Details_andChannelid:(NSString *)channelid
                                  andInfoid:(NSString *)new_id
                                 completion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:
          @"%@/youguu/newsrest/info/readNews/%@/%@/%@/%@/%@/%@/%@/%@",
          IP_HTTP_DATA, ak_version, YouGu_User_sessionid, YouGu_User_USerid,
          Iphone_Size(), channelid, new_id, @"1", @"1"];
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService
      execRequest:r
       completion:^(RFResponse *response) {

         //      请求数据处理
         [self Data_processing:response
                    completion:^(int state, NSDictionary *dic) {
                      //            网络请求成功
                      if (state == 0) {
                        if (dic &&
                            [dic[@"status"]
                                isEqualToString:@"0000"] == YES) {
                          NSString *file_name = [NSString
                              stringWithFormat:@"com.xmly/%@.json", new_id];
                          if (response.dataValue && new_id && channelid) {
                            //          删除这篇，过去存储的文章
                            [[NSFileManager defaultManager]
                                removeItemAtPath:pathInCacheDirectory(file_name)
                                           error:nil];
                            //再保存，新的
                            [[Json_Data_Nsstring sharedManager]
                                Json_To_File:response.dataValue
                                andfile_name:new_id];

                            [[The_NEWS_Focus_SQL sharedManager]
                                      saveUser:new_id
                                   andchannlid:channelid
                                andDescription:
                                    @"其他频道——保存本地的数据"];
                            if ([channelid intValue] == 25) {
                              [[The_NEWS_QU_Li_Cai_SQL sharedManager]
                                        saveUser:new_id
                                     andchannlid:@"25"
                                  andDescription:@"趣理财—数据存储"];
                            }
                          }
                        }
                      }
                      completion(dic);
                      return;
                    }];
       }];
}

///******************************************************************************
// 函数名称 :-(void)NEW_Consulting_Details_andChannelid:(NSString *)channelid
// andInfoid:(NSString *)new_id completion:(TRCompletion)completion
// 函数描述 :新闻正文，相关文章
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/

#pragma mark - 新闻正文，相关文章（新的API接口）
// 相关文章
- (void)NEW_Consulting_Details_Infoid:(NSString *)new_id
                           completion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:@"%@/youguu/newsrest/info/relateInfos/%@/%@/%@/%@",
                       IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                       YouGu_User_USerid, new_id];
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  NSLog(@"-----------------///////%@",r);

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

///******************************************************************************
// 函数名称 :-(void)ZAN_NEW_Consulting_Details_Infoid:(NSString *)new_id
// completion:(TRCompletion)completion
// 函数描述 :新闻正文，相关文章
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/

#pragma mark - 新闻正文，相关评论的赞功能（新的API接口）
// 新闻资讯，赞功能
- (void)ZAN_NEW_Consulting_Details_Infoid:(NSString *)new_id
                              andchannlid:(NSString *)channlid
                               andreplyId:(NSString *)replyid
                               completion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:
          @"%@/youguu/newsrest/info/commentReply/%@/%@/%@/%@/%@/%@/%@",
          IP_HTTP_DATA, ak_version, YouGu_User_sessionid, YouGu_User_USerid,
          channlid, new_id, replyid, @"1"];

  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

///******************************************************************************
// 函数名称 :-(void)Cai_COMMENTList_Zan_Consulting_Details_Infoid:(NSString
// *)new_id andchannlid:(NSString *)channlid andreplyId:(NSString *)replyid
// completion:(TRCompletion)completion
// 函数描述 :对财知道评论的赞
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/

#pragma mark - 对财知道评论的赞
// 对财知道评论的赞
- (void)Cai_COMMENTList_Zan_Consulting_Details_Infoid_Comment_id:
            (NSString *)commentid completion:(TRCompletion)completion {
  NSString *path =
      [NSString stringWithFormat:@"%@/bbs/reply/upComment/%@/%@/%@/%@",
                                 IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                                 YouGu_User_USerid, commentid];

  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

///******************************************************************************
// 函数名称 :-(void)getTopiclistgl_andStopicId:(NSString *)stopicId
// andStartnum:(int)startnum andPagesize:(int)pagesize
// completion:(TRCompletion)completion;
// 函数描述 :微热点
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/
//获取归类专题列表
- (void)getTopiclistgl_andStopicId:(NSString *)stopicId
                       andStartnum:(int)startnum
                       andPagesize:(int)pagesize
                        completion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:
          @"%@/youguu/newsrest/info/topiclistgl/%@/%@/%@/%@/%@/%d/%d",
          IP_HTTP_DATA, ak_version, YouGu_User_sessionid, YouGu_User_USerid,
          Iphone_Size(), stopicId, startnum, pagesize];
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

///******************************************************************************
// 函数名称 :Comments_List_AndChannelid:(NSString *)channelid
// AndInfoid:(NSString *)infoid AndStartnum:(int)startnum
// completion:(TRCompletion)completion
// 函数描述 评论列表
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/
//评论列表
- (void)Comments_List_AndChannelid:(NSString *)channelid
                         AndInfoid:(NSString *)infoid
                       AndStartnum:(int)startnum
                        completion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:
          @"%@/youguu/newsrest/info/newReplaylist/%@/%@/%@/%@/%@/%d/%@",
          IP_HTTP_DATA, ak_version, YouGu_User_sessionid, YouGu_User_USerid,
          channelid, infoid, startnum, @"20"];
  path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSURL *url = [NSURL URLWithString:path];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

///******************************************************************************
// 函数名称 :-(void)getTopicList_andTopicId:(int)topicId
// completion:(TRCompletion)completion
// 函数描述 :#pragma mark - 普通专题，和热门专题列表
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/
#pragma mark - 普通专题，和热门专题列表
//获取普通专题列表
- (void)getTopicList_andTopicId:(int)topicId
                     completion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:@"%@/youguu/newsrest/info/topiclist/%@/%@/%@/%@/%d",
                       IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                       YouGu_User_USerid, Iphone_Size(), topicId];

  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

///******************************************************************************
// 函数名称 :-(void)Praise_and_comments_num_AndChannelid:(NSString *)channelid
// AndInfoid:(NSString *)infoid completion:(TRCompletion)completion
// 函数描述 :获得赞和评论的个数
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/
//获得赞和评论的个数
- (void)Praise_and_comments_num_AndChannelid:(NSString *)channelid
                                   AndInfoid:(NSString *)infoid
                                  completion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:@"%@/youguu/newsrest/info/infonum/%@/%@/%@/%@/%@/%@",
                       IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                       YouGu_User_USerid, Iphone_Size(), channelid, infoid];
  path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

  NSURL *url = [NSURL URLWithString:path];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

///******************************************************************************
// 函数名称 :-(void)App_Recommendation_down_completion:(TRCompletion)completion
// 函数描述 :#pragma mark - 应用推荐接口
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/
#pragma mark - 应用推荐接口
//应用推荐接口
- (void)App_Recommendation_down_completion:(TRCompletion)completion {
  NSString *path =
      [NSString stringWithFormat:@"%@moreapp/%@/%@", IP_HTTP_APP_DOWN,
                                 ak_version, YouGu_User_sessionid];
  path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSURL *url = [NSURL URLWithString:path];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             if (state == 0) {
                               //          删除这篇，过去存储的文章
                               [[NSFileManager defaultManager]
                                   removeItemAtPath:
                                       pathInCacheDirectory(
                                           @"Collection.xmly/APP_Down_Sum.json")
                                              error:nil];
                               //   保存推荐app数据
                               [[Json_Data_Nsstring sharedManager]
                                   json_data_chche_file:response.dataValue
                                           andfile_name:@"APP_Down_Sum.json"];
                             }
                             completion(dic);
                             return;
                           }];
              }];
}

///******************************************************************************
// 函数名称 :-(void)Version_Upgrade_completion:(TRCompletion)completion
// 函数描述 :#pragma mark -版本更新
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/
//版本升级
- (void)Version_Upgrade_completion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:@"%@/jhss/member/doupdate/%@", IP_HTTP_USER, ak_version];
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

#pragma mark - 财知道，
/*
 *  财知道 ，热门，最新，消息  数据
 *
 *
 */
///******************************************************************************
// 函数名称 :-(void)Cai_Zui_Xin_start:(NSString *)bd_userid
// andend_limit:(NSString *)bd_ChannlId completion:(TRCompletion)completion
// 函数描述 ://最新排行
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/
//最新排行
- (void)Cai_Zui_Xin_start:(NSString *)bd_userid
             andend_limit:(NSString *)bd_ChannlId
               completion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:@"%@/bbs/article/newestTalkList/%@/%@/%@/%@/%@",
                       IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                       YouGu_User_USerid, bd_userid, bd_ChannlId];
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self
                    Data_processing:response
                         completion:^(int state, NSDictionary *dic) {
                           if (state == 0) {
                             if ([bd_userid intValue] == 0) {
                               //          删除这篇，过去存储的文章
                               [[NSFileManager defaultManager]
                                   removeItemAtPath:pathInCacheDirectory(
                                                        @"Collection.xmly/"
                                                        @"CAI_FIRSTVIEW_Down_"
                                                        @"Sum.json")
                                              error:nil];
                               //   保存推荐app数据
                               [[Json_Data_Nsstring sharedManager]
                                   json_data_chche_file:response.dataValue
                                           andfile_name:
                                               @"CAI_FIRSTVIEW_Down_Sum.json"];
                             }
                           }
                           completion(dic);
                           return;
                         }];
              }];
}

/*
 *  财知道 ，热门，最新，消息  数据
 *
 *
 */
//热门排行
- (void)Cai_Rot_top:(NSString *)start_limit
       andend_limit:(NSString *)end_limit
         completion:(TRCompletion)completion {
  NSString *iphone_size = Iphone_Size();
  NSString *path = [NSString
      stringWithFormat:@"%@/bbs/article/hotTalkList/%@/%@/%@/%@/%@/%@",
                       IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                       YouGu_User_USerid, start_limit, end_limit, iphone_size];
  NSLog(@"DDDE:%@", path);
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self
                    Data_processing:response
                         completion:^(int state, NSDictionary *dic) {
                           if (state == 0) {
                             if ([start_limit intValue] == 0) {
                               //          删除这篇，过去存储的文章
                               [[NSFileManager defaultManager]
                                   removeItemAtPath:pathInCacheDirectory(
                                                        @"Collection.xmly/"
                                                        @"CAI_SECONDVIEW_ROT_"
                                                        @"VIEW.json")
                                              error:nil];
                               //   保存推荐app数据
                               [[Json_Data_Nsstring sharedManager]
                                   json_data_chche_file:response.dataValue
                                           andfile_name:
                                               @"CAI_SECONDVIEW_ROT_VIEW.json"];
                             }
                           }
                           completion(dic);
                           return;
                         }];
              }];
}

///******************************************************************************
// 函数名称 :-(void)User_XINXI_uid:(NSString *)User_uid
// completion:(TRCompletion)completion
// 函数描述 ://用户个人信息接口
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/
//用户个人信息接口
- (void)User_XINXI_uid:(NSString *)User_uid
            completion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:@"%@/jhss/member/showmyinfo/%@/%@/%@", IP_HTTP_USER,
                       ak_version, YouGu_User_sessionid, YouGu_User_USerid];
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];

              }];
}

///******************************************************************************
// 函数名称 :-(void)Cai_NEWS_talk_id:(NSString *)talk_id
// completion:(TRCompletion)completion
// 函数描述 ://财知道帖子详情内容
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/
//帖子详情内容
- (void)Cai_NEWS_talk_id:(NSString *)talk_id
              completion:(TRCompletion)completion {
  NSString *path =
      [NSString stringWithFormat:@"%@/bbs/article/getOneTalk/%@/%@/%@/%@",
                                 IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                                 YouGu_User_USerid, talk_id];

  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService
      execRequest:r
       completion:^(RFResponse *response) {
         [self Data_processing:response
                    completion:^(int state, NSDictionary *dic) {
                      if (state == 0) {
                        NSString *file_name = [NSString
                            stringWithFormat:@"com.xmly/CAI_%@.json", talk_id];

                        if (talk_id && response.dataValue) {
                          //          删除这篇，过去存储的文章
                          [[NSFileManager defaultManager]
                              removeItemAtPath:pathInCacheDirectory(file_name)
                                         error:nil];

                          NSString *CAI_NEWS_id =
                              [NSString stringWithFormat:@"CAI_%@", talk_id];
                          //再保存，新的
                          [[Json_Data_Nsstring sharedManager]
                              Json_To_File:response.dataValue
                              andfile_name:CAI_NEWS_id];

                          [[The_NEWS_Focus_SQL sharedManager]
                                    saveUser:CAI_NEWS_id
                                 andchannlid:@"CAI"
                              andDescription:
                                  @"财知道——保存本地的数据"];
                        }
                      }
                      completion(dic);
                      return;
                    }];
       }];
}
///******************************************************************************
// 函数名称 :-(void)Cai_NEWS_review:(NSString *)talk_id  andstart:(NSString
// *)start completion:(TRCompletion)completion
// 函数描述 ://某个帖子的回复列表
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/
//某个帖子的回复列表
- (void)Cai_NEWS_review:(NSString *)talk_id
               andstart:(NSString *)start
             completion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:@"%@/bbs/reply/getOneTalkCommentList/%@/%@/%@/%@/%@/%@",
                       IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                       YouGu_User_USerid, talk_id, start, @"20"];
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}
/** 加载基金码表 */
- (void)loadFundTableWithLastModtime:(NSString *)modTime
                      withCompletion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:
          @"%@fincenWeb/fund/detail/getModifiedFundTable?lastmodtime=%@",
          IP_HTTP_SHOPPING, modTime];
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}
/*
 *  加入自选
 *  http://119.253.36.116/financeMarketWeb/financeMarket/addSelfSelection
 */
- (void)addMyOptionalWithFundId:(NSString *)fundId
                       withType:(NSString *)type
                     withUserId:(NSString *)userId
                 withCompletion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:@"%@/financeMarketWeb/financeMarket/addSelfSelection",
                       IP_HTTP];
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  [r addParam:fundId forKey:@"fundid"];
  [r addParam:type forKey:@"type"];
  [r addParam:userId forKey:@"userid"];
  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}
/*
 *  理财超市
 *  首页基金列表接口
 *  type 产品类型
 *  http://ip:port/fincenWeb/fund/recomm/list?type=1
 *  1：默认低收益；
    2：默认中等收益;
    3：默认高收益;
    10-不足100元低收益组合；
    11-青年低收益；
    12-青年中等收益；
    13-青年高收益；
    14-中年低收益；
    15-中年中等收益；
    16-中年高收益；
    17-老年低收益；
    18-老年中等收益；
    19-老年高收益
 */
- (void)loadFundListsWithType:(NSInteger)fundType
               withCompletion:(TRCompletion)completion {
  NSString *path =
      [NSString stringWithFormat:@"%@fincenWeb/fund/recomm/list?type=%ld",
                                 IP_HTTP_SHOPPING, (long)fundType];
  path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSURL *url = [NSURL URLWithString:path];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}
/**交易记录*/
- (void)sendRequestWithTradeUserId:(NSString *)userId
                    withCompletion:(TRCompletion)completion {
  // http://119.253.36.116/financeMarketWeb/financeMarket/queryEntrustCancellation
  // http://119.253.36.116/financeMarketWeb/financeMarket/transHis
  NSString *path = [NSString
      stringWithFormat:@"%@/financeMarketWeb/financeMarket/transHis", IP_HTTP];
  path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSURL *url = [NSURL URLWithString:path];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  [r addParam:userId forKey:@"userid"];
  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

/** 查委托/撤单页 */
- (void)sendRequestWithDelegateCheckUserId:(NSString *)userId
                            withCompletion:(TRCompletion)completion {
  // http://119.253.36.116/financeMarketWeb/financeMarket/queryEntrustCancellation
  NSString *path = [NSString
      stringWithFormat:
          @"%@/financeMarketWeb/financeMarket/queryEntrustCancellation",
          IP_HTTP];
  path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSURL *url = [NSURL URLWithString:path];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  [r addParam:userId forKey:@"userid"];
  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}
/* 撤单确认页 */
// http://119.253.36.116/financeMarketWeb/financeMarket/revoke
- (void)sendRequestWithAffirmUserId:(NSString *)userId
                     tradeAccountId:(NSString *)tradeAcco
                  serialnoAccountId:(NSString *)serialno
              andTradecodeAccountId:(NSString *)tradecode
                     withCompletion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:@"%@/financeMarketWeb/financeMarket/revoke", IP_HTTP];
  path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSURL *url = [NSURL URLWithString:path];

  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  [r addParam:userId forKey:@"userid"];
  [r addParam:tradeAcco forKey:@"tradeacco"];
  [r addParam:serialno forKey:@"serialno"];
  [r addParam:tradecode forKey:@"tradecode"];

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}
/****开户页*/
- (void)sendRequestWithOpenAcountFirstStepUserId:(NSString *)userId
                                        mobileId:(NSString *)mobile
                                        banknoId:(NSString *)bankno
                                      bankaccoId:(NSString *)bankacco
                                          idnoId:(NSString *)idno
                                       AndNameId:(NSString *)name
                                  withCompletion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:@"%@/financeMarketWeb/financeMarket/openAccount",
                       IP_HTTP];
  path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSURL *url = [NSURL URLWithString:path];

  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  [r addParam:userId forKey:@"userid"];
  [r addParam:bankno forKey:@"bankno"];
  [r addParam:name forKey:@"name"];
  [r addParam:mobile forKey:@"mobile"];
  [r addParam:idno forKey:@"idno"];
  [r addParam:bankacco forKey:@"bankacco"];

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}
///银行卡列表
- (void)sendRequestWithpartnerId:(NSString *)partnerId
                  withCompletion:(TRCompletion)completion {
  // http://119.253.36.116/financeMarketWeb/financeMarket/getPreference?userid=0
  NSString *path = [NSString
      stringWithFormat:
          @"%@/financeMarketWeb/financeMarket/getBankList?partnerid=%@",
          IP_HTTP, partnerId];
  path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSURL *url = [NSURL URLWithString:path];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  //  [r addParam:userId forKey:@"userid"];
  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

/* 开户验证码页 */
// http://119.253.36.116/financeMarketWeb/financeMarket/openAccountAuth
- (void)sendRequestWithOpenAcountFirstStepUserId:(NSString *)userId
                                      userbankid:(NSString *)userbankid
                               serialnoAccountId:(NSString *)serialno
                                  andCheckcodeId:(NSString *)checkcode
                                  withCompletion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:@"%@/financeMarketWeb/financeMarket/openAccountAuth",
                       IP_HTTP];
  path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSURL *url = [NSURL URLWithString:path];

  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  [r addParam:userId forKey:@"userid"];
  [r addParam:userbankid forKey:@"userbankid"];
  [r addParam:serialno forKey:@"serialno"];
  [r addParam:checkcode forKey:@"checkcode"];

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}
/* 开户设置密码页 */
// http://119.253.36.116/financeMarketWeb/financeMarket/setTradeCode
- (void)sendRequestWithSetPasswordtUserId:(NSString *)userId
                           andTradecodeId:(NSString *)tradecode
                           withCompletion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:@"%@/financeMarketWeb/financeMarket/setTradeCode",
                       IP_HTTP];
  path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSURL *url = [NSURL URLWithString:path];

  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  [r addParam:userId forKey:@"userid"];
  [r addParam:tradecode forKey:@"tradecode"];

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}
/**跳转申购页*/
// http://119.253.36.116/financeMarketWeb/financeMarket/toPurchase
- (void)sendRequestWithBuyUserId:(NSString *)userId
                       andFundId:(NSString *)fundid
                  withCompletion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:@"%@/financeMarketWeb/financeMarket/toPurchase",
                       IP_HTTP];
  path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSURL *url = [NSURL URLWithString:path];

  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  [r addParam:userId forKey:@"userid"];
  [r addParam:fundid forKey:@"fundid"];

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}
/**跳转赎回页*/
// http://119.253.36.116/financeMarketWeb/financeMarket/toRedeem
- (void)sendRequestWithRedeemUserId:(NSString *)userId
                          andFundId:(NSString *)fundid
                     withCompletion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:@"%@/financeMarketWeb/financeMarket/toRedeem", IP_HTTP];
  path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSURL *url = [NSURL URLWithString:path];

  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  [r addParam:userId forKey:@"userid"];
  [r addParam:fundid forKey:@"fundid"];

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

///众禄回调接口
// http://119.253.36.116/financeMarketWeb/financeMarket/oauthCallBackZL?refer=zlfund

- (void)sendRequestWithAuthorizationPageWithCompletion:
        (TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:
          @"%@/financeMarketWeb/financeMarket/oauthCallBackZL?refer=zlfund",
          IP_HTTP];
  path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSURL *url = [NSURL URLWithString:path];

  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}
///账户中心接口
- (void)sendRequestWithAccountCenterUserId:(NSString *)userid
                            withCompletion:(TRCompletion)completion {
  // http://119.253.36.116/financeMarketWeb/financeMarket/accountCenter?userid=0
  NSString *path = [NSString
      stringWithFormat:
          @"%@/financeMarketWeb/financeMarket/accountCenter?userid=%@", IP_HTTP,
          userid];
  path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSURL *url = [NSURL URLWithString:path];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  //  [r addParam:userId forKey:@"userid"];
  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}
/*  是否开户接口*/
// http://119.253.36.116/financeMarketWeb/financeMarket/isOpen
- (void)sendRequestWithIsOpenWithCompletion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:@"%@/financeMarketWeb/financeMarket/isOpen", IP_HTTP];
  path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSURL *url = [NSURL URLWithString:path];

  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}
///找回交易密码身份验证接口
- (void)sendRequestWithusernameId:(NSString *)username
                        AndidnoId:(NSString *)idno
                   withCompletion:(TRCompletion)completion {
  // http://119.253.36.116/financeMarketWeb/financeMarket/verifyIdentity?username=1111&idno=2222
  NSString *path =
      [NSString stringWithFormat:@"%@/financeMarketWeb/financeMarket/"
                                 @"verifyIdentity?username=%@&idno=%@",
                                 IP_HTTP, username, idno];
  path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSURL *url = [NSURL URLWithString:path];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  //  [r addParam:userId forKey:@"userid"];
  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}
///找回交易密码接口
- (void)sendRequestWithRetrieveTradeCodeUserId:(NSString *)userId
                                      AndPwdId:(NSString *)pwdId
                                withCompletion:(TRCompletion)completion {
  // http://119.253.36.116/financeMarketWeb/financeMarket/retrieveTradecode
  NSString *path = [NSString
      stringWithFormat:@"%@/financeMarketWeb/financeMarket/retrieveTradecode",
                       IP_HTTP];
  path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSURL *url = [NSURL URLWithString:path];

  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  [r addParam:userId forKey:@"userid"];
  [r addParam:pwdId forKey:@"pwd"];

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

/* 添加银行卡页 */
// http://119.253.36.116/financeMarketWeb/financeMarket/addBank
- (void)sendRequestWithAddBankUserId:(NSString *)userId
                            mobileId:(NSString *)mobile
                            banknoId:(NSString *)bankno
                       andbankaccoId:(NSString *)bankacco
                      withCompletion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:@"%@/financeMarketWeb/financeMarket/addBank", IP_HTTP];
  path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSURL *url = [NSURL URLWithString:path];

  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  [r addParam:userId forKey:@"userid"];
  [r addParam:mobile forKey:@"mobile"];
  [r addParam:bankno forKey:@"bankno"];
  [r addParam:bankacco forKey:@"bankacco"];

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

/*** 申购页*/
- (void)sendRequestWithBuyUserId:(NSString *)userId
                     tradecodeId:(NSString *)tradecode
                      uesrBankId:(NSString *)userBankId
                          fundId:(NSString *)fundId
                      AndMoneyId:(NSString *)money
                  withCompletion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:@"%@/financeMarketWeb/financeMarket/purchase", IP_HTTP];
  path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSURL *url = [NSURL URLWithString:path];

  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  [r addParam:userId forKey:@"userid"];
  [r addParam:userBankId forKey:@"userbankid"];
  [r addParam:money forKey:@"money"];
  [r addParam:fundId forKey:@"fundid"];
  [r addParam:tradecode forKey:@"tradecode"];

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}
/*** 赎回页*/
// http://119.253.36.116/financeMarketWeb/financeMarket/redeem
- (void)sendRequestWithRedemUserId:(NSString *)userId
                       tradecodeId:(NSString *)tradecode
                       largeflagId:(NSString *)largeflag
                        uesrBankId:(NSString *)userBankId
                            fundId:(NSString *)fundId
                      AndSubqutyId:(NSString *)subquty
                    withCompletion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:@"%@/financeMarketWeb/financeMarket/redeem", IP_HTTP];
  path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSURL *url = [NSURL URLWithString:path];

  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  [r addParam:userId forKey:@"userid"];
  [r addParam:userBankId forKey:@"userbankid"];
  [r addParam:subquty forKey:@"subquty"];
  [r addParam:fundId forKey:@"fundid"];
  [r addParam:tradecode forKey:@"tradecode"];
  [r addParam:largeflag forKey:@"largeflag"];
  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}
/*** 修改交易密码*/
// http://119.253.36.116/financeMarketWeb/financeMarket/updatePwd
- (void)sendRequestWithUpDatePwdUserId:(NSString *)userId
                              oldPwdId:(NSString *)oldpwd
                           AndNewPwdId:(NSString *)newpwd
                        withCompletion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:@"%@/financeMarketWeb/financeMarket/updatePwd", IP_HTTP];
  path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSURL *url = [NSURL URLWithString:path];

  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  [r addParam:userId forKey:@"userid"];
  [r addParam:oldpwd forKey:@"oldpwd"];
  [r addParam:newpwd forKey:@"newpwd"];

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

/** 加载我的自选码表 */
- (void)loadOptionalListsWithUserId:(NSString *)userId
                     withCompletion:(TRCompletion)completion {
  // http://119.253.36.116/financeMarketWeb/financeMarket/getSelfSelection
  NSString *path = [NSString
      stringWithFormat:@"%@/financeMarketWeb/financeMarket/getSelfSelection",
                       IP_HTTP_STOCK_Market];
  path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSURL *url = [NSURL URLWithString:path];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  [r addParam:userId forKey:@"userid"];
  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}
/** 删除自选 */
- (void)deleteFundListWithFundId:(NSMutableArray *)fundIdLists
                      withUserId:(NSString *)userId
                  withCompletion:(TRCompletion)completion {
  // http://119.253.36.116/financeMarketWeb/financeMarket/delSelfSelection
  NSString *path = [NSString
      stringWithFormat:@"%@/financeMarketWeb/financeMarket/delSelfSelection",
                       IP_HTTP_STOCK_Market];
  path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSURL *url = [NSURL URLWithString:path];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  [r addParam:userId forKey:@"userid"];
  NSMutableString *str;
  for (NSString *string in fundIdLists) {
    //逗号隔开
    if (str) {
      str = [NSMutableString stringWithFormat:@"%@,%@", str, string];
    } else {
      //首字符串
      str = [NSMutableString stringWithFormat:@"%@", string];
    }
  }
  [r addParam:str forKey:@"fundid"];
  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

/** 删除自选单个 */
- (void)deleteFundWithFundId:(NSString *)fundId
                  withUserId:(NSString *)userId
              withCompletion:(TRCompletion)completion {
  // http://119.253.36.116/financeMarketWeb/financeMarket/delSelfSelection
  NSString *path = [NSString
      stringWithFormat:@"%@/financeMarketWeb/financeMarket/delSelfSelection",
                       IP_HTTP_STOCK_Market];
  path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSURL *url = [NSURL URLWithString:path];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  [r addParam:userId forKey:@"userid"];

  //  NSMutableString *str;
  //  for (NSString *string in fundIdLists) {
  //    //逗号隔开
  //    if (str) {
  //      str =  [NSMutableString stringWithFormat:@"%@,%@", str, string];
  //    }else{
  //      //首字符串
  //      str = [NSMutableString stringWithFormat:@"%@", string];
  //    }
  //  }
  [r addParam:fundId forKey:@"fundid"];
  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

#if 1
/*
 * 查询我的资产（明细）
 * post
 * 参数：userId
 */
- (void)loadFundDetailWithUserId:(NSString *)userId
                  withCompletion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:@"%@/financeMarketWeb/financeMarket/transDetailed",
                       IP_HTTP_STOCK_Market];
  path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSURL *url = [NSURL URLWithString:path];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  [r addParam:userId forKey:@"userid"];
  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}
/*
 *  http://ip:port/youguu/newsrest/info/myReplyList?uid=48023&startnum=1&pagesize=1
 *  我的评论列表
 */
- (void)loadCommentListWithUserId:(NSString *)userId
                     withStartNum:(NSString *)startNum
                     withPageSize:(NSString *)pageSize
                   withCompletion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:
          @"%@/youguu/newsrest/info/myReplyList?uid=%@&startnum=%@&pagesize=%@",
          IP_HTTP_DATA, userId, startNum, pageSize];
  path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSURL *url = [NSURL URLWithString:path];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

/** 获取@我的列表 */
/** 获取用户风险偏好接口 */
- (void)loadResultOfRiskWithUserId:(NSString *)userId
                    withCompletion:(TRCompletion)completion {
  // http://119.253.36.116/financeMarketWeb/financeMarket/getPreference?userid=0
  NSString *path = [NSString
      stringWithFormat:
          @"%@/financeMarketWeb/financeMarket/getPreference?userid=%@",
          IP_HTTP_STOCK_Market, userId];
  path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSURL *url = [NSURL URLWithString:path];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  //  [r addParam:userId forKey:@"userid"];
  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}
#endif
///******************************************************************************
// 函数名称 :-(void)Cai_NEWS_review:(NSString *)talk_id  andstart:(NSString
// *)start completion:(TRCompletion)completion
// 函数描述 ://意见反馈
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/
#pragma mark -意见反馈
//意见反馈
- (void)Feedback_Feedtext:(NSString *)feedtext
               andContact:(NSString *)contact
               completion:(TRCompletion)completion {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSString *username = [defaults objectForKey:@"username"];
  NSString *path =
      [NSString stringWithFormat:@"%@/jhss/member/dofeedback/%@/%@/%@/%d/%@",
                                 IP_HTTP_USER, ak_version, YouGu_User_sessionid,
                                 YouGu_User_USerid, 3, @"not data"];

  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [r addParam:[CommonFunc base64StringFromText:feedtext] forKey:@"feedtext"];
  if (contact != nil) {
    [r addParam:contact forKey:@"contact"];
  }
  [r addParam:[CheckNetWork() stringByAddingPercentEscapesUsingEncoding:
                                  NSUTF8StringEncoding]
        forKey:@"am"];
  [r addParam:[NSString stringWithFormat:@"%@", Iphone_model()] forKey:@"ua"];
  [r addParam:[username stringByAddingPercentEscapesUsingEncoding:
                            NSUTF8StringEncoding]
        forKey:@"username"];
  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}
///******************************************************************************
// 函数名称 :-(void)ShowFeedBackList_completion:(TRCompletion)completion
// 函数描述 ://意见反馈列表
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/
//意见反馈列表
- (void)ShowFeedBackList_completion:(TRCompletion)completion {
  NSString *path =
      [NSString stringWithFormat:@"%@/jhss/member/showfeedbacklist/%@/%@/%@",
                                 IP_HTTP_USER, ak_version, YouGu_User_sessionid,
                                 YouGu_User_USerid];

  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self
                    Data_processing:response
                         completion:^(int state, NSDictionary *dic) {
                           if (state == 0) {
                             //          删除这篇，过去存储的文章
                             [[NSFileManager defaultManager]
                                 removeItemAtPath:
                                     pathInCacheDirectory(
                                         @"Collection.xmly/FackBack_List.json")
                                            error:nil];
                             //   保存反馈列表数据
                             [[Json_Data_Nsstring sharedManager]
                                 json_data_chche_file:response.dataValue
                                         andfile_name:@"FackBack_List.json"];
                           }
                           completion(dic);
                           return;
                         }];
              }];
}

///******************************************************************************
// 函数名称 :-(void)Text_Comments_AndChannelid:(NSString *)channelid
// AndInfoid:(NSString *)infoid AndContent:(NSString *)content
// completion:(TRCompletion)completion;
// 函数描述 :普通新闻正文页，评论和评论列表
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/
#pragma mark - 普通新闻正文页，评论和评论列表
//添加正文评论
- (void)Text_Comments_AndChannelid:(NSString *)channelid
                         AndInfoid:(NSString *)infoid
                        AndContent:(NSString *)content
                        completion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:@"%@/youguu/newsrest/info/replay/%@/%@/%@/%@/%@/%@",
                       IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                       YouGu_User_USerid, channelid, infoid, content];
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

///******************************************************************************
// 函数名称 :-(void)Reply_Comments_Text_Comments_AndChannelid:(NSString
// *)channelid AndInfoid:(NSString *)infoid AndContent:(NSString *)content
// and_be_do_userid:(NSString *)be_userid completion:(TRCompletion)completion
// 函数描述 :普通新闻正文页，回复，评论
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/
#pragma mark - 普通新闻正文页，回复，评论
//新闻详情，回复评论
- (void)Reply_Comments_Text_Comments_AndChannelid:(NSString *)channelid
                                        AndInfoid:(NSString *)infoid
                                       AndContent:(NSString *)content
                                 and_be_do_userid:(NSString *)be_userid
                                       completion:(TRCompletion)completion {
  content = [CommonFunc base64StringFromText:content];
  be_userid = [CommonFunc base64StringFromText:be_userid];
  NSString *path =
      [NSString stringWithFormat:@"%@/youguu/newsrest/info/newReplay/%@/%@/%@",
                                 IP_HTTP_DATA, channelid, infoid, be_userid];

  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];

  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];

  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  [r addParam:content forKey:@"content"];
  [r addParam:be_userid forKey:@"bid"];
  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

///******************************************************************************
// 函数名称 :-(void)Consulting_Evaluation_andChannelid:(NSString *)channelid
// andInfoid:(NSString *)infoid andLx:(int)lx
// completion:(TRCompletion)completion;
// 函数描述 :普通，新闻正文页，赞和评论接口
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/
#pragma mark - 普通，新闻正文页，赞和评论接口
// 赞接口   咨询评价
- (void)Consulting_Evaluation_andChannelid:(NSString *)channelid
                                 andInfoid:(NSString *)infoid
                                     andLx:(int)lx
                                completion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:@"%@/youguu/newsrest/info/infopj/%@/%@/%@/%@/%@/%d",
                       IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                       YouGu_User_USerid, channelid, infoid, lx];
  path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSURL *url = [NSURL URLWithString:path];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];

              }];
}

///******************************************************************************
// 函数名称 :-(void)add_Collect_NEW_id:(NSString *)newid andType:(NSString
// *)type andTitle:(NSString *)title comletion:(TRCompletion)completion
// completion:(TRCompletion)completion;
// 函数描述 :实名添加收藏
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/

- (void)add_Collect_NEW_id:(NSString *)newid
                   andType:(NSString *)type
                  andTitle:(NSString *)title
                 comletion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:
          @"%@/youguu/newsrest/info/addFavorite?id=%@&type=%@&title=%@",
          IP_HTTP_DATA, newid, type, title];
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

///******************************************************************************
// 函数名称 :-(void)Cancel_Collect_NEW_id:(NSString *)newid andType:(NSString
// *)type andTitle:(NSString *)title comletion:(TRCompletion)completion
// completion:(TRCompletion)completion;
// 函数描述 :实名取消收藏
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/

- (void)Cancel_Collect_id:(NSString *)collect_id
                comletion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:@"%@/youguu/newsrest/info/deleteFavorite?fid=%@",
                       IP_HTTP_DATA, collect_id];
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

///******************************************************************************
// 函数名称 :-(void)Query_Collect_comletion:(TRCompletion)completion
// 函数描述 :实名查询收藏
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/

- (void)Query_Collect_comletion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:@"%@/youguu/newsrest/info/queryFavorites", IP_HTTP_DATA];
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

///******************************************************************************
// 函数名称 :-(void)commentTalk:(NSString *)be_uid andBe_uname:(NSString
// *)be_uname andTalk_id:(NSString *)talk_id andContext:(NSString *)context
// andSlave_rid:(NSString *)slave_rid completion:(TRCompletion)completion;
// 函数描述 :用户回复，详情信息
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/
#pragma mark - 用户回复，详情信息
//用户回复，详情信息
- (void)commentTalk:(NSString *)be_uid
        andBe_uname:(NSString *)be_uname
         andTalk_id:(NSString *)talk_id
         andContext:(NSString *)context
       andSlave_rid:(NSString *)slave_rid
         completion:(TRCompletion)completion {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSString *nickname =
      [CommonFunc base64StringFromText:[defaults objectForKey:@"nickname"]];
  NSString *user_pic =
      [CommonFunc base64StringFromText:[defaults objectForKey:@"headpic"]];
  NSString *user_sign =
      [CommonFunc base64StringFromText:[defaults objectForKey:@"signature"]];
  NSString *User_name =
      [CommonFunc base64StringFromText:[defaults objectForKey:@"username"]];

  if ([be_uid length] == 0) {
    be_uid = @"-1";
  }

  be_uid = [CommonFunc base64StringFromText:be_uid];
  be_uname = [CommonFunc base64StringFromText:be_uname];
  talk_id = [CommonFunc base64StringFromText:talk_id];
  context = [CommonFunc base64StringFromText:context];
  slave_rid = [CommonFunc base64StringFromText:slave_rid];
  NSString *path = [NSString
      stringWithFormat:
          @"%@/bbs/reply/commentTalk/%@/%@/%@/%@/%@/%@/%@/%@/%@/%@/%@",
          IP_HTTP_DATA, ak_version, YouGu_User_sessionid, YouGu_User_USerid,
          nickname, user_pic, user_sign, User_name, be_uid, be_uname, talk_id,
          slave_rid];

  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];

  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  [r addParam:context forKey:@"context"];

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

///******************************************************************************
// 函数名称 :Ask_a_question_to_them:(NSString *)title andNick_Name:(NSString
// *)nick_name andPic:(NSString *)pic_url andSign:(NSString *)sign_label
// andbe_uid:(NSString *)be_uid andbe_nickname:(NSString *)be_nickname
// andContent_string:(NSString *)content_string
// completion:(TRCompletion)completion
// 函数描述 :向TA提问，详情信息
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/
#pragma mark - 向TA提问，详情信息
//向TA提问
- (void)Ask_a_question_to_them:(NSString *)title
                  andNick_Name:(NSString *)nick_name
                        andPic:(NSString *)pic_url
                       andSign:(NSString *)sign_label
                     andbe_uid:(NSString *)be_uid
                andbe_nickname:(NSString *)be_nickname
             andContent_string:(NSString *)content_string
                    completion:(TRCompletion)completion {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  title = [CommonFunc base64StringFromText:title];
  nick_name = [CommonFunc base64StringFromText:nick_name];
  pic_url = [CommonFunc base64StringFromText:pic_url];
  sign_label = [CommonFunc base64StringFromText:sign_label];
  be_uid = [CommonFunc base64StringFromText:be_uid];
  be_nickname = [CommonFunc base64StringFromText:be_nickname];
  content_string = [CommonFunc base64StringFromText:content_string];

  NSString *User_name = [defaults objectForKey:@"username"];
  NSString *path = [NSString
      stringWithFormat:@"%@/bbs/article/atHim/%@/%@/%@/%@/%@/%@/%@/%@/%@/%@",
                       IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                       YouGu_User_USerid, nick_name, title, pic_url, sign_label,
                       User_name, be_uid, be_nickname];
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                    resourcePathComponents:nil, nil];

  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  [r addParam:content_string forKey:@"context"];

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];

              }];
}

// VIP用户登入验证
- (void)Login_Authentication_VIP:(NSString *)username
                      AndUserpwd:(NSString *)userpwd
                      completion:(TRCompletion)completion {
  NSString *path =
      [NSString stringWithFormat:@"%@/jhss/member/dologonvip/%@/%@/%@",
                                 IP_HTTP_USER, ak_version, username, userpwd];
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

#pragma mark - log 日志，上传
/**
 *
 * LOG_日志，的上传接口
 *
 *
 **/
/**
 * @brief 将NSDictionary或NSArray转化为JSON串
 *
 * @param dic->json
 **/
- (NSString *)toJSONData:(id)theData {

  NSError *error = nil;
  id result = [NSJSONSerialization dataWithJSONObject:theData
                                              options:kNilOptions
                                                error:&error];
  if (error != nil)
    return nil;
  return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
}

//使用post方式，上传，log日志
- (void)Log_post_data:(NSString *)name
              andData:(NSArray *)log_array
           completion:(TRCompletion)completion {
  NSString *path = [NSString stringWithFormat:@"%@/stat/%@", IP_HTTP_LOG, name];
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  NSDictionary *dic_log_data =
      @{@"data" : log_array};
  NSString *End_data = [self toJSONData:dic_log_data];
  [r addParam:End_data forKey:@"data"];

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

#pragma mark - 百度云推送
/*
 *  百度云推送,用户绑定
 *
 *
 */
- (void)baidu_Push:(NSString *)bd_userid
      andChannelId:(NSString *)bd_ChannlId
        completion:(TRCompletion)completion {
  NSString *iphone_model = Iphone_model();
  NSString *checknet = CheckNetWork();
  NSString *path = [NSString
      stringWithFormat:
          @"%@/bind/pushuser/userrecode/binduser/%@/%@/%@/%@/%@/%@/%@",
          IP_HTTP_daidu_PUSH, ak_version, YouGu_User_sessionid,
          YouGu_User_USerid, bd_userid, bd_ChannlId, iphone_model, checknet];

  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                NSLog(@"百度推送绑定：%@", response);
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

/*
 *  百度云推送,解绑
 *
 *
 */
- (void)delbind_baidu_Push_completion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:@"%@/bind/pushuser/userrecode/delbind/%@/%@/%@",
                       IP_HTTP_daidu_PUSH, ak_version, YouGu_User_sessionid,
                       YouGu_User_USerid];
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

#pragma mark - 财知道，

//用户发言
- (void)User_fayan_query_uid:(NSString *)query_uid
                    andstart:(NSString *)start
                  completion:(TRCompletion)completion {
  NSString *path =
      [NSString stringWithFormat:@"%@/bbs/article/myTalkList/%@/%@/%@/%@/%@/%@",
                                 IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                                 YouGu_User_USerid, query_uid, start, @"20"];
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}
#pragma mark - 用户信息接口

//用户评论
- (void)User_Comment_query_uid:(NSString *)query_uid
                      andstart:(NSString *)start
                    completion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:@"%@/bbs/reply/myCommentList/%@/%@/%@/%@/%@/%@",
                       IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                       YouGu_User_USerid, query_uid, start, @"20"];
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

//获取系统头像列表
- (void)get_User_pic_completion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:@"%@/jhss/member/usericonlist/%@/%@", IP_HTTP_USER,
                       ak_version, YouGu_User_sessionid];
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

//修改用户信息（头像、昵称、个人签名）
- (void)Modification_User_pic_nick_sign:(NSData *)pic_data
                              andSysPic:(NSString *)syspic_url
                            andNickname:(NSString *)nickname
                            andSignture:(NSString *)signture
                             completion:(TRCompletion)completion {
  syspic_url = [CommonFunc base64StringFromText:syspic_url];
  nickname = [CommonFunc base64StringFromText:nickname];
  signture = [CommonFunc base64StringFromText:signture];

  NSString *path = [NSString
      stringWithFormat:@"%@/jhss/member/uploaduserpic/%@/%@/", IP_HTTP_USER,
                       ak_version, YouGu_User_sessionid];

  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                           bodyContentType:RFRequestBodyTypeMultiPartFormData
                    resourcePathComponents:nil, nil];

  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  [r addParam:nickname forKey:@"nickname"];
  [r addParam:@"1" forKey:@"sex"];
  [r addParam:signture forKey:@"signature"];

  [r addParam:syspic_url forKey:@"syspic"];

  if ([pic_data length] > 0) {
    [r addData:pic_data
           withFileName:@"image.jpg"
        withContentType:@"image/jpeg"
                 forKey:@"pic"];
  }

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

#pragma mark - 发帖接口
//发帖
- (void)Cai_Posting:(NSString *)title
         andNick_Name:(NSString *)nick_name
               andPic:(NSString *)pic_url
              andSign:(NSString *)sign_label
    andContent_string:(NSString *)content_string
           completion:(TRCompletion)completion {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSString *User_name =
      [CommonFunc base64StringFromText:[defaults objectForKey:@"username"]];
  title = [CommonFunc base64StringFromText:title];
  nick_name = [CommonFunc base64StringFromText:nick_name];
  pic_url = [CommonFunc base64StringFromText:pic_url];
  sign_label = [CommonFunc base64StringFromText:sign_label];
  content_string = [CommonFunc base64StringFromText:content_string];

  NSString *path = [NSString
      stringWithFormat:@"%@/bbs/article/releaseTalk/%@/%@/%@/%@/%@/%@/%@/%@",
                       IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                       YouGu_User_USerid, nick_name, title, pic_url, sign_label,
                       User_name];

  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];

  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];

  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [r addParam:content_string forKey:@"context"];

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

///******************************************************************************
// 函数名称 :
// -(void)The_server_time_calibration_completion:(TRCompletion)completion
// 函数描述 : 获取服务器的时间，
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/
#pragma mark -获取服务器的时间，
- (void)The_server_time_calibration_completion:(TRCompletion)completion {
  NSString *path =
      [NSString stringWithFormat:@"%@/youguu/simtrade/status", IP_HTTP_TIME];
  NSLog(@"path:%@", path);
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

///******************************************************************************
// 函数名称 : -(void)The_stock_market_code_completion:(TRCompletion)completion
// 函数描述 : 股票行情，
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/
#pragma mark -获取所有频道，
- (void)The_stock_market_code_completion:(TRCompletion)completion {
  NSString *path = [NSString
      stringWithFormat:
          @"%@/quote/stocklist/board/stock/curstatus/batch?code=%@,%@,%@",
          IP_HTTP_STOCK_Market, @"10000001", @"20399001", @"20399006"];

  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                id arr = [self requestFinished:response];
                if ([arr isKindOfClass:[NSArray class]] ||
                    [arr isKindOfClass:[NSMutableArray class]]) {
                  if ([arr count] > 0) {
                    completion(arr);
                  }
                }
              }];
}
//***********************************************************
//**********************
//*************************   packet，包解析了
//*************************
//************************************************************
- (id)requestFinished:(RFResponse *)request {
  //内容页面加载内容乱码
  if (!request) {
    return nil;
  }
  NSData *data = [request dataValue];
  if (data == nil || [data length] < 2) {
    return nil;
  }
  @try {
    //        NSLog(@"DDE:%@",data);

    NSMutableArray *tableDataArray = [self parseComPointPackageTables:data];
    NSString *status = nil;
    NSString *message = nil;

    for (int t = 0; t < [tableDataArray count]; t++) {
      //取得状态
      paketTableData *m_paketTableData = tableDataArray[t];
      if ([m_paketTableData.tableName isEqualToString:@"status"] == YES) {
        //状态表格
        NSMutableDictionary *dataDictionary =
            m_paketTableData.tableItemDataArray[0];
        status = dataDictionary[@"status"];
        message = dataDictionary[@"message"];
        if (![status isEqualToString:@"0000"]) {

          return nil;
        }
      } else {
        //                请求成功
        return m_paketTableData.tableItemDataArray;
      }
    }
  }
  @catch (NSException *ex) {
  }
  @finally {
  }
}

//解析逐点压缩表格
- (NSMutableArray *)parseComPointPackageTables:(NSData *)data {
  //取得数据总长度
  int m_corIndex = 12;

  //表格的数量
  int m_tableNumber = [data readIntAt:m_corIndex];
  m_corIndex += 4;

  NSMutableArray *tableDataArray = [[NSMutableArray alloc] init];

  for (int i = 0; i < m_tableNumber; i++) {
    paketTableData *m_paketTableData = [[paketTableData alloc] init];
    if (m_paketTableData) {
      //取得表名长度
      int title_lenth = [data readIntAt:m_corIndex];
      m_corIndex += 4;
      //表格名称
      NSString *table_name = [[NSString alloc]
          initWithData:[data subdataWithRange:NSMakeRange(m_corIndex,
                                                          title_lenth)]
              encoding:NSUTF8StringEncoding];
      m_paketTableData.tableName = table_name;
      m_corIndex += title_lenth;
      //表格字段数
      int field_Number = [data readIntAt:m_corIndex];
      m_paketTableData.tableConnumber = field_Number;
      m_corIndex += 4;
      //表格字段解析
      for (int j = 0; j < field_Number; j++) {
        tableFeildItemInfo *m_feildItemInfo = [[tableFeildItemInfo alloc] init];
        //解析是否有注释
        Byte *lenth = (Byte *)[data bytes];
        int expflage = lenth[m_corIndex] & 0xff;
        m_corIndex++;
        if (expflage == 1) {
          //有注释
          m_feildItemInfo.isNotes = YES;
        } else {
          //无注释
          m_feildItemInfo.isNotes = NO;
        }

        //解析字段类型
        NSString *fieltype = [[NSString alloc]
            initWithData:[data subdataWithRange:NSMakeRange(m_corIndex, 1)]
                encoding:NSUTF8StringEncoding];
        // NSLog(@"type: %@",fieltype);
        m_feildItemInfo.type = fieltype;
        m_corIndex++;

        //解析精度
        short Precision = [data readshortAt:m_corIndex];
        m_feildItemInfo.Precision = Precision;
        m_corIndex += 2;

        //解析字段最大长度
        int feildmaxlenth = [data readIntAt:m_corIndex];
        m_feildItemInfo.maxLenth = feildmaxlenth;
        m_corIndex += 4;

        //解析字段名称
        int name_lenth = [data readIntAt:m_corIndex];
        m_feildItemInfo.namelenth = name_lenth;
        m_corIndex += 4;
        NSString *feilname = [[NSString alloc]
            initWithData:[data subdataWithRange:NSMakeRange(m_corIndex,
                                                            name_lenth)]
                encoding:NSUTF8StringEncoding];
        // NSLog(@"name: %@",feilname);
        m_feildItemInfo.name = feilname;
        m_corIndex += name_lenth;

        //注释解析
        if (m_feildItemInfo.isNotes == YES) {
          int explain_lenth = [data readIntAt:m_corIndex];
          m_feildItemInfo.notesLenth = explain_lenth;
          m_corIndex += 4;
          NSString *feilname = [[NSString alloc]
              initWithData:[data subdataWithRange:NSMakeRange(m_corIndex,
                                                              explain_lenth)]
                  encoding:NSUTF8StringEncoding];
          m_feildItemInfo.notescontent = feilname;
          m_corIndex += explain_lenth;
        }
        [m_paketTableData.feldItemArray addObject:m_feildItemInfo];
      }
      //解析行数据
      int lineNumber = [data readIntAt:m_corIndex];
      m_paketTableData.tableLinenumber = lineNumber;
      m_corIndex += 4;
      for (int k = 0; k < m_paketTableData.tableLinenumber; k++) {
        NSMutableDictionary *dataDictionary =
            [[NSMutableDictionary alloc] init];
        //得到变量类型
        for (int h = 0; h < field_Number; h++) {
          tableFeildItemInfo *itemInfo = (m_paketTableData.feldItemArray)[h];
          if ([itemInfo.type isEqualToString:@"S"] ||
              [itemInfo.type isEqualToString:@"s"]) {
            //字符串类型
            int contentlent = [data readIntAt:m_corIndex];
            m_corIndex += 4;
            NSString *content = [[NSString alloc]
                initWithData:[data subdataWithRange:NSMakeRange(m_corIndex,
                                                                contentlent)]
                    encoding:NSUTF8StringEncoding];
            dataDictionary[itemInfo.name] = content;
            m_corIndex += contentlent;

          } else if ([itemInfo.type isEqualToString:@"N"] ||
                     [itemInfo.type isEqualToString:@"n"]) {
            int content = [data readIntAt:m_corIndex];
            m_corIndex += 4;
            NSNumber *numberdata = @(content);
            dataDictionary[itemInfo.name] = numberdata;
          } else if ([itemInfo.type isEqualToString:@"L"] ||
                     [itemInfo.type isEqualToString:@"l"]) {
            long long content = [data readInt64At:m_corIndex];
            // NSLog(@"L %@",itemInfo.name);
            m_corIndex += 8;
            NSNumber *numberdata = @(content);
            dataDictionary[itemInfo.name] = numberdata;
          } else if ([itemInfo.type isEqualToString:@"F"] ||
                     [itemInfo.type isEqualToString:@"f"]) {
            float content = [data readFloatAt:m_corIndex];
            // NSLog(@"L %@",itemInfo.name);
            m_corIndex += 4;
            NSNumber *numberdata = @(content);
            dataDictionary[itemInfo.name] = numberdata;
          } else if ([itemInfo.type isEqualToString:@"T"] ||
                     [itemInfo.type isEqualToString:@"t"]) {
            short content = [data readshortAt:m_corIndex];
            // NSLog(@"L %@",itemInfo.name);
            m_corIndex += 2;
            NSNumber *numberdata = @(content);
            dataDictionary[itemInfo.name] = numberdata;
          } else if ([itemInfo.type isEqualToString:@"D"] ||
                     [itemInfo.type isEqualToString:@"d"]) {
            double content = [data readDoubleAt:m_corIndex];
            // NSLog(@"L %@",itemInfo.name);
            m_corIndex += 8;
            NSNumber *numberdata = @(content);
            dataDictionary[itemInfo.name] = numberdata;
          } else if ([itemInfo.type isEqualToString:@"2"]) {
            //逐点压缩INT类型（COMPRESS_INT）
            NSNumber *temp = @(m_corIndex);
            int content = [data readCompressIntAt:&temp];
            NSNumber *numberdata = @(content);
            dataDictionary[itemInfo.name] = numberdata;
            m_corIndex = [temp intValue];
          } else if ([itemInfo.type isEqualToString:@"1"]) {
            //逐点压缩long 类型（COMPRESS_LONG）
            NSNumber *temp = @(m_corIndex);
            long long content = [data readCompressLongAt:&temp];
            NSNumber *numberdata = @(content);
            dataDictionary[itemInfo.name] = numberdata;
            m_corIndex = [temp intValue];
          } else if ([itemInfo.type isEqualToString:@"3"]) {
            //逐点压缩日期时间格式（COMPRESS_DATETIME
            //使用int型表示yyyyMMddhhmiss）
            long long content = [data readCompressDateTimeAt:m_corIndex];
            m_corIndex = m_corIndex + 4;
            NSNumber *numberdata = @(content);
            dataDictionary[itemInfo.name] = numberdata;
          }
        }

        [m_paketTableData.tableItemDataArray addObject:dataDictionary];
      }
    }
    [tableDataArray addObject:m_paketTableData];
  }
  return tableDataArray;
}

#pragma mark -广告id，
#pragma mark -广告id
#pragma mark -广告推广

///******************************************************************************
// 函数名称 : -(void)The_Salary_range_completion:(TRCompletion)completion
// 函数描述 : 激活上送接口
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/
#pragma mark -广告推广id，
- (void)The_Salary_range_completion:(TRCompletion)completion {
  NSString *appID = @"718149570";

  NSString *UDID = [OpenUDID value];

  NSString *macID = [SvUDIDTools getMacAddress];

  NSString *adfa = @"";

  if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled] ==
      YES) {
    adfa = [
        [[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
  }

  NSString *path = [NSString
      stringWithFormat:@"%@/stat/promote/activateNotify", IP_HTTP_LOG];
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders =
      @{@"ak" : ak_version};

  //    udid
  [r addParam:macID forKey:@"udid"];
  //    appID
  [r addParam:appID forKey:@"appid"];
  //    idfa
  [r addParam:adfa forKey:@"idfa"];
  //    opendudid
  [r addParam:UDID forKey:@"opendudid"];
  // 激活
  [r addParam:@"1" forKey:@"activateFlag"];

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

///******************************************************************************
// 函数名称 :
// -(void)The_registNotify_Salary_range_completion:(TRCompletion)completion
// 函数描述 : 注册上送接口
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/
#pragma mark - 注册上送接口
- (void)The_registNotify_Salary_range_completion:(TRCompletion)completion {
  NSString *appID = @"718149570";

  NSString *UDID = [OpenUDID value];

  NSString *macID = [SvUDIDTools getMacAddress];

  NSString *adfa = @"";

  if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled] ==
      YES) {
    adfa = [
        [[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
  }

  NSString *path =
      [NSString stringWithFormat:@"%@/stat/promote/registNotify", IP_HTTP_LOG];
  NSLog(@"消息广告id:%@", path);
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders =
      @{@"ak" : ak_version};

  //用户id
  [r addParam:YouGu_User_USerid forKey:@"userid"];

  //    udid
  [r addParam:macID forKey:@"udid"];
  //    appID
  [r addParam:appID forKey:@"appid"];
  //    idfa
  [r addParam:adfa forKey:@"idfa"];
  //    opendudid
  [r addParam:UDID forKey:@"opendudid"];
  // 激活
  [r addParam:@"1" forKey:@"registerFlag"];

  // ak
  [r addParam:ak_version forKey:@"ak"];
  //    设备身份码
  [r addParam:GetDeviceID() forKey:@"imei"];
  //    手机机型
  [r addParam:Iphone_model() forKey:@"model"];
  //    屏幕分辩率
  [r addParam:Iphone_Size() forKey:@"resolution"];
  //    操作系统版本号
  [r addParam:Iphone_OS() forKey:@"os"];
  //    运营商
  [r addParam:CarrierName() forKey:@"operator"];
  //    上网方式
  [r addParam:CarrierName() forKey:@"net"];

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

#pragma mark -工具箱接口，
#pragma mark -工具箱接口，
#pragma mark -工具箱接口，

#pragma mark -工资 区间，
- (void)The_Wage_Insurance_completion:(TRCompletion)completion {
  NSString *path = [NSString stringWithFormat:@"%@/taxLevel", IP_HTTP_Tools];
  NSLog(@"=========%@", path);
  //    NSLog(@"工资保险path:%@",path);
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

#pragma mark - 社保与公积金，不同城市，各百分比，
- (void)The_socialInsurance_completion:(TRCompletion)completion {
  NSString *path =
      [NSString stringWithFormat:@"%@/socialInsurance", IP_HTTP_Tools];
  //    NSLog(@"工资保险path:%@",path);
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}
#pragma mark - 存款利息利率
- (void)The_depositRate_completion:(TRCompletion)completion {
  NSString *path = [NSString stringWithFormat:@"%@/depositRate", IP_HTTP_Tools];
  //    NSLog(@"存款利息利率:%@",path);
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

#pragma mark - 外汇货币和名字字典
- (void)The_Forex_currency_and_Names_Dictionary_completion:
        (TRCompletion)completion {
  NSString *path = [NSString stringWithFormat:@"%@/foreignKey", IP_HTTP_Tools];
  //    NSLog(@"外汇货币和名字字典:%@",path);
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

#pragma mark - 外汇汇率接口
- (void)The_Foreign_Exchange_Rate_Interface_completion:
        (TRCompletion)completion {
  NSString *path =
      [NSString stringWithFormat:@"%@/foreignCurrency", IP_HTTP_Tools];
  //    NSLog(@"外汇货币和名字字典:%@",path);
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

#pragma mark - 房贷折扣问题
- (void)The_House_Exchange_Rate_completion:(TRCompletion)completion {
  NSString *path =
      [NSString stringWithFormat:@"%@/housingLoanRate", IP_HTTP_Tools];
  NSLog(@"房贷折扣问题:%@", path);
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

#pragma mark - 车贷
- (void)The_Four_Car_completion:(TRCompletion)completion {
  NSString *path = [NSString stringWithFormat:@"%@/lendingRate", IP_HTTP_Tools];
  NSLog(@"车贷:%@", path);
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

#pragma mark - 启动图接口访问，获取新图片的链接
- (void)StartPicAPIWithcompletion:(TRCompletion)completion {
  NSString *path = loadingImgAPI;
  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             return;
                           }];
              }];
}

#pragma mark －自选查询接口(吴国庆)
- (void)searchForPersonSelectedFundWithCompletion:(TRCompletion)completion {
  NSString *path =
      [NSString stringWithFormat:@"%@/youguu/simtrade/status", IP_HTTP_TIME];

  NSURL *url =
      [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                [self Data_processing:response
                           completion:^(int state, NSDictionary *dic) {
                             completion(dic);
                             // NSLog(@"---=-=-=-=-=-=-=-=-%@",dic);

                             // IP地址 ＋ 路径 ＋ 参数
                             return;
                           }];
              }];
}

@end
