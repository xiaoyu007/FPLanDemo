//
//  MyQuestionView.h
//  优顾理财
//
//  Created by Mac on 14-4-22.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyQuestionView : UIView {
  UIControl *_actionView;
  UIColor *_highlightedColor;

  UIImageView *img_View;
  UILabel *lable;
}
@property(nonatomic, retain) NSString *image_array;
@property(nonatomic, retain) NSString *title_array;
@property(nonatomic, retain) UIColor *highlightedColor;
@property(nonatomic, retain) UIColor *NormalbackgroundColor;
@property(nonatomic, retain) UIImageView *img_View;
@property(nonatomic, retain) UILabel *lable;

- (id)initWithFrame:(CGRect)frame
         andArray_1:(NSString *)img_array
         andArray_2:(NSString *)tit_array;
- (void)addTarget:(id)target action:(SEL)action;
@end
