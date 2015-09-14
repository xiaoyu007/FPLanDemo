//
//  ZKControl.m
//  01-爱限免-框架
//
//  Created by zhaokai on 15-1-6.
//  Copyright (c) 2015年 zhaokai. All rights reserved.
//

#import "ZKControl.h"
@interface myButton ()
@property(nonatomic, copy) block tempBlock;
@end

@implementation myButton
+ (myButton *)buttonWithFrame:(CGRect)frame
                         font:(int)size
                        title:(NSString *)title
                         type:(UIButtonType)type
                        image:(NSString *)image
                selectedImage:(NSString *)selectedImage
                     andBlock:(block)myBlock {

  myButton *button = [myButton buttonWithType:type];
  button.frame = frame;
  //设置字体颜色
  [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
  [button setTitle:title forState:UIControlStateNormal];
  [button.titleLabel setFont:[UIFont systemFontOfSize:size]];
  //    //设置背景图片
  //    [button setBackgroundImage:[UIImage imageNamed:backgroundImage]
  //    forState:UIControlStateNormal];
  //设置图片
  [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
  button.selected = YES;
  [button setImage:[UIImage imageNamed:selectedImage]
          forState:UIControlStateSelected];
  //添加方法
  [button addTarget:button
                action:@selector(buttonClicked:)
      forControlEvents:UIControlEventTouchUpInside];

  button.tempBlock = myBlock;

  return button;
}
- (void)buttonClicked:(myButton *)button {
  button.tempBlock(button);
}
@end




@implementation UIImageView (ZKControl)

+ (UIImageView *)imageViewWithFrame:(CGRect)frame image:(NSString *)image {
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];

  imageView.image = [UIImage imageNamed:image];

  return imageView;
}

@end

@implementation UILabel (ZKControl)

+ (UILabel *)labelWithFrame:(CGRect)frame
                      title:(NSString *)title
                       font:(int)size {
  UILabel *label = [[UILabel alloc] initWithFrame:frame];

  label.text = title;

  label.font = [UIFont systemFontOfSize:size];

  return label;
}

+ (UILabel *)boldLabelWithFrame:(CGRect)frame
                          title:(NSString *)title
                           font:(int)size {
  UILabel *label = [[UILabel alloc] initWithFrame:frame];

  label.text = title;

  label.font = [UIFont boldSystemFontOfSize:size];

  return label;
}

@end
