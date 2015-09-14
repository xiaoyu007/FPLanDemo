//
//  NewShowLabel.m
//  SimuStock
//
//  Created by moulin wang on 14-7-25.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

//#import "YouguuSchema.h"

@implementation NewShowLabel
static NewShowLabel *newShowLab;

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
  }
  return self;
}
+ (NewShowLabel *)newShowLabel {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    newShowLab = [[NewShowLabel alloc] init];
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

/**显示网络不给力提示 */
+ (void)showNoNetworkTip {
  [NewShowLabel setMessageContent:REQUEST_FAILED_MESSAGE];
}

+ (void)setMessageContent:(NSString *)message {
  if (!message || [message length] == 0) {
    return;
  }

  CGSize fsize = CGSizeMake(260.0, 40.0);
  UIFont *font = [UIFont systemFontOfSize:Font_Height_13_0];
  CGSize labelsize = [message sizeWithFont:font
                         constrainedToSize:fsize
                             lineBreakMode:NSLineBreakByCharWrapping];

  if (!newShowLab) {
    newShowLab = [NewShowLabel newShowLabel];
  }
  //横竖屏切换
  [NewShowLabel newShowLabel].transform =
      CGAffineTransformMakeRotation(newShowLab.isLandscape ? M_PI / 2 : 0);

  if (newShowLab.isLandscape) {
    newShowLab.frame =
        CGRectMake(100 - (labelsize.width - labelsize.height) / 2,
                   (HEIGHT_OF_SCREEN - labelsize.width - 10) / 2,
                   labelsize.height + 10.0, labelsize.width + 10.0);

  } else {
    newShowLab.frame =
        CGRectMake((WIDTH_OF_SCREEN - labelsize.width - 10) / 2,
                   HEIGHT_OF_SCREEN - labelsize.height - 100.0,
                   labelsize.width + 10.0, labelsize.height + 10.0);
  }

  newShowLab.text = message;
  newShowLab.textAlignment = NSTextAlignmentCenter;
  newShowLab.numberOfLines = 0;
  newShowLab.backgroundColor =
      [Globle colorFromHexRGB:Color_Blue_but withAlpha:0.8];

  // iOS6 与 iOS7 的UIWindow 层的结构不一样，iOS6
  // 上的UIAlertView会多一个UIAlertNormalizingOverlayWindow，导致提示框添加到此window上
  UIWindow *window;
  if (isIos7Version) {
    window = [UIApplication sharedApplication].windows.lastObject;
  } else {
    window = [UIApplication sharedApplication].windows.lastObject;
    //如果最后一个层是UIAlertNormalizingOverlayWindow，则取上一个Window层，否则提示框会随着警告框点击后消失
    if ([NSStringFromClass(window.class)
            isEqualToString:@"_UIAlertNormalizingOverlayWindow"]) {
      NSInteger windowsNum = [UIApplication sharedApplication].windows.count;
      window = [UIApplication sharedApplication].windows[windowsNum - 2];
    }
  }
  //打印当前系统层级结构
  //  NSLog(@"🈚️windows：%@", [UIApplication sharedApplication].windows);
  [window addSubview:newShowLab];

  //取消上一个正在执行的延迟操作，适合快速点击时调用
  [UIView cancelPreviousPerformRequestsWithTarget:newShowLab];

  newShowLab.hidden = NO;
  [newShowLab performSelector:@selector(hideNewShowLabel)
                   withObject:nil
                   afterDelay:2.5f];
}

///隐藏自己
- (void)hideNewShowLabel {
  newShowLab.hidden = YES;
  //必须及时从当前window层剔除，否则多指针引用，不过单例影响不大
  [newShowLab removeFromSuperview];
}

- (void)landscapeStyle:(BOOL)isLandscape {
  _isLandscape = isLandscape;
}

@end
