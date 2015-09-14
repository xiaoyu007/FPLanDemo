//
//  YG_Four_QC_ScrollView.h
//  优顾理财
//
//  Created by Mac on 14/10/22.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YG_Four_QC_ScrollView : UIView <UIScrollViewDelegate> {
  UIView *D_View;

  UIScrollView *_rootScrollView; //主视图
  UIScrollView *_topScrollView;  //顶部页签视图

  CGFloat _userContentOffsetX;
  BOOL _isLeftScroll; //是否左滑动
  BOOL _isRootScroll; //是否主视图滑动
  BOOL _isBuildUI;    //是否建立了ui

  NSInteger _userSelectedChannelID; //点击按钮选择名字ID

  UIImageView *_shadowImageView;

  UIView *read_message_view;
}
@property(nonatomic, strong) UIScrollView *rootScrollView;
@property(nonatomic, strong) UIScrollView *topScrollView;
@property(nonatomic, assign) CGFloat userContentOffsetX;
@property(nonatomic, assign) NSInteger userSelectedChannelID;
@property(nonatomic, assign) NSInteger scrollViewSelectedChannelID;

/*!
 * @method 通过16进制计算颜色
 * @abstract
 * @discussion
 * @param 16机制
 * @result 颜色对象
 */
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;

@end
