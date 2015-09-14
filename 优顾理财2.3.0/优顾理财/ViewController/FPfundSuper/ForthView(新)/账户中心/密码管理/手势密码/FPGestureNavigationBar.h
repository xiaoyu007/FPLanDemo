//
//  GestureNavigationBar.h
//  优顾理财
//
//  Created by Mac on 15-5-4.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FPGestureNavigationBar : UIView
/** 返回按钮 */
@property(weak, nonatomic) IBOutlet UIButton *backButton;
/** 标题 */
@property(weak, nonatomic) IBOutlet UILabel *pageTitleLabel;

@end
