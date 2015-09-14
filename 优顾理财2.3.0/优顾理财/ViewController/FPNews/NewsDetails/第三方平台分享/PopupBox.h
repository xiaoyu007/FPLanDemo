//
//  Pop-up_box.h
//  优顾理财
//
//  Created by moulin wang on 13-10-14.
//  Copyright (c) 2013年 Ling YU. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 资讯页分享按钮 */
@interface PopupBox : UIView <UIGestureRecognizerDelegate> {
  /** 提示框 */
  UIView *box_view;
  /** 箭头imageview */
  UIImageView *Arrow_image;
}
///选择箭头的位置
- (void)Arrow_frame:(CGRect)arrow_frame;
@end
