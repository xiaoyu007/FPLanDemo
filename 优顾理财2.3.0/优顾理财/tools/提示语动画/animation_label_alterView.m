//
//  animation_label_alterView.m
//  优顾理财
//
//  Created by Mac on 14-5-6.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

@implementation animation_label_alterView

static animation_label_alterView *shareAlertViewInstance = nil;

+ (animation_label_alterView *)shareManager {
  static dispatch_once_t predicate;
  dispatch_once(&predicate, ^{
    if (!shareAlertViewInstance) {
      shareAlertViewInstance =
      [[self alloc] initWithFrame:CGRectMake(20.0f, windowHeight - 120.0f,
                                             windowWidth - 40.0f, 20)];
    }
  });
  return shareAlertViewInstance;
}
- (id)initWithFrame:(CGRect)frame{
  self = [super initWithFrame:frame];
  if (self) {
    //提示动画
    self.backgroundColor =
    [Globle colorFromHexRGB:@"000000" withAlpha:0.5f];
    self.textAlignment = NSTextAlignmentCenter;
    self.layer.cornerRadius = 2.5f;
    self.clipsToBounds = YES;
    self.hidden = YES;
    self.numberOfLines = 0;
    self.contentMode = UIViewContentModeCenter;
    self.font = [UIFont systemFontOfSize:14.0f];
    self.textColor = [Globle colorFromHexRGB:@"ffffff"];
  }
  return self;
}
#pragma mark - 提示动画
///******************************************************************************
// 函数名称 : -(void)Creat_SDK_share
// 函数描述 : 提示动画
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/
+ (void)YouGu_animation_Did_Start:(NSString *)message {
  if (!message || [message length] == 0) {
    [[animation_label_alterView shareManager] performSelector:@selector(hideNewShowLabel)
                        withObject:nil
                        afterDelay:2.0f];
    return;
  }
  NSMutableString *mutableString = [[NSMutableString alloc]initWithString:message];
  [mutableString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
  [mutableString stringByReplacingOccurrencesOfString:@" " withString:@""];
  //文本自适应
  CGSize messageSize =
      [mutableString sizeWithFont:[UIFont systemFontOfSize:14.0f]
          constrainedToSize:CGSizeMake(windowWidth - 40 - 13.0f * 2, 100)
              lineBreakMode:NSLineBreakByCharWrapping];
  if (messageSize.height > 20.0f) {
    [animation_label_alterView shareManager].width = messageSize.width;
  } else {
    [animation_label_alterView shareManager].width = messageSize.width + 26.0f;
  }
  shareAlertViewInstance.height = messageSize.height + 6.0f;
  //最小字体
  shareAlertViewInstance.minimumScaleFactor = 12.0f;
  shareAlertViewInstance.center =
  CGPointMake(windowWidth / 2.0f, shareAlertViewInstance.center.y);
  shareAlertViewInstance.text = mutableString;
  // iOS6 与 iOS7 的UIWindow 层的结构不一样，iOS6
  // 上的UIAlertView会多一个UIAlertNormalizingOverlayWindow，导致提示框添加到此window上
  UIWindow *window;
  if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) {
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

  [window addSubview:shareAlertViewInstance];

  //取消上一个正在执行的延迟操作，适合快速点击时调用
  [UIView cancelPreviousPerformRequestsWithTarget:shareAlertViewInstance];

  shareAlertViewInstance.hidden = NO;
  [shareAlertViewInstance performSelector:@selector(hideNewShowLabel)
                      withObject:nil
                      afterDelay:2.0f];
}
///隐藏自己
- (void)hideNewShowLabel {
  if (shareAlertViewInstance&&[shareAlertViewInstance respondsToSelector:@selector(setHidden:)]) {
    [shareAlertViewInstance setHidden:YES];
  }
  //必须及时从当前window层剔除，否则多指针引用，不过单例影响不大
  //[shareInstance removeFromSuperview];
}
@end
