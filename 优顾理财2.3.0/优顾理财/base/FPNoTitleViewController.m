//
//  FPNoTitleViewController.m
//  优顾理财
//
//  Created by Mac on 15/6/29.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "NoNetWorkViewController.h"

@implementation FPNoTitleViewController
- (id)initWithFrame:(CGRect)frame {
  self = [super init];
  if (self) {
    self.rectFrame = frame;
  }
  return self;
}
-(id)init
{
  self =[super init];
  if (self) {
//    self.rectFrame = WINDOWUISCREEN;
  }
  return self;
}
- (void)viewDidLoad {
  if (self.rectFrame.size.height>0) {
    self.view.frame = self.rectFrame;
  }
  [super viewDidLoad];
  [self creatBaseView];
}
-(void)creatBaseView
{
  self.topNavView.hidden=YES;
  self.Ios7View.hidden=YES;
  self.childView.frame = self.view.frame;
  self.loading.frame = self.view.frame;
}
@end
