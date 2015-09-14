//
//  RedemDelegationViewController.m
//  优顾理财
//
//  Created by jhss on 15-4-7.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPRedemDelegationViewController.h"

@implementation FPRedemDelegationViewController
- (void)viewDidLoad {
  [super viewDidLoad];
  ///产品名称
  _productNameLabel.text = _productName;
  CGSize nameSize = [_productNameLabel.text sizeWithFont:[UIFont systemFontOfSize:15.0f]
                                       constrainedToSize:CGSizeMake(windowWidth - 95.0f, 100)];
  _productNameLabel.height = nameSize.height + 2.0f;
  _productNameLabel.numberOfLines = 0;
  //返回按钮
  _backBtn.layer.cornerRadius = 18.5;
  _backBtn.layer.masksToBounds = YES;

  UIImage *highlightImage = [FPYouguUtil createImageWithColor:buttonHighLightColor];
  [_backBtn setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
}
@end
