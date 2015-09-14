//
//  NetLoadingWaitView.m
//  SimuStock
//
//  Created by Mac on 13-9-13.
//  Copyright (c) 2013年 Mac. All rights reserved.
//

#import "NetLoadingWaitView.h"

static NetLoadingWaitView *sharedObj = nil;

@implementation NetLoadingWaitView
@synthesize isLaunching = _isLaunching;

+ (id)sharedInstance {
  @synchronized(self) {
    if (sharedObj == nil) {
      sharedObj = [[self alloc] init];
    }
  }
  return sharedObj;
}
- (id)init {
  if (self = [super init]) {
    nmv_isAnimationRun = NO;
    [self creatviews];
  }
  return self;
}
+ (void)startAnimating {
  NetLoadingWaitView *instance = [NetLoadingWaitView sharedInstance];
  if ([instance isAnimating]) {
    //取消上次的延迟任务
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
  } else {
    [instance startAnimating];
  }

  //防止菊花不停止
  [[NetLoadingWaitView sharedInstance] performSelector:@selector(stopAnimating)
                                            withObject:nil
                                            afterDelay:60.0];
}
+ (void)stopAnimating {
  NetLoadingWaitView *instance = [NetLoadingWaitView sharedInstance];
  if ([instance isAnimating]) {
    //取消上次的延迟任务
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [instance stopAnimating];
  }
}
+ (BOOL)isAnimating {
  return [[NetLoadingWaitView sharedInstance] isAnimating];
}
// lq
+ (void)isLaunching:(BOOL)isLaunching {
  if (!isLaunching) {
    [[NetLoadingWaitView sharedInstance] isLaunchingNO];
  } else {
    [[NetLoadingWaitView sharedInstance] isLaunchingYES];
  }
}
//正在启动界面
- (void)isLaunchingNO {
  sharedObj.isLaunching = NO;
}
- (void)isLaunchingYES {
  sharedObj.isLaunching = YES;
}
//创建视图
- (void)creatviews {
  //创建透明背景
  CGRect fullrect = [UIScreen mainScreen].bounds;
  nwv_fullbaseView = [[UIView alloc] initWithFrame:fullrect];
  nwv_fullbaseView.backgroundColor = [UIColor clearColor];
  [WINDOW addSubview:nwv_fullbaseView];
  nwv_fullbaseView.hidden = YES;
  CGPoint centerPoint =
      CGPointMake(CGRectGetMidX(fullrect), CGRectGetMidY(fullrect));
  //创建旋转图片背景
  UIView *backgroundView =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, 69, 69)];
  backgroundView.backgroundColor = [UIColor blackColor];
  backgroundView.center = centerPoint;
  backgroundView.alpha = 0.7;
  CALayer *layer = backgroundView.layer;
  [layer setMasksToBounds:YES];
  [layer setCornerRadius:10.0];
  [nwv_fullbaseView addSubview:backgroundView];

  //活动指示器
  indicator = [[UIActivityIndicatorView alloc]
      initWithFrame:CGRectMake(15, 15, 40, 40)];
  indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
  indicator.center = centerPoint;
  [nwv_fullbaseView addSubview:indicator];
  [indicator startAnimating];
}

#pragma mark
#pragma mark 对外接口
//开始显示联网等待动画
- (void)startAnimating {
  [WINDOW bringSubviewToFront:nwv_fullbaseView];
  nmv_isAnimationRun = YES;
  nwv_fullbaseView.hidden = NO;
  [indicator startAnimating];
}
//隐藏联网等待动画
- (void)stopAnimating {
  [indicator stopAnimating];
  nmv_isAnimationRun = NO;
  nwv_fullbaseView.hidden = YES;
}
//联网等待动画是否正在展示
- (BOOL)isAnimating {
  return nmv_isAnimationRun;
}
#pragma mark
#pragma mark 功能函数
- (void)repeatAnimation:(NSTimer *)timer {
  if (nmv_timer == timer) {
    nmv_frontImageView.transform = CGAffineTransformRotate(
        nmv_frontImageView.transform, (CGFloat)(M_PI / 20.0f));
  }
}

@end
