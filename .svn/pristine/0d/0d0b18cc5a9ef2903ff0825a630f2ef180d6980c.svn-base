//
//  FPBaseViewController.m
//  优顾理财
//
//  Created by Mac on 15/6/29.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPBaseViewController.h"
#import "NoNetWorkViewController.h"

@implementation FPBaseViewController

- (void)setRectFrame:(CGRect)rectFrame {
  self.view.frame = rectFrame;
}
- (id)init {
  self = [super init];
  if (self) {
  }
  return self;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  NSLog(@"\n-------------------\n%@ 已创建\n-------------------", self);
  if ([FPYouguUtil isIos7]) {
    [self creatIos7status];
  }
  //导航条
  CGRect topRect = CGRectMake(0, statusBarHeight, windowWidth, navigationHeght);
  self.topNavView = [[TopNavView alloc] initWithFrame:topRect];
  self.topNavView.mainLableString = @"默认导航标签";
  [self.topNavView setMainLableString:@"默认导航标签"];
  self.topNavView.delegate = self;
  [self.view addSubview:self.topNavView];

  CGRect childRect = CGRectMake(0, statusBarHeight + navigationHeght, windowWidth,
                                self.view.height - navigationHeght - statusBarHeight);
  _childView = [[UIView alloc] initWithFrame:childRect];
  _childView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin |
                                UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
  self.childView.backgroundColor = [UIColor clearColor];
  [self.view addSubview:_childView];
  _loading = [[LoadingView alloc] initWithFrame:childRect];
  _loading.delegate = self;
  _loading.hidden = YES;
  _loading.backgroundColor = [UIColor clearColor];
  _loading.userInteractionEnabled = YES;
  [self.view addSubview:_loading];

  [self.view bringSubviewToFront:self.topNavView];
}
- (void)refreshNewInfo {
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
- (void)setIsStatus:(BOOL)isStatus {
  if (isStatus) {
    CGRect childRect = CGRectMake(0, statusBarHeight, windowWidth, self.view.height - statusBarHeight);
    self.childView.frame = childRect;
    self.Ios7View.hidden = NO;
  } else {
    CGRect childRect = CGRectMake(0, 0, windowWidth, self.view.height);
    self.childView.frame = childRect;
    self.Ios7View.hidden = YES;
  }
  self.loading.frame = self.childView.frame;
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
- (void)dealloc {
  NSLog(@"\n-------------------\n%@ 已经释放\n----------------", self);
}
@end
