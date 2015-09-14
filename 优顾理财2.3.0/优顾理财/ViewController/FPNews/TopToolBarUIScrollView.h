//
//  TopToolBarView.h
//  SimuStock
//
//  Created by Mac on 14-5-14.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TopToolBarUIScrollViewDelegate <NSObject>

//点击标签回调
- (void)changeToIndex:(NSInteger)index;

@end
/*
 *类说明：上选择工具栏
 */
@interface TopToolBarUIScrollView : UIScrollView {
//  //当前选中
//  NSInteger ttlv_corSelIndex;
  //按钮数组
  NSMutableArray *ttlv_buttonArray;
  //按钮区域数组
  CGRect ttlv_arrayRect[10];
  //是否在动画显示中
  BOOL ttlv_isAnimationRuning;
 
  /// yes,滑动， no 为点击
  BOOL topStatus;
}

/** 粗线 */
@property(nonatomic, strong) UIView *maxlineView;

@property(weak, nonatomic) id<TopToolBarUIScrollViewDelegate> Tooldelegate;

//当前选中
@property(nonatomic) NSInteger ttlv_corSelIndex;

/** 初始化*/
- (id)initWithFrame:(CGRect)frame
          DataArray:(NSArray *)dataArray
withInitButtonIndex:(int)buttonIndex;


/** 切换至指定的按钮，并触发对应的页面被显示 */
- (void)changTapToIndex:(NSInteger)index;

#pragma mark
#pragma mark 创建各个控件
- (void)creatCtrlor:(NSArray *)dataArray;
@end
