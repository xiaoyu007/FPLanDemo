//
//  FTWCache.m
//  FTW
//
//  Created by Soroush Khanlou on 6/28/12.
//  Copyright (c) 2012 FTW. All rights reserved.
//

#import "FTWCache.h"

///默认超时时间7天
static NSTimeInterval cacheTime = (double)60 * 60 * 24 * 7;

@implementation FTWCache

+ (void)resetCache {
  [[NSFileManager defaultManager] removeItemAtPath:[FTWCache cacheDirectory]
                                             error:nil];
}

+ (NSString *)cacheDirectory {
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                       NSUserDomainMask, YES);
  NSString *cacheDirectory = paths[0];
  cacheDirectory = [cacheDirectory stringByAppendingPathComponent:@"FTWCaches"];
  return cacheDirectory;
}

+ (NSData *)objectForKey:(NSString *)key {
  return [FTWCache objectForKey:key withTimeOutSecond:cacheTime];
}

+ (NSData *)objectForKey:(NSString *)key withTimeOutSecond:(double)timeout {

  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSString *filename = [self.cacheDirectory stringByAppendingPathComponent:key];

  if ([fileManager fileExistsAtPath:filename]) {
    NSDate *modificationDate =
        [fileManager attributesOfItemAtPath:filename
                                      error:nil][NSFileModificationDate];
    if ([modificationDate timeIntervalSinceNow] > timeout) {
      [fileManager removeItemAtPath:filename error:nil];
    } else {
      NSData *data = [NSData dataWithContentsOfFile:filename]; 
      return data;
    }
  }
  return nil;
}

+ (void)setObject:(NSData *)data forKey:(NSString *)key {
  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSString *filename = [self.cacheDirectory stringByAppendingPathComponent:key];

  BOOL isDir = YES;
  if (![fileManager fileExistsAtPath:self.cacheDirectory isDirectory:&isDir]) {
    [fileManager createDirectoryAtPath:self.cacheDirectory
           withIntermediateDirectories:NO
                            attributes:nil
                                 error:nil];
  }

  NSError *error;
  @try {
    [data writeToFile:filename options:NSDataWritingAtomic error:&error];
  } @catch (NSException *e) {
    NSLog(@"%@", e);
  }
}
/** 删除key值 */
+ (void)removeKeyOfObjcet:(NSString *)key {
  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSString *filename = [self.cacheDirectory stringByAppendingPathComponent:key];
  if ([fileManager fileExistsAtPath:filename]) {
   BOOL isSuccess = [fileManager removeItemAtPath:filename error:nil];
    NSLog(@"是否成功 ：%d",isSuccess);
  }
}

@end