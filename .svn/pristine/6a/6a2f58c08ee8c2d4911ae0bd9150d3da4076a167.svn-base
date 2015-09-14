//
//  MPNotificationWindow.m
//  SimuStock
//
//  Created by Mac on 13-12-11.
//  Copyright (c) 2013年 Mac. All rights reserved.
//

#import "MPNotificationWindow.h"

@implementation MPNotificationWindow

@synthesize notificationQueue = _notificationQueue;
@synthesize currentNotification = _currentNotification;

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.windowLevel = UIWindowLevelStatusBar + 1;
    self.backgroundColor = [UIColor clearColor];
    _notificationQueue = [[NSMutableArray alloc] initWithCapacity:4];

    UIView *topHalfBlackView = [[UIView alloc]
        initWithFrame:CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame),
                                 CGRectGetWidth(frame),
                                 CGRectGetHeight(frame))];

    topHalfBlackView.backgroundColor = [UIColor blackColor];
    topHalfBlackView.layer.zPosition = -100;
    topHalfBlackView.autoresizingMask =
        UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    [self addSubview:topHalfBlackView];

    /*[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(willRotateScreen:)
                                                 name:UIApplicationWillChangeStatusBarFrameNotification
                                               object:nil];*/

    [self rotateStatusBarWithFrame:frame];
  }

  return self;
}

- (void)willRotateScreen:(NSNotification *)notification {
  CGRect notificationBarFrame =
      CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20);

  if (self.hidden) {
    [self rotateStatusBarWithFrame:notificationBarFrame];
  } else {
    [self rotateStatusBarAnimatedWithFrame:notificationBarFrame];
  }
}

- (void)rotateStatusBarAnimatedWithFrame:(CGRect)frame {
  NSTimeInterval duration =
      [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
  [UIView animateWithDuration:duration
      animations:^{ self.alpha = 0; }
      completion:^(BOOL finished) {
          [self rotateStatusBarWithFrame:frame];
          [UIView animateWithDuration:duration animations:^{ self.alpha = 1; }];
      }];
}

- (void)rotateStatusBarWithFrame:(CGRect)frame {
  BOOL isPortrait =
      (frame.size.width == [UIScreen mainScreen].bounds.size.width);

  if (isPortrait) {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
      frame.size.width = [UIScreen mainScreen].bounds.size.width;
    }
  }

  self.frame = frame;
  CGPoint center = self.center;
  if (isPortrait) {
    center.x = CGRectGetMidX([UIScreen mainScreen].bounds);
  } else {
    center.y = CGRectGetMidY([UIScreen mainScreen].bounds);
  }
  self.center = center;
}

@end
