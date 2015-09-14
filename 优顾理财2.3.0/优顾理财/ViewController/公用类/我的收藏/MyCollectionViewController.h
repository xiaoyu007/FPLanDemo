//
//  MyCollectionViewController.h
//  优顾理财
//
//  Created by Jhss on 15/8/21.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//
/** 我的收藏 */
#import "FPBaseViewController.h"
#import "DataArray.h"

@interface MyCollectionViewController
    : FPBaseViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, LoadingView_delegate> 

@property(nonatomic, retain) DataArray *dataArray;
@property(nonatomic, retain) UITableView *tableview;

@end
