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

@interface UIButton (Block)

/** 点击逻辑Block存储在字典中 */
@property(nonatomic, copy) ButtonPressed action;

/** 点击逻辑Block存储在字典中 */
@property(nonatomic, strong) NSNumber *lastPressedTime;

/** 设置点击处理逻辑 */
- (void)setOnButtonPressedHandler:(ButtonPressed)block;

@end