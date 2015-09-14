//
//  BaseTableAdapter.m
//  SimuStock
//
//  Created by Mac on 15/4/26.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "BaseTableAdapter.h"
#import "BaseTableViewController.h"

@implementation BaseTableAdapter

- (id)initWithTableViewController:
          (BaseTableViewController *)baseTableViewController
                    withDataArray:(DataArray *)dataList {
  if (self = [super init]) {
    _dataArray = dataList;
    _baseTableViewController = baseTableViewController;
  }
  return self;
}

/** 默认返回一个section */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

/** 默认返回数组的长度 */
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return _dataArray.array.count;
}

/** 子类必须实现的方法 */
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSException *ex =
      [NSException exceptionWithName:@"not implement exception"
                              reason:@"[tableView:cellForRowAtIndexPath:] "
                              @"method is not implemented"
                            userInfo:nil];
  [ex raise];
  return nil;
}

/** 子类必须实现的方法 */
- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSException *ex =
      [NSException exceptionWithName:@"not implement exception"
                              reason:@"[tableView:heightForRowAtIndexPath:] "
                              @"method is not implemented"
                            userInfo:nil];
  [ex raise];
  return 0.0f;
}

- (NSString *)nibName {
  return @"";
}

/** 当显示最后一行数据时，自动加载下一页 */
- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (_baseTableViewController == nil ||
      ![_baseTableViewController supportAutoLoadMore]) {
    return;
  }
  
  if (indexPath.row ==
      [self tableView:tableView numberOfRowsInSection:indexPath.section] -
          1) { //显示最后一行

    NSArray *indexes = [tableView indexPathsForVisibleRows];
    if (indexes && indexes.count > 0) {
      NSIndexPath *firstRow = indexes[0];
      if (firstRow.row == 0) {
        //如果第一行和最后一行都显示了，不自动加载，让用户手动加载吧
        return;
      }
    }

    if (_dataArray.dataComplete) {
      return;
    }

    //滑动至数据的最后一条时，加载下一页
    NSLog(@"loadNextPage");
    if (_baseTableViewController) {
      [_baseTableViewController
          requestResponseWithRefreshType:RefreshTypeLoaderMore];
    }
  }
}

@end
