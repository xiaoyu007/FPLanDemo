//
//  FPCacheUtil.h
//  优顾理财
//
//  Created by Mac on 15/7/13.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FPCacheUtil : NSObject
/** 缓存数据 */
+ (void)saveCacheData:(id)data withKey:(NSString*)key;
/** 获取对应对象缓存 */
+ (id)loadCacheWithKey:(NSString*)key withClassType:(Class)cls;

@end
