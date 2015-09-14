//
//  GesturePasswordView.m
//  GesturePassword
//
//  Created by hb on 14-8-23.
//  Copyright (c) 2014年 黑と白の印记. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "FPGesturePasswordView.h"
#import "FPGesturePasswordButton.h"
#import "KeychainItemWrapper.h"
#import "UIImageView+WebCache.h"

@implementation FPGesturePasswordView {
  NSMutableArray *buttonArray;

  CGPoint lineStartPoint;
  CGPoint lineEndPoint;
}
@synthesize imgView;
@synthesize forgetButton;
@synthesize changeButton;

@synthesize tentacleView;
@synthesize state;
@synthesize gesturePasswordDelegate;
/** 密码盘宽度 */
#define passwordTrayWidth 270.0f
/** 密码盘高度 */
#define passwordTrayHeight 270.0f
/** 分割线 */
#define cuttingLineOriginX self.frame.size.height / 3.0f

- (id)initWithFrame:(CGRect)frame
       withPageType:(GesturePasswordPageType)pageType {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code

    buttonArray = [[NSMutableArray alloc] initWithCapacity:0];
    UIView *view = [[UIView alloc]
        initWithFrame:CGRectMake((frame.size.width - passwordTrayWidth) / 2.0f,
                                 cuttingLineOriginX, passwordTrayWidth,
                                 passwordTrayHeight)];
    view.backgroundColor = [UIColor clearColor];
    //密码盘
    for (int i = 0; i < 9; i++) {
      NSInteger row = i / 3.0f;
      NSInteger col = i % 3;
      // Button Frame
      NSInteger distance = passwordTrayWidth / 3.0f;
      NSInteger margin = 20.0f;
      FPGesturePasswordButton *gesturePasswordButton =
          [[FPGesturePasswordButton alloc]
              initWithFrame:CGRectMake(col * distance + margin,
                                       row * distance + margin, 50.0f, 50.0f)];
      [gesturePasswordButton setTag:i];
      [view addSubview:gesturePasswordButton];
      [buttonArray addObject:gesturePasswordButton];
    }
    frame.origin.y = 0;
    [self addSubview:view];
    //链接线
    tentacleView = [[TentacleView alloc] initWithFrame:view.frame];
    [tentacleView setButtonArray:buttonArray];
    [tentacleView setTouchBeginDelegate:self];
    [tentacleView setUpdateSmallPasswordDelegate:self];
    //界面类型
    tentacleView.pageType = pageType;
    _currentPageType = pageType;
    [self addSubview:tentacleView];
    //操作结果状态栏
    state = [[UILabel alloc]
        initWithFrame:CGRectMake((frame.size.width - passwordTrayWidth) / 2.0f,
                                 cuttingLineOriginX - 27.0f, passwordTrayWidth,
                                 30)];
    [state setTextColor:[UIColor colorWithRed:0.0f
                                        green:226.0f / 255.0f
                                         blue:205.0f / 255.0f
                                        alpha:1.0f]];
    [state setTextAlignment:NSTextAlignmentCenter];
    state.backgroundColor = [UIColor clearColor];
    [state setFont:[UIFont systemFontOfSize:14.0f]];
    [self addSubview:state];
    //需要添加的底部按钮
    [self addResetButton];
    [self addForgetBtn];
    if (pageType == GesturePasswordPageTypeVerPassword) {
      //验证
      [self showHeadImageViewAndNickname];
    } else if (pageType == GesturePasswordPageTypeChangePasswod||pageType == GesturePasswordPageTypeRevokePassword) {
      state.text = @"请输入原手势密码";
    } else {
      //添加小密码盘
      [self createSmallPassword];
    }
  }

  return self;
}
/**添加重设按钮*/
- (void)addResetButton {
  //忘记密码
  _resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
  _resetButton.frame =
      CGRectMake(self.frame.size.width / 2.0f - 50.0f,
                 self.frame.size.height - 60.0f, 100.0f, 30.0f);
  [_resetButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
  _resetButton.backgroundColor = [UIColor clearColor];
  [_resetButton setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.7f]
                     forState:UIControlStateNormal];
  [_resetButton setTitle:@"重设手势密码" forState:UIControlStateNormal];
  [_resetButton addTarget:self
                   action:@selector(resetGesPassword:)
         forControlEvents:UIControlEventTouchDown];
  [self addSubview:_resetButton];
  _resetButton.hidden = YES;
}
/** 重新设置手势密码 */
- (void)resetGesPassword:(id)sender {
  self.currentPageType = GesturePasswordPageTypeFtSetting;
  tentacleView.pageType = GesturePasswordPageTypeFtSetting;
  [tentacleView enterArgin];
  [gesturePasswordDelegate resetState];
  state.text = @"绘制解锁图案";
  [state setTextColor:[UIColor colorWithRed:0.0f
                                      green:226.0f / 255.0f
                                       blue:205.0f / 255.0f
                                      alpha:1.0f]]; //清空
  [self resetSmallPassword];
}
- (void)addForgetBtn {
  //忘记密码
  forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
  forgetButton.frame =
      CGRectMake(self.frame.size.width / 2.0f - 50.0f,
                 self.frame.size.height - 60.0f, 100.0f, 30.0f);
  [forgetButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
  forgetButton.backgroundColor = [UIColor clearColor];
  [forgetButton setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.7f]
                     forState:UIControlStateNormal];
  [forgetButton setTitle:@"忘记手势密码" forState:UIControlStateNormal];
  [forgetButton addTarget:self
                   action:@selector(forget)
         forControlEvents:UIControlEventTouchDown];
  [self addSubview:forgetButton];
  forgetButton.hidden = YES;
}
/** 显示头像昵称 */
- (void)showHeadImageViewAndNickname {
  //头像
  imgView = [[UIImageView alloc]
      initWithFrame:CGRectMake(self.frame.size.width / 2 - 35.0f,
                               cuttingLineOriginX - 120.0f, 70.0f, 70.0f)];
  [imgView setBackgroundColor:[UIColor whiteColor]];
  [imgView.layer setMasksToBounds:YES];
  [imgView.layer setCornerRadius:35.0f];
  [imgView.layer
      setBorderColor:[UIColor colorWithWhite:1.0f alpha:0.5f].CGColor];
  [imgView.layer setBorderWidth:2.0f];
  [FPYouguUtil getUserID];
  [imgView setImageWithURL:[NSURL URLWithString:[FPYouguUtil getHeadpic]]
          placeholderImage:[UIImage imageNamed:@"头像无网络"]];
  [self addSubview:imgView];
  //昵称
  UILabel *nicknameLabel = [[UILabel alloc]
      initWithFrame:CGRectMake(self.frame.size.width / 2.0f - 100.0f,
                               cuttingLineOriginX - 38.0f, 200.0f, 14.0f)];
  nicknameLabel.backgroundColor = [UIColor clearColor];
  nicknameLabel.font = [UIFont systemFontOfSize:14.0f];
  nicknameLabel.textAlignment = NSTextAlignmentCenter;
  nicknameLabel.textColor = [UIColor whiteColor];
  nicknameLabel.text = [FPYouguUtil getUserNickName];
  [self addSubview:nicknameLabel];
}
/** 绘制小密码盘 */
- (void)createSmallPassword {
  state.text = @"绘制解锁图案";
  bgView = [[UIView alloc]
      initWithFrame:CGRectMake((self.bounds.size.width - 39.0f) / 2.0f,
                               cuttingLineOriginX - 73.0f, 39.0f, 39.0f)];
  bgView.backgroundColor = [UIColor clearColor];
  for (int st = 0; st < 9; st++) {
    UIView *circle = [[UIView alloc]
        initWithFrame:CGRectMake(st % 3 * 15.0f, st / 3 * 15.0f, 9.0f, 9.0f)];
    [circle.layer setMasksToBounds:YES];
    [circle.layer setCornerRadius:4.5f];
    [circle.layer setBorderWidth:1.0f];
    [circle.layer
        setBorderColor:
            [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.5f]
                .CGColor];
    circle.tag = 100 + st;
    [bgView addSubview:circle];
  }
  [self addSubview:bgView];
}
/** 刷新小密码盘 */
- (void)refreshSmallPassword:(NSArray *)circleColors {
  //只刷新这一种类型
  if (_currentPageType == GesturePasswordPageTypeFtSetting) {
    for (int st = 0; st < [circleColors count]; st++) {
      FPGesturePasswordButton *gesBtn = circleColors[st];
      if (gesBtn.selected) {
        UIView *circle = (UIView *)[bgView viewWithTag:100 + st];
        circle.backgroundColor = [UIColor colorWithRed:0.0f
                                                 green:226.0f / 255.0f
                                                  blue:205.0f / 255.0f
                                                 alpha:1.0f];
      }
    }
    [self setNeedsDisplay];
  }
}
- (void)resetSmallPassword {
  //只刷新这一种类型
  if (_currentPageType == GesturePasswordPageTypeFtSetting) {
    for (int st = 0; st < [buttonArray count]; st++) {
      UIView *circle = (UIView *)[bgView viewWithTag:100 + st];
      circle.backgroundColor = [UIColor clearColor];
    }
    [self setNeedsDisplay];
  }
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect {
  // Drawing code
  //渐变背景
  CGContextRef context = UIGraphicsGetCurrentContext();

  CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
  CGFloat colors[] = {
      37.0f / 255.0, 46.0f / 255.0, 97.0f / 255.0, 1.00,
      63.0f / 255.0, 29.0f / 255.0, 95.0f / 255.0, 1.00,
      85.0f / 255.0, 28.0f / 255.0, 76.0f / 255.0, 1.00,
  };
  CGGradientRef gradient = CGGradientCreateWithColorComponents(
      rgb, colors, NULL, sizeof(colors) / (sizeof(colors[0]) * 4));
  CGColorSpaceRelease(rgb);
  CGContextDrawLinearGradient(context, gradient, CGPointMake(0.0, 0.0),
                              CGPointMake(0.0, self.frame.size.height),
                              kCGGradientDrawsBeforeStartLocation);
  CGGradientRelease(gradient);

  switch (self.currentPageType) {
  case GesturePasswordPageTypeFtSetting: {
    _resetButton.hidden = YES;
    forgetButton.hidden = YES;
  } break;
  case GesturePasswordPageTypeSeSetting: {
    _resetButton.hidden = NO;
    forgetButton.hidden = YES;
  } break;
  case GesturePasswordPageTypeVerPassword: {
    forgetButton.hidden = NO;
    _resetButton.hidden = YES;
  } break;
  case GesturePasswordPageTypeChangePasswod: {
    state.text = @"请输入原手势密码";
    forgetButton.hidden = NO;
    _resetButton.hidden = YES;
  } break;
  default:
    break;
  }
}

- (void)gestureTouchBegin {
  [self.state setText:@""];
}
//忘记密码
- (void)forget {
  UIAlertView *alertView =
      [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                 message:@"忘记手势密码，需重新登录"
                                delegate:self
                       cancelButtonTitle:@"取消"
                       otherButtonTitles:@"重新登录", nil];
  [alertView show];
//  [gesturePasswordDelegate forget];
}
- (void)alertView:(UIAlertView *)alertView
    clickedButtonAtIndex:(NSInteger)buttonIndex {
  //忘记密码（重新登录）
  if (buttonIndex == 1) {
    if ([gesturePasswordDelegate respondsToSelector:@selector(releaseViewController)]) {
      [gesturePasswordDelegate releaseViewController];
    }
    //跳转登录页(登录成功，密码管理关闭)
    [Login_ViewController loginAgainWithCallback:^(BOOL logonSuccess) {
      if (logonSuccess) {
        // switch
        [SimuControl saveObjectWithObject:@"" withKey:@"userGesturePassword"];
        //密码重置
          KeychainItemWrapper *keychin =
          [[KeychainItemWrapper alloc] initWithIdentifier:@"YouGuuGesture"
                                              accessGroup:nil];
          [keychin resetKeychainItem];
      }
    }];
  }
}
- (void)change {
  [gesturePasswordDelegate change];
}

@end
