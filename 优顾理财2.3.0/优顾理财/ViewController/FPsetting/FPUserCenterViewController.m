//
//  FPUserCenterViewController.m
//  优顾理财
//
//  Created by Mac on 15/8/27.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPUserCenterViewController.h"
#import "CatalogCell.h"
#import "UserCenterInfo.h"

@interface FPUserCenterViewController ()

@end

@implementation FPUserCenterViewController
//- (id)initWithFrame:(CGRect)frame {
//  self = [super initWithFrame:frame];
//  if (self) {
//  }
//  return self;
//}
- (void)viewDidLoad {
  [super viewDidLoad];
  [self createHeadView];
  [self refreshHeadInfo];
  [self refreshTableview];
}
#pragma mark - 刷新用户信息
- (void)createHeadView{
  headVC = [[UserCenterHeadVC alloc]initWithNibName:@"UserCenterHeadVC" bundle:nil];
}
- (void)refreshHeadInfo {
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  HttpRequestCallBack *callback = [[HttpRequestCallBack alloc] init];
  __weak FPUserCenterViewController *weakSelf = self;
  callback.onCheckQuitOrStopProgressBar = ^{
    FPUserCenterViewController *strongSelf = weakSelf;
    if (strongSelf) {
      return NO;
    } else {
      return YES;
    }
  };
  callback.onSuccess = ^(NSObject *obj) {
    FPUserCenterViewController *strongSelf = weakSelf;
    if (strongSelf) {
      UserCenterInfo *userInfo = (UserCenterInfo *)obj;
      [strongSelf refreshUserCenterWithUserCenterInfo:userInfo];
    }
  };
  [UserCenterInfo sendUserCenterRequestWithCallback:callback];
}
- (void)refreshUserCenterWithUserCenterInfo:(UserCenterInfo *)info{
  
}
- (IBAction)headImageButtonClicked:(id)sender {
}

- (IBAction)userInfoButtonClicked:(id)sender {
}

- (IBAction)refreshButtonClicked:(id)sender {
  [self refreshHeadInfo];
}
#pragma mark - 目录页
- (void)refreshTableview {
  _catalogTableview.delegate = self;
  _catalogTableview.dataSource = self;

  [_catalogTableview setTableHeaderView:headVC.view];
  [self registerNibCell];
  catalogArray = @[@"工具箱", @"我收藏的文章", @"我的钻石", @"设置" ];
  [_catalogTableview reloadData];
}
#pragma mark - cell注册
- (void)registerNibCell {
  UINib *cellNib = [UINib nibWithNibName:NSStringFromClass([CatalogCell class]) bundle:nil];
  [self.catalogTableview registerNib:cellNib forCellReuseIdentifier:@"CatalogCell"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [catalogArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 40.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  CatalogCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CatalogCell"];
  cell.catalogNameLabel.text = [catalogArray objectAtIndex:indexPath.row];
  return cell;
}

@end
