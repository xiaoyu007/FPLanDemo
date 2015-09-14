//
//  NetLoadingWaitView.h
//  SimuStock
//
//  Created by Mac on 13-9-13.
//  Copyright (c) 2013年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 *类说明：联网等待动画视图
 */
@interface NetLoadingWaitView : NSObject {
  //透明覆盖整个手机屏幕视图，用来阻挡用户操作
  UIView *nwv_fullbaseView;
  //黑色旋转图片的半透明黑色背景
  UIImageView *nmv_backgroundImageView;
  //前方旋转图片
  UIImageView *nmv_frontImageView;

  UIActivityIndicatorView *indicator;
  //动画是否正在进行
  BOOL nmv_isAnimationRun;
  // lq
  BOOL _isLaunching;
  //定时期
  NSTimer *nmv_timer;
  //定时期频率时长
  CGFloat nmv_duration;
  //显示标题
  UILabel *textlable;
}
@property(assign, nonatomic) BOOL isLaunching;

- (void)startAnimating;
- (void)stopAnimating;
- (BOOL)isAnimating;

+ (id)sharedInstance;
+ (void)startAnimating;
+ (void)stopAnimating;
+ (BOOL)isAnimating;
+ (void)isLaunching:(BOOL)isLaunching;

@end
