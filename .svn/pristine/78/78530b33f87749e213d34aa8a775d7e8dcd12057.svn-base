//
//  ToolBaseViewController.h
//  优顾理财
//
//  Created by Mac on 14/10/20.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "topNavView.h"

@interface ToolBaseViewController
    : UIViewController <TopNavViewDelegate,
                        UIGestureRecognizerDelegate> {
  /**
   *   类型：(UIScrollView)
   *   作用：(适配，ios7与ios6 状态栏 显示不隐藏问题）以及
   *工具中过长，上下滚动问题
   *
   *   滚动：修改，size
   */
  UIScrollView *content_view;
  TopNavView *topNavView;
}

/**
 *   类型：(UIScrollView)
 *   作用：(适配，ios7与ios6 状态栏 显示不隐藏问题）以及
 *工具中过长，上下滚动问题
 *
 *   滚动：修改，size
 */
@property(nonatomic, strong) IBOutlet UIScrollView *content_view;

@property(nonatomic, strong) IBOutlet TopNavView *topNavView;
@end
