//
//  UIDevice+Screen.h
//  Jamper
//
//  Created by yihang zhuang on 9/20/12.
//
//

#import <Foundation/Foundation.h>

@interface UIDevice (Screen)
typedef enum {
  iPhone = 1 << 1,
  iPhoneRetnia = 1 << 2,
  iPhone5 = 1 << 3,
  iPad = 1 << 4,
  iPadRetnia = 1 << 5

} DeviceType;

+ (DeviceType)deviceType;
@end