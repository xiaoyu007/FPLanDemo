//
//  MyCommentViewController.h
//  优顾理财
//
//  Created by Mac on 15-4-9.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "YGBaseViewController.h"
#import "PullingRefreshTableView.h"
#import "LoadingView.h"
#import "BottomDefaultView.h"
/** 我的评论 */
@interface FPMyCommentViewController
    : YGBaseViewController <UITableViewDataSource, UITableViewDelegate,
                            PullingRefreshTableViewDelegate,
                            LoadingView_delegate> {
  /** 评论表格 */
  PullingRefreshTableView *myCommentTableview;
  BOOL refrash_is_have;
  /** 请求页数 */
  int pageNumber;
  /** 评论数据 */
  NSMutableArray *commentListArray;
  /** 底部刷新控件 */
  BottomDefaultView *reloadingView;
}

@end
