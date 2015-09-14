//
//  FPBaseScrollViewController.h
//  优顾理财
//
//  Created by Mac on 15/8/5.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopNavView.h"
#import "LoadingView.h"
@interface FPBaseScrollViewController : UIViewController<TopNavViewDelegate,LoadingView_delegate>
@property(nonatomic, strong) UIScrollView *childScrollView;
@property(nonatomic) CGRect  defaultFrame;
@property(nonatomic, strong) TopNavView *topNavView;
@property(nonatomic, strong) UIView * Ios7View;
@property(nonatomic) BOOL isStatus;
///正在加载loading
@property(nonatomic, strong) LoadingView *loading;
/**
 *  界面返回
 */
-(void)leftButtonPress;
///无网络重新刷新数据
-(void)refreshNewInfo;
@end
