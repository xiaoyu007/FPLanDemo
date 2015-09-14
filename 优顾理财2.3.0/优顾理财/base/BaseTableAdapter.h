//
//  BaseTableAdapter.h
//  SimuStock
//
//  Created by Mac on 15/4/26.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataArray.h"

@class BaseTableViewController;

/**
 * 表格适配器，提供Table数据绑定的基类,子类可以实现heightForRowAtIndexPath和cellForRowAtIndexPath*/
@interface BaseTableAdapter
    : NSObject <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) DataArray *dataArray;

@property(nonatomic, weak) BaseTableViewController *baseTableViewController;

- (id)initWithTableViewController:
          (BaseTableViewController *)baseTableViewController
                    withDataArray:(DataArray *)dataList;

/** 返回TableViewCell的nib文件名称*/
- (NSString *)nibName;

@end
