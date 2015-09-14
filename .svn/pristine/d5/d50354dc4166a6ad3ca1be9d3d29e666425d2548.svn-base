//
//  NewShowLabel.m
//  SimuStock
//
//  Created by moulin wang on 14-7-25.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "TopNewShowPushLabel.h"
#import "YouguuSchema.h"

@implementation TopNewShowPushLabel
static TopNewShowPushLabel * newShowLab;

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
  }
  return self;
}
+ (TopNewShowPushLabel *)topNewShowPushLabel {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    newShowLab = [[TopNewShowPushLabel alloc] init];
    newShowLab.backgroundColor =
        [[Globle colorFromHexRGB:@"#5d6a73"] colorWithAlphaComponent:0.75];
    [newShowLab.layer setMasksToBounds:YES];
    newShowLab.layer.cornerRadius = 5.0 / 2;
    newShowLab.textColor = [UIColor whiteColor];
    newShowLab.textAlignment = NSTextAlignmentCenter;
    newShowLab.font = [UIFont systemFontOfSize:Font_Height_13_0];
    newShowLab.numberOfLines = 0;
    newShowLab.hidden = YES;
    newShowLab.Userinfo = [[NSMutableDictionary alloc] init];
  });
  return newShowLab;
}



///隐藏自己
- (void)hideNewShowLabel {
  newShowLab.hidden = YES;
  //必须及时从当前window层剔除，否则多指针引用，不过单例影响不大
  [newShowLab removeFromSuperview];
}

///推送在应用启动时，的提示动画
+ (void)setBpushMessageContent:(NSString *)message
                 andDictionary:(NSDictionary *)dic {
  if (!message || [message length] == 0) {
    return;
  }
  if (!dic) {
    return;
  }
  if (!newShowLab) {
    newShowLab = [TopNewShowPushLabel topNewShowPushLabel];
  }
  [newShowLab.Userinfo removeAllObjects];
  [newShowLab.Userinfo addEntriesFromDictionary:dic];

  CGSize fsize = CGSizeMake(300.0, 80.0);
  UIFont *font = [UIFont systemFontOfSize:Font_Height_13_0];
  CGSize labelsize = [message sizeWithFont:font
                         constrainedToSize:fsize
                             lineBreakMode:NSLineBreakByCharWrapping];
  newShowLab.text = message;
  newShowLab.textAlignment = NSTextAlignmentCenter;
  newShowLab.numberOfLines = 2;
  newShowLab.backgroundColor =
      [Globle colorFromHexRGB:Color_Blue_but withAlpha:0.8];
  // iOS6 与 iOS7 的UIWindow 层的结构不一样，iOS6
  // 上的UIAlertView会多一个UIAlertNormalizingOverlayWindow，导致提示框添加到此window上
  UIWindow *window;
  if (isIos7Version) {
    window = [UIApplication sharedApplication].windows.lastObject;
    newShowLab.frame = CGRectMake(0, 20, 320, 0);
  } else {
    newShowLab.frame = CGRectMake(0,0, 320, 0);
    window = [UIApplication sharedApplication].windows.lastObject;
    //如果最后一个层是UIAlertNormalizingOverlayWindow，则取上一个Window层，否则提示框会随着警告框点击后消失
    if ([NSStringFromClass(window.class)
            isEqualToString:@"_UIAlertNormalizingOverlayWindow"]) {
      NSInteger windowsNum = [UIApplication sharedApplication].windows.count;
      window = [UIApplication sharedApplication].windows[windowsNum - 2];
    }
  }
  [window addSubview:newShowLab];
  newShowLab.userInteractionEnabled = YES;
  UITapGestureRecognizer *tap =
      [[UITapGestureRecognizer alloc] initWithTarget:newShowLab
                                              action:@selector(btnClick)];
  [newShowLab addGestureRecognizer:tap];
  [UIView animateWithDuration:0.5 animations:^{
    newShowLab.height =labelsize.height + 30.0;
  } completion:^(BOOL finished) {
    [UIView animateWithDuration:5 - 2*0.5 animations:^{
      
    } completion:^(BOOL finished) {
      [newShowLab performSelector:@selector(hideNewShowLabel)
                       withObject:nil
                       afterDelay:4.5f];
    }];
  }];

  //取消上一个正在执行的延迟操作，适合快速点击时调用
  [UIView cancelPreviousPerformRequestsWithTarget:newShowLab];

  newShowLab.hidden = NO;
}

- (void)btnClick {
  [YouguuSchema forwardPageFromNoticfication:newShowLab.Userinfo];
//  [self hideNewShowLabel];
}



@end
