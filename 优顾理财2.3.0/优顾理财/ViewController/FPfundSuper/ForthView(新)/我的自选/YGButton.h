//
//  YGButton.h
//  优顾理财
//
//  Created by Mac on 15/3/25.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//
/*
 功能介绍：该类重写了系统的UIButton，方便了该工程中对黄色背景、按钮左侧有“＋”号、圆角特征BUtton的直接调用
 实现原理：继承系统UIbutton，在初始化方法中添加有股理财主色调的黄色背景、添加两个白色背景view形成“＋”，设置圆角
 */
#import <UIKit/UIKit.h>

@interface YGButton : UIButton

@property(nonatomic, strong) UIView *horizontalView;
@property(nonatomic, strong) UIView *verticalView;

@end
