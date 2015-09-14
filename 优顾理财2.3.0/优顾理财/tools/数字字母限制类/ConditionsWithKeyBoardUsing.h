//
//  ConditionsWithKeyBoardUsing.h
//  SimuStock
//
//  Created by jhss on 14-10-30.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConditionsWithKeyBoardUsing : NSObject

+ (ConditionsWithKeyBoardUsing *)shareInstance;
/**密码是否只为字母或数字*/
- (BOOL)isNumbersOrLetters:(NSString *)str;
- (BOOL)isnumberOrChar:(NSString *)str;
/** 只为字母 */
+ (BOOL)isWord:(NSString *)str;
/** 只为数字 */
+ (BOOL)isNumbers:(NSString *)str;
/** 只为数字和小数点 */
+ (BOOL)isNumbersOrPoint:(NSString *)str;

@end
