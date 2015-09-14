//
//  UIButton+Block.m
//  BoothTag
//
//  Created by Josh Holtz on 4/22/12.
//  Copyright (c) 2012 Josh Holtz. All rights reserved.
//

#import "UIButton+Block.h"

//#import "/usr/include/objc/runtime.h"
#import <objc/runtime.h>

@implementation UIButton (Block)

static char overviewKeyTime;

static char overviewKeyBlock;

@dynamic action;

- (void)setOnButtonPressedHandler:(ButtonPressed)block {

  self.action = block;
  self.lastPressedTime = @0;

  [self addTarget:self
                action:@selector(doTouchUpInside:)
      forControlEvents:UIControlEventTouchUpInside];
}

- (void)doTouchUpInside:(id)sender {
  long long int currentTimestamp = [[NSDate date] timeIntervalSince1970] * 1000;
  //上次点击时间
  long long lastPressedTime = [self.lastPressedTime longLongValue];
  if (llabs(currentTimestamp - lastPressedTime) < kInvalid_Duration) {
    return;
  }
  self.lastPressedTime = @(currentTimestamp);
  ButtonPressed buttonPressed = [self action];
  if (buttonPressed) {
    [FPYouguUtil performBlockOnMainThread:^{
      buttonPressed();
    } withDelaySeconds:0.1];
  }
}

- (void)setAction:(ButtonPressed)action {
  objc_setAssociatedObject(self, &overviewKeyBlock, action,
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ButtonPressed)action {
  return objc_getAssociatedObject(self, &overviewKeyBlock);
}
- (void)setLastPressedTime:(NSNumber *)lastPressedTime {
  objc_setAssociatedObject(self, &overviewKeyTime, lastPressedTime,
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)lastPressedTime {
  return objc_getAssociatedObject(self, &overviewKeyTime);
}

@end