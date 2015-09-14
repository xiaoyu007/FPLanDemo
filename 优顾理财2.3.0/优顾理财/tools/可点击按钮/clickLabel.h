//
//  Click_Label.h
//  优顾理财
//
//  Created by Mac on 14-3-21.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface clickLabel : UILabel
{
  UIControl *_actionView;
  UIColor *_highlightedColor;
  UIImageView *imgView;
  UIColor *normalTextColor;
}

@property(nonatomic, strong) UIColor *highlightedColor;
@property(nonatomic, strong) UIColor *NormalbackgroundColor;
@property(nonatomic, strong) UIImageView *imgView;
@property(nonatomic, strong) UIColor *normalTextColor;
@property(nonatomic, strong) UIColor *imgHighlightedColor;

- (void)setImg_View:(UIImage *)img andFrame:(CGRect)frame;
- (void)setText:(NSString *)text andCenter:(CGPoint)center;
- (void)addTarget:(id)target action:(SEL)action;
//专题名字过长，调整
- (void)adject_title_label_1:(NSString *)text;

@end
