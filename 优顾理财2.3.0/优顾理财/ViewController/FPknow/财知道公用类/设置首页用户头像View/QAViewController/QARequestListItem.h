//
//  QARequestListItem.h
//  优顾理财
//
//  Created by Mac on 15/7/21.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "BaseRequestObject.h"
#import "JsonFormatRequester.h"
#import "UserListItem.h"
@interface QARequestListItem : JsonRequestObject

@end
/**
 *  Description
 */
@interface QTRequestItem : JsonRequestObject
//帖子id
@property(nonatomic, strong) NSString *aid;
//评论或回复article_id
@property(nonatomic, strong) NSString *articleId;

@property(nonatomic, strong) NSString *userNewsChannelId;
@property(nonatomic, strong) NSString *userNewsCreatTime;
@property(nonatomic, strong) NSString *userNewsId;

@property(nonatomic, strong) UserListItem *userListItem;

@property(nonatomic, strong) NSString *userSummary;
@property(nonatomic, assign) float summaryHeight;
@property(nonatomic, strong) NSString *userTitle;

@property(nonatomic, strong) NSString *praiseNum;
@property(nonatomic, strong) NSString *commentNum;

@property(nonatomic, strong) NSString *userCreattime;
@property(nonatomic, strong) NSString *userUpdateTime;
@property(nonatomic, strong) NSString *userBeNickname;
@property(nonatomic, strong) NSString *userBeUid;
@property(nonatomic, strong) NSString *userBeBeUid;

@property(nonatomic, assign) BOOL isReading;
@end

/**
 *  Description
 */
@interface QTRequestList : JsonRequestObject <Collectionable>
@property(nonatomic, strong) NSString *totalNum;
@property(nonatomic, strong) NSMutableArray *mainArray;

+ (void)getQTListWithUid:(NSString *)uid
                AndStart:(NSInteger)start
            withCallback:(HttpRequestCallBack *)callback;

+ (void)getQTListWithDic:(NSDictionary *)dic
            withCallback:(HttpRequestCallBack *)callback;
@end

/**
 *  Description
 */
@interface AWRequestList : JsonRequestObject <Collectionable>
@property(nonatomic, strong) NSString *totalNum;
@property(nonatomic, strong) NSMutableArray *mainArray;

+ (void)getAWListWithUid:(NSString *)uid
                AndStart:(NSInteger)start
            withCallback:(HttpRequestCallBack *)callback;

+ (void)getAWListWithDic:(NSDictionary *)dic
            withCallback:(HttpRequestCallBack *)callback;
@end