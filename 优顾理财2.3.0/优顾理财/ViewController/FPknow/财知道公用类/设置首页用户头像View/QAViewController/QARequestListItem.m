//
//  QARequestListItem.m
//  优顾理财
//
//  Created by Mac on 15/7/21.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "QARequestListItem.h"
#import "DateChangeSimple.h"

@implementation QARequestListItem

@end
@implementation QTRequestItem
- (void)jsonToObject:(NSDictionary *)dic {
  [super jsonToObject:dic];
  self.aid = [FPYouguUtil ishave_blank:dic[@"_id"]];
  self.articleId = [FPYouguUtil ishave_blank:dic[@"article_src"]];
  self.userNewsChannelId = [FPYouguUtil ishave_blank:dic[@"news_channelid"]];
  self.userNewsId = [FPYouguUtil ishave_blank:dic[@"news_id"]];
  self.userNewsCreatTime = [FPYouguUtil ishave_blank:dic[@"news_createtime"]];

  self.userListItem = [[UserListItem alloc] init];
  [self.userListItem jsonToObject2:dic];

  self.userTitle = [FPYouguUtil ishave_blank:dic[@"title"]];
  self.userSummary = [FPYouguUtil ishave_blank:dic[@"summary"]];
  //  self.summaryHeight = [FPYouguUtil ishave_blank:dic[@"summary"]];

  self.commentNum = [FPYouguUtil ishave_blank:dic[@"comment_num"]];
  self.praiseNum = [FPYouguUtil ishave_blank:dic[@"up_num"]];

  //        创建时间
  self.userCreattime = [[DateChangeSimple sharedManager]
      get_time_date:[FPYouguUtil ishave_blank:dic[@"create_time"]]];
  //        更新时间
  self.userUpdateTime = [[DateChangeSimple sharedManager]
      get_time_date:[FPYouguUtil ishave_blank:dic[@"update_time"]]];

  //        向ta提问的对象
  self.userBeNickname = [FPYouguUtil ishave_blank:dic[@"be_nickname"]];
  self.userBeUid = [FPYouguUtil ishave_blank:dic[@"be_uid"]];
}

///评论的列表
- (void)dicTojson:(NSDictionary *)dic {
  [super jsonToObject:dic];
  //        帖子id
  self.aid = [FPYouguUtil ishave_blank:dic[@"_id"]];
  //    评论id
  self.articleId = [FPYouguUtil ishave_blank:dic[@"article_id"]];

  // news channelid, news_id, news_creattime
  self.userNewsChannelId = [FPYouguUtil ishave_blank:dic[@"news_channelid"]];
  self.userNewsId = [FPYouguUtil ishave_blank:dic[@"news_id"]];
  self.userCreattime = [FPYouguUtil ishave_blank:dic[@"news_createtime"]];

  self.userListItem = [[UserListItem alloc] init];
  [self.userListItem jsonToObject3:dic];

  //        帖子标题
  self.userTitle = [FPYouguUtil ishave_blank:dic[@"title"]];
  self.userSummary = [FPYouguUtil ishave_blank:dic[@"context"]];
  //        评论数
  self.commentNum = [FPYouguUtil ishave_blank:dic[@"comment_num"]];
  self.praiseNum = [FPYouguUtil ishave_blank:dic[@"up_num"]];

  //        创建时间
  self.userCreattime = [[DateChangeSimple sharedManager]
      get_time_date:[FPYouguUtil ishave_blank:dic[@"create_time"]]];
  self.userUpdateTime = [[DateChangeSimple sharedManager]
      get_time_date:[FPYouguUtil ishave_blank:dic[@"update_time"]]];

  //        向ta提问的对象
  self.userBeNickname = [FPYouguUtil ishave_blank:dic[@"slave_name"]];
  self.userBeUid = [FPYouguUtil ishave_blank:dic[@"slave_id"]];
  self.userBeBeUid = [FPYouguUtil ishave_blank:dic[@"slave_rid"]];
}

@end
@implementation QTRequestList

- (NSArray *)getArray
{
    return _mainArray;
}

- (void)jsonToObject:(NSDictionary *)dic {
  [super jsonToObject:dic];
  self.totalNum = [FPYouguUtil ishave_blank:dic[@"article_num"]];
  self.mainArray = [[NSMutableArray alloc] init];
  NSArray *array = dic[@"talkList"];
  NSMutableArray *midArray = [[NSMutableArray alloc] init];
  [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx,
                                      BOOL *stop) {
    QTRequestItem *item = [[QTRequestItem alloc] init];
    [item jsonToObject:obj];
    [midArray addObject:item];
  }];
  [self.mainArray addObjectsFromArray:midArray];
}

+ (void)getQTListWithUid:(NSString *)uid
                AndStart:(NSInteger)start
            withCallback:(HttpRequestCallBack *)callback {
  NSString *path =
      [NSString stringWithFormat:@"%@/bbs/article/myTalkList/%@/%@/%@/%@/%d/%@",
                                 IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                                 YouGu_User_USerid, uid, (int)start, @"20"];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[QTRequestList class]
             withHttpRequestCallBack:callback];
}

+ (void)getQTListWithDic:(NSDictionary *)dic
            withCallback:(HttpRequestCallBack *)callback {
    NSString *path =
    [NSString stringWithFormat:@"%@/bbs/article/myTalkList/%@/%@/%@/%@/{start}/%@",
     IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
     YouGu_User_USerid, [FPYouguUtil getUserID], @"20"];
    JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
    [request asynExecuteWithRequestUrl:path
                     WithRequestMethod:@"GET"
                 withRequestParameters:dic
                withRequestObjectClass:[QTRequestList class]
               withHttpRequestCallBack:callback];
}

@end

/**
 *  Description
 */
@implementation AWRequestList

- (NSArray *)getArray
{
    return _mainArray;
}

- (void)jsonToObject:(NSDictionary *)dic {
  [super jsonToObject:dic];
  self.totalNum = [FPYouguUtil ishave_blank:dic[@"comment_num"]];
  self.mainArray = [[NSMutableArray alloc] init];
  NSArray *array = dic[@"replyList"];
  NSMutableArray *midArray = [[NSMutableArray alloc] init];
  [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx,
                                      BOOL *stop) {
    QTRequestItem *item = [[QTRequestItem alloc] init];
    [item dicTojson:obj];
    [midArray addObject:item];
  }];
  [self.mainArray addObjectsFromArray:midArray];
}

+ (void)getAWListWithUid:(NSString *)uid
                AndStart:(NSInteger)start
            withCallback:(HttpRequestCallBack *)callback {
  NSString *path = [NSString
      stringWithFormat:@"%@/bbs/reply/myCommentList/%@/%@/%@/%@/%d/%@",
                       IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                       YouGu_User_USerid, uid, (int)start, @"20"];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[AWRequestList class]
             withHttpRequestCallBack:callback];
}

+ (void)getAWListWithDic:(NSDictionary *)dic
            withCallback:(HttpRequestCallBack *)callback {
    NSString *path = [NSString
                      stringWithFormat:@"%@/bbs/reply/myCommentList/%@/%@/%@/%@/{start}/%@",
                      IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                      YouGu_User_USerid, [FPYouguUtil getUserID], @"20"];
    JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
    [request asynExecuteWithRequestUrl:path
                     WithRequestMethod:@"GET"
                 withRequestParameters:dic
                withRequestObjectClass:[AWRequestList class]
               withHttpRequestCallBack:callback];
}

@end
