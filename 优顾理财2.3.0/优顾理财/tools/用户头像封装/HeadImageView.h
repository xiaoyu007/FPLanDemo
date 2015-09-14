//
//  HeadImageView.h
//  优顾理财
//
//  Created by Mac on 15-4-15.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadImageView : UIView {
  /** 加V图标 */
  UIImageView *vipImageView;
}
@property(nonatomic, strong) UIImageView *headImageView;

//刷新头像的图片
- (void)refreshHeadImageStr:(NSString *)urlstring;
//改变头像的大小
- (void)changeImageViewFrame:(CGRect)frame;
//判断，是否是，加V,用户
- (void)ishasVtype:(int)is_not;

/** 有边框 */
- (void)haveBorderWithBorderColor:(NSString *)bordrColor;
/** 无边框 */
- (void)withoutBorder;

@end
