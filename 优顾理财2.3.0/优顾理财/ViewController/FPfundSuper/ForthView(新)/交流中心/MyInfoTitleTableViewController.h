//
//  MyInfoTableViewController.h
//  优顾理财
//
//  Created by Yuemeng on 15/9/7.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "BaseTableViewController.h"
#import "BaseTitleViewController.h"

/**
 *  我的消息页面
 */
@interface MyInfoTableAdapter : BaseTableAdapter
@end

@interface MyInfoTableViewController : BaseTableViewController
@end

@interface MyInfoTitleTableViewController : BaseTitleViewController {
  MyInfoTableViewController *_tableVC;
}
@end
