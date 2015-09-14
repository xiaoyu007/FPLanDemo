///
//  WebServiceManager.m
//  TrafficReport
//
//  Created by zyhang on 12/6/12.
//  Copyright (c) 2012 Jamper. All rights reserved.
//

#import "Json+Data_Nsstring.h"

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
    NSAssert(_sharedManager == nil, @"Attempted to allocated a second instance");
    _sharedManager = [super alloc];
    return _sharedManager;
  }
  return nil;
}

- (id)init {
  self = [super init];
  if (self) {
  }
  return self;
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
- (void)Data_processing:(RFResponse *)response completion:(YouGu_Data_Completion)completion {
  if (!response) //      网络访问失败
  {
    completion(1, nil);
  } else {
    NSString *string = [CommonFunc textFromBase64String:response.stringValue];

    NSDictionary *dic = [string objectFromJSONString];
    if (dic &&
        [dic[@"status"] isEqualToString:@"0101"] ==
            YES) //   sessionid 是否，失效，失效后，登入验证，从新获取sessionid
    {
      [AppDelegate addAlertView];
      //      NSLog(@"0101,非法用户");
      //      [self logonOut];
      completion(2, dic);
      return;
    } else if (dic && [dic[@"status"] isEqualToString:@"0000"] == YES)
    {
      completion(0, dic);
      return;
    } else {
      completion(1, dic);
    }
  }
}
/** 非法用户 */
- (void)logonOut {
  [[NSNotificationCenter defaultCenter] postNotificationName:@"logoutAccount" object:nil];
}
/** 网络请求公共类(post) */
- (void)NetworkPostRequestsWithPath:(NSString *)path
                             andDic:(NSDictionary *)dic
                            andType:(RFRequestMethod)type
                      andCompletion:(TRCompletion)completion {
  NSURL *url = [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:type
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  for (NSString *key in [dic allKeys]) {
    [r addParam:dic[key] forKey:key];
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
/** 网络请求公共类 */
- (void)NetworkRequestsWithPath:(NSString *)path
                         andDic:(NSDictionary *)dic
                        andType:(RFRequestMethod)type
                  andCompletion:(TRCompletion)completion {
  NSURL *url = [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:type
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
- (void)getFundTableWithLastModtime:(NSString *)modTime withCompletion:(TRCompletion)completion {
  NSString *path =
      [NSString stringWithFormat:@"%@fincenWeb/fund/detail/getModifiedFundTable?lastmodtime=%@", IP_HTTP_SHOPPING, modTime];
  NSURL *url = [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
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
  NSString *path =
      [NSString stringWithFormat:@"%@financeMarketWeb/financeMarket/addSelfSelection", IP_HTTP_SHOPPING];
  NSURL *url = [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
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
- (void)loadFundListsWithType:(NSInteger)fundType withCompletion:(TRCompletion)completion {
  NSString *path =
      [NSString stringWithFormat:@"%@fincenWeb/fund/recomm/list?type=%ld", IP_HTTP_SHOPPING_SHOPPING, (long)fundType];
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
                     withPageIndex:(NSInteger)pageIndex
                      withPageSize:(NSInteger)pageSize
                    withCompletion:(TRCompletion)completion {
  // http://119.253.36.116/financeMarketWeb/financeMarket/queryEntrustCancellation
  // http://119.253.36.116/financeMarketWeb/financeMarket/transHis
  NSString *path = [NSString stringWithFormat:@"%@financeMarketWeb/financeMarket/transHis", IP_HTTP_SHOPPING];
  path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSURL *url = [NSURL URLWithString:path];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  NSString *indexStr = [NSString stringWithFormat:@"%ld", (long)pageIndex];
  NSString *sizeStr = [NSString stringWithFormat:@"%ld", (long)pageSize];
  [r addParam:indexStr forKey:@"pageIndex"];
  [r addParam:sizeStr forKey:@"pageSize"];
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
  NSString *path =
      [NSString stringWithFormat:@"%@financeMarketWeb/financeMarket/queryEntrustCancellation", IP_HTTP_SHOPPING];
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
/** 跳转撤单页 */
- (void)sendRequestWithDelegateCheckUserId:(NSString *)userId
                               TradeaccoId:(NSString *)tradeacco
                                serialnoId:(NSString *)serialno
                                 AndStatus:(NSString *)status
                            withCompletion:(TRCompletion)completion {
  // http://119.253.36.116/financeMarketWeb/financeMarket/queryEntrustCancellation
  NSString *path = [NSString stringWithFormat:@"%@financeMarketWeb/financeMarket/toRevoke", IP_HTTP_SHOPPING];
  path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSURL *url = [NSURL URLWithString:path];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  [r addParam:tradeacco forKey:@"tradeacco"];
  [r addParam:serialno forKey:@"serialno"];
  [r addParam:status forKey:@"status"];
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
  NSString *path = [NSString stringWithFormat:@"%@financeMarketWeb/financeMarket/revoke", IP_HTTP_SHOPPING];
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
  NSString *path =
      [NSString stringWithFormat:@"%@financeMarketWeb/financeMarket/openAccount", IP_HTTP_SHOPPING];
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
- (void)sendRequestWithpartnerId:(NSString *)partnerId withCompletion:(TRCompletion)completion {
  // http://119.253.36.116/financeMarketWeb/financeMarket/getPreference?userid=0
  NSString *path =
      [NSString stringWithFormat:@"%@/financeMarketWeb/financeMarket/getBankList?partnerid=%@", IP_HTTP_SHOPPING, partnerId];
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
  NSString *path =
      [NSString stringWithFormat:@"%@financeMarketWeb/financeMarket/openAccountAuth", IP_HTTP_SHOPPING];
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
  NSString *path =
      [NSString stringWithFormat:@"%@financeMarketWeb/financeMarket/setTradeCode", IP_HTTP_SHOPPING];
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
  NSString *path = [NSString stringWithFormat:@"%@financeMarketWeb/financeMarket/toPurchase", IP_HTTP_SHOPPING];
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

/**  判断产品是否可以代销*/
// http://192.168.1.12:4044/fincenWeb/fund/detail/getFundOnSale?fundid=000003
- (void)sendRequestWithIsBuyFundId:(NSString *)fundid withCompletion:(TRCompletion)completion {
  NSString *path =
      [NSString stringWithFormat:@"%@fincenWeb/fund/detail/getFundOnSale?fundid=%@", IP_HTTP_SHOPPING, fundid];
  path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSURL *url = [NSURL URLWithString:path];

  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

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
                     andTradeaccoId:(NSString *)tradeacco
                     withCompletion:(TRCompletion)completion {
  NSString *path = [NSString stringWithFormat:@"%@financeMarketWeb/financeMarket/toRedeem", IP_HTTP_SHOPPING];
  path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSURL *url = [NSURL URLWithString:path];

  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  [r addParam:userId forKey:@"userid"];
  [r addParam:fundid forKey:@"fundid"];
  [r addParam:tradeacco forKey:@"tradeacco"];

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

- (void)sendRequestWithAuthorizationPageRstcode:(NSString *)rstcode
                                 withCompletion:(TRCompletion)completion {
  NSString *path = [NSString stringWithFormat:@"%@%@", rstcode, YouGu_User_USerid];
  NSLog(@"%@:----", path);
  path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSURL *url = [NSURL URLWithString:path];

  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  //  [r addParam:rstcode forKey:@"rstcode"];

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
  NSString *path =
      [NSString stringWithFormat:@"%@/financeMarketWeb/financeMarket/accountCenter?userid=%@", IP_HTTP_SHOPPING, userid];
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
  NSString *path = [NSString stringWithFormat:@"%@financeMarketWeb/financeMarket/isOpen", IP_HTTP_SHOPPING];
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
  NSString *path = [NSString
      stringWithFormat:@"%@/financeMarketWeb/financeMarket/" @"verifyIdentity?username=%@&idno=%@", IP_HTTP_SHOPPING, username, idno];
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
                                         PwdId:(NSString *)pwdId
                                       phoneId:(NSString *)phone
                                AndVertifyCode:(NSString *)vertifyCode
                                withCompletion:(TRCompletion)completion {
  // http://119.253.36.116/financeMarketWeb/financeMarket/retrieveTradecode
  NSString *path =
      [NSString stringWithFormat:@"%@financeMarketWeb/financeMarket/retrieveTradecode", IP_HTTP_SHOPPING];
  path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSURL *url = [NSURL URLWithString:path];

  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodPost
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  [r addParam:userId forKey:@"userid"];
  [r addParam:pwdId forKey:@"pwd"];
  [r addParam:phone forKey:@"phone"];
  [r addParam:vertifyCode forKey:@"vertifyCode"];

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
  NSString *path = [NSString stringWithFormat:@"%@financeMarketWeb/financeMarket/addBank", IP_HTTP_SHOPPING];
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
  NSString *path = [NSString stringWithFormat:@"%@financeMarketWeb/financeMarket/purchase", IP_HTTP_SHOPPING];
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
  NSString *path = [NSString stringWithFormat:@"%@financeMarketWeb/financeMarket/redeem", IP_HTTP_SHOPPING];
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
  NSString *path = [NSString stringWithFormat:@"%@financeMarketWeb/financeMarket/updatePwd", IP_HTTP_SHOPPING];
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
- (void)loadOptionalListsWithUserId:(NSString *)userId withCompletion:(TRCompletion)completion {
  // http://119.253.36.116/financeMarketWeb/financeMarket/getSelfSelection
  NSString *path =
      [NSString stringWithFormat:@"%@financeMarketWeb/financeMarket/getSelfSelection", IP_HTTP_SHOPPING];
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
  NSString *path =
      [NSString stringWithFormat:@"%@financeMarketWeb/financeMarket/delSelfSelection", IP_HTTP_SHOPPING];
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
  NSString *path =
      [NSString stringWithFormat:@"%@financeMarketWeb/financeMarket/delSelfSelection", IP_HTTP_SHOPPING];
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
- (void)loadFundDetailWithUserId:(NSString *)userId withCompletion:(TRCompletion)completion {
  NSString *path =
      [NSString stringWithFormat:@"%@financeMarketWeb/financeMarket/transDetailed", IP_HTTP_SHOPPING];
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
      stringWithFormat:@"%@/youguu/newsrest/info/myReplyList?uid=%@&startnum=%@&pagesize=%@", IP_HTTP_DATA, userId, startNum, pageSize];
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
- (void)loadResultOfRiskWithUserId:(NSString *)userId withCompletion:(TRCompletion)completion {
  // http://119.253.36.116/financeMarketWeb/financeMarket/getPreference?userid=0
  NSString *path =
      [NSString stringWithFormat:@"%@/financeMarketWeb/financeMarket/getPreference?userid=%@", IP_HTTP_SHOPPING, userId];
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
  NSString *path =
      [NSString stringWithFormat:@"%@/jhss/member/dofeedback/%@/%@/%@/%d/%@", IP_HTTP_USER, ak_version,
                                 YouGu_User_sessionid, YouGu_User_USerid, 3, @"not data"];

  NSURL *url = [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
  RFRequest *r =
      [RFRequest requestWithURL:url type:RFRequestMethodPost resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [r addParam:[CommonFunc base64StringFromText:feedtext] forKey:@"feedtext"];
  if (contact != nil) {
    [r addParam:contact forKey:@"contact"];
  }
  [r addParam:[CheckNetWork() stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
        forKey:@"am"];
  [r addParam:[NSString stringWithFormat:@"%@", Iphone_model()] forKey:@"ua"];
  [r addParam:[CommonFunc base64StringFromText:[FPYouguUtil getUserName]] forKey:@"username"];
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
      [NSString stringWithFormat:@"%@/jhss/member/showfeedbacklist/%@/%@/%@", IP_HTTP_USER, ak_version, YouGu_User_sessionid, YouGu_User_USerid];

  NSURL *url = [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
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
                               [[NSFileManager defaultManager] removeItemAtPath:pathInCacheDirectory(@"Collection.xmly/FackBack_List.json")
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
  id result = [NSJSONSerialization dataWithJSONObject:theData options:kNilOptions error:&error];
  if (error != nil)
    return nil;
  return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
}

//使用post方式，上传，log日志
- (void)Log_post_data:(NSString *)name
              andData:(NSArray *)log_array
           completion:(TRCompletion)completion {
  NSString *path = [NSString stringWithFormat:@"%@/stat/%@", IP_HTTP_LOG, name];
  NSURL *url = [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
  RFRequest *r =
      [RFRequest requestWithURL:url type:RFRequestMethodPost resourcePathComponents:nil, nil];
  // additional headers
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  NSDictionary *dic_log_data = @{ @"data" : log_array };
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

#pragma mark - 财知道，

//用户发言
- (void)User_fayan_query_uid:(NSString *)query_uid
                    andstart:(NSString *)start
                  completion:(TRCompletion)completion {
  NSString *path =
      [NSString stringWithFormat:@"%@/bbs/article/myTalkList/%@/%@/%@/%@/%@/%@", IP_HTTP_DATA, ak_version,
                                 YouGu_User_sessionid, YouGu_User_USerid, query_uid, start, @"20"];
  NSURL *url = [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
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
- (void)deleteTalkWithTalkId:(NSString *)talkId
                withNickName:(NSString *)nickName
              withCompletion:(TRCompletion)completion {
  NSString *path =
      [NSString stringWithFormat:@"%@/bbs/article/deleteTalk/%@/%@/%@/%@/%@", IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                                 YouGu_User_USerid, talkId, [CommonFunc base64StringFromText:nickName]];
  NSURL *url = [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
  RFRequest *request = [RFRequest requestWithURL:url
                                            type:RFRequestMethodGet
                                 bodyContentType:RFRequestBodyTypeFormUrlEncoded
                          resourcePathComponents:nil, nil];
  request.additionalHTTPHeaders = YouGu_User_HTTPHeaders;
  [RFService execRequest:request
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
  NSString *path =
      [NSString stringWithFormat:@"%@/jhss/member/usericonlist/%@/%@", IP_HTTP_USER, ak_version, YouGu_User_sessionid];
  NSURL *url = [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
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
#pragma mark - 发帖接口
//发帖
- (void)Cai_Posting:(NSString *)title
       andNick_Name:(NSString *)nick_name
             andPic:(NSString *)pic_url
            andSign:(NSString *)sign_label
  andContent_string:(NSString *)content_string
         completion:(TRCompletion)completion {
  NSString *User_name = [CommonFunc base64StringFromText:[FPYouguUtil getUserName]];
  title = [CommonFunc base64StringFromText:title];
  nick_name = [CommonFunc base64StringFromText:nick_name];
  pic_url = [CommonFunc base64StringFromText:pic_url];
  sign_label = [CommonFunc base64StringFromText:sign_label];
  content_string = [CommonFunc base64StringFromText:content_string];

  NSString *path =
      [NSString stringWithFormat:@"%@/bbs/article/releaseTalk/%@/%@/%@/%@/%@/%@/%@/%@", IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                                 YouGu_User_USerid, nick_name, title, pic_url, sign_label, User_name];

  NSURL *url = [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];

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
  NSString *path = [NSString stringWithFormat:@"%@/youguu/simtrade/status", IP_HTTP_TIME];
  NSURL *url = [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
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
  NSString *path =
      [NSString stringWithFormat:@"%@/quote/stocklist/board/stock/curstatus/batch?code=%@,%@,%@",
                                 IP_HTTP_STOCK_Market, @"10000001", @"20399001", @"20399006"];

  NSURL *url = [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
  RFRequest *r = [RFRequest requestWithURL:url
                                      type:RFRequestMethodGet
                           bodyContentType:RFRequestBodyTypeFormUrlEncoded
                    resourcePathComponents:nil, nil];
  r.additionalHTTPHeaders = YouGu_User_HTTPHeaders;

  [RFService execRequest:r
              completion:^(RFResponse *response) {
                id arr = [self requestFinished:response];
                if (arr && ([arr isKindOfClass:[NSArray class]] || [arr isKindOfClass:[NSMutableArray class]])) {
                  if ([arr count] > 0) {
                    completion(arr);
                  }
                } else {
                  completion(nil);
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
        NSMutableDictionary *dataDictionary = m_paketTableData.tableItemDataArray[0];
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
  } @catch (NSException *ex) {
  } @finally {
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
      NSData *mdata = [data subdataWithRange:NSMakeRange(m_corIndex, title_lenth)];
      //表格名称
      NSString *table_name = [[NSString alloc] initWithData:mdata encoding:NSUTF8StringEncoding];
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
        NSString *fieltype =
            [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(m_corIndex, 1)]
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
        NSString *feilname =
            [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(m_corIndex, name_lenth)]
                                  encoding:NSUTF8StringEncoding];
        // NSLog(@"name: %@",feilname);
        m_feildItemInfo.name = feilname;
        m_corIndex += name_lenth;

        //注释解析
        if (m_feildItemInfo.isNotes == YES) {
          int explain_lenth = [data readIntAt:m_corIndex];
          m_feildItemInfo.notesLenth = explain_lenth;
          m_corIndex += 4;
          NSString *feilname =
              [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(m_corIndex, explain_lenth)]
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
        NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] init];
        //得到变量类型
        for (int h = 0; h < field_Number; h++) {
          tableFeildItemInfo *itemInfo = (m_paketTableData.feldItemArray)[h];
          if ([itemInfo.type isEqualToString:@"S"] || [itemInfo.type isEqualToString:@"s"]) {
            //字符串类型
            int contentlent = [data readIntAt:m_corIndex];
            m_corIndex += 4;
            NSString *content =
                [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(m_corIndex, contentlent)]
                                      encoding:NSUTF8StringEncoding];
            dataDictionary[itemInfo.name] = content;
            m_corIndex += contentlent;

          } else if ([itemInfo.type isEqualToString:@"N"] || [itemInfo.type isEqualToString:@"n"]) {
            int content = [data readIntAt:m_corIndex];
            m_corIndex += 4;
            NSNumber *numberdata = @(content);
            dataDictionary[itemInfo.name] = numberdata;
          } else if ([itemInfo.type isEqualToString:@"L"] || [itemInfo.type isEqualToString:@"l"]) {
            long long content = [data readInt64At:m_corIndex];
            // NSLog(@"L %@",itemInfo.name);
            m_corIndex += 8;
            NSNumber *numberdata = @(content);
            dataDictionary[itemInfo.name] = numberdata;
          } else if ([itemInfo.type isEqualToString:@"F"] || [itemInfo.type isEqualToString:@"f"]) {
            float content = [data readFloatAt:m_corIndex];
            // NSLog(@"L %@",itemInfo.name);
            m_corIndex += 4;
            NSNumber *numberdata = @(content);
            dataDictionary[itemInfo.name] = numberdata;
          } else if ([itemInfo.type isEqualToString:@"T"] || [itemInfo.type isEqualToString:@"t"]) {
            short content = [data readshortAt:m_corIndex];
            // NSLog(@"L %@",itemInfo.name);
            m_corIndex += 2;
            NSNumber *numberdata = @(content);
            dataDictionary[itemInfo.name] = numberdata;
          } else if ([itemInfo.type isEqualToString:@"D"] || [itemInfo.type isEqualToString:@"d"]) {
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

#pragma mark -工资 区间，
- (void)The_Wage_Insurance_completion:(TRCompletion)completion {
  NSString *path = [NSString stringWithFormat:@"%@/taxLevel", IP_HTTP_Tools];
  NSLog(@"=========%@", path);
  //    NSLog(@"工资保险path:%@",path);
  NSURL *url = [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
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
  NSString *path = [NSString stringWithFormat:@"%@/socialInsurance", IP_HTTP_Tools];
  //    NSLog(@"工资保险path:%@",path);
  NSURL *url = [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
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
  NSURL *url = [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
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
- (void)The_Forex_currency_and_Names_Dictionary_completion:(TRCompletion)completion {
  NSString *path = [NSString stringWithFormat:@"%@/foreignKey", IP_HTTP_Tools];
  //    NSLog(@"外汇货币和名字字典:%@",path);
  NSURL *url = [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
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
- (void)The_Foreign_Exchange_Rate_Interface_completion:(TRCompletion)completion {
  NSString *path = [NSString stringWithFormat:@"%@/foreignCurrency", IP_HTTP_Tools];
  //    NSLog(@"外汇货币和名字字典:%@",path);
  NSURL *url = [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
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
  NSString *path = [NSString stringWithFormat:@"%@/housingLoanRate", IP_HTTP_Tools];
  NSLog(@"房贷折扣问题:%@", path);
  NSURL *url = [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
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
  NSURL *url = [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
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
  NSURL *url = [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
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
  NSString *path = [NSString stringWithFormat:@"%@/youguu/simtrade/status", IP_HTTP_TIME];

  NSURL *url = [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
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
