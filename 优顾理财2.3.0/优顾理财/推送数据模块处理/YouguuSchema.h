//
//  YouguuSchema.h
//  优顾理财
//
//  Created by Mac on 15/7/27.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 优顾协议处理, 例如： youguu://homepage?uid=1&nickname=abc */
@interface YouguuSchema : NSObject

/** 跳转最近收到的消息指定的页面 */
+ (void)forwardPageFromNoticfication:(NSDictionary *)dic;

/** 处理优顾协议的跳转 */
+ (void)handleYouguuUrl:(NSURL *)url;
@end
