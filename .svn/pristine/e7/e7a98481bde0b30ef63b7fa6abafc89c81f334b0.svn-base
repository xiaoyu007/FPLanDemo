//
//  FileChangelUtil.m
//  优顾理财
//
//  Created by Mac on 15/6/5.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FTWCache.h"
#import "ObjectJsonMappingUtil.h"

///当前用户的信息
static NSString *const UserOWERItem = @"UserOwerItem";
///选择的频道
static NSString *const CACHE_MY_NEWSChannels = @"my_news_channel_list";
///未选中的频道
static NSString *const CACHE_More_NEWSChannels = @"more_news_channel_list";
///所有的频道
static NSString *const CACHE_All_NEWSChannels = @"all_news_channel_list";

///新闻详情数据保存
static NSString *const NewsDetailInfo = @"NewsDetailInfo";
static NSString *const NewsId = @"NewsId";
static NSString *const KnowDetailInfo = @"KnowDetailInfo";
static NSString *const KnowTalkId = @"KnowTalkId";

static NSString *const NewsTeamListDataChanleId = @"NewsTeamListDataChanleId";
///财知道，首页list数据
static NSString *const KnowFirstNEWListData = @"KnowFirstNEWListData";
static NSString *const KnowFirstRotPointListData = @"KnowFirstRotPointListData";

///消息中心未读数统计数据
static NSString *const CACHE_UnReadMessageNum = @"CACHE_UserBpushInformationNum";
///用户未读数据个数刷新
static NSString *const MessageCenterNotification = @"EvenIfTheUpdate";

///用户赞的功能
static NSString *const FPYouGuPraise = @"FPYouGuPraise";

///已缓存的新闻id
static NSString *const FPCacheAllNewsId = @"FPCacheAllNewsId";
///已读缓存的新闻
static NSString *const DidReadWithNews = @"DidReadWithNews";
///收藏的新闻和财知道帖子
static NSString *const DidCollectWithNewsId = @"DidCollectWithNewsId";

@implementation FileChangelUtil
+ (NSString *)appVersion {
  static NSString *version;
  static dispatch_once_t predicate;
  dispatch_once(&predicate, ^{
    version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
  });
  return version;
}

+ (NSString *)getUserKey:(NSString *)key {
  NSString *userId = [FPYouguUtil getUserID];
  if (userId == nil || [@"-1" isEqualToString:userId]) {
    return [NSString stringWithFormat:@"%@_%@", key, @"null"];
    ;
  }
  return [NSString stringWithFormat:@"%@_%@", key, [FPYouguUtil getUserID]];
}
+ (void)saveCacheData:(id)data withKey:(NSString *)key {
  if (key == nil) {
    return;
  }
  if (data) {
    NSDictionary *dicData = [ObjectJsonMappingUtil getObjectData:data];
    NSData *myData = [NSKeyedArchiver archivedDataWithRootObject:dicData];
    [FTWCache setObject:myData forKey:key];
    return;
  } else {
    [FTWCache removeKeyOfObjcet:key];
  }
}

static UserListItem *userListItem;
static BOOL userListItemLoaded = NO;

///存储当前用户的基本信息
+ (void)saveUserListItem:(UserListItem *)data {
  [FileChangelUtil saveCacheData:data withKey:UserOWERItem];
  userListItem = data;
}
///加载当前用户的基本信息
+ (UserListItem *)loadUserListItem {
  if (userListItemLoaded) {
    return userListItem;
  } else {
    userListItem =
        [FileChangelUtil loadCacheWithKey:UserOWERItem withClassType:[UserListItem class]];
    userListItemLoaded = YES;
    return userListItem;
  }
}

///存储股市内参所有的频道
+ (void)saveAllNewsChannelList:(NewsChannelList *)data {
  [FileChangelUtil saveCacheData:data withKey:CACHE_All_NEWSChannels];
}

///加载股市内参所有的频道
+ (NewsChannelList *)loadAllNewsChannelList {
  return [FileChangelUtil loadCacheWithKey:CACHE_All_NEWSChannels
                             withClassType:[NewsChannelList class]];
}
///加载股市内参我选择的频道
+ (void)saveMyNewsChannelList:(NewsChannelList *)data {
  [FileChangelUtil saveCacheData:data withKey:CACHE_MY_NEWSChannels];
}
+ (void)saveMoreNewsChannelList:(NewsChannelList *)data {
  [FileChangelUtil saveCacheData:data withKey:CACHE_More_NEWSChannels];
}

+ (NewsChannelList *)loadMyNewsChannelList {
  return [FileChangelUtil loadCacheWithKey:CACHE_MY_NEWSChannels
                             withClassType:[NewsChannelList class]];
}
///加载股市内参其他的频道
+ (NewsChannelList *)loadMoreNewsChannelList {
  return [FileChangelUtil loadCacheWithKey:CACHE_More_NEWSChannels
                             withClassType:[NewsChannelList class]];
}

///存储资讯和财知道赞功能
+ (void)saveFPUserPraise:(PraiseObject *)data {
  NSString *key = [FileChangelUtil getUserKey:FPYouGuPraise];
  [FileChangelUtil saveCacheData:data withKey:key];
}
+ (PraiseObject *)loadFPUserPraise {
  NSString *key = [FileChangelUtil getUserKey:FPYouGuPraise];
  PraiseObject *item = [FileChangelUtil loadCacheWithKey:key withClassType:[PraiseObject class]];
  return item;
}

///存储消息中心未读数统计数据
+ (void)saveUserBpushInformationNum:(UserBpushInformationNum *)data {
  NSString *key = [FileChangelUtil getUserKey:CACHE_UnReadMessageNum];
  [FileChangelUtil saveCacheData:data withKey:key];
  ///刷新 推送各类型的个数
  [[NSNotificationCenter defaultCenter] postNotificationName:MessageCenterNotification object:nil];
}

///加载消息中心未读数统计数据
+ (UserBpushInformationNum *)loadUserBpushInformationNum {
  NSString *key = [FileChangelUtil getUserKey:CACHE_UnReadMessageNum];
  return [FileChangelUtil loadCacheWithKey:key withClassType:[UserBpushInformationNum class]];
}

///保存新闻信息
+ (void)saveNewsDetailInfo:(NewsDetailRequest *)data andNewId:(NSString *)newid andSaveObject:(BOOL)save
{
  if (!newid) {
    return;
  }
  CGFloat length = 0;
  if (data) {
    NSDictionary *dicData = [ObjectJsonMappingUtil getObjectData:data];
    NSData *myData = [NSKeyedArchiver archivedDataWithRootObject:dicData];
    length = [myData length];
  }
  NewsWithItem *item = [[NewsWithItem alloc] initWithNewsId:newid andType:1];
  [[NewsArrayWithALLNewsId sharedManager] addItem:item andFileLength:length andSaveObject:save];
  
  NSString *key = [NewsDetailInfo stringByAppendingString:newid];
  [FileChangelUtil saveCacheData:data withKey:key];
}
+ (void)saveNewsDetailInfo:(NewsDetailRequest *)data andNewId:(NSString *)newid {
  [FileChangelUtil saveNewsDetailInfo:data andNewId:newid andSaveObject:YES];
}
+ (NewsDetailRequest *)loadNewsDetailInfo:(NSString *)newid {
  if (!newid) {
    return nil;
  }
  NSString *key = [NewsDetailInfo stringByAppendingString:newid];
  return [FileChangelUtil loadCacheWithKey:key withClassType:[NewsDetailRequest class]];
}
+ (void)removeNewsDetailInfoWithNewsId:(NSString *)newid {
  if (!newid) {
    return;
  }
  NewsWithItem *item = [[NewsWithItem alloc] initWithNewsId:newid andType:1];
  [[NewsArrayWithALLNewsId sharedManager] removeWithItem:item];

  NSString *key = [NewsDetailInfo stringByAppendingString:newid];
  [FTWCache removeKeyOfObjcet:key];
}
///保存财知道帖子信息
+ (void)saveKnowDetailInfo:(KnowDetailItem *)data andTalkID:(NSString *)talkid {
  if (!talkid) {
    return;
  }
  CGFloat length = 0;
  if (data) {
    NSDictionary *dicData = [ObjectJsonMappingUtil getObjectData:data];
    NSData *myData = [NSKeyedArchiver archivedDataWithRootObject:dicData];
    length = [myData length];
  }
  NewsWithItem *item = [[NewsWithItem alloc] initWithNewsId:talkid andType:2];
  [[NewsArrayWithALLNewsId sharedManager] addItem:item AndFileLength:length];

  NSString *key = [KnowDetailInfo stringByAppendingString:talkid];
  [FileChangelUtil saveCacheData:data withKey:key];
}
+ (KnowDetailItem *)loadKnowDetailInfo:(NSString *)talkid {
  if (!talkid) {
    return nil;
  }
  NSString *key = [KnowDetailInfo stringByAppendingString:talkid];
  return [FileChangelUtil loadCacheWithKey:key withClassType:[KnowDetailItem class]];
}
+ (void)removeKnowDetailInfoWithId:(NSString *)talkid {
  if (!talkid) {
    return;
  }
  NewsWithItem *item = [[NewsWithItem alloc] initWithNewsId:talkid andType:1];
  [[NewsArrayWithALLNewsId sharedManager] removeWithItem:item];

  NSString *key = [KnowDetailInfo stringByAppendingString:talkid];
  [FTWCache removeKeyOfObjcet:key];
}
///删除所有缓存数据
+ (void)deleteUserAllWithId { ///删除所有新闻缓存
  [[NewsArrayWithALLNewsId sharedManager] delegateAllNewsID];
}

///新闻缓存的所有id
+ (void)saveALLNewsIdData:(NewsArrayWithALLNewsId *)data {
  [FileChangelUtil saveCacheData:data withKey:FPCacheAllNewsId];
}
+ (NewsArrayWithALLNewsId *)loadALLNewsId {
  NewsArrayWithALLNewsId *object = [FileChangelUtil loadCacheWithKey:FPCacheAllNewsId
                                                       withClassType:[NewsArrayWithALLNewsId class]];
  return object;
}
///已读的新闻文章
+ (void)saveDidReadWithNews:(NewsIdWithDidRead *)data {
  NSString *key = [FileChangelUtil getUserKey:DidReadWithNews];
  [FileChangelUtil saveCacheData:data withKey:key];
}
+ (NewsIdWithDidRead *)loadDidReadWithNews {
  NSString *key = [FileChangelUtil getUserKey:DidReadWithNews];
  NewsIdWithDidRead *object =
      [FileChangelUtil loadCacheWithKey:key withClassType:[NewsIdWithDidRead class]];
  return object;
}
///收藏的新闻文章和财知道帖子
+ (void)saveDidCollectWithNewsId:(NewsWithDidCollect *)data {
  NSString *key = [FileChangelUtil getUserKey:DidCollectWithNewsId];
  [FileChangelUtil saveCacheData:data withKey:key];
}
+ (NewsWithDidCollect *)loadDidCollectWithNewsId {
  NSString *key = [FileChangelUtil getUserKey:DidCollectWithNewsId];
  NewsWithDidCollect *object =
      [FileChangelUtil loadCacheWithKey:key withClassType:[NewsWithDidCollect class]];
  return object;
}

///资讯列表数据
+ (void)saveNewsTeamListData:(NewsListInChannel *)data andChanleId:(NSString *)chanleid {
  if ([chanleid intValue] > 0) {
    NSString *key = [NewsTeamListDataChanleId stringByAppendingString:chanleid];
    [FileChangelUtil saveCacheData:data withKey:key];
  }
}
+ (NewsListInChannel *)loadNewsTeamListData:(NSString *)chanleid {
  if ([chanleid intValue] > 0) {
    NSString *key = [NewsTeamListDataChanleId stringByAppendingString:chanleid];
    NewsListInChannel *list =
        [FileChangelUtil loadCacheWithKey:key withClassType:[NewsListInChannel class]];
    return list;
  }
  return nil;
}
///财知道最新列表数据
+ (void)saveKnowFirstNEWListItem:(KnowNewList *)data {
  [FileChangelUtil saveCacheData:data withKey:KnowFirstNEWListData];
}
+ (KnowNewList *)loadKnowFirstNEWListData {
  return [FileChangelUtil loadCacheWithKey:KnowFirstNEWListData withClassType:[KnowNewList class]];
}
///财知道热点列表数据
+ (void)saveKnowFirstRotPointListItem:(KnowRotList *)data {
  [FileChangelUtil saveCacheData:data withKey:KnowFirstRotPointListData];
}
+ (KnowRotList *)loadKnowFirstRotPointListData {
  return [FileChangelUtil loadCacheWithKey:KnowFirstRotPointListData
                             withClassType:[KnowRotList class]];
}
@end
