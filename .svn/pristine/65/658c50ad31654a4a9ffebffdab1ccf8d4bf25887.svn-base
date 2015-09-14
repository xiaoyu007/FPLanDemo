//
//  TentacleView.h
//  GesturePassword
//
//  Created by hb on 14-8-23.
//  Copyright (c) 2014年 黑と白の印记. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GesturePasswordPageType) {
  /** 首次设置手势密码 */
  GesturePasswordPageTypeFtSetting = 1,
  /** 再次设置手势密码 */
  GesturePasswordPageTypeSeSetting,
  /** 验证手势密码 */
  GesturePasswordPageTypeVerPassword,
  /** 修改手势密码 */
  GesturePasswordPageTypeChangePasswod,
  /** 撤销密码 */
  GesturePasswordPageTypeRevokePassword,
  /** 首页登录 */
  GesturePasswordPageTypeLogonVer,
};

@protocol updateSmallPasswordDelegate <NSObject>
/** 刷新小密码盘 */
- (void)refreshSmallPassword:(NSArray *)passwordArray;

@end

@protocol ResetDelegate <NSObject>

- (BOOL)resetPassword:(NSString *)result;

@end

@protocol VerificationDelegate <NSObject>

- (BOOL)verification:(NSString *)result;

@end

@protocol TouchBeginDelegate <NSObject>

- (void)gestureTouchBegin;

@end

/** 连接线控件 */
@interface TentacleView : UIView
{
  /** 上一次选中的坐标 */
  CGPoint previousPoint;
}

@property(nonatomic, strong) NSArray *buttonArray;

@property(nonatomic, assign) id<VerificationDelegate> rerificationDelegate;

@property(nonatomic, assign) id<ResetDelegate> resetDelegate;

@property(nonatomic, assign) id<TouchBeginDelegate> touchBeginDelegate;

@property(nonatomic, assign)
    id<updateSmallPasswordDelegate> updateSmallPasswordDelegate;
@property(nonatomic, assign) GesturePasswordPageType pageType;
/*
 1: Verify
 2: Reset
 */
@property(nonatomic, assign) GesturePasswordPageType style;

- (void)enterArgin;
/** 手势二次输入错误 */
- (void)inputContentFailed;
@end
