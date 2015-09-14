//
//  BaseTitleViewController.m
//  优顾理财
//
//  Created by Yuemeng on 15/9/7.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "BaseTitleViewController.h"

@implementation BaseTitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //在ios7以上版本主背景界面
    if (isIos7Version) {
        UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowWidth, statusBarHeight)];
        blackView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:blackView];
    }
    
    //导航栏
    CGRect topRect = CGRectMake(0, statusBarHeight, windowWidth, navigationHeght);
    _topNavView = [[TopNavView alloc] initWithFrame:topRect];
    _topNavView.mainLableString = @"默认导航标签";
    [_topNavView setMainLableString:@"默认导航标签"];
    _topNavView.delegate = self;
    [self.view addSubview:_topNavView];
    
    //子视图承载区
    _clientView = [[UIView alloc] initWithFrame:CGRectMake(0, _topNavView.bottom, self.view.width, self.view.height - navigationHeght - statusBarHeight)];
    _clientView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_clientView];
}

- (void)leftButtonPress {
    [AppDelegate popViewController:YES];
}

@end
