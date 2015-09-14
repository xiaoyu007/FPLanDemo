//
//  GesturePasswordController.h
//  GesturePassword
//
//  Created by hb on 14-8-23.
//  Copyright (c) 2014年 黑と白の印记. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import <UIKit/UIKit.h>
#import "TentacleView.h"
#import "FPGesturePasswordView.h"
#import "FPGestureNavigationBar.h"

/** 手势验证通过 */
typedef void (^CertificationSuccess)(BOOL isSuccess);

@interface FPGesturePasswordController
    : UIViewController <VerificationDelegate, ResetDelegate,
                        GesturePasswordDelegate, UIAlertViewDelegate> {
  ///导航条
  FPGestureNavigationBar *gesNavBar;
  //验证状态返回
  CertificationSuccess currentCallback;
}
@property(nonatomic, assign) GesturePasswordPageType pageType;

- (void)clear;

- (BOOL)exist;
/** 需要反向传值时初始化 */
- (id)initWithCallback:(CertificationSuccess)callback;
@end
