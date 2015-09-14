//
//  FPBaseTableViewController.h
//  优顾理财
//
//  Created by Mac on 15/7/8.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPNoTitleViewController.h"
#import "PullingRefreshTableView.h"
@interface FPBaseTableViewController : FPNoTitleViewController<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate,PullingRefreshTableViewDelegate>

@property(nonatomic, strong) PullingRefreshTableView * tableView;
///tableview，相关数据
@property(nonatomic, strong) NSMutableArray * mainArray;
/**是否网络请求成功 */
@property(nonatomic, assign) BOOL isSuccess;
///刷新
@property(nonatomic, strong) NSString * RefreshLable;
- (id)initWithFrame:(CGRect)frame
    AndRefreshLable:(NSString *)labletext;

#pragma mark - 数据上啦，下拉 加载
- (void)loadData_Start;
- (void)loadData_End;
@end
