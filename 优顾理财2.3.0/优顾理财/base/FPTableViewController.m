//
//  FPTableViewController.m
//  优顾理财
//
//  Created by Mac on 15/8/7.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPTableViewController.h"
#import "FPNoTitleBaseTableViewController.h"

@implementation FPTableViewController
- (void)viewDidLoad {
  [super viewDidLoad];
}
-(void)creatBaseView
{
}
-(void)creatBaseTableView
{
//  self.isStatus = NO;
  // Do any additional setup after loading the view from its nib.
  CGRect rect = self.childView.bounds;
  self.refrashIndex = 0;
  //资讯新闻页下方的新闻标题
  self.dataArray = [[DataArray alloc] init];
  self.tableView =
  [[PullingRefreshTableView alloc] initWithFrame:rect
                                 pullingDelegate:self
                                   andRefresh_id:self.RefreshLable];
  self.tableView.backgroundColor = [UIColor clearColor];
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  [self.childView addSubview:self.tableView];
}
@end
