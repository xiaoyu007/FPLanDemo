//
//  MessageCenterViewController.h
//  优顾理财
//
//  Created by Mac on 14-7-7.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyQuestionViewController.h"
#import "PullingRefreshTableView.h"
@interface MessageCenterViewController
    : UIView <UITableViewDataSource, UITableViewDelegate,
              PullingRefreshTableViewDelegate> {
  PullingRefreshTableView *caiTableview;
  /** 头图视图 */
  NSMutableArray *caiPicArray;
  /** 请求数据 */
  NSMutableArray *caiTableviewArray;
  /** 是否需要更新，刷新时间 */
  BOOL refrashIsHave;
  /** 继续下载的数据，启示位置 */
  int requestIndex;
  /** 列表数据最后一条 */
  int lastRequestIndex;
}
@end
