//
//  DelegationViewController.m
//  优顾理财
//
//  Created by jhss on 15-4-3.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPDelegationViewController.h"

@implementation FPDelegationViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  //下面返回按钮返回
  UIImage *highLightImage = [FPYouguUtil createImageWithColor:buttonHighLightColor];
  [_backNameBtn setBackgroundImage:highLightImage forState:UIControlStateHighlighted];
  _backNameBtn.layer.cornerRadius = 19;
  _backNameBtn.layer.masksToBounds = YES;
}

@end
