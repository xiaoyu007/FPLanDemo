//
//  ReplyMeViewController.m
//  优顾理财
//
//  Created by Mac on 15-4-9.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPReplyMeViewController.h"
#import "FPReplyMeCell.h"

#define tableviewCellHeight 110.0f


@implementation FPReplyMeViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self CreatNavBarWithTitle:@"@我的"];
  [self createTableview];
}
/** 创建表格 */
- (void)createTableview {
  replyMeTableview = [[UITableView alloc]
      initWithFrame:CGRectMake(0, navigationHeght, windowWidth,
                               windowHeight - navigationHeght -
                                   statusBarHeight)];
  replyMeTableview.dataSource = self;
  replyMeTableview.delegate = self;
  replyMeTableview.backgroundColor = [Globle colorFromHexRGB:customBGColor];
  replyMeTableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
  replyMeTableview.separatorColor = [Globle colorFromHexRGB:lightCuttingLine];
  [self.childView addSubview:replyMeTableview];
  //去除多余的分割线
  [replyMeTableview
      setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
}
#pragma mark -tableView的代理方法

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return 10;
}

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return tableviewCellHeight;
}
/** 自定义分割线长度 */
- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  if ([replyMeTableview respondsToSelector:@selector(setSeparatorInset:)]) {
    [replyMeTableview setSeparatorInset:UIEdgeInsetsMake(0, 18.0f, 0, 18.0f)];
  }

  if ([replyMeTableview respondsToSelector:@selector(setLayoutMargins:)]) {
    [replyMeTableview setLayoutMargins:UIEdgeInsetsMake(0, 18.0f, 0, 18.0f)];
  }
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
  if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {

    [cell setSeparatorInset:UIEdgeInsetsMake(0, 18.0f, 0, 18.0f)];
  }
  if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
    [cell setLayoutMargins:UIEdgeInsetsMake(0, 18.0f, 0, 18.0f)];
  }
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *ID = @"FPReplyMeCell";
  FPReplyMeCell *cell =
      (FPReplyMeCell *)[tableView dequeueReusableCellWithIdentifier:ID];
  if (!cell) {
    cell = [[[NSBundle mainBundle] loadNibNamed:ID
                                          owner:self
                                        options:nil] firstObject];
  }

  return cell;
}

@end
