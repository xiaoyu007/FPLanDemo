//
//  FTWCache.h
//  FTW
//
//  Created by Soroush Khanlou on 6/28/12.
//  Copyright (c) 2012 FTW. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 基于文件的缓存 */
@interface FTWCache : NSObject

/** 查询指定的缓存文件，使用默认的超时时间：7天 */
+ (NSData *)objectForKey:(NSString *)key;

/** 查询指定的缓存文件，使用指定的超时时间 */
+ (NSData *)objectForKey:(NSString *)key withTimeOutSecond:(double) timeout;

/** 设置指定的缓存文件 */
+ (void)setObject:(NSData *)data forKey:(NSString *)key;

/** 清除指定的缓存文件 */
+ (void)removeKeyOfObjcet:(NSString *)key;

/** 清除所有的缓存文件 */
+ (void)resetCache;

@end