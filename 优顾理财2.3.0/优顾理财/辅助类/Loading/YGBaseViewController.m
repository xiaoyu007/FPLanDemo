//
//  YGBaseViewController.m
//  优顾理财
//
//  Created by Mac on 15/2/11.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

@implementation YGBaseViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  NSLog(@"\n-------------------\n%@ 已创建\n-------------------", self);
  if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
    //在ios7以上版本主背景界面
    UIView *ios7View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowWidth, statusBarHeight)];
    ios7View.backgroundColor = [UIColor blackColor];
    [self.view addSubview:ios7View];
    _childView =
        [[UIView alloc] initWithFrame:CGRectMake(0, statusBarHeight, windowWidth, windowHeight - statusBarHeight)];
    [self.view addSubview:_childView];
  } else {
    //在ios7以下版本运行主界面
    _childView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowWidth, self.view.height)];
    [self.view addSubview:_childView];
  }
  _childView.backgroundColor = [Globle colorFromHexRGB:customBGColor];
  //控件越界问题
  self.childView.clipsToBounds = YES;
  //导航条
  self.topNavView = [[TopNavView alloc] initWithFrame:CGRectMake(0, 0, windowWidth, navigationHeght)];
  self.topNavView.mainLableString = @"默认导航标签";
  [self.topNavView setMainLableString:@"默认导航标签"];
  self.topNavView.delegate = self;
  self.topNavView.hidden = YES;
  [self.childView addSubview:self.topNavView];
  self.view.backgroundColor = [UIColor whiteColor];
  self.childView.backgroundColor = [UIColor clearColor];
}
/** 设置导航栏标题 */
- (void)CreatNavBarWithTitle:(NSString *)titleName {
  if (titleName && [titleName length] > 0) {
    self.topNavView.hidden = NO;
    self.topNavView.mainLableString = titleName;
    self.topNavView.mainLable.frame = CGRectMake(50, 0, self.view.size.width - 100, 50);
    self.topNavView.mainLable.textAlignment = NSTextAlignmentCenter;
  }
}

- (void)leftButtonPress {
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
  NSLog(@"\n-------------------\n%@ 已经释放\n----------------", self);
}

@end
