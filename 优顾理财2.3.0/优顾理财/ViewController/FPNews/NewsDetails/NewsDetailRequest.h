//
//  NewsDetailRequest.h
//  优顾理财
//
//  Created by Mac on 15/7/14.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "BaseRequestObject.h"
#import "JsonFormatRequester.h"
#import "UserListItem.h"
@interface NewsDetailRequest : JsonRequestObject
///标题
@property(nonatomic, strong) NSString *newsTitle;
///文章简介
@property(nonatomic, strong) NSString *newsIntroduction;
///文章内图片的位置
@property(nonatomic, assign) int Photo_position;
///文章来源
@property(nonatomic, strong) NSString *newsSource;
///评论数量
@property(nonatomic, assign) int newsPlnum;
///文章发布时间
@property(nonatomic, strong) NSString *creatTime;
/// web页面的url链接
@property(nonatomic, strong) NSString *webUrl;
///修改时间
//@property(nonatomic) long long xgsjTime;
@property(nonatomic, strong) NSString *xgsjTime;
///原文的url
@property(nonatomic, strong) NSString *originalUrl;
///赞的数量
@property(nonatomic, assign) int praiseNum;
///文章正文
@property(nonatomic, strong) NSString *newsContent;
/// webview的，html的字符串
@property(nonatomic, strong) NSString *webViewHtml;
///文章来源的logo
@property(nonatomic, strong) NSString *logoPic;
///新闻详情文章
+ (void)getNewsDetailWithChannlid:(NSString *)channlid
                        AndNewsid:(NSString *)newsid
                     withCallback:(HttpRequestCallBack *)callback;
@end

@interface NewsReviewRequest : JsonRequestObject
///资讯详情页评论和回复
+ (void)getRequestWithReply:(NSString *)channlid
                  andNewsId:(NSString *)newsid
                 andContent:(NSString *)content
                andBeUserid:(NSString *)beuid
               withCallback:(HttpRequestCallBack *)callback;
@end
@interface NewsOnlyCommentObject : JsonRequestObject
///评论内容
@property(nonatomic, strong) NSString *content;
///评论时间
@property(nonatomic, strong) NSString *creattime;
///评论id
@property(nonatomic, strong) NSString *commentId;
///评论数量
@property(nonatomic, strong) NSString *praiseNum;
///踩数
@property(nonatomic, strong) NSString *stampNum;
///类型
@property(nonatomic, assign) int commentType;
///用户信息
@property(nonatomic, strong) UserListItem *userListItem;
@end

@interface NewsCommentListRequest : JsonRequestObject <Collectionable>
@property(nonatomic, strong) NSMutableArray *commentList;
+ (void)getRequestWithCommentList:(NSString *)channlid
                        AndNewsId:(NSString *)newsid
                      AndStartNum:(NSString *)start
                     withCallback:(HttpRequestCallBack *)callback;
+ (void)getRequestWithDic:(NSDictionary *)dic
             withCallback:(HttpRequestCallBack *)callback;  
@end

@interface NewsonlyRelatedObject : JsonRequestObject
@property(nonatomic, strong) NSString *channlid;
@property(nonatomic, strong) NSString *newsId;
@property(nonatomic, strong) NSString *title;
@end

@interface NewsRelatedArticlesRequest : JsonRequestObject

@property(nonatomic, strong) NSMutableArray *listArray;
+ (void)getRelatedArticlesWithNewsid:(NSString *)newsid
                        withCallback:(HttpRequestCallBack *)callback;
@end

@interface NewspraiseNumAndCommentNumRequest : JsonRequestObject
///赞数
@property(nonatomic, strong) NSString *praiseNum;
///评论数
@property(nonatomic, strong) NSString *commentNum;
///获取赞数和评论数
+ (void)getPraiseNumAndCommentNumWithChannlid:(NSString *)channlid
                                    AndNewsId:(NSString *)newsid
                                 withCallback:(HttpRequestCallBack *)callback;
@end
@interface NewsCommentpraiseRequest : JsonRequestObject
+ (void)getNewsCommentPraiseRequest:(NSString *)channlid
                          AndNewsid:(NSString *)newsid
                         andReplyid:(NSString *)replyid
                       withCallback:(HttpRequestCallBack *)callback;
@end
@interface NewsCollectRequest : JsonRequestObject
///收藏id
@property(nonatomic, strong) NSString *fid;
///添加收藏
+ (void)getNewsCollectWithNewsId:(NSString *)newsId
                    andNewsTitle:(NSString *)title
                         andType:(NSString *)type
                    withCallback:(HttpRequestCallBack *)callback;
///取消收藏
+ (void)getNewsCollectWithFid:(NSString *)fid
                 withCallback:(HttpRequestCallBack *)callback;
@end