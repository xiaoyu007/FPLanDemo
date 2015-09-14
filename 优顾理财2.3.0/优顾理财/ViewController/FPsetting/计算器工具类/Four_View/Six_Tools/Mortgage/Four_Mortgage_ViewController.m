//
//  Four_Mortgage_ViewController.m
//  优顾理财
//
//  Created by Mac on 14/10/20.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//  房贷

#import "Four_Mortgage_ViewController.h"
#import "YG_Four_QC_ScrollView.h"


@implementation Four_Mortgage_ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  [self.topNavView setLineView];
  [self.topNavView setMainLableString:@"房贷"];
  self.content_view.contentSize =
      CGSizeMake(self.view.width, self.content_view.height);

  YG_Four_QC_ScrollView *qc_view =
      [[YG_Four_QC_ScrollView alloc] initWithFrame:self.content_view.bounds];
  qc_view.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin |
      UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight;
  [content_view addSubview:qc_view];
}



@end
