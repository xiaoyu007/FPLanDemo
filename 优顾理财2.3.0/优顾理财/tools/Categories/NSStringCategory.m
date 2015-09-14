//
//  CSRegex.m
//  Author: Jory Lee
//
//  Created by dev on 09-9-24.
//  Copyright 2009 Netgen. All rights reserved.
//

//#import "Base64.h"
#import "Base64.h"
#import "NSStringCategory.h"
#import <CommonCrypto/CommonDigest.h>

static NSString *nullstring = nil;

@implementation NSStringCategory

- (id)initWithPattern:(NSString *)pattern options:(int)options {
  if (self = [super init]) {
    int err = regcomp(&preg, [pattern UTF8String], options | REG_EXTENDED);
    if (err) {
      char errbuf[256];
      regerror(err, &preg, errbuf, sizeof(errbuf));
      [NSException
           raise:@"CSRegexException"
          format:@"Could not compile regex \"%@\": %s", pattern, errbuf];
    }
  }
  return self;
}

- (void)dealloc {
  regfree(&preg);
}

- (BOOL)matchesString:(NSString *)string {
  if (regexec(&preg, [string UTF8String], 0, NULL, 0) == 0)
    return YES;
  return NO;
}

- (NSString *)matchedSubstringOfString:(NSString *)string {
  const char *cstr = [string UTF8String];
  regmatch_t match;
  if (regexec(&preg, cstr, 1, &match, 0) == 0) {
    return [[NSString alloc] initWithBytes:cstr + match.rm_so
                                    length:(NSUInteger)(match.rm_eo - match.rm_so)
                                  encoding:NSUTF8StringEncoding];
  }

  return nil;
}

- (NSArray *)capturedSubstringsOfString:(NSString *)string {
  const char *cstr = [string UTF8String];
  long num = preg.re_nsub + 1;
  regmatch_t *matches = calloc(sizeof(regmatch_t), num);

  if (regexec(&preg, cstr, num, matches, 0) == 0) {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:num];

    int i;
    for (i = 0; i < num; i++) {
      NSString *str;

      if (matches[i].rm_so == -1 && matches[i].rm_eo == -1)
        str = nullstring;
      else
        str =
            [[NSString alloc] initWithBytes:cstr + matches[i].rm_so
                                     length:(NSUInteger)(matches[i].rm_eo - matches[i].rm_so)
                                   encoding:NSUTF8StringEncoding];

      [array addObject:str];
    }

    free(matches);

    return [NSArray arrayWithArray:array];
  }

  free(matches);

  return nil;
}

+ (NSStringCategory *)regexWithPattern:(NSString *)pattern
                               options:(int)options {
  return [[NSStringCategory alloc] initWithPattern:pattern options:options];
}

+ (NSStringCategory *)regexWithPattern:(NSString *)pattern {
  return [[NSStringCategory alloc] initWithPattern:pattern options:0];
}

+ (NSString *)null {
  return nullstring;
}

+ (void)initialize {
  if (!nullstring)
    nullstring = @"";
}

@end

@implementation NSString (NSStringCategory)

- (BOOL)matchedByPattern:(NSString *)pattern options:(int)options {
  NSStringCategory *re =
      [NSStringCategory regexWithPattern:pattern options:options | REG_NOSUB];
  return [re matchesString:self];
}

- (BOOL)matchedByPattern:(NSString *)pattern {
  return [self matchedByPattern:pattern options:0];
}

- (NSString *)substringMatchedByPattern:(NSString *)pattern
                                options:(int)options {
  NSStringCategory *re =
      [NSStringCategory regexWithPattern:pattern options:options];
  return [re matchedSubstringOfString:self];
}

- (NSString *)substringMatchedByPattern:(NSString *)pattern {
  return [self substringMatchedByPattern:pattern options:0];
}

- (NSArray *)substringsCapturedByPattern:(NSString *)pattern
                                 options:(int)options {
  NSStringCategory *re =
      [NSStringCategory regexWithPattern:pattern options:options];
  return [re capturedSubstringsOfString:self];
}

- (NSArray *)substringsCapturedByPattern:(NSString *)pattern {
  return [self substringsCapturedByPattern:pattern options:0];
}

- (NSString *)escapedPattern {
  long len = [self length];
  NSMutableString *escaped = [NSMutableString stringWithCapacity:len];

  for (int i = 0; i < len; i++) {
    unichar c = [self characterAtIndex:i];
    if (c == '^' || c == '.' || c == '[' || c == '$' || c == '(' || c == ')' ||
        c == '|' || c == '*' || c == '+' || c == '?' || c == '{' || c == '\\')
      [escaped appendFormat:@"\\%C", c];
    else
      [escaped appendFormat:@"%C", c];
  }
  return [NSString stringWithString:escaped];
}

- (NSString *)base64Encode {

  return nil;
}
- (NSString *)base64DecodeAsString {

  return [CommonFunc textFromBase64String:self];
}
- (NSData *)base64Decode {
  // NSData *data = [Base64 decode:self];
  // return data;
  //修改base64编码函数 libb modify
  NSData *data =
      [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
  NSData *Base64data = [Base64 decodeData:data];
  return Base64data;
}
- (NSString *)getSecuString {
  BOOL needEnCode = NO;
  if ([self length] > 0) {

    if ([self characterAtIndex:0] == '~') {
      return self;
    }
  }
  //
  for (int i = 0; i < [self length]; i++) {
    if ([self characterAtIndex:i] > 0x7A ||
        ([self characterAtIndex:i]<0x61 & [self characterAtIndex:i]> 0x5A) ||
        ([self characterAtIndex:i]<0x41 & [self characterAtIndex:i]> 0x39) ||
        [self characterAtIndex:i] < 0x30) {
      needEnCode = YES;
      break;
    }
  }
  //
  if (needEnCode)
    return [self base64Encode];
  else
    return self;
}

- (NSString *)getxxTeaBase64SecuString {

  return nil;
}

- (NSString *)getStrMayBase64 {

  BOOL needDecode = NO;
  // NSLog(@"first chart:%@",[self substringToIndex:1]);
  if ([[self substringToIndex:1] isEqualToString:@"~"])
    needDecode = YES;

  if (needDecode)
    return [self base64DecodeAsString];
  else
    return self;
}

+ (NSString *)longToString:(int64_t)v {
  if (v > 100000000)
    return [NSString stringWithFormat:@"%.2f亿", 1.0 * v / 100000000];
  else if (v > 10000)
    return [NSString stringWithFormat:@"%.2f万", 1.0 * v / 10000];
  else
    return [NSString stringWithFormat:@"%lld", v];
}
///////////////////////////////////////////
// md5 加密
- (NSString *)md5:(NSString *)str {

  const char *cStr = [str UTF8String];

  unsigned char result[16];

  CC_MD5(cStr, (CC_LONG)strlen(cStr), result);

  return [NSString
      stringWithFormat:

          @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",

          result[0], result[1], result[2], result[3],

          result[4], result[5], result[6], result[7],

          result[8], result[9], result[10], result[11],

          result[12], result[13], result[14], result[15]

  ];
}
// md5 加密
///////////////////////////////////////////

#pragma mark
#pragma mark utf8编解码
- (NSString *)URLEncodedString {
  NSString *result =
      (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
          kCFAllocatorDefault, (__bridge CFStringRef)self, NULL,
          CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8));
  return result;
}

- (NSString *)URLDecodedString {
  NSString *result = (NSString *)CFBridgingRelease(
      CFURLCreateStringByReplacingPercentEscapesUsingEncoding(
          kCFAllocatorDefault, (__bridge CFStringRef)self, CFSTR(""),
          kCFStringEncodingUTF8));
  return result;
}

- (BOOL)isNumber {
  NSUInteger uILength = [self length];
  for (int i = 0; i < uILength; ++i) {
    unichar everyChar = [self characterAtIndex:i];
    if ((everyChar >= '0' && everyChar <= '9'))
      continue;
    else
      return NO;
  }
  return YES;
}

- (BOOL)isLetter {
  NSUInteger uILength = [self length];
  for (int i = 0; i < uILength; ++i) {
    unichar everyChar = [self characterAtIndex:i];
    if ((everyChar >= 'a' && everyChar <= 'z') ||
        (everyChar >= 'A' && everyChar <= 'Z'))
      continue;
    else
      return NO;
  }
  return YES;
}

- (BOOL)isNumberOrText {
  NSUInteger uILength = [self length];
  for (int i = 0; i < uILength; ++i) {
    unichar everyChar = [self characterAtIndex:i];
    if ((everyChar >= '0' && everyChar <= '9') ||
        (everyChar >= 'a' && everyChar <= 'z') ||
        (everyChar >= 'A' && everyChar <= 'Z'))
      continue;
    else
      return NO;
  }
  return YES;
}

@end