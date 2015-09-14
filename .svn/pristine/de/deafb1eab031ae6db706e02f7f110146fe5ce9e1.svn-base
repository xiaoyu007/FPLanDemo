//
//  TopicRequestItem.h
//  优顾理财
//
//  Created by Mac on 15/7/30.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "BaseRequestObject.h"
@interface TopicObjectItem : JsonRequestObject
@property(nonatomic, strong) NSString * title;
@property(nonatomic, strong) NSMutableArray * listArray;
@end

@interface TopicRequestItem : JsonRequestObject

@property(nonatomic, strong) NSString * imageUrl;
@property(nonatomic, strong) NSString * summary;
@property(nonatomic, strong) NSMutableArray * array;
#pragma mark - 普通专题，和热门专题列表
//获取普通专题列表
+ (void)getTopicWithTopicId:(NSString*)topicId
               withCallback:(HttpRequestCallBack*)callback;
@end
