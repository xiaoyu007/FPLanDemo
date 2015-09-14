//
//  UIButton+Block.h
//  BoothTag
//
//  Created by Josh Holtz on 4/22/12.
//  Copyright (c) 2012 Josh Holtz. All rights reserved.
//

/** 点击后，再次点击无效的时间间隔 */
#define kInvalid_Duration 1000 * 0.5

#import <UIKit/UIKit.h>

/**
 点击按钮的回调函数
 */
typedef void (^ButtonPressed)();
///传递的回调函数
typedef void (^CallBackAction)();

@interface UIButton (Block)

/** 点击逻辑Block存储在字典中 */
@property(nonatomic, copy) ButtonPressed action;

/** 点击逻辑Block存储在字典中 */
@property(nonatomic, strong) NSNumber *lastPressedTime;

/** 设置点击处理逻辑 */
- (void)setOnButtonPressedHandler:(ButtonPressed)block;

@end

/** 点击时背景颜色会发生变化 */
@interface BGColorUIButton : UIButton

/** 平常状态背景色 */
@property(nonatomic, strong) UIColor *normalBGColor;

/** 高亮状态背景色 */
@property(nonatomic, strong) UIColor *highlightBGColor;

/** 平常状态下title颜色 */
@property(nonatomic, strong) UIColor *normalTitleColor;

/** 高亮状态下title颜色 */
@property(nonatomic, strong) UIColor *highlightTitleColor;

/** 设置button title */
- (void)buttonWithTitle:(NSString *)title
          andNormaltextcolor:(NSString *)normaltextcolor
    andHightlightedTextColor:(NSString *)hightlightedTextcolor;

@end

/** 点击或者按下时，按钮的文字颜色会发生变化
 1. 对于默认的按钮，点击时，文字颜色不发生变化；
 */
@interface TitleColorChangedUIButton : UIButton

@property(nonatomic, strong) UIColor *normalTitleColor;

@property(nonatomic, strong) UIColor *highlightTitleColor;

@end