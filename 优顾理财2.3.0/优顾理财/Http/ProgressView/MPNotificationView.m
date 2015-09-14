//
//  MPNotificationView.m
//  SimuStock
//
//  Created by Mac on 13-12-11.
//  Copyright (c) 2013年 Mac. All rights reserved.
//

#import "MPNotificationView.h"
#import "MPNotificationWindow.h"

static MPNotificationWindow *__notificationWindow = nil;

@interface MPNotificationView () {
  UILabel *_textLabel;
}
@end

@implementation MPNotificationView

@synthesize textLabel = _textLabel;
@synthesize duration = _duration;

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
    UIFont *textFont = [UIFont boldSystemFontOfSize:Font_Height_14_0];
    _textLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _textLabel.font = textFont;
    _textLabel.numberOfLines = 1;
    _textLabel.textColor = [UIColor whiteColor];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _textLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_textLabel];
  }
  return self;
}

+ (MPNotificationView *)notifyWithText:(NSString *)text
                           andDuration:(NSTimeInterval)duration {
  if (__notificationWindow == nil) {
    __notificationWindow = [[MPNotificationWindow alloc]
        initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,
                                 20)];
    __notificationWindow.hidden = NO;
  }
  MPNotificationView *notification =
      [[MPNotificationView alloc] initWithFrame:__notificationWindow.bounds];

  notification.textLabel.text = text;
  notification.duration = duration;

  [__notificationWindow.notificationQueue addObject:notification];

  if (__notificationWindow.currentNotification == nil) {
    [self showNextNotification];
  }

  return notification;
}
+ (void)showNextNotification {
  MPNotificationView *viewToRotateIn = nil;
  if ([__notificationWindow.notificationQueue count] > 0) {
    viewToRotateIn = (__notificationWindow.notificationQueue)[0];
  }
  if (viewToRotateIn == nil)
    return;
  __notificationWindow.currentNotification = viewToRotateIn;

  [__notificationWindow addSubview:viewToRotateIn];
  __notificationWindow.alpha = 0;
  __notificationWindow.hidden = NO;

  [UIView animateWithDuration:viewToRotateIn.duration
      delay:0.0
      options:UIViewAnimationOptionCurveEaseInOut
      animations:^{
          __notificationWindow.alpha = 1;

      }
      completion:^(BOOL finished) {
          [UIView animateWithDuration:viewToRotateIn.duration
              delay:0.0
              options:UIViewAnimationOptionCurveEaseInOut
              animations:^{
                  __notificationWindow.alpha = 0;

              }
              completion:^(BOOL finished) {
                  __notificationWindow.hidden = YES;
                  [__notificationWindow.notificationQueue
                      removeObjectAtIndex:0];
                  [viewToRotateIn removeFromSuperview];
                  __notificationWindow.currentNotification = nil;
              }];

      }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
