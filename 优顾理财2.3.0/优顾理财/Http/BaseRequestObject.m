//
//  BaseRequestObject.m
//  SimuStock
//
//  Created by Mac on 14-8-27.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <objc/message.h>
#import "NSString+Java.h"

@implementation BaseRequestObject2

- (id)initWithDictionary:(NSDictionary *)data {
  if (self = [super init]) {
    [self setAttributes:data];
  }
  return self;
}

- (id)copyWithZone:(NSZone *)zone {
  id bmodel = [[self.class allocWithZone:zone] init];
  return bmodel;
}

- (void)loadData:(NSDictionary *)data {
  [self setAttributes:data];
}

- (NSDictionary *)mappingDictionary {
  return @{};
}

/** 返回所有属性构成的字典 */
- (NSDictionary *)attributeMapDictionary {
  NSMutableDictionary *propertyDict = [[NSMutableDictionary alloc] init];
  Class cls = self.class;
  while (![NSStringFromClass(cls) isEqualToString:@"NSObject"]) {
    unsigned int outCount = 0;
    objc_property_t *properties = class_copyPropertyList(cls, &outCount);

    for (int i = 0; i < outCount; i++) {
      objc_property_t property = properties[i];
      NSString *propName =
          [NSString stringWithUTF8String:property_getName(property)];
      const char *typeName = property_getAttributes(property);
      NSString *properyTypeName =
          [[NSString alloc] initWithCString:typeName
                                   encoding:NSUTF8StringEncoding];
      // NSLog(@"property class is %@", properyTypeName);
      propertyDict[propName] = properyTypeName;
    }
    free(properties);
    cls = [cls superclass];
  }
  return propertyDict;
}

/** 判断类型是否为基础类型 */
+ (BOOL)isPrimitiveType:(NSString *)attrClassType {
  BOOL isPrimitive = NO;
  if (attrClassType) {
    NSInteger index = [attrClassType indexOfString:@"T"];
    if (index >= 0) {
      isPrimitive =
          ![[attrClassType substringFromIndex:index + 1 toIndex:index + 2]
              isEqualToString:@"@"];
    }
  }
  return isPrimitive;
}

- (id)createObjectWithClassType:(NSString *)classType
              withAttributeName:(NSString *)attributeName
                      withValue:(id)value
                   inCollection:(BOOL)inCollection {
  // NSNull处理
  if (value == [NSNull null] || value == nil) {
    return inCollection ? value : nil;
  }

  Class class = NSClassFromString(classType);
  //基础类型，直接返回
  if (class == nil && [BaseRequestObject2 isPrimitiveType:classType]) {
    return value;
  }
  //数组类型
  if ([class isSubclassOfClass:[NSArray class]] &&
      [value isKindOfClass:[NSArray class]]) {
    NSString *subItemclassName = [self mappingDictionary][attributeName];
    if (subItemclassName == nil) {
      NSString *name = @"Not exist class type mappping";
      NSString *reason =
          [NSString stringWithFormat:@"%@: class = %@, attr = %@", name,
                                     [self description], attributeName];
      [[NSException exceptionWithName:name reason:reason userInfo:nil] raise];
    }
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    for (id dateItem in value) {
      id subObject = [self createObjectWithClassType:subItemclassName
                                   withAttributeName:nil
                                           withValue:dateItem
                                        inCollection:YES];
      [dataArray addObject:subObject];
    }

    return dataArray;
  }
  //数组类型
  if ([class isSubclassOfClass:[NSSet class]] &&
      [value isKindOfClass:[NSArray class]]) {
    NSString *subItemclassName = [self mappingDictionary][attributeName];
    if (subItemclassName == nil) {
      NSString *name = @"Not exist class type mappping";
      NSString *reason =
          [NSString stringWithFormat:@"%@: class = %@, attr = %@", name,
                                     [self description], attributeName];
      [[NSException exceptionWithName:name reason:reason userInfo:nil] raise];
    }
    NSMutableSet *dataArray = [[NSMutableSet alloc] init];
    NSArray *dicValue = value;
    [dicValue
        enumerateObjectsUsingBlock:^(id dateItem, NSUInteger idx, BOOL *stop) {
          id subObject = [self createObjectWithClassType:subItemclassName
                                       withAttributeName:nil
                                               withValue:dateItem
                                            inCollection:YES];
          [dataArray addObject:subObject];
        }];

    return dataArray;
  }

  //字典类型
  if ([class isSubclassOfClass:[NSDictionary class]] &&
      [value isKindOfClass:[NSDictionary class]]) {
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] init];
    NSDictionary *keyValueMapping = [self mappingDictionary][attributeName];
    if (keyValueMapping == nil) {
      NSString *name = @"Not exist class type mappping";
      NSString *reason =
          [NSString stringWithFormat:@"%@: class = %@, attr = %@", name,
                                     [self description], attributeName];
      [[NSException exceptionWithName:name reason:reason userInfo:nil] raise];
    }
    NSString *keyClass = [keyValueMapping allKeys][0];
    NSString *valueClass = [keyValueMapping allValues][0];

    NSDictionary *valueDictionary = (NSDictionary *)value;
    [valueDictionary
        enumerateKeysAndObjectsUsingBlock:^(id keyDic, id objDic, BOOL *stop) {
          id keyObject = [self createObjectWithClassType:keyClass
                                       withAttributeName:nil
                                               withValue:keyDic
                                            inCollection:YES];
          id subObject = [self createObjectWithClassType:valueClass
                                       withAttributeName:nil
                                               withValue:objDic
                                            inCollection:YES];
          dataDic[keyObject] = subObject;
        }];
    return dataDic;
  }

  //如果value是字典类型, 构造
  if ([class isSubclassOfClass:[BaseRequestObject2 class]] &&
      [value isKindOfClass:[NSDictionary class]]) {
    return [[NSClassFromString(classType) alloc] initWithDictionary:value];
  }

  //类型兼容，直接返回
  if ([value isKindOfClass:class]) {
    return value;
  }

  return value;
}

- (void)setAttributes:(NSDictionary *)data {

  //获取所有的属性
  NSDictionary *propertys = [self attributeMapDictionary];
  //遍历所有的属性
  for (NSString *attributeName in [propertys allKeys]) {

    ///获取属性名对相应的setKey方法
    SEL sel = [self getSetterAttributeName:attributeName];
    if ([self respondsToSelector:sel]) {
      ///获取属性对应的值的类型
      NSString *attr = propertys[attributeName];
      ///获取属性名对应的值
      id value = data[attributeName];
      id valueObject;
      if ([BaseRequestObject2 isPrimitiveType:attr]) {
        //当前测试通过BOOL、int类型
        if (value) {
          [self setValue:value forKey:attributeName];
        }
      } else {
        NSString *className = [self className:attr];
        valueObject = [self createObjectWithClassType:className
                                    withAttributeName:attributeName
                                            withValue:value
                                         inCollection:NO];
        [self performSelector:sel
                     onThread:[NSThread currentThread]
                   withObject:valueObject
                waitUntilDone:YES];
      }
    }
  }
}

/** 返回属性的对应的类名 */
- (NSString *)className:(NSString *)propertyTypeName {

  //  NSLog(@"%@", propertyTypeName);
  NSString *name = [propertyTypeName componentsSeparatedByString:@","][0];

  NSString *cName =
      [[name substringToIndex:[name length] - 1] substringFromIndex:3];

  if ([cName rangeOfString:@"<"].location != NSNotFound) {
    NSString *subName =
        [cName substringFromIndex:[cName rangeOfString:@"<"].location + 1];
    return [subName substringToIndex:[subName length] - 1];
  }
  return cName;
}

/** 返回属性的Set方法 */
- (SEL)getSetterAttributeName:(NSString *)attributeName {
  NSString *capital = [[attributeName substringToIndex:1] uppercaseString];
  NSString *setterSelStr =
      [NSString stringWithFormat:@"set%@%@:", capital,
                                 [attributeName substringFromIndex:1]];

  return NSSelectorFromString(setterSelStr);
}

@end

@implementation BaseRequestObject

@end

@implementation JsonRequestObject
- (void)jsonToObject:(NSDictionary *)dic {
  self.status = dic[@"status"];
  self.message = dic[@"message"];
}

- (BOOL)isOK {
  return [@"0000" isEqualToString:self.status];
}

//字典解析的key：value但我们没有或变量名冲突的情况
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

  NSLog(@"%@'s UndefinedKey is %@， value is %@ "
        @"🙅赶紧在你的数据模型中添加这个键吧！",
        self.class, key, value);
}

@end

@implementation JsonErrorObject

@end
