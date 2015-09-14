//
//  NewsChannelList.m
//  SimuStock
//
//  Created by Mac on 15/5/24.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

@implementation NewsArrayWithId
@end

@implementation NewsChannelItem

- (void)jsonToObject:(NSDictionary *)dic {
  self.channleID = [dic[@"id"] stringValue];
  self.name = dic[@"mc"];
  if (dic[@"isEditable"]) {
    self.isEditable = [dic[@"isEditable"] boolValue];
  } else {
    if ([self.channleID intValue] == 1) {
      self.isEditable = NO;
    } else
      self.isEditable = YES;
  }
  self.isVisible = YES;
}
@end

@implementation NewsChannelList

- (void)jsonToObject:(NSDictionary *)dic {
  [super jsonToObject:dic];
  _channels = [[NSMutableArray alloc] init];
  NSArray *result = dic[@"result"];
  if (result && result.count > 0) {
    [result enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx,
                                         BOOL *stop) {
      NewsChannelItem *item = [[NewsChannelItem alloc] init];
      [item jsonToObject:obj];
      [_channels addObject:item];
    }];
  }
}

- (NSArray *)getArray {
  return _channels;
}

- (NSDictionary *)mappingDictionary {
  return @{ @"channels" : NSStringFromClass([NewsChannelItem class]) };
}

+ (void)getNetworkRequestsAllChannelwithCallback:
    (HttpRequestCallBack *)callback {
  NSString *path = [NSString
      stringWithFormat:@"%@/youguu/newsrest/info/channellist/%@/%@/%@",
                       IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                       YouGu_User_USerid];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[NewsChannelList class]
             withHttpRequestCallBack:callback];
}

@end

@implementation NewsInChannelItem

- (void)jsonToObject:(NSDictionary *)dic {
  [super jsonToObject:dic];
  self.newsID = [FPYouguUtil ishave_blank:dic[@"id"]];
  self.title = dic[@"bt"];
  self.newsIntroduction = dic[@"jj"];
  self.publishTime = [FPYouguUtil ishave_blank:dic[@"sj"]];
  self.newsSourceUrl = dic[@"sourceUrl"];
  self.topicid = [FPYouguUtil ishave_blank:dic[@"topicid"]];
  self.wzlx = [FPYouguUtil ishave_blank:dic[@"wzlx"]];
  self.ly = dic[@"ly"];
  self.xgsj = [FPYouguUtil ishave_blank:dic[@"xgsj"]];
  self.lx = [FPYouguUtil ishave_blank:dic[@"lx"]];
  self.source = dic[@"source"];
  self.praise = dic[@"praise"];
  self.isPraise = [[PraiseObject sharedManager] isDonePraise:self.newsID];
  //  BOOL isExist = [FileChangelUtil isReadNewsWithID:self.newsID];
  NewsWithItem *newsItem =
      [[NewsWithItem alloc] initWithNewsId:self.newsID andType:1];
  BOOL isExist = [[NewsIdWithDidRead sharedManager] isReadNewsWithID:newsItem];
  if (isExist) {
    self.is_or_read = YES;
  } else {
    self.is_or_read = NO;
  }
}

- (void)headerWithjsonToObject:(NSDictionary *)dic {
  [super jsonToObject:dic];
  self.newsID = [dic[@"id"] stringValue];
  self.source = dic[@"source"];
  self.wzlx = [dic[@"wzlx"] stringValue];
  self.title = dic[@"bt"];
  self.aid = [dic[@"aid"] stringValue];
  self.newsSourceUrl = dic[@"sourceUrl"];
  self.picImage = [NSString
      stringWithFormat:@"%@%@", IP_HTTP, [FPYouguUtil ishave_blank:dic[@"tp"]]];
  ;
}

@end

@implementation NewsListInChannel

- (void)jsonToObject:(NSDictionary *)dic {
  [super jsonToObject:dic];
  _headerList = [[NSMutableArray alloc] init];
  NSArray *list = dic[@"list"];
  if (list && [[list class] isSubclassOfClass:[NSArray class]] &&
      list.count > 0) {
    [list enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx,
                                       BOOL *stop) {
      NewsInChannelItem *item = [[NewsInChannelItem alloc] init];
      [item headerWithjsonToObject:obj];
      [_headerList addObject:item];
    }];
  }

  _newsList = [[NSMutableArray alloc] init];
  NSArray *result = dic[@"result"];
  if (result && [[result class] isSubclassOfClass:[NSArray class]] &&
      result.count > 0) {
    [result enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx,
                                         BOOL *stop) {
      NewsInChannelItem *item = [[NewsInChannelItem alloc] init];
      [item jsonToObject:obj];
      [_newsList addObject:item];
    }];
  }
}

- (NSArray *)getArray {
  return _newsList;
}
- (NSDictionary *)mappingDictionary {
  return @{
    @"newsList" : NSStringFromClass([NewsInChannelItem class]),
    @"headerList" : NSStringFromClass([NewsInChannelItem class])
  };
}

+ (void)requestNewsListWithChannlid:(NSString *)channlid
                           andStart:(NSInteger)startnum
                       withCallback:(HttpRequestCallBack *)callback {
  NSString *path = [NSString
      stringWithFormat:
          @"%@/youguu/newsrest/info/infolist/%@/%@/%@/%@/%@/%ld/%@",
          IP_HTTP_DATA, ak_version, YouGu_User_sessionid, YouGu_User_USerid,
          Iphone_Size(), channlid, (long)startnum + 1, @"20"];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[NewsListInChannel class]
             withHttpRequestCallBack:callback];
}

@end
@implementation NewsItemPraise

- (void)jsonToObject:(NSDictionary *)dic {
  [super jsonToObject:dic];
}

+ (void)requestNewsItemWithNewsId:(NSString *)newsId
                      AndChannlid:(NSString *)channlid
                     withCallback:(HttpRequestCallBack *)callback {
  NSString *path = [NSString
      stringWithFormat:@"%@/youguu/newsrest/info/infopj/%@/%@/%@/%@/%@/%d",
                       IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                       YouGu_User_USerid, channlid, newsId, 1];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[NewsItemPraise class]
             withHttpRequestCallBack:callback];
}
@end

@implementation OnlyNewsRotItem
- (void)jsonToObject:(NSDictionary *)dic {
  [super jsonToObject:dic];
}
@end

////新闻微热点
@implementation NewsRotList

- (NSArray *)getArray {
  return _newsList;
}

- (void)jsonToObject:(NSDictionary *)dic {
  [super jsonToObject:dic];
  _name = dic[@"name"];
  _newsList = [[NSMutableArray alloc] init];
  NSArray *result = dic[@"result"];
  [result enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx,
                                       BOOL *stop) {
    NewsInChannelItem *item = [[NewsInChannelItem alloc] init];
    [item jsonToObject:obj];
    [_newsList addObject:item];
  }];
}

+ (void)requestNewsRotItemWithtopicId:(NSString *)topicid
                             andStart:(int)startnum
                          andPagesize:(NSString *)page
                         withCallback:(HttpRequestCallBack *)callback {
  NSString *path =
      [NSString stringWithFormat:
                    @"%@/youguu/newsrest/info/topiclistgl/%@/%@/%@/%@/%@/%d/%@",
                    IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                    YouGu_User_USerid, Iphone_Size(), topicid, startnum, page];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[NewsRotList class]
             withHttpRequestCallBack:callback];
}

+ (void)requestNewsRotItemWithDic:(NSDictionary *)dic
                     withCallback:(HttpRequestCallBack *)callback {
  NSString *path =
      [NSString stringWithFormat:@"%@/youguu/newsrest/info/topiclistgl/%@/%@/"
                                 @"%@/%@/{topicid}/{start}/%@",
                                 IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                                 YouGu_User_USerid, Iphone_Size(), @"20"];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:dic
              withRequestObjectClass:[NewsRotList class]
             withHttpRequestCallBack:callback];
}
@end
