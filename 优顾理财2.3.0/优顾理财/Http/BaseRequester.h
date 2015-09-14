//
//  BaseRequester.h
//  SimuStock
//
//  Created by Mac on 14-8-27.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"

#import "CommonFunc.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequestDelegate.h"
#import "BaseRequestObject.h"
#import "NewShowLabel.h"

@interface JhssPostFile : NSObject
@property(nonatomic, strong) NSString *filepath;
@property(nonatomic, strong) NSString *filename;
@property(nonatomic, strong) NSString *contentType;

@end

@interface JhssPostData : NSObject
@property(nonatomic, strong) NSData *data;
@property(nonatomic, strong) NSString *filename;
@property(nonatomic, strong) NSString *contentType;

@end

/**
 数据成功返回的回调函数
 */
typedef void (^onSuccess)(NSObject *);
/**
 错误信息或者解析失败的回调函数
 */
typedef void (^onError)(BaseRequestObject *, NSException *);
/**
 请求失败的回调函数
 */
typedef void (^onFailed)();

typedef void (^CleanAction)();

/**
 保存数据到缓存中
 */
typedef void (^saveToCache)(NSData *);

/**
 请求返回后检查view
 controller状态，如果为YES，则下面的回调操作不执行（onSuccess, onFailed,
 onError;
 */
typedef BOOL (^checkQuitOrStopProgressBar)();

@interface HttpRequestCallBack : NSObject

@property(nonatomic, copy) onSuccess onSuccess;
@property(nonatomic, copy) onError onError;
@property(nonatomic, copy) onFailed onFailed;
/**
 请求返回后检查view
 controller状态，如果为YES，则下面的回调操作不执行（onSuccess, onFailed,
 onError;
 */
@property(nonatomic, copy)
    checkQuitOrStopProgressBar onCheckQuitOrStopProgressBar;

+ (id)initWithOwner:(NSObject *)owner cleanCallback:(CleanAction)clearAction;

@end

@interface BaseRequester : NSObject <ASIHTTPRequestDelegate> {
}

@property(nonatomic, strong) HttpRequestCallBack *httpRequestCallback;

/**
 最终发送的完整url
 */
@property(nonatomic, strong) NSString *url;
/**
 Http请求参数字典
 */
@property(nonatomic, strong) NSDictionary *requestParameters;

/**
 Http请求
 */
@property(nonatomic, strong) ASIHTTPRequest *httpRequest;
/**
 请求返回结果的数据类型
 */
@property(nonatomic, strong) Class requestObjectClass;

@property(nonatomic, copy) saveToCache saveToCache;

/**  网络超时时间 */
@property(nonatomic, assign) int timeoutSeconds;

/**
 返回默认的错误处理
 */
+ (onError)defaultErrorHandler;

/**
 返回默认的请求失败处理
 */
+ (onFailed)defaultFailedHandler;

/**
 调用保存数据至缓存
 */
- (void)handleSaveCache:(NSData *)dic;

- (void)handleSuccess:(NSObject *)obj;

- (void)handleError:(BaseRequestObject *)requestObject
        orException:(NSException *)ex;

- (void)handleFailed;

// Returns the shared queue
+ (ASINetworkQueue *)sharedQueue;

+ (NSMutableArray *)getRequestCache;

/**
 添加默认的Header信息，子类可以添加其他的Header
 */
- (NSMutableDictionary *)createHttpHeaders;

/**
 配置ASIHTTPRequest
 */
- (void)configHTTPRequest:(ASIHTTPRequest *)request;

/**
 异步请求数据
 requestUrl：请求的url或者url模板
 requestMethod：请求方法，当前仅支持 GET,POST
 parameters: 请求参数，字典形式
 requestClass：请求返回结果的数据类型
 callback：当数据返回时的应用层的回调代理类
 */
- (void)asynExecuteWithRequestUrl:(NSString *)requestUrl
                WithRequestMethod:(NSString *)requestMethod
            withRequestParameters:(NSDictionary *)parameters
           withRequestObjectClass:(Class)requestClass
          withHttpRequestCallBack:(HttpRequestCallBack *)httpRequestCallback;

/**
 异步请求数据
 requestUrl：请求的url或者url模板
 requestMethod：请求方法，当前仅支持 GET,POST
 parameters: 请求参数，字典形式
 requestClass：请求返回结果的数据类型
 callback：当数据返回时的应用层的回调代理类
 queue: 请求队列
 */
- (void)asynExecuteWithRequestUrl:(NSString *)requestUrl
                WithRequestMethod:(NSString *)requestMethod
            withRequestParameters:(NSDictionary *)parameters
           withRequestObjectClass:(Class)requestClass
          withHttpRequestCallBack:(HttpRequestCallBack *)httpRequestCallback
                 withNetworkQueue:(ASINetworkQueue *)queue;

/**
 创建Http请求
 requestUrl：请求的url或者url模板
 requestMethod：请求方法，当前仅支持 GET,POST
 parameters: 请求参数，字典形式
 */
- (void)createHttpRequestWithUrl:(NSString *)requestUrl
               WithRequestMethod:(NSString *)requestMethod
           withRequestParameters:(NSDictionary *)parameters;

@end
