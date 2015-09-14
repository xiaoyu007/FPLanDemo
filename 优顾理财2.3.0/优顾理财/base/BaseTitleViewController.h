//
//  BaseTitleViewController.h
//  优顾理财
//
//  Created by Yuemeng on 15/9/7.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "TopNavView.h"

/**
 *  带标题的tableViewController基类
 */
@interface BaseTitleViewController : UIViewController<TopNavViewDelegate>

@property(nonatomic, strong) TopNavView *topNavView;
@property(nonatomic, strong) UIView *clientView;

@end
