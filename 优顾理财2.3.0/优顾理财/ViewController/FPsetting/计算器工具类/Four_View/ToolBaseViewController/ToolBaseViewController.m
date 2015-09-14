//
//  ToolBaseViewController.m
//  优顾理财
//
//  Created by Mac on 14/10/20.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "ToolBaseViewController.h"

@implementation ToolBaseViewController
@synthesize content_view;
@synthesize topNavView;
- (void)viewDidLoad {
  [super viewDidLoad];
  NSLog(@"\n-------------------\n%@ 已创建\n-------------------", self);
  topNavView = [[TopNavView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 50)];
  topNavView.mainLableString = @"无标题";
  topNavView.delegate = self;
  [self.view addSubview:topNavView];

  if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
    UIView *ios_7_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    ios_7_view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:ios_7_view];

    topNavView.frame = CGRectMake(0, 20, self.view.width, 50);

    content_view =
        [[UIScrollView alloc] initWithFrame:CGRectMake(0, 70, 320, self.view.frame.size.height - 70)];
    content_view.contentSize = CGSizeMake(self.view.width, 700);
    //    content_view=[[UIView alloc]initWithFrame:CGRectMake(0, 50,
    //    self.view.width, self.view.height-50)];
    [self.view addSubview:content_view];

    UITapGestureRecognizer *tap_scroll =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(tap_gesturerecongnizer:)];
    tap_scroll.delegate = self;
    [self.view addGestureRecognizer:tap_scroll];

  } else {
    content_view =
        [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, self.view.width, self.view.height - 50)];
    content_view.contentSize = CGSizeMake(self.view.width, 700);
    //    content_view=[[UIView alloc]initWithFrame:CGRectMake(0, 50,
    //    self.view.width, self.view.height-50)];
    [self.view addSubview:content_view];

    UITapGestureRecognizer *tap_scroll =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(tap_gesturerecongnizer:)];
    tap_scroll.delegate = self;
    [self.view addGestureRecognizer:tap_scroll];
  }

  self.view.backgroundColor = [Globle colorFromHexRGB:customBGColor];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [self.view endEditing:NO];
}

- (void)tap_gesturerecongnizer:(UITapGestureRecognizer *)sender {
  [self.view endEditing:NO];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch {
  if (![touch.view isKindOfClass:[UITextField class]]) {
    [self.view endEditing:NO];
  }
  return NO;
}

#pragma mark - NEWS_Nav_View 自定义导航条  按钮delegate 点击函数
- (void)leftButtonPress {
  [self.view endEditing:NO];
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
  NSLog(@"\n-------------------\n%@ 已经释放\n----------------", self);
}

@end
