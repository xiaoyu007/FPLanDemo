//
//  StreamFormatRequester.m
//  SimuStock
//
//  Created by Mac on 14-8-28.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "StreamFormatRequester.h"

@implementation StreamFormatRequester
- (void)requestFinished:(ASIHTTPRequest *)request {
  @try {
    NSData *data = [request responseData];
    if (data == nil || [data length] < 2) {
      [self handleFailed];
      return;
    }

    //得到状态
    NSString *status =
        [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 4)]
                              encoding:NSUTF8StringEncoding];

    if (![status isEqualToString:@"0000"]) {
      //返回错误页面
      NSString *errerMessage = [[NSString alloc]
          initWithData:[data subdataWithRange:NSMakeRange(4, [data length] - 4)]
              encoding:NSUTF8StringEncoding];
      BaseRequestObject *requestObject = [[BaseRequestObject alloc] init];
      requestObject.status = status;
      requestObject.message = errerMessage;
      [self handleError:requestObject orException:nil];
      return;
    }

    //解析
    id<ParseStream> object = [[self.requestObjectClass alloc] init];

    if (object && [object respondsToSelector:@selector(streamToObject:)]) {
      [object streamToObject:data];
      BaseRequestObject *requestObject = object;
      requestObject.status = status;
      [self handleSuccess:requestObject];
    } else {
      NSException *ex =
          [NSException exceptionWithName:@"NO method found: streamToObject"
                                  reason:@"NO method found: streamToObject"
                                userInfo:nil];
      [self handleError:nil orException:ex];
    }
  }
  @catch (NSException *ex) {
    [self handleError:nil orException:ex];
  }
  @finally {
    [[BaseRequester getRequestCache] removeObject:self];
  }
};
@end
