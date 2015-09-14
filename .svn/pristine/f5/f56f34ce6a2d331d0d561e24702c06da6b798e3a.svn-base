//
//  UserDetailViewController.h
//  优顾理财
//
//  Created by Mac on 15/7/20.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPBaseViewController.h"
#import "UserHeaderView.h"
#import "UserHomeView.h"
#import "QATableViewController.h"
@interface UserDetailViewController : FPBaseViewController<UserHomeViewDelegate>

@property(nonatomic, strong) UserHeaderView * headerView;
@property(nonatomic, strong) UserHomeView * userHomeView;
@property(nonatomic, strong) UserListItem * userListItem;
///用户id
@property(nonatomic,strong) NSString * userId;
///向ta提问
@property(nonatomic,strong) clickLabel *Summit_btn;
@property(nonatomic,strong) UIScrollView * scrollView;

@property(nonatomic,strong) QATableViewController * questionVC;

- (id)initWithUserListItem:(UserListItem *)userlistItem;
@end
