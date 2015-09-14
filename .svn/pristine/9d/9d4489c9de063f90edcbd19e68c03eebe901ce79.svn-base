//
//  Youguu_Loading_View.h
//  优顾理财
//
//  Created by Mac on 14-1-3.
//  Copyright (c) 2014年 Ling YU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Loading.h"
@protocol youguu_loading_View_delegate <NSObject>
@optional
- (void)loadData_Cai;

//无网，趣理财
- (void)Interest_management;

@end

@interface Youguu_Loading_View : UIView {
  UIView *view_context;
  UIView *view_down_tap;
  Loading *loading;
  //    消息中心的，name

  UIImageView *back_image;
  UIButton *btn_view;
  UIButton *btn_Click;
}
@property(nonatomic, assign) id<youguu_loading_View_delegate> delegate;
- (void)btn_click;
//返回到旋转动画
- (void)start_btn_click;
@end
