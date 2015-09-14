//
//  YL_SelectionButton.h
//  优顾理财
//
//  Created by Mac on 14/12/18.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YL_SelectionButton_delegate <NSObject>
@optional
///你选择第几个按钮
- (void)selection_btn:(int)row;
@end

@interface YL_SelectionButton : UIView {
  UILabel *city_lable_first;
}
///代理方法，当按钮被点击的时候
@property(nonatomic, assign) id<YL_SelectionButton_delegate> delegate;
///记入标签文本
@property(nonatomic, retain) NSMutableArray *mainArray;

/// 记入当前选择的是第几个按钮
@property(nonatomic, assign) NSInteger row;

- (id)initWithFrame:(CGRect)frame
           andTitle:(NSString *)title
            andType:(int)type
           andArray:(NSArray *)array;

///恢复初始化
- (void)my_init_btn;
@end
