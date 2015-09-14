//
//  KnowRequestItem.m
//  优顾理财
//
//  Created by Mac on 15/7/22.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "DateChangeSimple.h"

@implementation KnowArrayWithId

//+ (KnowArrayWithId *)addNewsId:(NSString *)newsid {
//  NSArray *array = [FileChangelUtil loadKnowWithTalkId];
//  NSMutableArray *mArray = [[NSMutableArray alloc] init];
//  if (![KnowArrayWithId isExist:array AndNewsID:newsid]) {
//    [mArray addObject:newsid];
//  }
//  if (array && array.count > 0) {
//    [mArray addObjectsFromArray:array];
//    if (array.count > 2000) {
//      NSArray *tArray = [mArray subarrayWithRange:NSMakeRange(0, 500)];
//      for (NSString *newid in tArray) {
//        [FileChangelUtil removeKnowDetailInfoWithId:newid];
//      }
//      NSArray *restArray = [mArray subarrayWithRange:NSMakeRange(500, 1500)];
//      [mArray removeAllObjects];
//      [mArray addObjectsFromArray:restArray];
//    }
//  }
//
//  KnowArrayWithId *item = [[KnowArrayWithId alloc] init];
//  item.listArray = [[NSMutableArray alloc] initWithArray:mArray];
//  return item;
//}
//+ (BOOL)isExist:(NSArray *)array AndNewsID:(NSString *)newsid {
//  if (!array) {
//    return NO;
//  }
//  for (NSString *str in array) {
//    if ([str isEqualToString:newsid]) {
//      return YES;
//    }
//  }
//  return NO;
//}
/////删除所有新闻缓存
//+ (void)delegateAllNewsID {
//  NSArray *array = [FileChangelUtil loadKnowWithTalkId];
//  for (NSString *newid in array) {
//    [FileChangelUtil removeNewsDetailInfoWithNewsId:newid];
//  }
//}
//
//+ (KnowArrayWithId *)removeWithId:(NSString *)newsid {
//  NSArray *array = [FileChangelUtil loadKnowWithTalkId];
//  if (array && array.count > 0) {
//    NSMutableArray *mArray = [[NSMutableArray alloc] init];
//    [mArray addObjectsFromArray:array];
//    [mArray removeObject:newsid];
//    if (mArray.count > 0) {
//      KnowArrayWithId *item = [[KnowArrayWithId alloc] init];
//      item.listArray = [[NSMutableArray alloc] initWithArray:mArray];
//      return item;
//    }
//  }
//  return nil;
//}
//
//- (NSArray *)getArray {
//  return _listArray;
//}
//
//- (NSDictionary *)mappingDictionary {
//  return @{ @"listArray" : NSStringFromClass([NSString class]) };
//}
@end

@implementation KnowRequestItem

@end
@implementation knownewItem
- (void)jsonToObject:(NSDictionary *)dic {
  [super jsonToObject:dic];
  self.talkId = [FPYouguUtil ishave_blank:dic[@"aid"]];
  self.aid = [FPYouguUtil ishave_blank:dic[@"aid"]];
  self.title = [FPYouguUtil ishave_blank:dic[@"title"]];
  self.summary = dic[@"summary"];
  self.userListItem = [[UserListItem alloc] init];
  self.userListItem.userId = [FPYouguUtil ishave_blank:dic[@"user_id"]];
  self.userListItem.nickName = [FPYouguUtil ishave_blank:dic[@"nick_name"]];
  self.userListItem.headPic = [FPYouguUtil ishave_blank:dic[@"user_pic"]];
  self.userListItem.signature = [FPYouguUtil ishave_blank:dic[@"user_sign"]];
  self.userListItem.vipType = [FPYouguUtil ishave_blank:dic[@"vtype"]];
  self.userListItem.CertifySignature =
      [FPYouguUtil ishave_blank:dic[@"certifySignature"]];

  self.commentNum = [FPYouguUtil ishave_blank:dic[@"comment_num"]];
  self.praiseNum = [FPYouguUtil ishave_blank:dic[@"up_num"]];
  self.creatTime = [[DateChangeSimple sharedManager]
      get_time_date:[FPYouguUtil ishave_blank:dic[@"create_time"]]];
  self.updateTime = [[DateChangeSimple sharedManager]
      get_time_date:[FPYouguUtil ishave_blank:dic[@"update_time"]]];
  self.rotBeUid = [FPYouguUtil ishave_blank:dic[@"be_uid"]];
  self.rotBeNickname = [FPYouguUtil ishave_blank:dic[@"be_nickname"]];
  NewsWithItem *item =
      [[NewsWithItem alloc] initWithNewsId:self.talkId andType:2];
  BOOL isExist = [[NewsArrayWithALLNewsId sharedManager] isReadNewsWithID:item];
  if (isExist) {
    self.isreading = YES;
  } else {
    self.isreading = NO;
  }
  self.sourceType = [dic[@"article_src"] intValue];
}

- (void)jsonToObject2:(NSDictionary *)dic {
  [super jsonToObject:dic];
  self.talkId = [dic[@"forward"]
      componentsSeparatedByString:@"youguu://forum_content?tid="][1];
  self.aid = [FPYouguUtil ishave_blank:dic[@"id"]];
  self.title = [FPYouguUtil ishave_blank:dic[@"title"]];
  self.summary = [FPYouguUtil ishave_blank:dic[@"msg"]];
  self.userListItem = [[UserListItem alloc] init];
  self.userListItem.userId = [FPYouguUtil ishave_blank:dic[@"fromUid"]];
  self.userListItem.nickName = [FPYouguUtil ishave_blank:dic[@"nickName"]];
  self.userListItem.headPic = [FPYouguUtil ishave_blank:dic[@"picUrl"]];
  self.userListItem.signature = [FPYouguUtil ishave_blank:dic[@"signature"]];
  self.userListItem.vipType = [FPYouguUtil ishave_blank:dic[@"vType"]];
  self.userListItem.CertifySignature =
      [FPYouguUtil ishave_blank:dic[@"certifySignature"]];

  self.commentNum = [FPYouguUtil ishave_blank:dic[@"comment_num"]];
  self.praiseNum = [FPYouguUtil ishave_blank:dic[@"up_num"]];
  self.creatTime = [[DateChangeSimple sharedManager]
      get_time_date:[FPYouguUtil ishave_blank:dic[@"createTime"]]];
  self.updateTime = [[DateChangeSimple sharedManager]
      get_time_date:[FPYouguUtil ishave_blank:dic[@"update_time"]]];
  self.rotBeUid = [FPYouguUtil ishave_blank:[dic[@"toUids"] objectAtIndex:0]];
  self.rotBeNickname = [FPYouguUtil ishave_blank:dic[@"be_nickname"]];
  NewsWithItem *item =
      [[NewsWithItem alloc] initWithNewsId:self.talkId andType:2];
  BOOL isExist = [[NewsIdWithDidRead sharedManager] isReadNewsWithID:item];
  if (isExist) {
    self.isreading = YES;
  } else {
    self.isreading = NO;
  }
  self.sourceType = [dic[@"type"] intValue];
}

@end

/**
 *  Description
 */
@implementation KnowNewList

- (void)jsonToObject:(NSDictionary *)dic {
  [super jsonToObject:dic];
  self.listArray = [[NSMutableArray alloc] init];
  NSArray *array = dic[@"talkList"];
  NSMutableArray *mArray = [[NSMutableArray alloc] init];
  [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx,
                                      BOOL *stop) {
    if (obj && obj.count > 0) {
      knownewItem *item = [[knownewItem alloc] init];
      [item jsonToObject:obj];
      [mArray addObject:item];
    }
  }];
  [self.listArray addObjectsFromArray:mArray];
}

- (NSArray *)getArray {
  return _listArray;
}

- (NSDictionary *)mappingDictionary {
  return @{ @"listArray" : NSStringFromClass([knownewItem class]) };
}

+ (void)getNewListWithstart:(NSString *)start
                   Andlimit:(NSString *)limit
               withCallback:(HttpRequestCallBack *)callback {
  NSString *path = [NSString
      stringWithFormat:@"%@/bbs/article/newestTalkList/%@/%@/%@/%@/%@",
                       IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                       YouGu_User_USerid, start, limit];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[KnowNewList class]
             withHttpRequestCallBack:callback];
}

+ (void)getNewListWithDic:(NSDictionary *)dic
             withCallback:(HttpRequestCallBack *)callback {
  NSString *path = [NSString
      stringWithFormat:@"%@/bbs/article/newestTalkList/%@/%@/" @"%@/{start}/%@",
                       IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                       YouGu_User_USerid, @"20"];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:dic
              withRequestObjectClass:[KnowNewList class]
             withHttpRequestCallBack:callback];
}

@end

/**
 *  Description
 */
@implementation KnowRotList
- (void)jsonToObject:(NSDictionary *)dic {
  [super jsonToObject:dic];
  self.listArray = [[NSMutableArray alloc] init];
  NSArray *array = dic[@"talkList"];
  NSMutableArray *mArray = [[NSMutableArray alloc] init];
  [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx,
                                      BOOL *stop) {
    if (obj && obj.count > 0) {
      knownewItem *item = [[knownewItem alloc] init];
      [item jsonToObject:obj];
      [mArray addObject:item];
    }
  }];
  [self.listArray addObjectsFromArray:mArray];
}

- (NSArray *)getArray {
  return _listArray;
}

- (NSDictionary *)mappingDictionary {
  return @{ @"listArray" : NSStringFromClass([knownewItem class]) };
}

+ (void)getRotListWithStart:(NSString *)start
               withCallback:(HttpRequestCallBack *)callback {
  NSString *path = [NSString
      stringWithFormat:@"%@/bbs/article/hotTalkList/%@/%@/%@/%@/%@/%@",
                       IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                       YouGu_User_USerid, start, @"20", Iphone_Size()];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[KnowRotList class]
             withHttpRequestCallBack:callback];
}

+ (void)getRotListWithDic:(NSDictionary *)dic
             withCallback:(HttpRequestCallBack *)callback {
  NSString *path = [NSString
      stringWithFormat:@"%@/bbs/article/hotTalkList/%@/%@/%@/{start}/%@/%@",
                       IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                       YouGu_User_USerid, @"20", Iphone_Size()];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:dic
              withRequestObjectClass:[KnowRotList class]
             withHttpRequestCallBack:callback];
}
@end

#pragma mark - 实名 ,消息推送列表
@implementation KnowMessageList

- (NSArray *)getArray {
  return _listArray;
}

- (void)jsonToObject:(NSDictionary *)dic {
  [super jsonToObject:dic];
  self.listArray = [[NSMutableArray alloc] init];
  NSArray *array = dic[@"result"];
  NSMutableArray *mArray = [[NSMutableArray alloc] init];
  [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx,
                                      BOOL *stop) {
    knownewItem *item = [[knownewItem alloc] init];
    [item jsonToObject2:obj];
    [mArray addObject:item];
  }];
  [self.listArray addObjectsFromArray:mArray];
}

+ (void)getMessageListWithStart:(NSString *)start
                   withCallback:(HttpRequestCallBack *)callback {
  NSString *path =
      [NSString stringWithFormat:@"%@/bbs/notice/myMessage?fromId=%@&count=20",
                                 IP_HTTP_DATA, start];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[KnowMessageList class]
             withHttpRequestCallBack:callback];
}

+ (void)getMessageListWithDic:(NSDictionary *)dic
                 withCallback:(HttpRequestCallBack *)callback {
  NSString *path = [NSString
      stringWithFormat:@"%@/bbs/notice/myMessage?fromId={fromId}&count=20",
                       IP_HTTP_DATA];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:dic
              withRequestObjectClass:[KnowMessageList class]
             withHttpRequestCallBack:callback];
}

@end
///帖子详情内容
@implementation KnowDetailItem
- (void)jsonToObject:(NSDictionary *)dic {
  [super jsonToObject:dic];
  NSDictionary *mdic = dic[@"oneTalk"];
  self.talkid = [FPYouguUtil ishave_blank:mdic[@"_id"]];
  self.sourceType = [mdic[@"article_src"] intValue];
  self.rotNewsId = [FPYouguUtil ishave_blank:mdic[@"news_id"]];
  self.rotNewsChannlid = [FPYouguUtil ishave_blank:mdic[@"news_channelid"]];
  self.rotNewsCreatTime = [FPYouguUtil ishave_blank:mdic[@"news_createtime"]];

  self.userListItem = [[UserListItem alloc] init];
  self.userListItem.userId = [FPYouguUtil ishave_blank:mdic[@"user_id"]];
  self.userListItem.nickName = [FPYouguUtil ishave_blank:mdic[@"nick_name"]];
  self.userListItem.headPic = [FPYouguUtil ishave_blank:mdic[@"user_pic"]];
  self.userListItem.signature = [FPYouguUtil ishave_blank:mdic[@"user_sign"]];
  self.userListItem.vipType = [FPYouguUtil ishave_blank:mdic[@"vtype"]];
  self.userListItem.CertifySignature =
      [FPYouguUtil ishave_blank:mdic[@"certifySignature"]];

  //   帖子正文
  NSString *content = [FPYouguUtil ishave_blank:mdic[@"context"]];
  content =
      [content stringByReplacingOccurrencesOfString:@"<p>\n" withString:@"<p>"];
  content = [content stringByReplacingOccurrencesOfString:@"\n</p>"
                                               withString:@"</p>"];
  self.content = content;
  self.rotShareUrl = [FPYouguUtil ishave_blank:mdic[@"share_url"]];
  self.summary = [FPYouguUtil ishave_blank:mdic[@"summary"]];
  self.title = [FPYouguUtil ishave_blank:mdic[@"title"]];
  self.praiseNum = [FPYouguUtil ishave_blank:mdic[@"up_num"]];
  self.commentNum = [FPYouguUtil ishave_blank:mdic[@"comment_num"]];
  self.creatTime = [[DateChangeSimple sharedManager]
      get_time_date:[FPYouguUtil ishave_blank:mdic[@"create_time"]]];
  self.updateTime = [[DateChangeSimple sharedManager]
      get_time_date:[FPYouguUtil ishave_blank:mdic[@"update_time"]]];
  self.rotBeUid = [FPYouguUtil ishave_blank:mdic[@"be_uid"]];
  self.rotBeNickname = [FPYouguUtil ishave_blank:mdic[@"be_nickname"]];
  self.rotBeBeRid = [FPYouguUtil ishave_blank:mdic[@"slave_rid"]];

  self.payRate = [FPYouguUtil ishave_blank:mdic[@"payRate"]];
  self.rewardDiamonds = [FPYouguUtil ishave_blank:mdic[@"rewardDiamonds"]];
  self.rewardState = [mdic[@"rewardState"] intValue];
}
+ (void)getKnowDetailWithTalkId:(NSString *)talkid
                   withCallback:(HttpRequestCallBack *)callback {
  NSString *path =
      [NSString stringWithFormat:@"%@/bbs/article/getOneTalk/%@/%@/%@/%@",
                                 IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                                 YouGu_User_USerid, talkid];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[KnowDetailItem class]
             withHttpRequestCallBack:callback];
}

@end
@implementation KnowDetailCommentItem

- (void)jsonToObject:(NSDictionary *)dic {
  [super jsonToObject:dic];
  //        帖子id
  self.talkid = [FPYouguUtil ishave_blank:dic[@"_id"]];
  self.articleId = [FPYouguUtil ishave_blank:dic[@"article_id"]];
  //    帖子类型
  self.sourceType = [dic[@"state"] intValue];

  self.userListItem = [[UserListItem alloc] init];
  [self.userListItem jsonToObject3:dic];

  self.content = [FPYouguUtil ishave_blank:dic[@"context"]];
  self.slaveName = [FPYouguUtil ishave_blank:dic[@"slave_name"]];
  self.slaveRid = [FPYouguUtil ishave_blank:dic[@"slave_rid"]];
  self.creatTime = [[DateChangeSimple sharedManager]
      get_time_date:[FPYouguUtil ishave_blank:dic[@"create_time"]]];
  self.updateTime = [[DateChangeSimple sharedManager]
      get_time_date:[FPYouguUtil ishave_blank:dic[@"update_time"]]];
  self.praiseNum = [FPYouguUtil ishave_blank:dic[@"up_num"]];
}
@end

@implementation KnowDetailCommentList

- (NSArray *)getArray {
  return _listArray;
}

- (void)jsonToObject:(NSDictionary *)dic {
  [super jsonToObject:dic];
  self.listArray = [[NSMutableArray alloc] init];
  self.commentNum = [dic[@"comment_num"] intValue];
  NSArray *array = dic[@"replyList"];
  NSMutableArray *mArray = [[NSMutableArray alloc] init];
  [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx,
                                      BOOL *stop) {
    KnowDetailCommentItem *item = [[KnowDetailCommentItem alloc] init];
    [item jsonToObject:obj];
    [mArray addObject:item];
  }];
  [self.listArray addObjectsFromArray:mArray];
}

+ (void)getKnowDetailCommentListWithtalkId:(NSString *)talkid
                                  andStart:(NSString *)start
                              withCallback:(HttpRequestCallBack *)callback {
  NSString *path = [NSString
      stringWithFormat:@"%@/bbs/reply/getOneTalkCommentList/%@/%@/%@/%@/%@/%@",
                       IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                       YouGu_User_USerid, talkid, start, @"20"];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[KnowDetailCommentList class]
             withHttpRequestCallBack:callback];
}

+ (void)getKnowDetailCommentListWithDic:(NSDictionary *)dic
                              withCallback:(HttpRequestCallBack *)callback {
    NSString *path = [NSString
                      stringWithFormat:@"%@/bbs/reply/getOneTalkCommentList/%@/%@/%@/{talkId}/{start}/%@",
                      IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                      YouGu_User_USerid, @"20"];
    JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
    [request asynExecuteWithRequestUrl:path
                     WithRequestMethod:@"GET"
                 withRequestParameters:dic
                withRequestObjectClass:[KnowDetailCommentList class]
               withHttpRequestCallBack:callback];
}

@end

@implementation UserCommentKnowInfo

#pragma mark - 用户回复，详情信息
//用户回复，详情信息
+ (void)commentTalk:(NSString *)talkid
        andSlaveRid:(NSString *)salverid
       andsalveName:(NSString *)salvename
         andContext:(NSString *)context
       withCallback:(HttpRequestCallBack *)callback {
  if ([salverid length] == 0) {
    salverid = @"-1";
  }
  UserListItem *item = [FileChangelUtil loadUserListItem];
  NSString *myName = [CommonFunc base64StringFromText:item.nickName];
  salvename = [CommonFunc base64StringFromText:salvename];
  NSString *path = [NSString
      stringWithFormat:
          @"%@/bbs/reply/commentTalk/%@/%@/%@/%@/%@/%@/%@/%@/%@/%@/%@",
          IP_HTTP_DATA, ak_version, YouGu_User_sessionid, YouGu_User_USerid,
          myName, [CommonFunc base64StringFromText:item.headPic],
          item.sessionid, [CommonFunc base64StringFromText:item.userName],
          salverid, salvename, talkid, salverid];
  if (context && context.length > 0) {
    NSDictionary *dic = @{ @"context" : context };
    JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
    [request asynExecuteWithRequestUrl:path
                     WithRequestMethod:@"POST"
                 withRequestParameters:dic
                withRequestObjectClass:[UserCommentKnowInfo class]
               withHttpRequestCallBack:callback];
  } else {
    NSLog(@"财知道评论内容为空");
  }
}
@end

@implementation AskQuestionToThem

- (void)jsonToObject:(NSDictionary *)dic {
  [super jsonToObject:dic];
}

#pragma mark - 向TA提问，详情信息
//向TA提问
+ (void)getAskQuestionToThemWithContent:(NSString *)content
                            andSlaveRid:(NSString *)slaverid
                           andSlaveName:(NSString *)slavename
                           withCallback:(HttpRequestCallBack *)callback {
  UserListItem *item = [FileChangelUtil loadUserListItem];
  NSString *path = [NSString
      stringWithFormat:@"%@/bbs/article/atHim/%@/%@/%@/%@/%@/%@/%@/%@/%@/%@/",
                       IP_HTTP_DATA, ak_version, [FPYouguUtil getSesionID],
                       [FPYouguUtil getUserID],
                       [CommonFunc base64StringFromText:item.nickName],
                       [CommonFunc base64StringFromText:@""],
                       [CommonFunc base64StringFromText:item.headPic],
                       [CommonFunc base64StringFromText:item.signature],
                       [CommonFunc base64StringFromText:item.userName],
                       slaverid, [CommonFunc base64StringFromText:slavename]];
  NSDictionary *dic = @{
    @"context" : [FPYouguUtil ishave_blank:content],
  };
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"POST"
               withRequestParameters:dic
              withRequestObjectClass:[AskQuestionToThem class]
             withHttpRequestCallBack:callback];
}
@end

@implementation KnowCommentPraiseRequest

- (void)jsonToObject:(NSDictionary *)dic {
  [super jsonToObject:dic];
}
#pragma mark - 对财知道评论的赞
// 对财知道评论的赞
+ (void)getKnowCommentPraiseWithCommentId:(NSString *)commentid
                             withCallback:(HttpRequestCallBack *)callback {
  NSString *path =
      [NSString stringWithFormat:@"%@/bbs/reply/upComment/%@/%@/%@/%@",
                                 IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                                 YouGu_User_USerid, commentid];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[KnowCommentPraiseRequest class]
             withHttpRequestCallBack:callback];
}
@end

@implementation MyRlyListRequestItem

- (void)jsonToObject:(NSDictionary *)dic {
  [super jsonToObject:dic];
  self.commentId = [FPYouguUtil ishave_blank:dic[@"id"]];
  self.articleId = [FPYouguUtil ishave_blank:dic[@"iid"]];
  self.commentTime = [[DateChangeSimple sharedManager]
      get_time_date:[FPYouguUtil ishave_blank:dic[@"createtime"]]];
  self.commentTitle = [FPYouguUtil ishave_blank:dic[@"title"]];
  self.commentContent = [FPYouguUtil ishave_blank:dic[@"content"]];
}

@end

@implementation MyRlyListRequestList

- (NSArray *)getArray {
  return _listArray;
}

- (void)jsonToObject:(NSDictionary *)dic {
  [super jsonToObject:dic];
  self.listArray = [[NSMutableArray alloc] init];
  NSArray *array = dic[@"result"];
  NSMutableArray *mArray = [[NSMutableArray alloc] init];
  [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    MyRlyListRequestItem *item = [[MyRlyListRequestItem alloc] init];
    [item jsonToObject:obj];
    [mArray addObject:item];
  }];
  [self.listArray addObjectsFromArray:mArray];
}

+ (void)getMyRlyListWith:(NSString *)userId
                andStart:(NSString *)startNum
            withCallback:(HttpRequestCallBack *)callback {
  NSString *path = [NSString
      stringWithFormat:
          @"%@/youguu/newsrest/info/myReplyList?uid=%@&startnum=%@&pagesize=%@",
          IP_HTTP_DATA, userId, startNum, @"20"];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[MyRlyListRequestList class]
             withHttpRequestCallBack:callback];
}

+ (void)getMyRlyListWithDic:(NSDictionary *)dic
               withCallback:(HttpRequestCallBack *)callback {
  NSString *path = [NSString
      stringWithFormat:@"%@/youguu/newsrest/info/"
                       @"myReplyList?uid=%@&startnum={start}&pagesize=%@",
                       IP_HTTP_DATA, [FPYouguUtil getUserID], @"20"];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:dic
              withRequestObjectClass:[MyRlyListRequestList class]
             withHttpRequestCallBack:callback];
}

@end

@implementation KnowPostingRequest

#pragma mark - 发帖接口
//发帖
+ (void)KnowPosting:(NSString *)title
        andNickname:(NSString *)nickname
             andPic:(NSString *)picUrl
            andSign:(NSString *)sign
         andContent:(NSString *)content
       withCallback:(HttpRequestCallBack *)callback {
  NSString *username =
      [CommonFunc base64StringFromText:[FPYouguUtil getUserName]];
  title = [CommonFunc base64StringFromText:title];
  nickname = [CommonFunc base64StringFromText:nickname];
  picUrl = [CommonFunc base64StringFromText:picUrl];
  sign = [CommonFunc base64StringFromText:sign];
  content = [CommonFunc base64StringFromText:content];

  NSString *path = [NSString
      stringWithFormat:@"%@/bbs/article/releaseTalk/%@/%@/%@/%@/%@/%@/%@/%@",
                       IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                       YouGu_User_USerid, nickname, title, picUrl, sign,
                       username];
  NSDictionary *dic = @{ @"context" : content };
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"POST"
               withRequestParameters:dic
              withRequestObjectClass:[KnowPostingRequest class]
             withHttpRequestCallBack:callback];
}

@end
