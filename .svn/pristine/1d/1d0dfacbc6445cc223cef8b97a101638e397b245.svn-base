//
//  RefreshButtonView.h
//  优顾理财
//
//  Created by Yuemeng on 15/9/9.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^refreshButtonPressDownBlock)(void);

/**
 *  列表页刷新按钮
 */
@interface RefreshButtonView : UIView {
  /** 请求时菊花控件 */
  UIActivityIndicatorView *_indicator;
  /** 刷新按钮*/
  UIButton *_refreshButton;
}

@property(nonatomic, copy)
    refreshButtonPressDownBlock refreshButtonPressDownBlock;

- (void)showIndicator;
- (void)hiddenIndicator;

- (instancetype)initWithSuperView:(UIView *)superView;

@end
