//
//  BaseNoTitleViewController.m
//  SimuStock
//
//  Created by Mac on 15/4/17.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "BaseNoTitleViewController.h"
#import "Globle.h"

@implementation BaseNoTitleViewController

+ (BOOL)isIOS7 {
  return [[[UIDevice currentDevice] systemVersion] floatValue] >= 7;
}

- (void)dealloc {
  NSLog(@"\n-------------------\n%@ 已经释放\n----------------", self);
}

- (id)initWithFrame:(CGRect)frame {
  if (self = [super init]) {
    self.frameInParent = frame;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  NSLog(@"\n-------------------\n%@ 已创建\n-------------------", self);
  if (CGRectIsEmpty(self.frameInParent)) {
    //    self.view.frame = UIScreen.mainScreen.bounds; TODO 以后恢复
    self.frameInParent = self.view.frame;
  } else {
    self.view.frame = self.frameInParent;
  }
  //设置统一的页面背景色
  self.view.backgroundColor = [Globle colorFromHexRGB:Color_BG_Common];
  [self createLittleCattleView];
}

//创建小牛视图
- (void)createLittleCattleView {
    _loading = [[LoadingView alloc] initWithFrame:_frameInParent];
    _loading.delegate = self;
    _loading.hidden = YES;
    _loading.backgroundColor = [UIColor clearColor];
    _loading.userInteractionEnabled = YES;
    [self.view addSubview:_loading];
}

- (BOOL)isVisible {
  return [self isViewLoaded] && self.view.window;
}

- (void)performBlock:(void (^)())block withDelaySeconds:(float)delayInSeconds {
  dispatch_time_t popTime = dispatch_time(
      DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), block);
}

@end
