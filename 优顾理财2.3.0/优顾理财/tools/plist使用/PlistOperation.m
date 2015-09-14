//
//  PlistOperation.m
//  优顾理财
//
//  Created by Mac on 15-5-7.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "PlistOperation.h"

@implementation PlistOperation

+ (NSString *)getPlistPath:(NSString *)plistStr {
  NSString *rootPath = NSSearchPathForDirectoriesInDomains(
      NSDocumentDirectory, NSUserDomainMask, YES)[0];
  NSString *plistPath = [rootPath stringByAppendingPathComponent:plistStr];
  return plistPath;
}

@end
