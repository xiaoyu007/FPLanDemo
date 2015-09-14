//
//  FPMainViewController1.h
//  优顾理财
//
//  Created by Mac on 15/7/27.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPNoTitleViewController.h"
#import "simuBottomToolBarView.h"
@interface FPMainViewController : FPNoTitleViewController<simuBottomToolBarViewDelegate>
{
  SimuBottomToolBarView * simubottomToolBarview;
  ///当前选中的界面
  NSInteger page_Type;
  ///当前页面的子页面
  NSMutableDictionary *viewControllers;
  NSTimer *iKLTimer;
}
///行情数据
@property(nonatomic,strong)NSMutableArray * MarketArray;
@end
