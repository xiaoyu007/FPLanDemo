//
//  OrderViewController.h
//  ifengNewsOrderDemo
//
//  Created by zer0 on 14-2-27.
//  Copyright (c) 2014年 zer0. All rights reserved.
//
#import "FPBaseViewController.h"
#import "NewsChannelList.h"
#import "FileChangelUtil.h"
/**
 点击按钮的回调函数
 */
typedef void (^OrderViewControllerClick)();
@interface OrderViewController : FPBaseViewController {
 @public
  NSMutableArray* _viewArr1;
  NSMutableArray* _viewArr2;

  UIImageView* shadowImageView;

  UILabel* label_text;

  UIView* X_view;

  //    加上下，分界线
  UIView* View_1;

  NSMutableArray* channelVCs;

  NewsChannelList* myChannelList;
  NewsChannelList* moreChannelList;
}

@property(nonatomic, retain) UILabel* titleLabel;
@property(nonatomic, retain) UILabel* titleLabel2;

/** 返回按钮 */
@property(nonatomic, retain) UIButton *backButton;
/** 关闭按钮 */
@property(nonatomic, retain) UIButton *header_btn;
@property(nonatomic, strong) NSMutableArray * mutArr1;
@property(nonatomic, strong) NSMutableArray * mutArr2;

@property(nonatomic, copy)OrderViewControllerClick block;
@end
