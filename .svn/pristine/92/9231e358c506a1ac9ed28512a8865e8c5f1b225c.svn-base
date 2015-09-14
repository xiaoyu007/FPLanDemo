//
//  YouGuNewsUtil.m
//  优顾理财
//
//  Created by Mac on 15/6/24.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "YouGuNewsUtil.h"

@implementation YouGuNewsUtil
+ (void)WebViewUserAgent:(UIWebView*)webview {
  NSString* secretAgent =
  [[NSUserDefaults standardUserDefaults] objectForKey:@"YL_userAgent"];
  if (!(secretAgent && [secretAgent length] > 0)) {
    UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    secretAgent =
    [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    
    if (secretAgent) {
      [[NSUserDefaults standardUserDefaults] setObject:secretAgent
                                                forKey:@"YL_userAgent"];
    }
  }
  NSString* version = [[NSBundle mainBundle]
                       objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
  
  NSString* newUagent =
  [NSString stringWithFormat:@"%@ jhss/ios/mncg/%@/%@/%@/%@", secretAgent,
   version, ak_version,YouGu_User_USerid, YouGu_User_sessionid];
  NSLog(@"打印userAgent：%@", newUagent);
  
  NSDictionary *dictionary = @{ @"UserAgent" : newUagent };
  [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
}

#pragma mark - 颜色转图片方法，创建纯色图片
+ (UIImage*)imageFromColor:(NSString*)color {
  CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
  UIGraphicsBeginImageContext(rect.size);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(context, [[Globle colorFromHexRGB:color] CGColor]);
  CGContextFillRect(context, rect);
  
  UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return theImage;
}

+ (UIImage*)imageFromColor:(NSString*)color alpha:(CGFloat)alpha {
  CGRect rect = CGRectMake(0, 0, WIDTH_OF_SCREEN, HEIGHT_OF_SCREEN);
  UIGraphicsBeginImageContext(rect.size);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(
                                 context,
                                 [[[Globle colorFromHexRGB:color] colorWithAlphaComponent:alpha] CGColor]);
  CGContextFillRect(context, rect);
  UIImage* img = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return img;
}
@end
