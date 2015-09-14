//
//  UIButton+CustomButton.h
//  优顾理财
//
//  Created by Mac on 15-4-2.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CustomButton)
/** 圆环 + 文本高亮 */
- (void)setButtonHighlightStateWithTitleColor:(NSString *)titleColor;
/** 内部填充，标题白色 */
- (void)setButtonHighlightStateWithFilledColor:(NSString *)titleColor;

@end
