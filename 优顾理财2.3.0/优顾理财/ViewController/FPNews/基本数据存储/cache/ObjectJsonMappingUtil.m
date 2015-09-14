//
//  ObjectJsonMappingUtil.m
//  SimuStock
//
//  Created by Mac on 15/4/15.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ObjectJsonMappingUtil.h"

#import <objc/runtime.h>

@implementation ObjectJsonMappingUtil

+ (NSDictionary *)getObjectData:(id)obj {
  NSMutableDictionary *dic = [NSMutableDictionary dictionary];

  Class cls = [obj class];
  while (![NSStringFromClass(cls) isEqualToString:@"NSObject"]) {
    [self addPropertiesOfObject:obj Class:cls withDic:dic];
    cls = [cls superclass];
  }
  return dic;
}

+ (void)addPropertiesOfObject:(id)obj Class:(Class)cls withDic:(NSMutableDictionary *)dic {
  unsigned int propsCount;

  objc_property_t *props = class_copyPropertyList(cls, &propsCount);
  for (int i = 0; i < propsCount; i++) {
    objc_property_t prop = props[i];

    NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
    if ([@"hash" isEqualToString:propName] || [@"superclass" isEqualToString:propName] ||
        [@"description" isEqualToString:propName] || [@"debugDescription" isEqualToString:propName]) {
      continue;
    }
    @try {
      id value = [obj valueForKey:[@"_" stringByAppendingString:propName]];
      if (value == nil) {
        value = [NSNull null];
      } else {
        value = [self getObjectInternal:value];
      }

      dic[propName] = value;
    } @catch (NSException *exception) {
      NSLog(@"%@", exception);
    } @finally {
    }
  }
  free(props);
}

+ (void)print:(id)obj {
  NSLog(@"%@", [self getObjectData:obj]);
}

+ (NSData *)getJSON:(id)obj options:(NSJSONWritingOptions)options error:(NSError **)error {

  return
      [NSJSONSerialization dataWithJSONObject:[self getObjectData:obj] options:options error:error];
}

+ (id)getObjectInternal:(id)obj {
  if ([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]] ||
      [obj isKindOfClass:[NSNull class]]) {
    return obj;
  }

  if ([obj isKindOfClass:[NSArray class]]) {
    NSArray *objarr = obj;
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
    for (int i = 0; i < objarr.count; i++) {
      arr[i] = [self getObjectInternal:[objarr objectAtIndex:i]];
    }
    return arr;
  }

  if ([obj isKindOfClass:[NSSet class]]) {
    NSSet *objarr = obj;
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
    [objarr enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
      [arr addObject:[self getObjectInternal:obj]];
    }];
    return arr;
  }

  if ([obj isKindOfClass:[NSDictionary class]]) {
    NSDictionary *objdic = obj;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
    for (NSString *key in objdic.allKeys) {
      dic[key] = [self getObjectInternal:[objdic objectForKey:key]];
    }
    return dic;
  }

  return [self getObjectData:obj];
}
@end
