//
//  UIButton+Block.m
//  BoothTag
//
//  Created by Josh Holtz on 4/22/12.
//  Copyright (c) 2012 Josh Holtz. All rights reserved.
//

#import "UIButton+Block.h"
#import "FPYouguUtil.h"

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
  int64_t currentTimestamp = [[NSDate date] timeIntervalSince1970] * 1000;

  //上次点击时间
  int64_t lastPressedTime = [self.lastPressedTime longLongValue];
  if (llabs(currentTimestamp - lastPressedTime) < kInvalid_Duration) {
    NSLog(@"连续点击了！！！");
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

@implementation BGColorUIButton {
  NSTimeInterval touchBeginTime;
  CallBackAction action;
}
/** 设置平常状态下的 背景颜色 */
- (void)setNormalBGColor:(UIColor *)normalColor {
  if (normalColor) {
    _normalBGColor = normalColor;
    self.backgroundColor = _normalBGColor;
  }
}

/** 设置高亮状态下 背景颜色 */
- (void)setHighlightBGColor:(UIColor *)highlightColor {
  if (highlightColor) {
    _highlightBGColor = highlightColor;
  }
}

/** 设置title 在平常状态的颜色 */
- (void)setNormalTitleColor:(UIColor *)normalTitleColor {
  if (normalTitleColor) {
    _normalTitleColor = normalTitleColor;
    [self setTitleColor:_normalTitleColor forState:UIControlStateNormal];
  }
}

/** 设置title 在高亮状态的颜色 */
- (void)setHighlightTitleColor:(UIColor *)highlightTitleColor {
  if (highlightTitleColor) {
    _highlightTitleColor = highlightTitleColor;
    [self setTitleColor:_highlightTitleColor
               forState:UIControlStateHighlighted];
  }
}
/** 设置button title */
- (void)buttonWithTitle:(NSString *)title
          andNormaltextcolor:(NSString *)normaltextcolor
    andHightlightedTextColor:(NSString *)hightlightedTextcolor {
  [self setTitle:title forState:UIControlStateNormal];
  [self setTitle:title forState:UIControlStateHighlighted];
  _normalTitleColor = [Globle colorFromHexRGB:normaltextcolor];
  _highlightTitleColor = [Globle colorFromHexRGB:hightlightedTextcolor];
  [self setTitleColor:_normalTitleColor forState:UIControlStateNormal];
}

/** 按钮按下时 触发的事件 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesBegan:touches withEvent:event];
  //记录当前时间
  touchBeginTime = [[NSDate date] timeIntervalSince1970];
  //高亮时的背景颜色
  if (_highlightBGColor) {
    self.backgroundColor = _highlightBGColor;
  }
  if (_highlightTitleColor) {
    [self setTitleColor:_highlightTitleColor forState:UIControlStateNormal];
    [self setTitleColor:_highlightTitleColor
               forState:UIControlStateHighlighted];
  }
  __weak BGColorUIButton *weakSelf = self;
  action = ^{
    BGColorUIButton *strongSelf = weakSelf;
    if (strongSelf) {
      [strongSelf restoreNormalBGColor];
      [strongSelf restoreNormalTitleColor];
    }
  };
  [self delayExecPendingAction];
}

- (void)delayExecPendingAction {
  __weak BGColorUIButton *weakSelf = self;
  [FPYouguUtil performBlockOnMainThread:^{
    BGColorUIButton *strongSelf = weakSelf;
    if (!strongSelf) {
      return;
    }
    if (strongSelf.highlighted) {
      [strongSelf delayExecPendingAction];
      return;
    }
    [strongSelf execPendingAction];
  } withDelaySeconds:0.1];
}

- (void)execPendingAction {
  if (action) {
    action();
    action = nil;
  }
}
/** 恢复平常状态 背景颜色*/
- (void)restoreNormalBGColor {
  if (_normalBGColor) {
    self.backgroundColor = _normalBGColor;
  }
}
/** 恢复平常状态 字体颜色*/
- (void)restoreNormalTitleColor {
  if (_normalTitleColor) {
    [self setTitleColor:_normalTitleColor forState:UIControlStateNormal];
    [self setTitleColor:_normalTitleColor forState:UIControlStateHighlighted];
  }
}

@end

@implementation TitleColorChangedUIButton {
  NSTimeInterval touchBeginTime;
}

- (void)setNormalTitleColor:(UIColor *)normalTitleColor {
  if (normalTitleColor) {
    _normalTitleColor = normalTitleColor;
    [self setTitleColor:_normalTitleColor forState:UIControlStateNormal];
  }
}

- (void)setHighlightTitleColor:(UIColor *)highlightTitleColor {
  if (highlightTitleColor) {
    _highlightTitleColor = highlightTitleColor;
    [self setTitleColor:_highlightTitleColor
               forState:UIControlStateHighlighted];
  }
}

- (void)restoreNormalTitleColor {
  if (_normalTitleColor) {
    NSTimeInterval current = [[NSDate date] timeIntervalSince1970];
    if (current - touchBeginTime < 0.1) {
      [FPYouguUtil performBlockOnMainThread:^{
        [self setTitleColor:_normalTitleColor forState:UIControlStateNormal];
      } withDelaySeconds:0.1];
    } else {
      [self setTitleColor:_normalTitleColor forState:UIControlStateNormal];
    }
  }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesBegan:touches withEvent:event];
  touchBeginTime = [[NSDate date] timeIntervalSince1970];
  if (_highlightTitleColor) {
    [self setTitleColor:_highlightTitleColor forState:UIControlStateNormal];
  }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesCancelled:touches withEvent:event];
  [self restoreNormalTitleColor];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesEnded:touches withEvent:event];
  [self restoreNormalTitleColor];
}

@end