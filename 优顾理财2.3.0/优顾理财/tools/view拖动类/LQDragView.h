//
//  LQDragView.h
//  优顾理财
//
//  Created by Mac on 15-4-26.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LQDragView;
@protocol LQDragViewDelegate <NSObject>
@optional

- (void)dragViewDidBeginDragging:(LQDragView *)dragView;

- (void)dragViewDidDragging:(LQDragView *)dragView;

- (void)dragViewDidEndDragging:(LQDragView *)dragView
                  withVelocity:(CGPoint)velocity
           targetContentOffset:(CGFloat)targetContentOffset;

- (void)dragViewDidEndScrollingAnimation:(LQDragView *)dragView;

@end

/**
 *  view控件上添加拖动功能
 */
@interface LQDragView : UIView

@property(nonatomic, weak) id<LQDragViewDelegate> delegate;
/** 收缩后frame */
@property(nonatomic, assign) CGRect upRect;
/** 扩展后frame */
@property(nonatomic, assign) CGRect downRect;
/** 当前frame */
@property(nonatomic, assign) CGRect currentRect;
#if 0
/**
 *  images for dragView
 */
@property (nonatomic, strong)NSArray *images;

@property (nonatomic, assign)NSInteger currentIndex;

@property (nonatomic, weak)UIImageView *currentImageView;

/**
 *  @param images 存放UIImage(图片)或者NSString(图片名称)
 */
- (instancetype)initWithFrame:(CGRect)frame andImages:(NSArray *)images;

+ (instancetype)dragViewWithFrame:(CGRect)frame andImages:(NSArray *)images;
#endif
@end
