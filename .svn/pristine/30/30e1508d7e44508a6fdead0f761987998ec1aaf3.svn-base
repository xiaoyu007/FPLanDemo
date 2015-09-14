//
//  FileChangelUtil.h
//  优顾理财
//
//  Created by Mac on 15/6/5.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsDetailRequest.h"
#import "NewsChannelList.h"
#import "FPCacheUtil.h"
#import "UserListItem.h"
#import "KnowRequestItem.h"
#import "PraiseObject.h"
#import "NewsIdWithDidRead.h"
#import "NewsWithDidCollect.h"
#import "NewsArrayWithALLNewsId.h"
#import "UserBpushInformationNum.h"
@interface FileChangelUtil : FPCacheUtil
///存储当前用户的基本信息
+ (void)saveUserListItem:(UserListItem *)data;
///加载当前用户的基本信息
+ (UserListItem *)loadUserListItem;

///存储股市内参所有的频道
+ (void)saveAllNewsChannelList:(NewsChannelList *)data;

///加载股市内参所有的频道
+ (NewsChannelList *)loadAllNewsChannelList;

///存储股市内参我的频道
+ (void)saveMyNewsChannelList:(NewsChannelList *)data;

///加载股市内参我的频道
+ (NewsChannelList *)loadMyNewsChannelList;

///存储股市内参其他的频道
+ (void)saveMoreNewsChannelList:(NewsChannelList *)data;

///加载股市内参其他的频道
+ (NewsChannelList *)loadMoreNewsChannelList;

///存储消息中心未读数统计数据
+ (void)saveUserBpushInformationNum:(UserBpushInformationNum *)data;

///加载消息中心未读数统计数据
+ (UserBpushInformationNum *)loadUserBpushInformationNum;

///保存新闻信息
+ (void)saveNewsDetailInfo:(NewsDetailRequest *)data
                  andNewId:(NSString *)newid
             andSaveObject:(BOOL)save;
+ (void)saveNewsDetailInfo:(NewsDetailRequest *)data andNewId:(NSString *)newid;
+ (NewsDetailRequest *)loadNewsDetailInfo:(NSString *)newid;
+ (void)removeNewsDetailInfoWithNewsId:(NSString *)newid;

///保存新闻信息
+ (void)saveKnowDetailInfo:(KnowDetailItem *)data andTalkID:(NSString *)talkid;
+ (KnowDetailItem *)loadKnowDetailInfo:(NSString *)talkid;
+ (void)removeKnowDetailInfoWithId:(NSString *)talkid;

///删除所有缓存数据
+ (void)deleteUserAllWithId;
///新闻缓存的所有id
+ (void)saveALLNewsIdData:(NewsArrayWithALLNewsId *)data;
+ (NewsArrayWithALLNewsId *)loadALLNewsId;
///已读的新闻文章
+ (void)saveDidReadWithNews:(NewsIdWithDidRead *)data;
+ (NewsIdWithDidRead *)loadDidReadWithNews;
///收藏的新闻文章和财知道帖子
+ (void)saveDidCollectWithNewsId:(NewsWithDidCollect *)data;
+ (NewsWithDidCollect *)loadDidCollectWithNewsId;

///资讯列表数据
+ (void)saveNewsTeamListData:(NewsListInChannel *)data andChanleId:(NSString *)chanleid;
+ (NewsListInChannel *)loadNewsTeamListData:(NSString *)chanleid;
///财知道最新列表数据
+ (void)saveKnowFirstNEWListItem:(KnowNewList *)data;
+ (KnowNewList *)loadKnowFirstNEWListData;
///财知道热点列表数据
+ (void)saveKnowFirstRotPointListItem:(KnowRotList *)data;
+ (KnowRotList *)loadKnowFirstRotPointListData;

///存储资讯和财知道赞功能
+ (void)saveFPUserPraise:(PraiseObject *)data;
+ (PraiseObject *)loadFPUserPraise;
@end
