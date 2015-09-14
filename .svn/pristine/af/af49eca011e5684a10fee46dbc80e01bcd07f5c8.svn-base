//
//  MyInfoViewController.m
//  优顾理财
//
//  Created by Mac on 15-4-12.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPMyInfoViewController.h"
#import "KnowRequestItem.h"
#import "FPMyInfoTableViewCell.h"
#import "KnowDetailViewController.h"

@implementation FPMyInfoViewController

- (id)init {
  self = [super initWithFrame:WINDOWUISCREEN AndRefreshLable:@"MyQuestionVC"];
  if (self) {
    //    [self registerNibCell];
  }
  return self;
}

#pragma mark - 注册NibCell
- (void)registerNibCell {
  UINib *cellNib =
      [UINib nibWithNibName:NSStringFromClass([FPMyInfoTableViewCell class]) bundle:nil];
  [self.tableView registerNib:cellNib forCellReuseIdentifier:@"FPMyInfoTableViewCell"];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.topNavView.mainLableString = @"我的消息";
  [self registerNibCell];
  self.loading.hidden = NO;
  self.refrashIndex = 0;
  if ([FPYouguUtil isExistNetwork]) {
    [self requestData];
  } else {
    [self.loading animationNoNetWork];
  }
}
#pragma mark - 数据上啦，下拉 加载
- (void)refreshNewInfo {
  if ([FPYouguUtil isExistNetwork]) {
    [self requestData];
  }
}
#pragma mark - 刷新数据
- (void)returnBlock:(NSObject *)obj {
  KnowMessageList *object = (KnowMessageList *)obj;
  [super jsonToDic:object.listArray];
  //刷新
  [self.tableView reloadData];
}

- (void)requestData {
  int fromId = 0;
  if (self.dataArray.array.count > 0) {
    knownewItem *item = [self.dataArray.array lastObject];
    fromId = [item.aid intValue];
  }
  HttpRequestCallBack *callBack = [super getHttpCallBack];
  [KnowMessageList getMessageListWithStart:[@(fromId) stringValue] withCallback:callBack];
}

//获取文本
- (NSString *)cell_text:(NSInteger)row {
  knownewItem *item = [self.dataArray.array objectAtIndex:row];
  NSString *content = item.summary;
  if (item.sourceType == 7) {
    content = [NSString stringWithFormat:@"回复我: %@", content];
  } else if (item.sourceType == 2) {
    content = [NSString stringWithFormat:@"@我: %@", content];
  } else if (item.sourceType == 3) {
    content = [NSString stringWithFormat:@"评论我: %@", content];
  } else if (item.sourceType == 4) {
    content = [NSString stringWithFormat:@"%@: %@", @"消息通知", content];
  }
  return content;
}
///计算cell中内容label的高度
- (CGFloat)getCellOnLabelHeight:(NSInteger)row {
  CGFloat height = [FTLabel getLableHeightWithText:[self cell_text:row]];
  return height;
}
#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 60 + [self getCellOnLabelHeight:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"FPMyInfoTableViewCell";
  FPMyInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

  if ([self.dataArray.array count] > 0) {
    knownewItem *item = [self.dataArray.array objectAtIndex:indexPath.row];
    cell.timeLable.text = item.creatTime;
    if (item.sourceType == 6) {
      [cell systemDefaultWithPic:@"喇叭.png" andNickname:@"系统消息"];
    } else {
      cell.userListItem = item.userListItem;
    }
    //颜色
    if (item.sourceType == 7) {
      cell.contentLable.nameNick = [NSString stringWithFormat:@"回复我:"];
    } else if (item.sourceType == 2) {
      cell.contentLable.nameNick = [NSString stringWithFormat:@"@我:"];
    } else if (item.sourceType == 3) {
      cell.contentLable.nameNick = [NSString stringWithFormat:@"评论我:"];
    } else if (item.sourceType == 4) {
      cell.contentLable.nameNick = [NSString stringWithFormat:@"%@:", @"消息通知"];
    } else {
      cell.contentLable.nameNick = nil;
    }

    cell.isRead = item.isreading;
    //内容
    NSString *contentStr = [self cell_text:indexPath.row];
    if (contentStr && contentStr.length > 0) {
      [cell.contentLable setOfUILablewithContent:contentStr];
    } else {
      cell.contentLable.text = nil;
    }
    cell.longPress.minimumPressDuration = 25.0f;
  }

  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if ([self.dataArray.array count] > indexPath.row) {
    knownewItem *item = [self.dataArray.array objectAtIndex:indexPath.row];
    KnowDetailViewController *knowDetailVC = [[KnowDetailViewController alloc] initWithTalkId:item.talkId];
    [AppDelegate pushViewControllerFromRight:knowDetailVC];
  }
  [tableView reloadData];
}

#pragma mark - 注销
- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
