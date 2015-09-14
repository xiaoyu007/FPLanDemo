//
//  NSStringWrapper.h
//  NSStringWrapper
//
//  Created by Tang Qiao on 12-2-4.
//  Copyright (c) 2012年 blog.devtang.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(Java)

/**  Return the char value at the specified index. */
- (unichar) charAt:(NSInteger)index;

/**
 * Compares two strings lexicographically.
 * the value 0 if the argument string is equal to this string;
 * a value less than 0 if this string is lexicographically less than the string argument;
 * and a value greater than 0 if this string is lexicographically greater than the string argument.
 */
- (NSInteger) compareTo:(NSString*) anotherString;

- (NSInteger) compareToIgnoreCase:(NSString*) str;

- (BOOL) contains:(NSString*) str;

//判断字符串是否以指定的前缀开头
- (BOOL) startsWith:(NSString*)prefix;

//判断字符串是否以指定的后缀结束
- (BOOL) endsWith:(NSString*)suffix;

//对比两个字符串内容是否一致
- (BOOL) equals:(NSString*) anotherString;

- (BOOL) equalsIgnoreCase:(NSString*) anotherString;

- (NSInteger) indexOfChar:(unichar)ch;

- (NSInteger) indexOfChar:(unichar)ch fromIndex:(NSInteger)index;

- (NSInteger) indexOfString:(NSString*)str;

- (NSInteger) indexOfString:(NSString*)str fromIndex:(NSInteger)index;

- (NSInteger) lastIndexOfChar:(unichar)ch;

- (NSInteger) lastIndexOfChar:(unichar)ch fromIndex:(NSInteger)index;

- (NSInteger) lastIndexOfString:(NSString*)str;

- (NSInteger) lastIndexOfString:(NSString*)str fromIndex:(NSInteger)index;

//从指定的开始位置和结束位置开始截取字符串
- (NSString *) substringFromIndex:(NSInteger)beginIndex toIndex:(NSInteger)endIndex;

//转换成小写
- (NSString *) toLowerCase;

//转换成大写
- (NSString *) toUpperCase;

//截取字符串前后空格
- (NSString *) trim;

//用指定字符串替换原字符串
- (NSString *) replaceAll:(NSString*)origin with:(NSString*)replacement;

//用指定分隔符将字符串分割成数组
- (NSArray *) split:(NSString*) separator;

///正则表达式匹配
-(BOOL) matches:(NSString*)pattern;




@end





