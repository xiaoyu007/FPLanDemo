//
//  KnowRequestItem.h
//  优顾理财
//
//  Created by Mac on 15/7/22.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "BaseRequestObject.h"
#import "JsonFormatRequester.h"
#import "UserListItem.h"

/** 临时保存新闻id */
@interface KnowArrayWithId : JsonRequestObject
//@property(nonatomic, strong) NSMutableArray * listArray;
//
//+(KnowArrayWithId*)addNewsId:(NSString *)newsid;
/////删除所有新闻缓存
//+(void)delegateAllNewsID;
//+(KnowArrayWithId*)removeWithId:(NSString *)newsid;
@end

@interface KnowRequestItem : JsonRequestObject

@end
@interface knownewItem : JsonRequestObject

/** 消息id */
@property(nonatomic, strong) NSString *talkId;
//帖子id
@property(nonatomic, strong) NSString *aid;
//帖子来源 0.客户端发帖 1.cms发帖 2.新闻推送 发帖
@property(nonatomic, assign) int sourceType;

///用户信息
@property(nonatomic, strong) UserListItem *userListItem;
///帖子摘要
@property(nonatomic, strong) NSString *summary;
///帖子标题
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *praiseNum;
@property(nonatomic, strong) NSString *commentNum;

@property(nonatomic, strong) NSString *creatTime;
@property(nonatomic, strong) NSString *updateTime;
@property(nonatomic, strong) NSString *rotBeNickname;
@property(nonatomic, strong) NSString *rotBeUid;
@property(nonatomic, assign) BOOL isreading;
@end

/**
 *  财知道数据列表
 */
@interface KnowNewList : JsonRequestObject <Collectionable>
@property(nonatomic, strong) NSMutableArray *listArray;
+ (void)getNewListWithstart:(NSString *)start
                   Andlimit:(NSString *)limit
               withCallback:(HttpRequestCallBack *)callback;
+ (void)getNewListWithDic:(NSDictionary *)dic
             withCallback:(HttpRequestCallBack *)callback;
@end

/**
 *  财知道最热
 */
@interface KnowRotList : JsonRequestObject <Collectionable>
@property(nonatomic, strong) NSMutableArray *listArray;
+ (void)getRotListWithStart:(NSString *)start
               withCallback:(HttpRequestCallBack *)callback;
+ (void)getRotListWithDic:(NSDictionary *)dic
             withCallback:(HttpRequestCallBack *)callback;
@end

/**
 *  Description
 *
 *  @param nonatomic nonatomic description
 *  @param strong    strong description
 *
 *  @return return value description
 */
#pragma mark - 实名 ,消息推送列表
@interface KnowMessageList : JsonRequestObject <Collectionable>
@property(nonatomic, strong) NSMutableArray *listArray;
+ (void)getMessageListWithStart:(NSString *)start
                   withCallback:(HttpRequestCallBack *)callback;
+ (void)getMessageListWithDic:(NSDictionary *)dic
                 withCallback:(HttpRequestCallBack *)callback;
@end

@interface KnowDetailItem : JsonRequestObject

///帖子id
@property(nonatomic, strong) NSString *talkid;
//帖子来源 0.客户端发帖 1.cms发帖 2.新闻推送 发帖
@property(nonatomic, assign) int sourceType;

@property(nonatomic, strong) NSString *rotNewsChannlid;
@property(nonatomic, strong) NSString *rotNewsCreatTime;
@property(nonatomic, strong) NSString *rotNewsId;

@property(nonatomic, strong) UserListItem *userListItem;

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *content;
@property(nonatomic, assign) float contentHeight;

@property(nonatomic, strong) NSString *rotShareUrl;
@property(nonatomic, strong) NSString *summary;
@property(nonatomic, assign) float summaryHeight;
@property(nonatomic, strong) NSString *praiseNum;
@property(nonatomic, strong) NSString *commentNum;

@property(nonatomic, strong) NSString *creatTime;
@property(nonatomic, strong) NSString *updateTime;
@property(nonatomic, strong) NSString *rotBeNickname;
@property(nonatomic, strong) NSString *rotBeUid;
@property(nonatomic, strong) NSString *rotBeBeRid;

@property(nonatomic, strong) NSString *payRate;
@property(nonatomic, strong) NSString *rewardDiamonds;
@property(nonatomic, assign) int rewardState;

@property(nonatomic, assign) BOOL isreading;
+ (void)getKnowDetailWithTalkId:(NSString *)talkid
                   withCallback:(HttpRequestCallBack *)callback;
@end

/**
 *  、、、
 */
@interface KnowDetailCommentItem : JsonRequestObject

///帖子id
@property(nonatomic, strong) NSString *talkid;
@property(nonatomic, strong) NSString *articleId;
//帖子来源 0.客户端发帖 1.cms发帖 2.新闻推送 发帖
@property(nonatomic, assign) int sourceType;

@property(nonatomic, strong) UserListItem *userListItem;

@property(nonatomic, strong) NSString *slaveRid;
@property(nonatomic, strong) NSString *slaveName;
@property(nonatomic, strong) NSString *praiseNum;
@property(nonatomic, strong) NSString *creatTime;
@property(nonatomic, strong) NSString *updateTime;
@property(nonatomic, strong) NSString *content;

@property(nonatomic, strong) NSString *rotBeNickname;
@property(nonatomic, strong) NSString *rotBeBeRid;

@property(nonatomic, strong) NSString *payRate;
@property(nonatomic, strong) NSString *rewardDiamonds;
@property(nonatomic, assign) int rewardState;

@property(nonatomic, assign) BOOL isreading;
@end

/**
 *  Description
 */
@interface KnowDetailCommentList : JsonRequestObject <Collectionable>
@property(nonatomic, assign) int commentNum;
@property(nonatomic, strong) NSMutableArray *listArray;
+ (void)getKnowDetailCommentListWithtalkId:(NSString *)talkid
                                  andStart:(NSString *)start
                              withCallback:(HttpRequestCallBack *)callback;
+ (void)getKnowDetailCommentListWithDic:(NSDictionary *)dic
                           withCallback:(HttpRequestCallBack *)callback;
@end

@interface UserCommentKnowInfo : JsonRequestObject
#pragma mark - 用户回复，详情信息
//用户回复，详情信息
+ (void)commentTalk:(NSString *)talkid
        andSlaveRid:(NSString *)salverid
       andsalveName:(NSString *)salvename
         andContext:(NSString *)context
       withCallback:(HttpRequestCallBack *)callback;
@end

@interface AskQuestionToThem : JsonRequestObject

#pragma mark - 向TA提问，详情信息
//向TA提问
+ (void)getAskQuestionToThemWithContent:(NSString *)content
                            andSlaveRid:(NSString *)slaverid
                           andSlaveName:(NSString *)slavename
                           withCallback:(HttpRequestCallBack *)callback;
@end

@interface KnowCommentPraiseRequest : JsonRequestObject
// 对财知道评论的赞
+ (void)getKnowCommentPraiseWithCommentId:(NSString *)commentid
                             withCallback:(HttpRequestCallBack *)callback;
@end

@interface MyRlyListRequestItem : JsonRequestObject

/** 评论id */
@property(nonatomic, strong) NSString *commentId;
/** 文章id */
@property(nonatomic, strong) NSString *articleId;
/** 文章标题 */
@property(nonatomic, strong) NSString *commentTitle;
/** 评论时间 */
@property(nonatomic, strong) NSString *commentTime;
/** 评论内容 */
@property(nonatomic, strong) NSString *commentContent;
@property(nonatomic, assign) BOOL isReading;
@end

/**
 *  Description
 */
@interface MyRlyListRequestList : JsonRequestObject <Collectionable>

@property(nonatomic, strong) NSMutableArray *listArray;

+ (void)getMyRlyListWith:(NSString *)userId
                andStart:(NSString *)startNum
            withCallback:(HttpRequestCallBack *)callback;

+ (void)getMyRlyListWithDic:(NSDictionary *)dic
               withCallback:(HttpRequestCallBack *)callback;
@end

@interface KnowPostingRequest : JsonRequestObject
//发帖
+ (void)KnowPosting:(NSString *)title
        andNickname:(NSString *)nickname
             andPic:(NSString *)picUrl
            andSign:(NSString *)sign
         andContent:(NSString *)content
       withCallback:(HttpRequestCallBack *)callback;
@end
