//
//  QuestionViewController.h
//  优顾理财
//
//  Created by Mac on 14-5-21.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//
#import "PullingRefreshTableView.h"
#import "Loading.h"
#import "LoadingView.h"
#import "UserLoadingView.h"
#import "BottomDefaultView.h"

@interface QuestionViewController
    : YGBaseViewController <PullingRefreshTableViewDelegate,
                            UITableViewDataSource, UITableViewDelegate,
                            LoadingView_delegate, UIAlertViewDelegate> {
  NSMutableArray *Cai_array_tableview;

  BOOL refrash_is_have;
  int num;
  PullingRefreshTableView *Cai_NEWS_Tableview;

  LoadingView *loading;
  /** 长按index */
  NSInteger longProcessIndex;
  /** 底部刷新控件 */
  BottomDefaultView *reloadingView;
}
@end
