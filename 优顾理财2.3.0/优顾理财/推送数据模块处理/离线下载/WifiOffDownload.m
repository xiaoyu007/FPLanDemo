//
//  WifiOffDownload.m
//  优顾理财
//
//  Created by Mac on 15/7/29.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "WifiOffDownload.h"

@implementation WifiOffDownload
-(void)jsonToObject:(NSDictionary *)dic
{
  [super jsonToObject:dic];
  self.array =[[NSMutableArray alloc]init];
  NSMutableArray * dArray = [[NSMutableArray alloc]init];
  NSArray * mArray = dic[@"result"];
  [mArray enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL *stop) {
    NewsInChannelItem * item = [[NewsInChannelItem alloc]init];
    [item jsonToObject:obj];
    [dArray addObject:item];
  }];
  [self.array addObjectsFromArray:dArray];
}
#pragma mark - 离线下载
//基本信息
+(void)getWifiOffDownloadWithChannlid:(NSString*)channlid
                           andStartnum:(int)startnum
                          withCallback:(HttpRequestCallBack*)callback {
  NSString* path = [NSString
      stringWithFormat:
          @"%@/youguu/newsrest/info/downinfolist/%@/%@/%@/%@/%@/%d/%@",
          IP_HTTP_DATA, ak_version, YouGu_User_sessionid, YouGu_User_USerid,
          Iphone_Size(), channlid, startnum, @"20"];
  JsonFormatRequester* request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[WifiOffDownload class]
             withHttpRequestCallBack:callback];
}
@end
