//
//  MyCollectRequest.m
//  优顾理财
//
//  Created by Mac on 15/8/25.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "MyCollectRequest.h"
#import "DateChangeSimple.h"
#import "NewsWithDidCollect.h"
@implementation MyCollectItem
-(void)jsonToObject:(NSDictionary *)dic
{
  self.newsId = [FPYouguUtil ishave_blank:dic[@"eid"]];
  self.fid = [FPYouguUtil ishave_blank:dic[@"fid"]];
  self.type = [dic[@"type"] intValue];
  self.title = [FPYouguUtil ishave_blank:dic[@"title"]];
  self.lastTime =[[DateChangeSimple sharedManager] get_time_date:[FPYouguUtil ishave_blank:dic[@"lastModified"]]];
  self.isreading = NO;
  [[NewsWithDidCollect sharedManager]addNewsId:self];
}
+(MyCollectItem *)creatMyCollectWithObject:(NSString *)newsId AndType:(int)type andTitle:(NSString *)title
{
  MyCollectItem * item =[[MyCollectItem alloc]init];
  item.newsId =newsId;
  item.type = type;
  item.title = title;
  item.isRemove=NO;
  item.isreading =NO;
  return item;
}
@end

@implementation MyCollectRequest
-(void)jsonToObject:(NSDictionary *)dic
{
  [super jsonToObject:dic];
  NSMutableArray * dArray =[[NSMutableArray alloc]init];
  NSArray * mArray = dic[@"result"];
  [mArray enumerateObjectsUsingBlock:^(NSDictionary * dic, NSUInteger idx, BOOL *stop) {
    MyCollectItem * item =[[MyCollectItem alloc]init];
    [item jsonToObject:dic];
    [dArray addObject:item];
  }];
  self.array = [dArray copy];
}

+ (void)myCollectWithCallback:(HttpRequestCallBack *)callback {
  NSString *path = [NSString stringWithFormat:@"%@/youguu/newsrest/info/queryFavorites", IP_HTTP_DATA];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[MyCollectRequest class]
             withHttpRequestCallBack:callback];
}
@end
