//
//  QAMyTalkRequestItem.h
//  优顾理财
//
//  Created by Mac on 15/8/10.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "BaseRequestObject.h"

@interface QAMyTalkRequestItem : JsonRequestObject
///删除我的提问，和我的回答
+ (void)delegateKnowQuestionAndAnswerWithTalkId:(NSString *)talkid
                                    AndNickname:(NSString *)nickname
                                   withCallback:(HttpRequestCallBack *)callback;
///删除我的回答
+ (void)delegateKnowAnswerWithTalkId:(NSString *)talkid
                         AndNickname:(NSString *)nickname
                        withCallback:(HttpRequestCallBack *)callback;
///删除我的评论
+ (void)delegateNewsTalkWithTalkId:(NSString *)talkid
                      withCallback:(HttpRequestCallBack *)callback;
@end
