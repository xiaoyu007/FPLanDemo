//
//  FPBaseScrollViewController.m
//  优顾理财
//
//  Created by Mac on 15/8/5.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPBaseScrollViewController.h"
#import "NoNetWorkViewController.h"

@implementation FPBaseScrollViewController
- (void)setRectFrame:(CGRect)rectFrame {
  self.view.frame = rectFrame;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  // Do any additional setup after loading the view.
  //导航条
  self.topNavView = [[TopNavView alloc] initWithFrame:CGRectMake(0, 0, windowWidth, navigationHeght)];
  self.topNavView.mainLableString = @"默认导航标签";
  [self.topNavView setMainLableString:@"默认导航标签"];
  self.topNavView.delegate = self;
  [self.view addSubview:self.topNavView];

  _childScrollView =
      [[UIScrollView alloc] initWithFrame:CGRectMake(0, navigationHeght, windowWidth, self.view.height - navigationHeght)];
  self.childScrollView.backgroundColor = [UIColor clearColor];
  [self.view addSubview:self.childScrollView];
  if ([FPYouguUtil isIos7]) {
    [self creatIos7status];
    self.topNavView.top = 20;
    self.childScrollView.top = 20 + navigationHeght;
    self.childScrollView.height = self.view.height - navigationHeght - 20;
  }

  _loading = [[LoadingView alloc] initWithFrame:self.view.bounds];
  _loading.delegate = self;
  _loading.hidden = YES;
  _loading.userInteractionEnabled = YES;
  [self.view addSubview:_loading];
}
-(void)refreshNewInfo
{
  NSLog(@"无网络点击，重新刷新数据");
}
- (void)InfoManagementBtnClick {
  NoNetWorkViewController *defautVC = [[NoNetWorkViewController alloc] init];
  [AppDelegate pushViewControllerFromRight:defautVC];
}
- (void)creatIos7status {
  if (!_Ios7View) {
    //在ios7以上版本主背景界面
    _Ios7View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowWidth, statusBarHeight)];
    _Ios7View.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_Ios7View];
  }
}
- (void)viewDidAppear:(BOOL)animated {
  [self setExclusiveTouchForButtons:self.view];
  [super viewDidAppear:animated];
}
- (void)setExclusiveTouchForButtons:(UIView *)myView {
  for (UIView *v in [myView subviews]) {
    if ([v isKindOfClass:[UIButton class]])
      [((UIButton *)v)setExclusiveTouch:YES];
    else if ([v isKindOfClass:[UIView class]]) {
      [self setExclusiveTouchForButtons:v];
    }
  }
}

- (void)leftButtonPress {
  [AppDelegate popViewController:YES];
}
@end
