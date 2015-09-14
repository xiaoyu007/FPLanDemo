//
//  ConditionsWithKeyBoardUsing.m
//  SimuStock
//
//  Created by jhss on 14-10-30.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "ConditionsWithKeyBoardUsing.h"

static ConditionsWithKeyBoardUsing *conditions = nil;

@implementation ConditionsWithKeyBoardUsing

+ (ConditionsWithKeyBoardUsing *)shareInstance {
  @synchronized(self) {
    if (conditions == nil) {
      conditions = [[ConditionsWithKeyBoardUsing alloc] init];
    }
  }
  return conditions;
}
/**密码是否只为字母或数字*/
- (BOOL)isNumbersOrLetters:(NSString *)str {
  if (str != nil && [str length] > 0) {
    NSUInteger uILength = [str length];
    int i;
    for (i = 0; i < uILength; ++i) {
      unichar everyChar = [str characterAtIndex:i];
      if ((everyChar >= '0' && everyChar <= '9') ||
          (everyChar >= 'a' && everyChar <= 'z') ||
          (everyChar >= 'A' && everyChar <= 'Z'))
        continue;
      else {
        return NO;
      }
    }
  }
  return YES;
}
/** 只为数字 */
+ (BOOL)isNumbers:(NSString *)str {
  if (str != nil && [str length] > 0) {
    NSUInteger uILength = [str length];
    int i;
    for (i = 0; i < uILength; ++i) {
      unichar everyChar = [str characterAtIndex:i];
      if (everyChar >= '0' && everyChar <= '9') {
        continue;
      } else {
        return NO;
      }
    }
  }
  return YES;
}
/** 只为数字和小数点 */
+ (BOOL)isNumbersOrPoint:(NSString *)str {
  if (str != nil && [str length] > 0) {
    NSUInteger uILength = [str length];
    int i;
    for (i = 0; i < uILength; ++i) {
      unichar everyChar = [str characterAtIndex:i];
      if ((everyChar >= '0' && everyChar <= '9')||everyChar == '.') {
        continue;
      } else {
        return NO;
      }
    }
  }
  return YES;
}
/** 只为字母 */
+ (BOOL)isWord:(NSString *)str {
  if (str != nil && [str length] > 0) {
    NSUInteger uILength = [str length];
    int i;
    for (i = 0; i < uILength; ++i) {
      unichar everyChar = [str characterAtIndex:i];
      if ((everyChar >= 'a' && everyChar <= 'z') ||
          (everyChar >= 'A' && everyChar <= 'Z')) {
        continue;
      } else {
        return NO;
      }
    }
  }
  return YES;
}
/**限制输入——-仅输入字母、数字、汉字*/
- (BOOL)isnumberOrChar:(NSString *)str {
  NSString *regex = @"[a-zA-Z\u4e00-\u9fa5][a-zA-Z0-9\u4e00-\u9fa5]+";
  NSPredicate *pred =
      [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
  //单个字符查询失败bug
  /*数据加倍处理下*/
  if ([str length] == 1) {
    str = [NSString stringWithFormat:@"%@%@", str, str];
  }
  if ([pred evaluateWithObject:str]) {
    return YES;
  } else {
    return NO;
  }
}
/**邮箱验证*/
- (BOOL)validateEmail:(NSString *)email {
  NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
  NSPredicate *emailTest =
      [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
  return [emailTest evaluateWithObject:email];
}

@end
