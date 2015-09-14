//
//  NSString+validate.h
//  SimuStock
//
//  Created by Mac on 15/5/20.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (validate)
/** 判断手机号是否符合规范 */
+ (BOOL)validataPhoneNumber:(NSString *)phoneNumber;

/** 判断身份证的真实性  在输入的时候进行弱检验 */
+ (BOOL)validataIdCardNumberOnInput:(NSString *)idCardNumber;

/** 判断身份证的真实性 输入完成之后进行强校验*/
+ (BOOL)validataIdCardNumberOnEnd:(NSString *)idCardNumber;

/** 判断中文姓名  在输入的时候进行弱检验 */
+ (BOOL)validataChineseNameOnInput:(NSString *)chineseName;

/** 判断中文姓名， 输入完成之后进行强校验*/
+ (BOOL)validataChineseNameOnEnd:(NSString *)chineseName;

/** 判断输入内容只能为数字*/
+ (BOOL)validataNumberInput:(NSString *)number;

/** 判断输入内容只能为字母和数字的校验  在输入的时候进行弱检验*/
+ (BOOL)validataPasswordOnInput:(NSString *)password;

/** 判断输入内容只能为字母或中文*/
+ (BOOL)validataChineseOrEnglish:(NSString *)string;

@end
