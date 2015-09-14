//
//  my_ViewController.h
//  优顾理财
//
//  Created by Mac on 14-2-20.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface my_ViewController
    : UINavigationController <UINavigationControllerDelegate,
                              UIGestureRecognizerDelegate> {
  CGPoint startTouch; //拖动时的开始坐标
  BOOL isMoving;      //是否在拖动中
  UIView *blackMask;  //那层黑面罩
}
@property(nonatomic, retain) UIImageView *backgroundView;     //背景
@property(nonatomic, retain) NSMutableArray *screenShotsList; //存截图的数组

//拖动手势
- (void)handlePanGesture:(UIGestureRecognizer *)sender;
@end
