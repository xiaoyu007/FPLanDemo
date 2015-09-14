//
//  FourForeignVC.m
//  优顾理财
//
//  Created by jhss on 15/8/31.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FourForeignVC.h"

//@interface FourForeignVC ()
//
//@end

@implementation FourForeignVC

- (void)viewDidLoad {
    [super viewDidLoad];
  self.topNavView.mainLableString = @"外汇兑换计算";
  
  [self createMainPage];
}
-(void)createMainPage{
  fourForeignVC = [[FourForegnViewController  alloc]initWithNibName:@"FourForegnViewController" bundle:nil];
  fourForeignVC.view.frame  = self.childView.bounds;
  [self.childView addSubview:fourForeignVC.view];

  
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
