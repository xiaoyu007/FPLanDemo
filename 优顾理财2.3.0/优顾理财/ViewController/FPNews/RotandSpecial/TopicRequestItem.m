//
//  TopicRequestItem.m
//  优顾理财
//
//  Created by Mac on 15/7/30.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "TopicRequestItem.h"

@implementation TopicObjectItem

-(void)jsonToObject:(NSDictionary *)dic
{
  [super jsonToObject:dic];
  self.listArray = [[NSMutableArray alloc]init];
  self.title = dic[@"name"];
}

@end

@implementation TopicRequestItem
-(void)jsonToObject:(NSDictionary *)dic
{
  [super jsonToObject:dic];
  self.imageUrl = YouGu_StringWithFormat_double(
                                                IP_HTTP, YouGu_ishave_blank(dic[@"pic"]));
  self.summary = [FPYouguUtil ishave_blank:dic[@"brief"]];
  NSArray * array = dic[@"result"];
  self.array = [[NSMutableArray alloc]init];
  NSMutableArray * mArray = [[NSMutableArray alloc]init];
  NSMutableArray * dArray = [[NSMutableArray alloc]init];
  [array enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL *stop) {
    NSString * type = [FPYouguUtil ishave_blank:obj[@"type"]];
    if ([type intValue] == 2) {
      NewsInChannelItem * item = [[NewsInChannelItem alloc]init];
      [item jsonToObject:obj];
      [dArray addObject:item];
    }else
    {
      TopicObjectItem * object = [[TopicObjectItem alloc]init];
      object.listArray =[[NSMutableArray alloc]initWithArray:dArray];
      object.title = obj[@"name"];
      [mArray addObject:object];
      [dArray removeAllObjects];
    }
  }];
  [self.array  addObjectsFromArray:mArray];
}
#pragma mark - 普通专题，和热门专题列表
//获取普通专题列表
+ (void)getTopicWithTopicId:(NSString*)topicId
               withCallback:(HttpRequestCallBack*)callback {
  NSString* path = [NSString
      stringWithFormat:@"%@/youguu/newsrest/info/topiclist/%@/%@/%@/%@/%@",
                       IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                       YouGu_User_USerid, Iphone_Size(), topicId];
  JsonFormatRequester* request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[TopicRequestItem class]
             withHttpRequestCallBack:callback];
}
@end
