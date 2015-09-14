//
//  KnowFirstListViewController.h
//  优顾理财
//
//  Created by Mac on 15/8/9.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPNoTitleBaseTableViewController.h"
#import "BaseTableViewController.h"

typedef enum {
  NEWListViewController = 0, /// 最新列表
  RotPointViewController = 1 ///热点列表
} KnowFirstListType;

/*
 *  财知道里最新、热点列表 （⚠️已废弃！）
 */
@interface KnowFirstListViewController : FPNoTitleBaseTableViewController {
  KnowFirstListType type;

  UIColor *color_Normal;
  UIColor *color_Selected;
}

- (id)initWithFrame:(CGRect)frame AndStart:(KnowFirstListType)state;

@end
