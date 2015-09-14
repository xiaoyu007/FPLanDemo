//
//  CommunicationCenterViewController.m
//  优顾理财
//
//  Created by Mac on 15/3/20.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

/*
 该类是交流中心页面的控制器类，负责控制tableView和cell的展示和行为控制
 */

#import "FPCommunicationCenterViewController.h"
#import "FPCommunicationCenterTableViewCell.h"
//#import "QATotalViewController.h""
#import "QATotalTitleTableViewController.h"
#import "FPReplyMeViewController.h"
//#import "FPMyInfoViewController.h"
#import "MyInfoTitleTableViewController.h"

#define tableviewCellHeight 64.0f
#define tableviewHeadHeight 25.0f

@implementation FPCommunicationCenterViewController
- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [commuTableview reloadData];
}
- (void)viewDidLoad {
  [super viewDidLoad];
  self.topNavView.mainLableString = @"交流中心";
  self.loading.hidden = YES;
  [self createTableview];
  [self loadData];
}
/** 创建表格 */
- (void)createTableview {
  commuTableview = [[UITableView alloc] initWithFrame:self.childView.bounds];
  commuTableview.dataSource = self;
  commuTableview.delegate = self;
  commuTableview.backgroundColor = [UIColor clearColor];
  commuTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
  [self.childView addSubview:commuTableview];
  //去除多余的分割线
  [commuTableview setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
  [self registerNibCell];
}

#pragma mark - 注册NibCell
- (void)registerNibCell {
  UINib *cellNib =
      [UINib nibWithNibName:NSStringFromClass(
                                [FPCommunicationCenterTableViewCell class])
                     bundle:nil];
  [commuTableview registerNib:cellNib
       forCellReuseIdentifier:@"FPCommunicationCenterTableViewCell"];
}

/** 加载表格数据 */
- (void)loadData {
  dataArray = @[ @[ @"我的提问", @"我的回答", @"我的消息" ], @[ @"我的评论" ] ];
  imageArray = @[
    @[ @"我的提问小图标",
       @"我的回答小图标",
       @"我的消息小图标" ],
    @[ @"我的评论小图标" ]
  ];
  bgColorArray =
      @[ @[ @"f6786f", @"5eaeff", @"f7ad41" ], @[ @"57d4d6" ] ]; // @"ff94c1",
}
#pragma mark -tableView的代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [dataArray count];
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return [dataArray[section] count];
}
- (UIView *)tableView:(UITableView *)tableView
    viewForHeaderInSection:(NSInteger)section {
  UIView *sectionView =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowWidth, 25.0f)];
  sectionView.backgroundColor = [Globle colorFromHexRGB:@"f2f3f3"];

  UILabel *sectionNameLabel =
      [[UILabel alloc] initWithFrame:CGRectMake(17, 5, 100, 13)];
  sectionNameLabel.backgroundColor = [UIColor clearColor];
  sectionNameLabel.textAlignment = NSTextAlignmentLeft;
  sectionNameLabel.font = [UIFont systemFontOfSize:13.0f];
  sectionNameLabel.textColor = [Globle colorFromHexRGB:@"84929e"];
  if (section == 0) {
    sectionNameLabel.text = @"财知道";
  } else {
    sectionNameLabel.text = @"文章评论";
  }
  [sectionView addSubview:sectionNameLabel];
  return sectionView;
}
- (CGFloat)tableView:(UITableView *)tableView
    heightForHeaderInSection:(NSInteger)section {
  return tableviewHeadHeight;
}
- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return tableviewCellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellId = @"FPCommunicationCenterTableViewCell";
  FPCommunicationCenterTableViewCell *cell =
      (FPCommunicationCenterTableViewCell *)
          [tableView dequeueReusableCellWithIdentifier:cellId];
  [cell setIconBGImageViewColor:[bgColorArray[indexPath.section]
                                    objectAtIndex:indexPath.row]];
  cell.iconImageView.image = [UIImage
      imageNamed:[imageArray[indexPath.section] objectAtIndex:indexPath.row]];
  cell.nameLabel.text =
      [dataArray[indexPath.section] objectAtIndex:indexPath.row];
  if (indexPath.row == 2) {
    UserBpushInformationNum *savedCount =
        [UserBpushInformationNum getUnReadObject];
    NSUInteger count = [savedCount getCount:UserBpushAllCount];
    if (count > 0) {
      cell.unreadNum.hidden = NO;
      cell.unreadNum.text = [@(count) stringValue];
    } else {
      cell.unreadNum.hidden = YES;
    }
  }
  return cell;
}
- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [UIView animateWithDuration:0.3f
                   animations:^{
                     [tableView deselectRowAtIndexPath:indexPath animated:YES];
                   }];
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
  }

  switch (indexPath.row + 3 * indexPath.section) {
  case CommunCenterPageTypeMyQuestion: {
    //我的提问
    QATotalTitleTableViewController *qtVC =
        [[QATotalTitleTableViewController alloc] initWithQAType:QATypeMyQuestion];
    [AppDelegate pushViewControllerFromRight:qtVC];
  } break;
  case CommunCenterPageTypeMyAnswer: {
    //我的回答
    QATotalTitleTableViewController *awVC =
        [[QATotalTitleTableViewController alloc] initWithQAType:QATypeMyAnswer];
    [AppDelegate pushViewControllerFromRight:awVC];
  } break;
  case CommunCenterPageTypeMyInfo: {
    [UserBpushInformationNum clearAllUnReadCount];
    //我的消息
    MyInfoTitleTableViewController *myInfo = [[MyInfoTitleTableViewController alloc] init];
    [AppDelegate pushViewControllerFromRight:myInfo];
  } break;
  case CommunCenterPageTypeMyComment: {
    //我的评论
    QATotalTitleTableViewController *awVC =
        [[QATotalTitleTableViewController alloc] initWithQAType:QATypeMyComment];
    [AppDelegate pushViewControllerFromRight:awVC];
  } break;
  case CommunCenterPageTypeAtMe: {
    //回复我的
    FPReplyMeViewController *replyMeVC = [[FPReplyMeViewController alloc] init];
    [AppDelegate pushViewControllerFromRight:replyMeVC];
  } break;
  default:
    break;
  }
}

@end
