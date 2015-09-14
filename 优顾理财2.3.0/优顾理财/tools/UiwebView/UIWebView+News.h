//
//  UIWebView+NewsWebView.h
//  优顾理财
//
//  Created by Mac on 15/7/6.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (News)
//设置webview字体大小
- (void)webviewWithTextfontsize:(int)fontsize;
//设置背景颜色
- (void)webviewWithbackgroundColor:(NSString*)bg_color;
//设置标题的字体颜色
- (void)webviewWithTitleColor:(NSString*)color;
//设置正文字体的颜色
- (void)webviewWithContentTextcolor:(NSString*)T_color;

@end
