//
//  SimTopBannerView.h
//  SimuStock
//
//  Created by Mac on 13-8-16.
//  Copyright (c) 2013年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globle.h"

#define navigation_bar_7 64
#define navigation_bar_44 44
#define navigation_bar_with [[UIScreen mainScreen] bounds].size.width

typedef enum {
  //侧滑菜单模式
  TTBM_Mode_Sideslip,
  //二级菜单模式
  TTBM_Mode_Leveltwo,
} TopToolBarMode;

@protocol SimTopBannerViewDelegate <NSObject>
@optional
//左边按钮按下
- (void)leftButtonPress;
///右边按钮按下  delegate代理
- (void)rightButtonPress;
///隐藏右边原有的刷新按钮
- (void)hideRefreshButton;
@end

/**
 点击返回按钮的回调函数
 */
typedef void (^onBackButtonPressed)();

/*
 *类说明：程序最上方的工具条栏
 */
@interface SimTopBannerView : UIView {
  //背景图
  UIView *sbv_bgView;
  //侧滑按钮
  UIButton *leftbutton;
}

///代理
@property(nonatomic, weak) id<SimTopBannerViewDelegate> delegate;

/** 点击返回按钮的回调函数 */
@property(nonatomic, copy) onBackButtonPressed onBackButtonPressed;

///页面名称
@property(nonatomic, strong)UILabel *sbv_nameLable;

///对外提供返回按钮 
@property(nonatomic, strong) UIButton *backButton;

//重新设置上边栏的内容和类型
- (void)resetContentAndFlage:(NSString *)content Mode:(TopToolBarMode)modetype;

///标题居中
- (void)setTitleCenter:(NSString *)text;
@end
