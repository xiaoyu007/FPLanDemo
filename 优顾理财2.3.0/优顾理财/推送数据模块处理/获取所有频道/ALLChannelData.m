//
//  ALLChannelData.m
//  优顾理财
//
//  Created by Mac on 15/7/28.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "ALLChannelData.h"

@implementation ALLChannelData
// all 所有频道的获取
+(void)getAllChannelObject {
  HttpRequestCallBack* callback = [[HttpRequestCallBack alloc] init];
  callback.onSuccess = ^(NSObject* obj) {
      NewsChannelList* allObject = (NewsChannelList*)obj;
      //   所有频道
      [FileChangelUtil saveAllNewsChannelList:allObject];
      
      NewsChannelList* myObject = [FileChangelUtil loadMyNewsChannelList];
      if (myObject.channels.count >= 5) {
        NSMutableArray* myAry = [[NSMutableArray alloc] init];
        NSMutableArray* moreAry = [[NSMutableArray alloc] init];
        [allObject.channels enumerateObjectsUsingBlock:^(NewsChannelItem* item,
                                                         NSUInteger idx,
                                                         BOOL* stop) {
          if ([ALLChannelData findChannle:item.name andarray:myObject.channels]) {
            NewsChannelList* onlyObject =
                allObject.channels[idx];
            [myAry addObject:onlyObject];
          } else {  /// 其他剩余的频道
            NewsChannelItem* onlyObject =
                allObject.channels[idx];
            [moreAry addObject:onlyObject];
          }
        }];
        
        NewsChannelList* myObject1 = [[NewsChannelList alloc] init];
        myObject1.channels = myAry;
        [FileChangelUtil saveMyNewsChannelList:myObject1];
        NewsChannelList* moreObject = [[NewsChannelList alloc] init];
        moreObject.channels = moreAry;
        [FileChangelUtil saveMoreNewsChannelList:moreObject];
      }
  };
  callback.onError = ^(BaseRequestObject *err, NSException *ex) {
  };
  callback.onFailed = ^{
  };
  [NewsChannelList getNetworkRequestsAllChannelwithCallback:callback];
}
///判断该频道，是否还存在
+ (BOOL)findChannle:(NSString*)name andarray:(NSArray*)array {
  for (NewsChannelItem* onlyObject in array) {
    if ([onlyObject.name isEqualToString:name]) {
      return YES;
    }
  }
  return NO;
}

@end
