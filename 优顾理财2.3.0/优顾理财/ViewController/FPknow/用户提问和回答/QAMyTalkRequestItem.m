//
//  QAMyTalkRequestItem.m
//  优顾理财
//
//  Created by Mac on 15/8/10.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "QAMyTalkRequestItem.h"

@implementation QAMyTalkRequestItem
- (void)jsonToObject:(NSDictionary *)dic {
  [super jsonToObject:dic];
}
///删除我的提问
+ (void)delegateKnowQuestionAndAnswerWithTalkId:(NSString *)talkid
                                    AndNickname:(NSString *)nickname
                                   withCallback:
                                       (HttpRequestCallBack *)callback {
  NSString *path =
      [NSString stringWithFormat:@"%@/bbs/article/deleteTalk/%@/%@/%@/%@/%@",
                                 IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                                 YouGu_User_USerid, talkid,
                                 [CommonFunc base64StringFromText:nickname]];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[QAMyTalkRequestItem class]
             withHttpRequestCallBack:callback];
}
///删除我的回答
+ (void)delegateKnowAnswerWithTalkId:(NSString *)talkid
                         AndNickname:(NSString *)nickname
                        withCallback:(HttpRequestCallBack *)callback {
  NSString *path = [NSString
      stringWithFormat:@"%@/bbs/reply/deleteReply/%@/%@/%@/%@/%@", IP_HTTP_DATA,
                       ak_version, YouGu_User_sessionid, YouGu_User_USerid,
                       talkid, [CommonFunc base64StringFromText:nickname]];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[QAMyTalkRequestItem class]
             withHttpRequestCallBack:callback];
}
///删除我的评论
+ (void)delegateNewsTalkWithTalkId:(NSString *)talkid
                      withCallback:(HttpRequestCallBack *)callback {
  NSString *path = [NSString
      stringWithFormat:@"%@/youguu/newsrest/info/delReplay", IP_HTTP_DATA];
  NSDictionary *dic = @{ @"replayid" : talkid };
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"POST"
               withRequestParameters:dic
              withRequestObjectClass:[QAMyTalkRequestItem class]
             withHttpRequestCallBack:callback];
}

@end
