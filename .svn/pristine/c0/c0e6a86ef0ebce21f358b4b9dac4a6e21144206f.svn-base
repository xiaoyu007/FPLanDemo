//
//  KnowBottomView.h
//  优顾理财
//
//  Created by Mac on 14-3-26.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 评论按钮点击回传 */
@protocol KnowBottomView_Delegate <NSObject>
/** 财知道评论页评论按钮点击 */
- (void)C_button_click:(UIButton *)sender;

@end

/** 评论视图 ，“说说我的看法”*/
@interface KnowBottomView : UIView {
  ///底部view
  UIView *bottom_view;
  ///分割线
  UIView *C_Fen_view;
  ///评论底部view
  UIView *C_view;
  ///评论输入框
  UITextField *C_field;
  ///右侧评论底视图
  UIView *C_field_view;
  ///右侧评论label
  UILabel *C_field_label;
}
@property(nonatomic, assign)
    id<KnowBottomView_Delegate> delegate;
@end
