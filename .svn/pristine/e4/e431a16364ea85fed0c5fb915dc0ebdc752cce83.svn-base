//
//  WebServiceManager.h
//  TrafficReport
//
//  Created by zyhang on 12/6/12.
//  Copyright (c) 2012 Jamper. All rights reserved.
//ƒ

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "NSDataCategory.h"
#import "CustomPageDada.h"

#import "RFService.h"
#import "RFRequest.h"
#import "RFResponse.h"

typedef void (^TRCompletion)(id response);

typedef void (^YouGu_Data_Completion)(
    int state, id result); // state 0.成功  1.失败  2.（非法用户）

@interface WebServiceManager : NSObject {
}

+ (WebServiceManager *)sharedManager;
+ (id)alloc;

/** 网络请求公共类(post) */
-(void)NetworkPostRequestsWithPath:(NSString *)path andDic:(NSDictionary *)dic andType:(RFRequestMethod)type andCompletion:(TRCompletion)completion;
////网络请求公共类
-(void)NetworkRequestsWithPath:(NSString *)path andDic:(NSDictionary *)dic andType:(RFRequestMethod)type andCompletion:(TRCompletion)completion;
#pragma mark - 意见反馈列表
/**
 * 函数描述 : 意见反馈列表
 * @param
 *     输入参数 :无
 * @return
 *      (void)
 */
- (void)ShowFeedBackList_completion:(TRCompletion)completion;

#pragma mark - 发表意见反馈
/**
 * 函数描述 : 发表意见反馈
 * @param
 *     输入参数 :feedtext（联系方式）、contact（反馈内容）
 * @return
 *      (void)
 */
- (void)Feedback_Feedtext:(NSString *)feedtext
               andContact:(NSString *)contact
               completion:(TRCompletion)completion;
#pragma mark - 使用post方式，上传，log日志
/**
 * 函数描述 : 使用post方式，上传，log日志
 * @param
 *     输入参数 :name（log标签，表示某一块log数据）、log_array（log内容）
 * @return
 *      (void)
 */
- (void)Log_post_data:(NSString *)name
              andData:(NSArray *)log_array
           completion:(TRCompletion)completion;

#pragma mark - //用户发言
/**
 * 函数描述 : //用户发言
 * @param
 *     输入参数 :query_uid（财知道正文id）、start（拉取的起始位置）
 * @return
 *      (void)
 */
- (void)User_fayan_query_uid:(NSString *)query_uid
                    andstart:(NSString *)start
                  completion:(TRCompletion)completion;
#pragma mark - //获取系统头像列表
/**
 * 函数描述 : //获取系统头像列表
 * @param
 *     输入参数 :无
 * @return
 *      (void)
 */
- (void)get_User_pic_completion:(TRCompletion)completion;
#pragma mark -（财知道）发帖
/**
 * 函数描述 :（财知道）发帖
 * @param
 *     输入参数
 * :title（标题）、nick_name（昵称）、pic_url（头像）、sign_label（签名）、content_string（财知道发帖内容）
 * @return
 *      (void)
 */
- (void)Cai_Posting:(NSString *)title
       andNick_Name:(NSString *)nick_name
             andPic:(NSString *)pic_url
            andSign:(NSString *)sign_label
  andContent_string:(NSString *)content_string
         completion:(TRCompletion)completion;

#pragma mark -获取服务器的时间，
/**
 * 函数描述 : 获取服务器的时间
 * @param
 *     输入参数 : 无
 * @return
 *      (void)
 */
- (void)The_server_time_calibration_completion:(TRCompletion)completion;

#pragma mark -获取股票行情，
/**
 * 函数描述 : 获取股票行情
 * @param
 *     输入参数 : 无
 * @return
 *      (void)
 */
- (void)The_stock_market_code_completion:(TRCompletion)completion;

#pragma mark -工具箱接口，
#pragma mark -工资保险（收税区间，
/**
 * 函数描述 : 工资保险（收税区间）
 * @param
 *     输入参数 : 无
 * @return
 *      (void)
 */
- (void)The_Wage_Insurance_completion:(TRCompletion)completion;

#pragma mark - 社保与公积金，不同城市，各百分比，
/**
 * 函数描述 : 社保与公积金，不同城市，各百分比，
 * @param
 *     launchOptions -
 * @return
 *     不同城市，社保与公积金所占比例，及上下区间
 */
- (void)The_socialInsurance_completion:(TRCompletion)completion;

#pragma mark - 存款利息利率
/**
 * 函数描述 : 存款利息利率
 * @param
 *     输入参数 : 无
 * @return
 *      (void)
 */
- (void)The_depositRate_completion:(TRCompletion)completion;
#pragma mark - 外汇货币和名字字典
/**
 * 函数描述 : 外汇货币和名字字典
 * @param
 *     输入参数 : 无
 * @return
 *      (void)
 */
- (void)The_Forex_currency_and_Names_Dictionary_completion:
    (TRCompletion)completion;
#pragma mark - 外汇汇率接口
/**
 * 函数描述 : 外汇汇率接口
 * @param
 *     输入参数 : 无
 * @return
 *      (void)
 */
- (void)The_Foreign_Exchange_Rate_Interface_completion:(TRCompletion)completion;

#pragma mark - 房贷折扣问题
/**
 * 函数描述 : 房贷折扣问题
 * @param
 *     输入参数 : 无
 * @return
 *      (void)
 */
- (void)The_House_Exchange_Rate_completion:(TRCompletion)completion;
#pragma mark - 车贷
/**
 * 函数描述 : 车贷
 * @param
 *     输入参数 : 无
 * @return
 *      (void)
 */
- (void)The_Four_Car_completion:(TRCompletion)completion;

/**
 * 函数描述 : 启动广告图片path，获取借口
 * @param
 *     输入参数 : 无
 * @return
 *      (void)
 */
#pragma mark - 启动图接口访问，获取新图片的链接
- (void)StartPicAPIWithcompletion:(TRCompletion)completion;
/**
 *  函数描述 : 获取基金的精品推荐类表
 *  @param
 *      输入参数 : type
 *  @return
 *      (void)
 */
- (void)loadFundListsWithType:(NSInteger)fundType
               withCompletion:(TRCompletion)completion;
/*
 * 函数描述：查询我的资产（明细）
 * post
 * @param
 *    输入参数：userid
 * @return
 *    （void）
 */
- (void)loadFundDetailWithUserId:(NSString *)userId
                  withCompletion:(TRCompletion)completion;

/*
 *函数描述：查委托/撤单页
 * post
 * @param
 *    输入参数：userid
 * @return
 *    （void）
 */
- (void)sendRequestWithDelegateCheckUserId:(NSString *)userId
                            withCompletion:(TRCompletion)completion;


/** 跳转撤单页 */
/*
 *函数描述：跳转撤单页
 * post
 * @param
 *    输入参数：userid
 * @return
 *    （void）
 */

- (void)sendRequestWithDelegateCheckUserId:(NSString *)userId TradeaccoId:(NSString *)tradeacco serialnoId:(NSString *)serialno AndStatus:(NSString *)status withCompletion:(TRCompletion)completion;
/*
 *函数描述：确认撤单页
 * post
 * @param
 *    输入参数：userid,tradeAcco,serialno,tradecode
 * @return
 *    （void）
 */
- (void)sendRequestWithAffirmUserId:(NSString *)userId
                     tradeAccountId:(NSString *)tradeAcco
                  serialnoAccountId:(NSString *)serialno
              andTradecodeAccountId:(NSString *)tradecode
                     withCompletion:(TRCompletion)completion;

/*
 *  函数描述：获取用户风险偏好接口
 *  @param
 *    输入参数：userid
 *  @return
 *    (void)
 */
- (void)loadResultOfRiskWithUserId:(NSString *)userId
                    withCompletion:(TRCompletion)completion;
/*
 *  函数描述：获取用户交易记录
 *  @param
 *    输入参数：userid
 *  @return
 *   (void)
 */
- (void)sendRequestWithTradeUserId:(NSString *)userId
                     withPageIndex:(NSInteger)pageIndex
                      withPageSize:(NSInteger)pageSize
                    withCompletion:(TRCompletion)completion;
/*
 *  函数描述：开户验证码（短信）
 *  @param
 *    输入参数：userid，userbankid，serialno，checkcode
 *  @return
 *   (void)
 */
- (void)sendRequestWithOpenAcountFirstStepUserId:(NSString *)userId
                                      userbankid:(NSString *)userbankid
                               serialnoAccountId:(NSString *)serialno
                                  andCheckcodeId:(NSString *)checkcode
                                  withCompletion:(TRCompletion)completion;

/*
 *  函数描述：开户关联银行卡页
 *  @param
 *    输入参数：userid，mobile，bankno，idno，name
 *  @return
 *   (void)
 */
- (void)sendRequestWithOpenAcountFirstStepUserId:(NSString *)userId
                                        mobileId:(NSString *)mobile
                                        banknoId:(NSString *)bankno
                                      bankaccoId:(NSString *)bankacco
                                          idnoId:(NSString *)idno
                                       AndNameId:(NSString *)name
                                  withCompletion:(TRCompletion)completion;
/*
 *  函数描述：开户设置密码页
 *  @param
 *    输入参数：userid，tradecode
 *  @return
 *   (void)
 */
- (void)sendRequestWithSetPasswordtUserId:(NSString *)userId
                           andTradecodeId:(NSString *)tradecode
                           withCompletion:(TRCompletion)completion;
/*
 *  函数描述：跳转申购页
 *  @param
 *    输入参数：userid，fundid
 *  @return
 *   (void)
 */
- (void)sendRequestWithBuyUserId:(NSString *)userId
                       andFundId:(NSString *)fundid
                  withCompletion:(TRCompletion)completion;

/*
 *  函数描述：跳转申购页判断是否可以代销
 *  @param
 *    输入参数：fundid
 *  @return
 *   (void)
 */
- (void)sendRequestWithIsBuyFundId:(NSString *)fundid
                    withCompletion:(TRCompletion)completion;

/*
 *  函数描述：跳转赎回页
 *  @param
 *    输入参数：userid，fundid
 *  @return
 *   (void)
 */
- (void)sendRequestWithRedeemUserId:(NSString *)userId
                          andFundId:(NSString *)fundid andTradeaccoId:(NSString *)tradeacco
                     withCompletion:(TRCompletion)completion;
/*
 *  函数描述：众禄授权页
 *  @param
 *    输入参数：无
 *  @return
 *   (void)
 */
//- (void)sendRequestWithAuthorizationPageWithCompletion:(TRCompletion)completion;
- (void)sendRequestWithAuthorizationPageRstcode:(NSString *)rstcode withCompletion:(TRCompletion)completion;

///账户中心接口
/*
 *  函数描述：用户授权页
 *  @param
 *    输入参数：userid
 *  @return
 *   (void)
 */
- (void)sendRequestWithAccountCenterUserId:(NSString *)userid
                            withCompletion:(TRCompletion)completion;
/*  是否开户接口*/
/*
 *  函数描述：账户中心页
 *  @param
 *    输入参数：userid
 *  @return
 *   (void)
 */
- (void)sendRequestWithIsOpenWithCompletion:(TRCompletion)completion;
///找回交易密码身份验证接口
/*
 *  函数描述：用户授权页
 *  @param
 *    输入参数：无
 *  @return
 *   (void)
 */
- (void)sendRequestWithusernameId:(NSString *)username
                        AndidnoId:(NSString *)idno
                   withCompletion:(TRCompletion)completion;

///找回交易密码接口
- (void)sendRequestWithRetrieveTradeCodeUserId:(NSString *)userId
                                         PwdId:(NSString *)pwdId phoneId:(NSString *)phone AndVertifyCode:(NSString *)vertifyCode
                                withCompletion:(TRCompletion)completion;
/* 添加银行卡页 */
/*
 *  函数描述：添加银行卡页(账户中心页)
 *  @param
 *    输入参数：无
 *  @return
 *   (void)
 */
// http://119.253.36.116/financeMarketWeb/financeMarket/addBank
- (void)sendRequestWithAddBankUserId:(NSString *)userId
                            mobileId:(NSString *)mobile
                            banknoId:(NSString *)bankno
                       andbankaccoId:(NSString *)bankacco
                      withCompletion:(TRCompletion)completion;
/*
 *  函数描述：申购页
 *  @param
 *    输入参数：userid，userbankid，tradecode，fundid，money
 *  @return
 *   (void)
 */
- (void)sendRequestWithBuyUserId:(NSString *)userId
                     tradecodeId:(NSString *)tradecode
                      uesrBankId:(NSString *)userBankId
                          fundId:(NSString *)fundId
                      AndMoneyId:(NSString *)money
                  withCompletion:(TRCompletion)completion;
/*
 *  函数描述：赎回页
 *  @param
 *    输入参数：userid，userbankid，tradecode，fundid，subquty
 *  @return
 *   (void)
 */
- (void)sendRequestWithRedemUserId:(NSString *)userId
                       tradecodeId:(NSString *)tradecode
                       largeflagId:(NSString *)largeflag
                        uesrBankId:(NSString *)userBankId
                            fundId:(NSString *)fundId
                      AndSubqutyId:(NSString *)subquty
                    withCompletion:(TRCompletion)completion;
/*
 *  函数描述：修改交易密码
 *  @param
 *    输入参数：userid，oldpwd，newpwd
 *  @return
 *   (void)
 */
- (void)sendRequestWithUpDatePwdUserId:(NSString *)userId
                              oldPwdId:(NSString *)oldpwd
                           AndNewPwdId:(NSString *)newpwd
                        withCompletion:(TRCompletion)completion;
/** 加载我的自选列表 */
- (void)loadOptionalListsWithUserId:(NSString *)userId
                     withCompletion:(TRCompletion)completion;

///添加银行卡
- (void)sendRequestWithpartnerId:(NSString *)partnerId
                  withCompletion:(TRCompletion)completion;

/*
 *  加入自选
 *  http://119.253.36.116/financeMarketWeb/financeMarket/addSelfSelection
 */
- (void)addMyOptionalWithFundId:(NSString *)fundId
                       withType:(NSString *)type
                     withUserId:(NSString *)userId
                 withCompletion:(TRCompletion)completion;
/**
 *  @brief 删除自选
 *
 *  @param 输入参数：userid, fundIdLists，completion
 *
 *  @return 返回void
 */
- (void)deleteFundListWithFundId:(NSMutableArray *)fundIdLists
                      withUserId:(NSString *)userId
                  withCompletion:(TRCompletion)completion;

/** 删除自选单个 */
/**
 *  @brief 删除自选
 *
 *  @param 输入参数：userid, fundId，completion
 *
 *  @return 返回void
 */
- (void)deleteFundWithFundId:(NSString *)fundId
                  withUserId:(NSString *)userId
              withCompletion:(TRCompletion)completion;

/**
 *  我的评论列表
 */
- (void)loadCommentListWithUserId:(NSString *)userId
                     withStartNum:(NSString *)startNum
                     withPageSize:(NSString *)pageSize
                   withCompletion:(TRCompletion)completion;
/** 删除帖子 */
- (void)deleteTalkWithTalkId:(NSString *)talkId
                withNickName:(NSString *)nickName
              withCompletion:(TRCompletion)completion;
@end
