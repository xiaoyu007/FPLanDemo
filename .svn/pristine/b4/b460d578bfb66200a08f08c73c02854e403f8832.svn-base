//
//  UIWebView+NewsWebView.m
//  优顾理财
//
//  Created by Mac on 15/7/6.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "UIWebView+News.h"

@implementation UIWebView (News)
//设置webview字体大小
- (void)webviewWithTextfontsize:(int)fontsize {
  NSString* str = [NSString
                   stringWithFormat:@"var "
                   @"content_text_p=document.getElementById('content_text_"
                   @"sizefont').getElementsByTagName('p');for(i=0;i<"
                   @"content_text_p.length;i++) "
                   @"{content_text_p[i].style.fontSize = '\%dpx';}",
                   fontsize];
  [self stringByEvaluatingJavaScriptFromString:str];
}
//设置背景颜色
- (void)webviewWithbackgroundColor:(NSString*)bg_color {
  NSString* str_color =
  [NSString stringWithFormat:@"document.getElementsByTagName('body')[0]."
   @"style.backgroundColor='\%@'",
   bg_color];
  [self stringByEvaluatingJavaScriptFromString:str_color];
}
//设置标题的字体颜色
- (void)webviewWithTitleColor:(NSString*)color {
  NSString* str = [NSString
                   stringWithFormat:@"var "
                   @"content_text_p=document.getElementsByTagName('h1');"
                   @"for(i=0;i<content_text_p.length;i++) "
                   @"{content_text_p[i].style.color = '\%@';}",
                   color];
  [self stringByEvaluatingJavaScriptFromString:str];
}
//设置正文字体的颜色
- (void)webviewWithContentTextcolor:(NSString*)T_color {
  NSString* str = [NSString
                   stringWithFormat:@"var "
                   @"content_text_p=document.getElementById('content_text_"
                   @"sizefont').getElementsByTagName('p');for(i=0;i<"
                   @"content_text_p.length;i++) "
                   @"{content_text_p[i].style.color = '\%@';}",
                   T_color];
  [self stringByEvaluatingJavaScriptFromString:str];
}

@end
