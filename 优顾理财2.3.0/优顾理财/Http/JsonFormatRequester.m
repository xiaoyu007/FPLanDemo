//
//  RequesterForJsonData.m
//  SimuStock
//
//  Created by Mac on 14-8-27.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "NSString+Java.h"

//#import "SREmojiConvertor.h"
@implementation JsonFormatRequester

- (void)configHTTPRequest:(ASIHTTPRequest *)request {
  [super configHTTPRequest:request];
  [request addRequestHeader:@"Cache-Control" value:@"no-cache"]; //,no-store
}

- (void)requestFinished:(ASIHTTPRequest *)request {
  @try {
    NSData *data = [request responseData];
    if (data == nil || data.length == 0) {
      [self handleFailed];
      return;
    }

    //得到返回内容，未排除不可见字符
    NSString *responseString =
        [[NSString alloc] initWithBytes:[data bytes]
                                 length:[data length]
                               encoding:[request responseEncoding]];
    NSString *jsonText =
        [CommonFunc textFromBase64String:[responseString trim]];
    //    jsonText = @"{\"content\":\"购 6 有B\n\"}"; //测试用例

    //如果字符串中含有0x00-0x1F和0x7F这样的控制字符，则解析失败
    //对策：将其转义为\uxxxx的形式
    NSMutableString *escapedString = [NSMutableString string];
    for (NSUInteger i = 0; i < jsonText.length; i++) {
      unichar c = [jsonText characterAtIndex:i];
      if (c < 0x1F || c == 0x7F) {
        [escapedString appendFormat:@"\\u%04X", (int)c];
      } else {
        [escapedString appendFormat:@"%C", c];
      }
    }

    jsonText = escapedString;

    if (jsonText == nil || [jsonText length] == 0) {
      [self handleFailed];
      return;
    }

    NSDictionary *dic = [jsonText objectFromJSONString];
    if (dic == nil) {
      dic = [data objectFromJSONData];
    }

    id<ParseJson> object = [[self.requestObjectClass alloc] init];
    NSString *status = dic[@"status"];
    if ([@"0000" isEqualToString:status] || [@"0001" isEqualToString:status]||[@"000000" isEqualToString:status]) {
      if (object && [object respondsToSelector:@selector(jsonToObject:)]) {
        [object jsonToObject:dic];
        [self handleSaveCache:data];
        [self handleSuccess:(NSObject *)object];
      } else {
        NSException *ex =
            [NSException exceptionWithName:@"NO method found: jsonToObject"
                                    reason:@"NO method found: jsonToObject"
                                  userInfo:nil];
        [self handleError:nil orException:ex];
      }
    } else {
      JsonErrorObject *requestObject = [[JsonErrorObject alloc] init];
      [requestObject jsonToObject:dic];
      requestObject.errorDetailInfo = dic;
      [self handleError:requestObject orException:nil];
    }
  } @catch (NSException *ex) {
    [self handleError:nil orException:ex];
  } @finally {
    [[BaseRequester getRequestCache] removeObject:self];
  }
};

+ (NSDictionary *)toDictionaryWithData:(NSData *)data {
  NSString *responseString =
      [[NSString alloc] initWithBytes:[data bytes]
                               length:[data length]
                             encoding:NSUTF8StringEncoding];
  NSString *jsonText = [CommonFunc textFromBase64String:responseString];
  return [jsonText objectFromJSONString];
}
@end
