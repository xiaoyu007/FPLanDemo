//
//  AboutUsNewsViewController.m
//  优顾理财
//
//  Created by Mac on 15/8/6.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "AboutUsNewsViewController.h"
#import "AboutUsView.h"


@implementation AboutUsNewsViewController
- (void)viewDidLoad {
  [super viewDidLoad];
  self.topNavView.mainLableString = @"关于我们";
  self.childScrollView.contentSize = CGSizeMake(self.view.width,520);
  AboutUsView * aboutView = [[[NSBundle mainBundle] loadNibNamed:@"AboutUsView" owner:self options:nil]firstObject];
  [self.childScrollView addSubview:aboutView];
}
@end
