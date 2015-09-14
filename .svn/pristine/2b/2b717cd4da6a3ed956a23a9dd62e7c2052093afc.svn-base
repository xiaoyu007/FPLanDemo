//
//  QATotalViewController.m
//  优顾理财
//
//  Created by Mac on 15/8/9.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "QATotalViewController.h"
#import "QAMyTalkRequestItem.h"
#import "KnowDetailViewController.h"
#import "FPKnowTableViewCell.h"
#import "QARequestListItem.h"
#import "FPMyCommentTableViewCell.h"
#import "NewsDetailViewController.h"

@implementation QATotalViewController

- (id)initWithQAType:(QAType)state {
  type = state;
  if (state == QATypeMyQuestion) {
    self = [super initWithRefreshLable:@"MyQuestionVC"];
    if (self) {
      //      [self registerNibCell];
    }
    return self;
  } else if (state == QATypeMyAnswer) {
    self = [super initWithRefreshLable:@"MyAnswerVC"];
    if (self) {
      //      [self registerNibCell];
    }
    return self;
  } else if (state == QATypeMyComment) {
    self = [super initWithRefreshLable:@"MyCommentVC"];
    if (self) {
      //      [self registerNibCell];
    }
    return self;
  } else {
    NSLog(@"我的提问或我的回答传值的type不对");
  }
  return nil;
}

#pragma mark - 注册NibCell
- (void)registerNibCell {
  UINib *cellNib =
      [UINib nibWithNibName:NSStringFromClass([FPMyCommentTableViewCell class]) bundle:nil];
  [self.tableView registerNib:cellNib forCellReuseIdentifier:@"FPMyCommentTableViewCell"];
  UINib *knowCellNib =
      [UINib nibWithNibName:NSStringFromClass([FPKnowTableViewCell class]) bundle:nil];
  [self.tableView registerNib:knowCellNib forCellReuseIdentifier:@"FPKnowTableViewCell"];
}

#pragma mark - pv, 初始化
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  if (type == QATypeMyQuestion) {
    [MobClick beginLogPageView:@"My_question_list_view"];
    [[PV_view_sql sharedManager] PV_DB_DATA:@"My_question_list_view"];
  } else if (type == QATypeMyAnswer) {
    [MobClick beginLogPageView:@"My_Answer_list_view"];
    [[PV_view_sql sharedManager] PV_DB_DATA:@"My_Answer_list_view"];
  }
}
- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  if (type == QATypeMyQuestion) {
    [MobClick endLogPageView:@"My_question_list_view"];
  } else if (type == QATypeMyAnswer) {
    [MobClick endLogPageView:@"My_Answer_list_view"];
  }
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [self judgeIsHasNetwork];
  switch (type) {
  case QATypeMyQuestion: {
    self.topNavView.mainLableString = @"我的提问";
  } break;
  case QATypeMyAnswer: {
    self.topNavView.mainLableString = @"我的回答";
  } break;
  case QATypeMyComment: {
    self.topNavView.mainLableString = @"我的评论";
  }
  default:
    break;
  }
  [self registerNibCell];
  self.loading.frame = self.childView.frame;
}

- (void)judgeIsHasNetwork {
  if ([FPYouguUtil isExistNetwork]) {
    [self requestData];
  } else {
    self.loading.hidden = NO;
    [self.loading animationNoNetWork];
  }
}

#pragma mark - 数据上啦，下拉 加载
- (void)refreshNewInfo {
  if ([FPYouguUtil isExistNetwork]) {
    [self requestData];
  }
}
#pragma 复写父类的方法
- (void)returnBlock:(NSObject *)obj {
  if (type == QATypeMyQuestion) {
    QTRequestList *list = (QTRequestList *)obj;
    [super jsonToDic:list.mainArray];
  } else if (type == QATypeMyAnswer) {
    AWRequestList *list = (AWRequestList *)obj;
    [super jsonToDic:list.mainArray];
  } else if (type == QATypeMyComment) {
    MyRlyListRequestList *list = (MyRlyListRequestList *)obj;
    [super jsonToDic:list.listArray];
  }
}
- (void)requestData {
  HttpRequestCallBack *callBack = [super getHttpCallBack];
  if (type == QATypeMyQuestion) {
    [QTRequestList getQTListWithUid:[FPYouguUtil getUserID]
                           AndStart:self.refrashIndex * 20
                       withCallback:callBack];
  } else if (type == QATypeMyAnswer) {
    [AWRequestList getAWListWithUid:[FPYouguUtil getUserID]
                           AndStart:self.refrashIndex * 20
                       withCallback:callBack];
  } else if (type == QATypeMyComment) {
    [MyRlyListRequestList getMyRlyListWith:[FPYouguUtil getUserID]
                                  andStart:[@(self.refrashIndex * 20) stringValue]
                              withCallback:callBack];
  }
}
#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  if (section == 0) {
    return 0;
  }
  return 3.0;
}
#pragma mark - 计算cell的高度，和，html的形成
//组成html，的文本，
- (NSString *)set_html_text:(NSInteger)row {
  if (type == QATypeMyComment) {
    MyRlyListRequestItem *item = self.dataArray.array[row];
    NSString *contentStr = item.commentContent;
    return contentStr;
  }
  QTRequestItem *item = self.dataArray.array[row];
  NSString *contentStr = item.userSummary;
  if ([item.userBeNickname length] > 0) {
    if (type == QATypeMyAnswer) {
      contentStr = [NSString stringWithFormat:@"@%@:%@", item.userBeNickname, contentStr];
    } else {
      contentStr = [NSString stringWithFormat:@"@%@:%@", item.userBeNickname, contentStr];
    }
  }
  return contentStr;
}

//计算cell的高度
- (CGFloat)set_Cell_Height:(NSInteger)row {
  if (self.dataArray.array.count <= 0) {
    return 0;
  }
  if (type == QATypeMyComment) {
    MyRlyListRequestItem *item = [self.dataArray.array objectAtIndex:row];
    return [FTLabel getLableHeightWithText:item.commentContent andTitle:item.commentTitle];
  }
  return [FTLabel getLableHeightWithText:[self set_html_text:row]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (type == QATypeMyComment) {
    return 40 + [self set_Cell_Height:indexPath.row];
  }
  return 60 + [self set_Cell_Height:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (type == QATypeMyComment) {
    static NSString *CellIdentifier = @"FPMyCommentTableViewCell";
    FPMyCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    MyRlyListRequestItem *item = [self.dataArray.array objectAtIndex:indexPath.row];
    cell.commentTimeLabel.text = item.commentTime;
    if (item.commentTitle && item.commentTitle.length > 0) {
      cell.commentTitleLabel.text = item.commentTitle;
    } else {
      cell.commentTitleLabel.text = nil;
    }
    //内容赋值
    NSString *contentStr = [self set_html_text:indexPath.row];
    if (contentStr && contentStr.length > 0) {
      [cell.commentLabel setOfUILablewithContent:contentStr];
    } else {
      cell.commentLabel.text = nil;
    }
    cell.isRead = item.isReading;
    // cell长按
    [cell.longPress addTarget:self action:@selector(cellLongProcess:)];
    return cell;
  } else {
    static NSString *CellIdentifier = @"FPKnowTableViewCell";
    FPKnowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.isToUserInfoVC = YES;
    QTRequestItem *item = self.dataArray.array[indexPath.row];
    //用户昵称
    cell.userListItem = item.userListItem;
    cell.timeLable.text = item.userCreattime;
    cell.praiseNum.text = [NSString stringWithFormat:@"回答数 : %@", item.commentNum];
    //判断有没有标题
    if (item.userTitle && item.userTitle.length > 0) {
      cell.titleLabel.text = item.userTitle;
      cell.contentLable.lineLimit = 2;
    } else {
      cell.titleLabel.text = nil;
      cell.contentLable.lineLimit = 3;
    }
    if (type == QATypeMyQuestion) {
      cell.praiseNum.hidden = NO;
    } else {
      cell.praiseNum.hidden = YES;
    }
    //判断颜色
    if ([item.userBeNickname length] > 0) {
      if (type == QATypeMyAnswer) {
        cell.contentLable.nameNick = [NSString stringWithFormat:@"@%@:", item.userBeNickname];
      } else {
        cell.contentLable.nameNick = [NSString stringWithFormat:@"@%@:", item.userBeNickname];
      }
    } else {
      cell.contentLable.nameNick = nil;
    }
    //内容
    NSString *contentStr = [self set_html_text:indexPath.row];
    if (contentStr && contentStr.length > 0) {
      [cell.contentLable setOfUILablewithContent:contentStr];
    } else {
      cell.contentLable.text = nil;
    }
    cell.isRead = item.isReading;
    // cell长按
    [cell.longPress addTarget:self action:@selector(cellLongProcess:)];
    return cell;
  }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

  [UIView animateWithDuration:0.3f
                   animations:^{
                     [tableView deselectRowAtIndexPath:indexPath animated:YES];
                   }];

  if (type == QATypeMyComment) {
    MyRlyListRequestItem *item = [self.dataArray.array objectAtIndex:indexPath.row];
    item.isReading = YES;
    NewsDetailViewController *newsVC = [[NewsDetailViewController alloc] initWithChannlId:@"1"
                                                                                andNewsId:item.articleId
                                                                                  Andxgsj:item.commentTime];
    [AppDelegate pushViewControllerFromRight:newsVC];
    return;
  }
  QTRequestItem *item = self.dataArray.array[indexPath.row];
  item.isReading = YES;
  if (type == QATypeMyQuestion) {
    KnowDetailViewController *knowDetailVC = [[KnowDetailViewController alloc] initWithTalkId:item.aid];
    [AppDelegate pushViewControllerFromRight:knowDetailVC];
  } else if (type == QATypeMyAnswer) {
    KnowDetailViewController *knowDetailVC = [[KnowDetailViewController alloc] initWithTalkId:item.articleId];
    [AppDelegate pushViewControllerFromRight:knowDetailVC];
  }

  [tableView reloadData];
}

/** 按钮长按 */
- (void)cellLongProcess:(UILongPressGestureRecognizer *)ges {
  if (ges.state == UIGestureRecognizerStateBegan) {
    CGPoint location = [ges locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    longProcessIndex = indexPath.row;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"删除提示"
                                                        message:@"确定要删除此条目"
                                                       delegate:self
                                              cancelButtonTitle:@"删除"
                                              otherButtonTitles:@"取消", nil];
    [alertView show];
  }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (buttonIndex == 0) {
    //我的提问，删除一栏
    HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
    __weak QATotalViewController *weakSelf = self;
    callBack.onSuccess = ^(NSObject *obj) {
      QATotalViewController *strongSelf = weakSelf;
      if (strongSelf) {
        if (longProcessIndex < [self.dataArray.array count]) {
          //数组清除对应数据
          [strongSelf.dataArray.array removeObjectAtIndex:longProcessIndex];
          if (strongSelf.dataArray.array.count == 0) {
            strongSelf.loading.hidden = NO;
            [strongSelf.loading notDataStatus];
          }
          [strongSelf.tableView reloadData];
        }
      }
    };
    if (type == QATypeMyComment) {
      MyRlyListRequestItem *item = [self.dataArray.array objectAtIndex:longProcessIndex];
      [QAMyTalkRequestItem delegateNewsTalkWithTalkId:item.commentId withCallback:callBack];
    } else {
      QTRequestItem *item = [self.dataArray.array objectAtIndex:longProcessIndex];
      if (type == QATypeMyQuestion) {
        [QAMyTalkRequestItem delegateKnowQuestionAndAnswerWithTalkId:item.aid
                                                         AndNickname:item.userListItem.nickName
                                                        withCallback:callBack];
      } else if (type == QATypeMyAnswer) {
        [QAMyTalkRequestItem delegateKnowAnswerWithTalkId:item.aid
                                              AndNickname:item.userListItem.nickName
                                             withCallback:callBack];
      }
    }
  }
}
- (BOOL)tableView:(UITableView *)tableView
    shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}
///** 删除某一行 */
//- (void)tableView:(UITableView *)tableView
// commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
// forRowAtIndexPath:(NSIndexPath *)indexPath{
//  [self.tableView removeObjectAtIndex:indexPath.row];
//  [tableView reloadData];
//}
#pragma mark - 注销
- (void)dealloc {
  [self.view removeAllSubviews];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
