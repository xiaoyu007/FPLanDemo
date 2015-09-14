//
//  KnowFirstTableViewController.h
//  优顾理财
//
//  Created by Yuemeng on 15/9/6.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "BaseTableViewController.h"

typedef enum {
  NEWListViewController = 0, /// 最新列表
  RotPointViewController = 1 ///热点列表
} KnowFirstListType;

/*
 *  财知道里最新、热点列表
 */
@interface KnowFirstTableAdapter : BaseTableAdapter

@end

@interface KnowFirstTableViewController : BaseTableViewController {
  KnowFirstListType type;
}


- (id)initWithFrame:(CGRect)frame AndStart:(KnowFirstListType)state;

@end
