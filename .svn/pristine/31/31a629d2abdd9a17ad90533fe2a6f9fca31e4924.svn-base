//
//  UIDevice+Screen.m
//  Jamper
//
//  Created by yihang zhuang on 9/20/12.
//
//

#import "UIDevice+Screen.h"

@implementation UIDevice (Screen)

+ (DeviceType)deviceType {
  DeviceType thisDevice = 0;
  if ([[UIDevice currentDevice] userInterfaceIdiom] ==
      UIUserInterfaceIdiomPhone) {
    thisDevice |= iPhone;
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
      thisDevice |= iPhoneRetnia;
      if ([[UIScreen mainScreen] bounds].size.height == 568)
        thisDevice |= iPhone5;
    }
  } else {
    thisDevice |= iPad;
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
      thisDevice |= iPadRetnia;
  }
  return thisDevice;
}

@end