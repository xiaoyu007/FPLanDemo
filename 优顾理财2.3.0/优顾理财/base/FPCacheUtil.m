//
//  FPCacheUtil.m
//  优顾理财
//
//  Created by Mac on 15/7/13.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FTWCache.h"
#import "ObjectJsonMappingUtil.h"

@implementation FPCacheUtil

+ (void)saveCacheData:(id)data withKey:(NSString*)key {
  if (key == nil) {
    return;
  }
  if (data == nil) {
    [FTWCache removeKeyOfObjcet:key];
    return;
  }
  NSDictionary* dicData = [ObjectJsonMappingUtil getObjectData:data];
  NSData* myData = [NSKeyedArchiver archivedDataWithRootObject:dicData];
  [FTWCache setObject:myData forKey:key];
}

+ (id)loadCacheWithKey:(NSString*)key withClassType:(Class)cls {
  if (key == nil) {
    return nil;
  }
  @try {
    NSData* data =
    [FTWCache objectForKey:key withTimeOutSecond:60 * 60 * 24 * 100000];
    if (data) {
      NSDictionary* dic =
      (NSDictionary*)[NSKeyedUnarchiver unarchiveObjectWithData:data];
      return [[cls alloc] initWithDictionary:dic];
    }
  } @catch (NSException* exception) {
    NSLog(@"%@", exception);
    [FTWCache removeKeyOfObjcet:key];
  }
  return nil;
}

@end
