//
//  Tap_view.h
//  DDMenuController
//
//  Created by moulin wang on 13-9-9.
//
//

#import <UIKit/UIKit.h>
/** 自定义点击view */
@interface Tap_view : UIView {
  /** 图片背景 */
  UIImageView *IMG;
  /** 文本内容 */
  UILabel *label;
  /** 菊花控件 */
  UIActivityIndicatorView *indicator;
}
@property(nonatomic, strong) UILabel *label;
@property(nonatomic, strong) UIImageView *IMG;
@property(nonatomic, strong) UIActivityIndicatorView *indicator;
@end
