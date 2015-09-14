//
//  ZKControl.h
//  01-爱限免-框架
//
//  Created by zhaokai on 15-1-6.
//  Copyright (c) 2015年 zhaokai. All rights reserved.
//

#import <Foundation/Foundation.h>
@class myButton;
typedef void (^block)(myButton *button);
@interface myButton : UIButton
+ (myButton *)buttonWithFrame:(CGRect)frame
                         font:(int)size
                        title:(NSString *)title
                         type:(UIButtonType)type
                        image:(NSString *)image
                selectedImage:(NSString *)selectedImage
                     andBlock:(block)myBlock;
@end

@interface UIImageView (ZKControl)
+ (UIImageView *)imageViewWithFrame:(CGRect)frame image:(NSString *)image;
@end

@interface UILabel (ZKControl)
+ (UILabel *)labelWithFrame:(CGRect)frame
                      title:(NSString *)title
                       font:(int)size;

+ (UILabel *)boldLabelWithFrame:(CGRect)frame
                          title:(NSString *)title
                           font:(int)size;
@end