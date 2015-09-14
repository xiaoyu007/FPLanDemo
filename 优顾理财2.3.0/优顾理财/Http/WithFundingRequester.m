//
//  WithFundingRequester.m
//  SimuStock
//
//  Created by Mac on 15/4/9.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "WithFundingRequester.h"


#pragma mark 配资请求返回结果基本类

@implementation BaseWithFundingResponseObject

-(void) jsonToObject:(NSDictionary *)dic{};

- (BOOL)isOK {
  return [@"0" isEqualToString:self.status];
}

//字典解析的key：value但我们没有或变量名冲突的情况
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
  NSLog(@"UndefinedKey is %@， value is %@ 赶紧在你的数据模型中添加这个键吧！",
        key, value);
}

@end



#pragma mark 配资接口请求及解析框架类

@implementation WithFundingRequester

- (void)configHTTPRequest:(ASIHTTPRequest *)request {
  request.shouldAttemptPersistentConnection = NO;
  [request
   setValidatesSecureCertificate:NO]; //请求https的时候，就要设置这个属性
}

- (void)requestFinished:(ASIHTTPRequest *)request {
  @try {
    NSData *data = [request responseData];
    if (data == nil || [data length] < 2) {
      [self handleFailed];
      return;
    }
    
    //得到返回内容，未排除不可见字符
    NSString *jsonText =
    [[NSString alloc] initWithBytes:[data bytes]
                             length:[data length]
                           encoding:[request responseEncoding]];


    
    NSDictionary *dic = [jsonText objectFromJSONString];
    
    //{result:{"data":false,"errorCode":"0","errorInfo":"成功"}}
    
    id<ParseJson> object = [[self.requestObjectClass alloc] init];
    NSDictionary *result = dic[@"result"];
    NSString *status = result[@"errorCode"];
    if ([@"0" isEqualToString:status]) {
      if ([object isKindOfClass:[BaseWithFundingResponseObject class]]) {
        BaseWithFundingResponseObject *response = (BaseWithFundingResponseObject*) object;
        response.status = status;
        response.message = result[@"errorInfo"];
      }
      if (object && [object respondsToSelector:@selector(jsonToObject:)]) {
        [object jsonToObject:result];
        [self handleSaveCache:data];
        [self handleSuccess:object];
        
        //设置网络接口的cookie
        
        NSDictionary *cookies = [request responseHeaders];
        if (cookies[@"Set-Cookie"]) {
          //        [RealTradeAuthInfo singleInstance].cookie = cookies[@"Set-Cookie"];
        }
      } else {
        NSException *ex =
        [NSException exceptionWithName:@"NO method found: jsonToObject"
                                reason:@"NO method found: jsonToObject"
                              userInfo:nil];
        [self handleError:nil orException:ex];
      }
    } else {
      JsonRequestObject *requestObject = [[JsonRequestObject alloc] init];
      requestObject.status = status;
      requestObject.message = result[@"errorInfo"];
      [self handleError:requestObject orException:nil];
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
