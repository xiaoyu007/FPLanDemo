//
//  NSString+validate.m
//  SimuStock
//
//  Created by Mac on 15/5/20.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "NSString+validate.h"
#import "NSString+Java.h"

@implementation NSString (validate)

+ (BOOL)validataPhoneNumber:(NSString *)phoneNumber {

  /*
   * 移动: 2G号段(GSM网络)有139,138,137,136,135,134, 159,158,157,152,151,150,
   * 3G号段(TD-SCDMA网络)有157,182,183,188,187 147是移动TD上网卡专用号段. 联通:
   * 2G号段(GSM网络)有130,131,132,155,156 3G号段(WCDMA网络)有186,185 电信:
   * 2G号段(CDMA网络)有133,153 3G号段(CDMA网络)有189,180
   * 新添加 181 dx、170虚拟、176dx、177dx、178虚拟（统一放在电信中）
   *
   * 139,138,137,136,135,134,133
   * 147
   * 130,131,132,
   * 159,158,157,152,151,150,155,156,153
   * 182,183,188,187,189,180,181
   */
  NSString *pattern = @"^1[358][0-9]{9}$";
  return [phoneNumber matches:pattern];
}

+ (BOOL)validataIdCardNumberOnInput:(NSString *)idCardNumber {
  NSString *pattern = @"^[0123456789]{0,}?([xX]{0,1})$";
  return [idCardNumber matches:pattern];
}

+ (BOOL)validataIdCardNumberOnEnd:(NSString *)idCardNumber {
  NSString *pattern = @"^\\d{15}(?:\\d{3}|\\d{2}[xX])?$";
  return [idCardNumber matches:pattern];
}

+ (BOOL)validataChineseNameOnInput:(NSString *)chineseName {
  NSString *pattern = @"^[\u4e00-\u9fa5]{0,}+(?:[.·．￼•][\u4e00-\u9fa5]*){0,}*$";
  return [chineseName matches:pattern];
}

+ (BOOL)validataChineseNameOnEnd:(NSString *)chineseName {
  NSString *pattern = @"^[\u4e00-\u9fa5]+(?:[.·．￼•][\u4e00-\u9fa5]+)*$";
  return [chineseName matches:pattern];
}

+ (BOOL)validataNumberInput:(NSString *)number{
  NSString *pattern = @"^\\d{0,}$";
  return [number matches:pattern];
}
+ (BOOL)validataPasswordOnInput:(NSString *)password
{
  NSString *pattern = @"^[0-9A-Za-z]{0,16}$";
  return [password matches:pattern];
}

+ (BOOL)validataChineseOrEnglish:(NSString *)string
{
  NSString *pattern = @"^[A-Za-z\u4e00-\u9fa5]+$";
  return [string matches:pattern];
}


@end
