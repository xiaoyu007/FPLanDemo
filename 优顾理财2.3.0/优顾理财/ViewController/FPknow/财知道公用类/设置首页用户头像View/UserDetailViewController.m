//
//  UserDetailViewController.m
//  优顾理财
//
//  Created by Mac on 15/7/20.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "UserDetailViewController.h"
#import "FindQusetionVC.h"
#import "QATableViewController.h"
#import "UserInfoViewController.h"
@interface UserDetailViewController () <QATableViewControllerDelegate, UserHeaderViewDelegate>

@end

@implementation UserDetailViewController
- (id)initWithUserListItem:(UserListItem *)userlistItem {
  self = [super init];
  if (self) {
    self.userId = userlistItem.userId;
    self.userListItem = userlistItem;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  self.loading.hidden = YES;

  _userHomeView =
      [[[NSBundle mainBundle] loadNibNamed:@"UserHomeView" owner:self options:nil] firstObject];
  _userHomeView.frame = self.childView.bounds;
  _userHomeView.delegate = self;
  [self.childView addSubview:_userHomeView];

  _headerView = [[UserHeaderView alloc] initWithFrame:CGRectMake(0, 0, windowWidth, 75.0f)];
  [_headerView setValue:self.userListItem];
  [self.childView addSubview:_headerView];

  if ([_userId isEqualToString:YouGu_User_USerid]) {
    self.topNavView.mainLableString = @"我的主页";
    _headerView.isClick = YES;
    _headerView.delegate = self;
    _headerView.userInteractionEnabled = YES;
  } else {
    self.topNavView.mainLableString = @"TA的主页";
    _headerView.isClick = NO;
    _headerView.userInteractionEnabled = NO;
    _Summit_btn = [[clickLabel alloc] initWithFrame:CGRectMake(windowWidth - 100.0f, 0, 100.0f, 50)];
    _Summit_btn.font = [UIFont systemFontOfSize:18];
    _Summit_btn.textAlignment = NSTextAlignmentCenter;
    _Summit_btn.text = @"向TA提问";
    _Summit_btn.backgroundColor = [UIColor clearColor];
    _Summit_btn.textColor = [Globle colorFromHexRGB:customFilledColor];
    _Summit_btn.highlightedColor = [Globle colorFromHexRGB:customFilledColor];
    [_Summit_btn addTarget:self action:@selector(Summit_btn_click:)];
    [self.topNavView addSubview:_Summit_btn];
  }
  [self creatScrollView];
}

#pragma 用户头像点击 delegate
- (void)USerPicBtnClick {
  [Login_ViewController checkLoginStatusWithCallback:^(BOOL logonSuccess) {
    if (logonSuccess) {
      UserInfoViewController *USer_Mod = [[UserInfoViewController alloc] init];
      [AppDelegate pushViewControllerFromRight:USer_Mod];
    }
  }];
}

- (void)Summit_btn_click:(UIView *)sender {
  [Login_ViewController checkLoginStatusWithCallback:^(BOOL logonSuccess) {
    if (logonSuccess) {
      FindQusetionVC *find_to_ta_question = [[FindQusetionVC alloc] initWithBlock:^(BOOL success) {
        if (success) {
          if (self.questionVC) {
            [self.questionVC refreshNewInfo];
          }
        }
      }];
      find_to_ta_question.item = self.userListItem;
      [AppDelegate pushViewControllerFromRight:find_to_ta_question];
    }
  }];
}
#pragma mark - UIscrollview
- (void)creatScrollView {
  _scrollView =
      [[UIScrollView alloc] initWithFrame:CGRectMake(0, 144, _userHomeView.width, self.userHomeView.height - 144)];
  _scrollView.pagingEnabled = YES;
  _scrollView.scrollEnabled = NO;
  _scrollView.contentSize = CGSizeMake(self.view.width * 2, _userHomeView.height - 144);
  [_userHomeView addSubview:_scrollView];
  _scrollView.contentOffset = CGPointMake(0, 0);
  
  for (int i = 0; i < 2; i++) {
    QATableViewController *qaVC =
    [[QATableViewController alloc] initWithFrame:CGRectMake(0, 0, _userHomeView.width, _scrollView.height)
                                       andQAType:(QAUserListType)i];
    qaVC.delegate = self;
    qaVC.userId = self.userListItem.userId;
    qaVC.view.frame = CGRectMake(self.view.width * i, 0, _userHomeView.width, _scrollView.height);
    if (i == 0) {
      self.questionVC = qaVC;
    }
    [self addChildViewController:qaVC];
    [_scrollView addSubview:qaVC.view];
  }
}

- (void)getArrayNum:(NSInteger)num andUserSign:(NSString *)sign andtype:(QAUserListType)type {
  if (num > 0) { //签名
    if (sign.length > 0) {
      self.headerView.signLable.text = sign;
    } else {
      self.headerView.signLable.text = @"该用户正在构思一个伟大的签名";
    }
  }
  if (type == QATypeMyQuestion) {
    [self.userHomeView.qtBtn setTitle:[NSString stringWithFormat:@"提问（%ld）", num]
                             forState:UIControlStateNormal];
  } else {
    [self.userHomeView.awBtn setTitle:[NSString stringWithFormat:@"回答（%ld）", num]
                             forState:UIControlStateNormal];
  }
}
- (void)selectHomeBtnClick:(NSInteger)index {
  _scrollView.contentOffset = CGPointMake(self.view.width * index, 0);
}
@end
