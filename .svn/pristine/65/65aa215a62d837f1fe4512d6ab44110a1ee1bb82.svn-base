//
//  simuBottomToolBarView.h
//  SimuStock
//
//  Created by Mac on 14-7-8.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol simuBottomToolBarViewDelegate <NSObject>
//按钮点击
- (void)bottomButtonPressDown:(NSInteger)index;
@end
/*
 *类说明：主页面下工具栏
 */
@interface SimuBottomToolBarView : UIView {
  //普通图片数组
  NSMutableArray *sbtb_UpImageViewArray;
  //按下图片数组
  NSMutableArray *sbtb_DownImageViewArray;
  //文字lable数组
  NSMutableArray *sbtb_LableArray;
  //当前选中的按钮
  NSInteger sbtb_selectedindex;
  //当前是否可以点击
  BOOL sbtb_isButtonVisible;
  ///推送信息的小红点
  UIView * redPointView;
}
//- (void)buttonpressdown:(UIButton *)button;
@property(weak, nonatomic) id<simuBottomToolBarViewDelegate> delegate;
- (void)resetSelectedState:(NSInteger)new_index;
@end
