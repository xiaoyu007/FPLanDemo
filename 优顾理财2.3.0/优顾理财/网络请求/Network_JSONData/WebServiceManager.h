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

typedef void (^YouGu_Data_Completion)(int state,id result);//state 0.成功  1.失败  2.（非法用户）

@interface WebServiceManager : NSObject
{

}

+(WebServiceManager *)sharedManager;
+(id)alloc;

#pragma mark -微信获取，token 值 openid
/**
 * 函数描述 :微信获取，token 值 openid
 * @param
 *     输入参数 : 无
 * @return
 *      (void)
 */
-(void)WX_Code:(NSString *)code andAppid:(NSString *)appid andSecret:(NSString *)secret completion:(TRCompletion)completion;


#pragma mark - 微信获取用户基本信息
/**
 * 函数描述 :微信获取用户基本信息
 * @param
 *     输入参数 : 无
 * @return
 *      (void)
 */
-(void)WX_access_token:(NSString *)token andOpenid:(NSString *)openid completion:(TRCompletion)completion;


#pragma mark - 获取所有频道，
/**
 * 函数描述 :获取所有频道，
 * @param
 *     输入参数 : 无
 * @return
 *      (void)
 */
-(void)YOUGUU_ALL_Channlid:(TRCompletion)completion;


#pragma mark - //基本信息(FirstView,cell的数据)
/**
 * 函数描述 ://基本信息(FirstView,cell的数据)
 * @param
 *     输入参数 : channlid_id(频道id)、startnum(从哪一条开始拉取数据)
 * @return
 *      (void)
 */
-(void)Basic_Information_andChannelid:(NSString *)channlid_id andStartnum:(int)startnum completion:(TRCompletion)completion;


#pragma mark - 普通，新闻正文页，具体新闻接口（新的API接口）
/**
 * 函数描述 :普通，新闻正文页，具体新闻接口（新的API接口）
 * @param
 *     输入参数 : channlid_id(频道id)、new_id（文章id）
 * @return
 *      (void)
 */
-(void)NEW_Consulting_Details_andChannelid:(NSString *)channelid andInfoid:(NSString *)new_id completion:(TRCompletion)completion;

#pragma mark - 新闻正文，相关文章（新的API接口）
/**
 * 函数描述 :新闻正文，相关文章
 * @param
 *     输入参数 :new_id（文章id）
 * @return
 *      (void)
 */
-(void)NEW_Consulting_Details_Infoid:(NSString *)new_id completion:(TRCompletion)completion;

///******************************************************************************
// 函数名称 :-(void)getTopiclistgl_andStopicId:(NSString *)stopicId andStartnum:(int)startnum andPagesize:(int)pagesize completion:(TRCompletion)completion;
// 函数描述 :微热点
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/
//获取归类专题列表
#pragma mark - /获取归类专题列表（微热点）
/**
 * 函数描述 :/获取归类专题列表（微热点）
 * @param
 *     输入参数 :stopicId(专题id)、startnum（拉取数据的，起始位置）pagesize（每次拉取的条数）
 * @return
 *      (void)
 */

-(void)getTopiclistgl_andStopicId:(NSString *)stopicId andStartnum:(int)startnum andPagesize:(int)pagesize completion:(TRCompletion)completion;

#pragma mark - // 新闻资讯，赞功能
/**
 * 函数描述 :// 新闻资讯，赞功能
 * @param
 *     输入参数 :new_id(文章id)、channlid（频道id）、replyid（点赞用户的id）
 * @return
 *      (void)
 */
-(void)ZAN_NEW_Consulting_Details_Infoid:(NSString *)new_id andchannlid:(NSString *)channlid andreplyId:(NSString *)replyid completion:(TRCompletion)completion;

#pragma mark - 对财知道评论的赞
/**
 * 函数描述 : 对财知道评论的赞
 * @param
 *     输入参数 :commentid(财知道正文id)
 * @return
 *      (void)
 */
-(void)Cai_COMMENTList_Zan_Consulting_Details_Infoid_Comment_id:(NSString *)commentid completion:(TRCompletion)completion;

#pragma mark -（新闻）评论列表
/**
 * 函数描述 : 新闻）评论列表
 * @param
 *     输入参数 :channelid(频道id)、infoid（文章id）、startnum（从哪一条开始拉取）
 * @return
 *      (void)
 */
-(void)Comments_List_AndChannelid:(NSString *)channelid AndInfoid:(NSString *)infoid AndStartnum:(int)startnum completion:(TRCompletion)completion;

#pragma mark - 普通专题
/**
 * 函数描述 : 普通专题
 * @param
 *     输入参数 :topicId(普通专题id)
 * @return
 *      (void)
 */
-(void)getTopicList_andTopicId:(int)topicId   completion:(TRCompletion)completion;

#pragma mark - 获得赞和评论的个数
/**
 * 函数描述 : 获得赞和评论的个数
 * @param
 *     输入参数 :channelid(频道id)、infoid（文章id）
 * @return
 *      (void)
 */
-(void)Praise_and_comments_num_AndChannelid:(NSString *)channelid AndInfoid:(NSString *)infoid completion:(TRCompletion)completion;

#pragma mark - 应用推荐接口
/**
 * 函数描述 : 应用推荐接口
 * @param
 *     输入参数 :无
 * @return
 *      (void)
 */
-(void)App_Recommendation_down_completion:(TRCompletion)completion;

#pragma mark - 版本升级
/**
 * 函数描述 : 版本升级
 * @param
 *     输入参数 :无
 * @return
 *      (void)
 */
-(void)Version_Upgrade_completion:(TRCompletion)completion;

#pragma mark - 意见反馈列表
/**
 * 函数描述 : 意见反馈列表
 * @param
 *     输入参数 :无
 * @return
 *      (void)
 */
-(void)ShowFeedBackList_completion:(TRCompletion)completion;

#pragma mark - 发表意见反馈
/**
 * 函数描述 : 发表意见反馈
 * @param
 *     输入参数 :feedtext（联系方式）、contact（反馈内容）
 * @return
 *      (void)
 */
-(void)Feedback_Feedtext:(NSString *)feedtext  andContact:(NSString *)contact  completion:(TRCompletion)completion;

#pragma mark - 新闻详情页（发表评论）
/**
 * 函数描述 : 新闻详情页（发表评论）
 * @param
 *     输入参数 :channelid（频道id）、infoid（文章id）、content（评论内容）
 * @return
 *      (void)
 */
-(void)Text_Comments_AndChannelid:(NSString *)channelid AndInfoid:(NSString *)infoid AndContent:(NSString *)content completion:(TRCompletion)completion;

#pragma mark - 新闻详情页（回复评论）
/**
 * 函数描述 : 新闻详情页（回复评论）
 * @param
 *     输入参数 :channelid（频道id）、infoid（文章id）、content（评论内容）、be_userid（被评论用户的id）
 * @return
 *      (void)
 */
-(void)Reply_Comments_Text_Comments_AndChannelid:(NSString *)channelid AndInfoid:(NSString *)infoid AndContent:(NSString *)content and_be_do_userid:(NSString *)be_userid completion:(TRCompletion)completion;

#pragma mark - 新闻赞接口
/**
 * 函数描述 : 新闻赞接口
 * @param
 *     输入参数 :channelid（频道id）、infoid（文章id）、lx（默认为1）
 * @return
 *      (void)
 */
-(void)Consulting_Evaluation_andChannelid:(NSString *)channelid andInfoid:(NSString *)infoid andLx:(int)lx completion:(TRCompletion)completion;

#pragma mark - 用户回复，详情信息
/**
 * 函数描述 : 用户回复，详情信息
 * @param
 *     输入参数 :be_uid（用户id）、be_uname（用户昵称id）、talk_id（评论id）、context（回复内容）、slave_rid（被回复的用户id）
 * @return
 *      (void)
 */
-(void)commentTalk:(NSString *)be_uid andBe_uname:(NSString *)be_uname andTalk_id:(NSString *)talk_id andContext:(NSString *)context andSlave_rid:(NSString *)slave_rid completion:(TRCompletion)completion;

#pragma mark - 向TA提问
/**
 * 函数描述 : 向TA提问
 * @param
 *     输入参数 :title（标题）、nick_name（用户昵称）、pic_url（用户头像）、sign_label（用户签名）、be_uid（被提问用户的id）、be_nickname（被提问用户的昵称）、content_string（提问的内容）
 * @return
 *      (void)
 */
-(void)Ask_a_question_to_them:(NSString *)title andNick_Name:(NSString *)nick_name andPic:(NSString *)pic_url andSign:(NSString *)sign_label andbe_uid:(NSString *)be_uid andbe_nickname:(NSString *)be_nickname andContent_string:(NSString *)content_string completion:(TRCompletion)completion;

#pragma mark - 离线下载
/**
 * 函数描述 : 离线下载
 * @param
 *     输入参数 :channlid_id（频道id）、startnum（从哪一条数据开始拉取）
 * @return
 *      (void)
 */

-(void)WI_FI_Basic_Information:(NSString *)channlid_id andStartnum:(int)startnum completion:(TRCompletion)completion;

#pragma mark - 实名添加收藏
/**
 * 函数描述 : 实名添加收藏
 * @param
 *     输入参数 :newid（文章id）、type（类型，1，新闻，2.财知道）、title（收藏标题）
 * @return
 *      (void)
 */
-(void)add_Collect_NEW_id:(NSString *)newid andType:(NSString *)type andTitle:(NSString *)title comletion:(TRCompletion)completion;

#pragma mark - 实名取消收藏
/**
 * 函数描述 : 实名取消收藏
 * @param
 *     输入参数 :collect_id（收藏id）
 * @return
 *      (void)
 */
-(void)Cancel_Collect_id:(NSString *)collect_id  comletion:(TRCompletion)completion;

#pragma mark - 实名查询收藏
/**
 * 函数描述 : 实名查询收藏
 * @param
 *     输入参数 :无
 * @return
 *      (void)
 */
-(void)Query_Collect_comletion:(TRCompletion)completion;

#pragma mark - 用户登入验证
/**
 * 函数描述 : 用户登入验证
 * @param
 *     输入参数 :username（账号）、userpwd（密码）
 * @return
 *      (void)
 */
-(void)Login_Authentication:(NSString *)username AndUserpwd:(NSString *)userpwd completion:(TRCompletion)completion;

#pragma mark - VIP用户登入验证
/**
 * 函数描述 : VIP用户登入验证
 * @param
 *     输入参数 :username（账号）、userpwd（密码）
 * @return
 *      (void)
 */
-(void)Login_Authentication_VIP:(NSString *)username AndUserpwd:(NSString *)userpwd completion:(TRCompletion)completion;

#pragma mark - 用户登入  (自动注册激活)
/**
 * 函数描述 : 用户登入  (自动注册激活)
 * @param
 *     输入参数 :无
 * @return
 *      (void)
 */
-(void)Auto_Registration_completion:(TRCompletion)completion;

#pragma mark - 用户登入 普通用户注册（邮箱激活）
/**
 * 函数描述 : 用户登入 普通用户注册（邮箱激活）
 * @param
 *     输入参数 :username（账号）、userpwd（密码）、email_url（邮箱）
 * @return
 *      (void)
 */
-(void)General_Email_Registration:(NSString *)username AndUserpwd:(NSString *)userpwd  andEmail:(NSString *)email_url completion:(TRCompletion)completion;
#pragma mark - 手机号注册，获取验证码
/**
 * 函数描述 :手机号注册，获取验证码
 * @param
 *     输入参数 :phone_number（手机号）
 * @return
 *      (void)
 */
-(void)GET_REGISTERPIN:(NSString *)phone_number completion:(TRCompletion)completion;

///找回交易密码  验证码
/**
 * 函数描述 :获取验证码
 * @param
 *     输入参数 :phone_number（手机号）
 * @return
 *      (void)
 */
-(void)GET_FINDTRADEPASSWORD:(NSString *)phone_number completion:(TRCompletion)completion;

#pragma mark - 手机号找回密码，获取验证码
/**
 * 函数描述 :手机号找回密码，获取验证码
 * @param
 *     输入参数 :phone_number（手机号）
 * @return
 *      (void)
 */
-(void)Change_password_REGISTERPIN:(NSString *)phone_number completion:(TRCompletion)completion;
#pragma mark - 验证码 校验
/**
 * 函数描述 :验证码 校验
 * @param
 *     输入参数 :phone_number（手机号）verification（验证码）、type（类型）
 * @return
 *      (void)
 */
-(void)Verification_REGISTERPIN:(NSString *)phone_number andVerification:(NSString *)verification andType:(NSString *)type completion:(TRCompletion)completion;
#pragma mark -  绑定手机号码
/**
 * 函数描述 : 绑定手机号码
 * @param
 *     输入参数 :phone_number（手机号
 * @return
 *      (void)
 */
-(void)bind_Mobile_Phone:(NSString *)phone_number completion:(TRCompletion)completion;

#pragma mark -  解绑手机号码
/**
 * 函数描述 : 解绑手机号码
 * @param
 *     输入参数 :phone_number（手机号
 * @return
 *      (void)
 */
-(void)Unbind_Mobile_Phone:(NSString *)phone_number completion:(TRCompletion)completion;

#pragma mark -  3.6.3	查询用户个人信息
/**
 * 函数描述 : 3.6.3	查询用户个人信息
 * @param
 *     输入参数 :无
 * @return
 *      (void)
 */
-(void)ShowMyLnfo_completion:(TRCompletion)completion;

#pragma mark -  用户登入    手机用户注册（邮箱）激活
/**
 * 函数描述 : 用户登入 手机用户注册（邮箱）激活
 * @param
 *     输入参数 :phone_number(手机号)、userpwd（密码）、verification（验证码）
 * @return
 *      (void)
 */
-(void)Phone_Number_Registration:(NSString *)phone_number AndUserpwd:(NSString *)userpwd andVerification:(NSString *)verification completion:(TRCompletion)completion;

#pragma mark -  修改用户密码
/**
 * 函数描述 : 修改用户密码
 * @param
 *     输入参数 :无
 * @return
 *      (void)
 */
-(void)Change_password_Authentication:(NSString *)phone_Number AndUserpwd:(NSString *)userpwd completion:(TRCompletion)completion;

#pragma mark -  修改用户密码(通过旧密码，修改新密码)
/**
 * 函数描述 : 修改用户密码(通过旧密码，修改新密码)
 * @param
 *     输入参数 :无
 * @return
 *      (void)
 */
-(void)Oldpwd_to_Newpwd:(NSString *)oldpwd and_username:(NSString *)user_name AndUserpwd:(NSString *)userpwd completion:(TRCompletion)completion;

#pragma mark -  //修改用户密码(旧版本的用户，获取密码)
/**
 * 函数描述 : //修改用户密码(旧版本的用户，获取密码)
 * @param
 *     输入参数 :无
 * @return
 *      (void)
 */
-(void)Old_User_to_New_User:(NSString *)userpwd completion:(TRCompletion)completion;

#pragma mark - 第三方验证接口
/**
 * 函数描述 : 第三方验证接口
 * @param
 *     输入参数 :openid（第三方openid）、token（第三方token）、type（第三方类型）
 * @return
 *      (void)
 */
-(void)DothirdPartAuth_Authentication:(NSString *)openid AndToken:(NSString *)token andtype:(NSString *)type completion:(TRCompletion)completion;
#pragma mark - 绑定自动注册用户
/**
 * 函数描述 : 绑定自动注册用户
 * @param
 *     输入参数 :openid（第三方openid）、thirdname（第三方昵称）、nickname（用户昵称）、pic_url（用户头像）、type（第三方类型）
 * @return
 *      (void)
 */
-(void)Dothird_bind_Authentication:(NSString *)openid andThirdnickname:(NSString *)thirdname AndNickname:(NSString *)nickname andPic:(NSString *)pic_url andtype:(NSString *)type completion:(TRCompletion)completion;
#pragma mark - 绑定已有账号(用户登录之后）
/**
 * 函数描述 : 绑定已有账号(用户登录之后）
 * @param
 *     输入参数 :openid（第三方openid）、token（第三方token）、thirdname（第三方昵称）、type（第三方类型）、sid（sessionid）、uid（用户id）
 * @return
 *      (void)
 */
-(void)Bind_Authentication:(NSString *)openid andToken:(NSString *)token andThirdnickname:(NSString *)thirdname  andtype:(NSString *)type andSid:(NSString *)sid andUid:(NSString *)uid completion:(TRCompletion)completion;



#pragma mark - 实名 ,消息推送列表
/**
 * 函数描述 : 实名 ,消息推送列表
 * @param
 *     输入参数 :start（从第几条数据可以拉取）
 * @return
 *      (void)
 */
-(void)PUSH_List_start_id:(int)start completion:(TRCompletion)completion;

#pragma mark - 使用post方式，上传，log日志
/**
 * 函数描述 : 使用post方式，上传，log日志
 * @param
 *     输入参数 :name（log标签，表示某一块log数据）、log_array（log内容）
 * @return
 *      (void)
 */
-(void)Log_post_data:(NSString *)name andData:(NSArray *)log_array completion:(TRCompletion)completion;

#pragma mark - 百度云推送,用户绑定
/**
 * 函数描述 : 百度云推送,用户绑定
 * @param
 *     输入参数 :bd_userid（用户id）、bd_ChannlId（用户在百度的渠道）
 * @return
 *      (void)
 */
-(void)baidu_Push:(NSString *)bd_userid andChannelId:(NSString *)bd_ChannlId completion:(TRCompletion)completion;

#pragma mark - 百度云推送,解绑
/**
 * 函数描述 : 百度云推送,解绑
 * @param
 *     输入参数 :无
 * @return
 *      (void)
 */
-(void)delbind_baidu_Push_completion:(TRCompletion)completion;

#pragma mark - 热门排行
/**
 * 函数描述 : 热门排行
 * @param
 *     输入参数 :start_limit（开始的位置）、end_limit（结尾位置）
 * @return
 *      (void)
 */
-(void)Cai_Rot_top:(NSString *)start_limit andend_limit:(NSString *)end_limit completion:(TRCompletion)completion;

#pragma mark - 最新排行
/**
 * 函数描述 : 最新排行
 * @param
 *     输入参数 :start_limit（开始的位置）、end_limit（结尾位置）
 * @return
 *      (void)
 */
-(void)Cai_Zui_Xin_start:(NSString *)bd_userid andend_limit:(NSString *)bd_ChannlId completion:(TRCompletion)completion;

#pragma mark - //帖子详情内容
/**
 * 函数描述 : //帖子详情内容
 * @param
 *     输入参数 :talk_id（财知道正文id）
 * @return
 *      (void)
 */
-(void)Cai_NEWS_talk_id:(NSString *)talk_id completion:(TRCompletion)completion;

#pragma mark - //某个帖子的回复列表
/**
 * 函数描述 : //某个帖子的回复列表
 * @param
 *     输入参数 :talk_id（财知道正文id）、start（拉取的起始位置）
 * @return
 *      (void)
 */
-(void)Cai_NEWS_review:(NSString *)talk_id  andstart:(NSString *)start completion:(TRCompletion)completion;

#pragma mark - //用户发言
/**
 * 函数描述 : //用户发言
 * @param
 *     输入参数 :query_uid（财知道正文id）、start（拉取的起始位置）
 * @return
 *      (void)
 */
-(void)User_fayan_query_uid:(NSString *)query_uid andstart:(NSString *)start completion:(TRCompletion)completion;

#pragma mark - //用户评论
/**
 * 函数描述 : //用户评论
 * @param
 *     输入参数 :query_uid（财知道正文id）、start（拉取的起始位置）
 * @return
 *      (void)
 */
-(void)User_Comment_query_uid:(NSString *)query_uid andstart:(NSString *)start completion:(TRCompletion)completion;

#pragma mark - //用户个人信息接口
/**
 * 函数描述 : //用户个人信息接口
 * @param
 *     输入参数 :User_uid（用户id）
 * @return
 *      (void)
 */
-(void)User_XINXI_uid:(NSString *)User_uid completion:(TRCompletion)completion;

#pragma mark - //获取系统头像列表
/**
 * 函数描述 : //获取系统头像列表
 * @param
 *     输入参数 :无
 * @return
 *      (void)
 */
-(void)get_User_pic_completion:(TRCompletion)completion;

#pragma mark - //修改用户信息（头像、昵称、个人签名）
/**
 * 函数描述 : //修改用户信息（头像、昵称、个人签名）
 * @param
 *     输入参数 :pic_data（头像nsdata）、syspic_url（系统头像，使用url）、nickname（昵称）、signture（签名）
 * @return
 *      (void)
 */
-(void)Modification_User_pic_nick_sign:(NSData *)pic_data andSysPic:(NSString *)syspic_url andNickname:(NSString *)nickname andSignture:(NSString *)signture completion:(TRCompletion)completion;


#pragma mark -（财知道）发帖
/**
 * 函数描述 :（财知道）发帖
 * @param
 *     输入参数 :title（标题）、nick_name（昵称）、pic_url（头像）、sign_label（签名）、content_string（财知道发帖内容）
 * @return
 *      (void)
 */
-(void)Cai_Posting:(NSString *)title andNick_Name:(NSString *)nick_name andPic:(NSString *)pic_url andSign:(NSString *)sign_label andContent_string:(NSString *)content_string completion:(TRCompletion)completion;




#pragma mark -获取服务器的时间，
/**
 * 函数描述 : 获取服务器的时间
 * @param
 *     输入参数 : 无
 * @return
 *      (void)
 */
-(void)The_server_time_calibration_completion:(TRCompletion)completion;

#pragma mark -获取股票行情，
/**
 * 函数描述 : 获取股票行情
 * @param
 *     输入参数 : 无
 * @return
 *      (void)
 */
-(void)The_stock_market_code_completion:(TRCompletion)completion;





#pragma mark -广告推广
#pragma mark -广告推广id，
/**
 * 函数描述 : 激活上送接口
 * @param
 *     输入参数 : 无
 * @return
 *      (void)
 */
-(void)The_Salary_range_completion:(TRCompletion)completion;

#pragma mark - 注册上送接口
/**
 * 函数描述 : 注册上送接口
 * @param
 *     输入参数 : 无
 * @return
 *      (void)
 */
-(void)The_registNotify_Salary_range_completion:(TRCompletion)completion;









#pragma mark -工具箱接口，

#pragma mark -工资保险（收税区间，
/**
 * 函数描述 : 工资保险（收税区间）
 * @param
 *     输入参数 : 无
 * @return
 *      (void)
 */
-(void)The_Wage_Insurance_completion:(TRCompletion)completion;

#pragma mark - 社保与公积金，不同城市，各百分比，
/**
 * 函数描述 : 社保与公积金，不同城市，各百分比，
 * @param
 *     launchOptions -
 * @return
 *     不同城市，社保与公积金所占比例，及上下区间
 */
-(void)The_socialInsurance_completion:(TRCompletion)completion;

#pragma mark - 存款利息利率
/**
 * 函数描述 : 存款利息利率
 * @param
 *     输入参数 : 无
 * @return
 *      (void)
 */
-(void)The_depositRate_completion:(TRCompletion)completion;
#pragma mark - 外汇货币和名字字典
/**
 * 函数描述 : 外汇货币和名字字典
 * @param
 *     输入参数 : 无
 * @return
 *      (void)
 */
-(void)The_Forex_currency_and_Names_Dictionary_completion:(TRCompletion)completion;
#pragma mark - 外汇汇率接口
/**
 * 函数描述 : 外汇汇率接口
 * @param
 *     输入参数 : 无
 * @return
 *      (void)
 */
-(void)The_Foreign_Exchange_Rate_Interface_completion:(TRCompletion)completion;

#pragma mark - 房贷折扣问题
/**
 * 函数描述 : 房贷折扣问题
 * @param
 *     输入参数 : 无
 * @return
 *      (void)
 */
-(void)The_House_Exchange_Rate_completion:(TRCompletion)completion;
#pragma mark - 车贷
/**
 * 函数描述 : 车贷
 * @param
 *     输入参数 : 无
 * @return
 *      (void)
 */
-(void)The_Four_Car_completion:(TRCompletion)completion;



/**
 * 函数描述 : 启动广告图片path，获取借口
 * @param
 *     输入参数 : 无
 * @return
 *      (void)
 */
#pragma mark - 启动图接口访问，获取新图片的链接
-(void)StartPicAPIWithcompletion:(TRCompletion)completion;
/**
 *  函数描述 : 获取基金的精品推荐类表
 *  @param
 *      输入参数 : type
 *  @return
 *      (void)
 */
- (void)loadFundListsWithType:(NSInteger)fundType withCompletion:(TRCompletion)completion;
/*
 * 函数描述：查询我的资产（明细）
 * post
 * @param
 *    输入参数：userid
 * @return
 *    （void）
 */
- (void)loadFundDetailWithUserId:(NSString *)userId withCompletion:(TRCompletion)completion;

/*
 *函数描述：查委托/撤单页
 * post
 * @param
 *    输入参数：userid
 * @return
 *    （void）
 */
- (void)sendRequestWithDelegateCheckUserId:(NSString *)userId withCompletion:(TRCompletion)completion;
/*
 *函数描述：确认撤单页
 * post
 * @param
 *    输入参数：userid,tradeAcco,serialno,tradecode
 * @return
 *    （void）
 */
-(void)sendRequestWithAffirmUserId:(NSString *)userId tradeAccountId:(NSString *)tradeAcco  serialnoAccountId:(NSString *)serialno andTradecodeAccountId:(NSString *)tradecode  withCompletion:(TRCompletion)completion;


/*
 *  函数描述：获取用户风险偏好接口 
 *  @param
 *    输入参数：userid
 *  @return
 *    (void)
 */
- (void)loadResultOfRiskWithUserId:(NSString *)userId withCompletion:(TRCompletion)completion;
/** 加载基金码表 */
- (void)loadFundTableWithLastModtime:(NSString *)modTime
                      withCompletion:(TRCompletion)completion;
/*
 *  函数描述：获取用户交易记录
 *  @param
 *    输入参数：userid
 *  @return
 *   (void)
 */
- (void)sendRequestWithTradeUserId:(NSString *)userId withCompletion:(TRCompletion)completion;
/*
 *  函数描述：开户验证码（短信）
 *  @param
 *    输入参数：userid，userbankid，serialno，checkcode
 *  @return
 *   (void)
 */
-(void)sendRequestWithOpenAcountFirstStepUserId:(NSString *)userId userbankid:(NSString *)userbankid  serialnoAccountId:(NSString *)serialno andCheckcodeId:(NSString *)checkcode  withCompletion:(TRCompletion)completion;


/*
 *  函数描述：开户关联银行卡页
 *  @param
 *    输入参数：userid，mobile，bankno，idno，name
 *  @return
 *   (void)
 */
-(void)sendRequestWithOpenAcountFirstStepUserId:(NSString *)userId mobileId:(NSString *)mobile  banknoId:(NSString *)bankno bankaccoId:(NSString *)bankacco  idnoId:(NSString *)idno AndNameId:(NSString *)name withCompletion:(TRCompletion)completion;
/*
 *  函数描述：开户设置密码页
 *  @param
 *    输入参数：userid，tradecode
 *  @return
 *   (void)
 */
-(void)sendRequestWithSetPasswordtUserId:(NSString *)userId  andTradecodeId:(NSString *)tradecode  withCompletion:(TRCompletion)completion;
/*
 *  函数描述：跳转申购页
 *  @param
 *    输入参数：userid，fundid
 *  @return
 *   (void)
 */
-(void)sendRequestWithBuyUserId:(NSString *)userId  andFundId:(NSString *)fundid  withCompletion:(TRCompletion)completion;
/*
 *  函数描述：跳转赎回页
 *  @param
 *    输入参数：userid，fundid
 *  @return
 *   (void)
 */
-(void)sendRequestWithRedeemUserId:(NSString *)userId  andFundId:(NSString *)fundid  withCompletion:(TRCompletion)completion;
/*
 *  函数描述：众禄授权页
 *  @param
 *    输入参数：无
 *  @return
 *   (void)
 */
-(void)sendRequestWithAuthorizationPageWithCompletion:(TRCompletion)completion;
///账户中心接口
/*
 *  函数描述：用户授权页
 *  @param
 *    输入参数：userid
 *  @return
 *   (void)
 */
- (void)sendRequestWithAccountCenterUserId:(NSString *)userid  withCompletion:(TRCompletion)completion;
/*  是否开户接口*/
/*
 *  函数描述：账户中心页
 *  @param
 *    输入参数：userid
 *  @return
 *   (void)
 */
-(void)sendRequestWithIsOpenWithCompletion:(TRCompletion)completion;
///找回交易密码身份验证接口
/*
 *  函数描述：用户授权页
 *  @param
 *    输入参数：无
 *  @return
 *   (void)
 */
- (void)sendRequestWithusernameId:(NSString *)username AndidnoId:(NSString *)idno withCompletion:(TRCompletion)completion;

///找回交易密码接口
- (void)sendRequestWithRetrieveTradeCodeUserId:(NSString *)userId AndPwdId:(NSString *)pwdId withCompletion:(TRCompletion)completion;
/* 添加银行卡页 */
/*
 *  函数描述：添加银行卡页(账户中心页)
 *  @param
 *    输入参数：无
 *  @return
 *   (void)
 */
//http://119.253.36.116/financeMarketWeb/financeMarket/addBank
-(void)sendRequestWithAddBankUserId:(NSString *)userId mobileId:(NSString *)mobile  banknoId:(NSString *)bankno andbankaccoId:(NSString *)bankacco  withCompletion:(TRCompletion)completion;
/*
 *  函数描述：申购页
 *  @param
 *    输入参数：userid，userbankid，tradecode，fundid，money
 *  @return
 *   (void)
 */
-(void)sendRequestWithBuyUserId:(NSString *)userId tradecodeId:(NSString *)tradecode uesrBankId:(NSString *)userBankId fundId:(NSString *)fundId AndMoneyId:(NSString *)money withCompletion:(TRCompletion)completion
;
/*
 *  函数描述：赎回页
 *  @param
 *    输入参数：userid，userbankid，tradecode，fundid，subquty
 *  @return
 *   (void)
 */
-(void)sendRequestWithRedemUserId:(NSString *)userId tradecodeId:(NSString *)tradecode largeflagId:(NSString *)largeflag  uesrBankId:(NSString *)userBankId fundId:(NSString *)fundId AndSubqutyId:(NSString *)subquty withCompletion:(TRCompletion)completion;
/*
 *  函数描述：修改交易密码
 *  @param
 *    输入参数：userid，oldpwd，newpwd
 *  @return
 *   (void)
 */
-(void)sendRequestWithUpDatePwdUserId:(NSString *)userId oldPwdId:(NSString *)oldpwd AndNewPwdId:(NSString *)newpwd  withCompletion:(TRCompletion)completion;
/** 加载我的自选列表 */
- (void)loadOptionalListsWithUserId:(NSString *)userId withCompletion:(TRCompletion)completion;


///手机绑定
-(void)sendRequestWithMobileId:(NSString *)userId withCompletion:(TRCompletion)completion;
///添加银行卡
- (void)sendRequestWithpartnerId:(NSString *)partnerId withCompletion:(TRCompletion)completion;

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
@end
