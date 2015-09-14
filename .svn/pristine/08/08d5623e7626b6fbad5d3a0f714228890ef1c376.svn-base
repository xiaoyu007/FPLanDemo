//
//  BaseNoTitleViewController.h
//  SimuStock
//
//  Created by Mac on 15/4/17.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNoTitleViewController : UIViewController <LoadingView_delegate>

/** 容器VC设置的frame */
@property(assign, nonatomic) CGRect frameInParent;
///正在加载loading
@property(nonatomic, strong) LoadingView *loading;

/** 使用指定的frame大小设置页面的大小 */
- (id)initWithFrame:(CGRect)frame;

/**
 返回当前页面是否用户可视状态
 */
- (BOOL)isVisible;

- (void)performBlock:(void (^)())block withDelaySeconds:(float)delayInSeconds;

@end
