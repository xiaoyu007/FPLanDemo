//
//  UserBpushInformationNum.h
//  SimuStock
//
//  Created by Mac on 15/3/18.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "BaseRequestObject.h"
#import "BpushModelDeal.h"
@class HttpRequestCallBack;

///消息中心未读数统计数据
@interface UserBpushInformationNum : JsonRequestObject

@property(nonatomic, strong) NSMutableDictionary *unReadCountDic;

- (NSInteger)getCount:(YLBpushType)type;

/////如果点击应用启动,需要请求一下当前用户的所收到的应用信息
//+ (void)requestUnReadStaticData;

///重新计算未读总数
+ (void)resetUnReadAllCount;
////清除所有数据
+(void)clearAllUnReadCount;

///指定类型消息未读数设置为0
+ (void)clearUnReadCountWithMessageType:(YLBpushType)bpushType;

///指定类型消息未读数+1
+ (void)increaseUnReadCountWithMessageType:(YLBpushType)bpushType;

///获取未读的统计数据
+ (UserBpushInformationNum *)getUnReadObject;
@end
