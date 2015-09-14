//
//  FPBaseViewController.h
//  优顾理财
//
//  Created by Mac on 15/6/29.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopNavView.h"
#import "LoadingView.h"
@interface FPBaseViewController : UIViewController<TopNavViewDelegate,LoadingView_delegate>
@property(nonatomic, strong) UIView *childView;
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
/**复写父类view的frame*/
-(void)isTopView;
@end
