//
//  QATotalTableViewController.m
//  优顾理财
//
//  Created by Yuemeng on 15/9/7.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "QATotalTitleTableViewController.h"
#import "FPMyCommentTableViewCell.h"
#import "FPKnowTableViewCell.h"
#import "QARequestListItem.h"
#import "NewsDetailViewController.h"
#import "KnowDetailViewController.h"
#import "QAMyTalkRequestItem.h"

@implementation QATotalTableAdapter

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (_type == QATypeMyComment) {
    return 40 + [self set_Cell_Height:indexPath.row];
  }
  return 60 + [self set_Cell_Height:indexPath.row];
}

- (CGFloat)set_Cell_Height:(NSInteger)row {
  if (self.dataArray.array.count <= 0) {
    return 0;
  }
  if (_type == QATypeMyComment) {
    MyRlyListRequestItem *item = [self.dataArray.array objectAtIndex:row];
    return [FTLabel getLableHeightWithText:item.commentContent
                                  andTitle:item.commentTitle];
  }
  return [FTLabel getLableHeightWithText:[self set_html_text:row]];
}

- (NSString *)set_html_text:(NSInteger)row {
  if (_type == QATypeMyComment) {
    MyRlyListRequestItem *item = self.dataArray.array[row];
    NSString *contentStr = item.commentContent;
    return contentStr;
  }
  QTRequestItem *item = self.dataArray.array[row];
  NSString *contentStr = item.userSummary;
  if ([item.userBeNickname length] > 0) {
    if (_type == QATypeMyAnswer) {
      contentStr = [NSString
          stringWithFormat:@"@%@:%@", item.userBeNickname, contentStr];
    } else {
      contentStr = [NSString
          stringWithFormat:@"@%@:%@", item.userBeNickname, contentStr];
    }
  }
  return contentStr;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (_type == QATypeMyComment) {
    static NSString *CellIdentifier = @"FPMyCommentTableViewCell";
    FPMyCommentTableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    MyRlyListRequestItem *item =
        [self.dataArray.array objectAtIndex:indexPath.row];
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
    FPKnowTableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.isToUserInfoVC = YES;
    QTRequestItem *item = self.dataArray.array[indexPath.row];
    //用户昵称
    cell.userListItem = item.userListItem;
    cell.timeLable.text = item.userCreattime;
    cell.praiseNum.text =
        [NSString stringWithFormat:@"回答数 : %@", item.commentNum];
    //判断有没有标题
    if (item.userTitle && item.userTitle.length > 0) {
      cell.titleLabel.text = item.userTitle;
      cell.contentLable.lineLimit = 2;
    } else {
      cell.titleLabel.text = nil;
      cell.contentLable.lineLimit = 3;
    }
    if (_type == QATypeMyQuestion) {
      cell.praiseNum.hidden = NO;
    } else {
      cell.praiseNum.hidden = YES;
    }
    //判断颜色
    if ([item.userBeNickname length] > 0) {
      if (_type == QATypeMyAnswer) {
        cell.contentLable.nameNick =
            [NSString stringWithFormat:@"@%@:", item.userBeNickname];
      } else {
        cell.contentLable.nameNick =
            [NSString stringWithFormat:@"@%@:", item.userBeNickname];
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

- (void)cellLongProcess:(UILongPressGestureRecognizer *)ges {
  if (ges.state == UIGestureRecognizerStateBegan) {

    CGPoint location =
        [ges locationInView:self.baseTableViewController.tableView];
    NSIndexPath *indexPath = [self.baseTableViewController.tableView
        indexPathForRowAtPoint:location];
    _longProcessIndex = indexPath.row;
    UIAlertView *alertView =
        [[UIAlertView alloc] initWithTitle:@"删除提示"
                                   message:@"确定要删除此条目"
                                  delegate:self
                         cancelButtonTitle:@"删除"
                         otherButtonTitles:@"取消", nil];
    [alertView show];
  }
}

- (void)alertView:(UIAlertView *)alertView
    clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (buttonIndex == 0) {
    //我的提问，删除一栏
    HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
    __weak QATotalTableAdapter *weakSelf = self;
    callBack.onSuccess = ^(NSObject *obj) {
      QATotalTableAdapter *strongSelf = weakSelf;
      if (strongSelf) {
        if (_longProcessIndex < [self.dataArray.array count]) {
          //数组清除对应数据
          [strongSelf.dataArray.array removeObjectAtIndex:_longProcessIndex];
          if (strongSelf.dataArray.array.count == 0) {
            strongSelf.baseTableViewController.loading.hidden = NO;
            [strongSelf.baseTableViewController.loading notDataStatus];
          }
          [strongSelf.baseTableViewController.tableView reloadData];
        }
      }
    };
    if (_type == QATypeMyComment) {
      MyRlyListRequestItem *item =
          [self.dataArray.array objectAtIndex:_longProcessIndex];
      [QAMyTalkRequestItem delegateNewsTalkWithTalkId:item.commentId
                                         withCallback:callBack];
    } else {
      QTRequestItem *item =
          [self.dataArray.array objectAtIndex:_longProcessIndex];
      if (_type == QATypeMyQuestion) {
        [QAMyTalkRequestItem
            delegateKnowQuestionAndAnswerWithTalkId:item.aid
                                        AndNickname:item.userListItem.nickName
                                       withCallback:callBack];
      } else if (_type == QATypeMyAnswer) {
        [QAMyTalkRequestItem
            delegateKnowAnswerWithTalkId:item.aid
                             AndNickname:item.userListItem.nickName
                            withCallback:callBack];
      }
    }
  }
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

  [UIView animateWithDuration:0.3f
                   animations:^{
                     [tableView deselectRowAtIndexPath:indexPath animated:YES];
                   }];

  if (_type == QATypeMyComment) {
    MyRlyListRequestItem *item =
        [self.dataArray.array objectAtIndex:indexPath.row];
    item.isReading = YES;
    NewsDetailViewController *newsVC =
        [[NewsDetailViewController alloc] initWithChannlId:@"1"
                                                 andNewsId:item.articleId
                                                   Andxgsj:item.commentTime];
    [AppDelegate pushViewControllerFromRight:newsVC];
    return;
  }
  QTRequestItem *item = self.dataArray.array[indexPath.row];
  item.isReading = YES;
  if (_type == QATypeMyQuestion) {
    KnowDetailViewController *knowDetailVC =
        [[KnowDetailViewController alloc] initWithTalkId:item.aid];
    [AppDelegate pushViewControllerFromRight:knowDetailVC];
  } else if (_type == QATypeMyAnswer) {
    KnowDetailViewController *knowDetailVC =
        [[KnowDetailViewController alloc] initWithTalkId:item.articleId];
    [AppDelegate pushViewControllerFromRight:knowDetailVC];
  }

  [tableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView
    shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}

@end

/**
 *  TableViewController
 */
@implementation QATotalTableViewController

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  if (_type == QATypeMyQuestion) {
    [MobClick beginLogPageView:@"My_question_list_view"];
    [[PV_view_sql sharedManager] PV_DB_DATA:@"My_question_list_view"];
  } else if (_type == QATypeMyAnswer) {
    [MobClick beginLogPageView:@"My_Answer_list_view"];
    [[PV_view_sql sharedManager] PV_DB_DATA:@"My_Answer_list_view"];
  }
}
- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  if (_type == QATypeMyQuestion) {
    [MobClick endLogPageView:@"My_question_list_view"];
  } else if (_type == QATypeMyAnswer) {
    [MobClick endLogPageView:@"My_Answer_list_view"];
  }
}

- (NSString *)headerViewKey {
  if (_type == QATypeMyQuestion) {
    return @"MyQuestionVC";
  } else if (_type == QATypeMyAnswer) {
    return @"MyAnswerVC";
  } else if (_type == QATypeMyComment) {
    return @"MyCommentVC";
  } else {
    return nil;
  }
}

/** 请求最新数据，此方法子类必须实现 */
- (void)requestDataListWithRefreshType:(RefreshType)refreshType
                         withDataArray:(DataArray *)existDataList
                          withCallBack:(HttpRequestCallBack *)callback {

  if (_type == QATypeMyQuestion) {
    [QTRequestList
        getQTListWithDic:[self getRequestParamertsWithRefreshType:refreshType]
            withCallback:callback];
  } else if (_type == QATypeMyAnswer) {
    [AWRequestList
        getAWListWithDic:[self getRequestParamertsWithRefreshType:refreshType]
            withCallback:callback];
  } else if (_type == QATypeMyComment) {
    [MyRlyListRequestList
        getMyRlyListWithDic:[self
                                getRequestParamertsWithRefreshType:refreshType]
               withCallback:callback];
  }
}

- (NSDictionary *)getRequestParamertsWithRefreshType:(RefreshType)refreshType {
  NSString *start = @"0";

  if (refreshType == RefreshTypeLoaderMore) {
    start = [@((self.dataArray.array.count + 19) / 20) stringValue];
  }

  return @{ @"start" : start };
}

- (BOOL)isDataValidWithResponseObject:(NSObject<Collectionable> *)latestData
                withRequestParameters:(NSDictionary *)parameters
                      withRefreshType:(RefreshType)refreshType {
  if (refreshType == RefreshTypeLoaderMore) {
    if (((self.dataArray.array.count + 19) / 20) !=
        [parameters[@"start"] integerValue]) {
      return NO;
    }
  }
  return YES;
}

/** 返回表格数据适配器，此方法子类必须实现 */
- (BaseTableAdapter *)getBaseTableAdaperWithDataList:(DataArray *)dataList {
  if (_tableAdapter == nil) {
    _tableAdapter = [[QATotalTableAdapter alloc]
        initWithTableViewController:self
                      withDataArray:self.dataArray];
    ((QATotalTableAdapter *)_tableAdapter).type = _type;
    [self registerNibCell];
  }
  return _tableAdapter;
}

#pragma mark - 注册NibCell
- (void)registerNibCell {
  UINib *cellNib =
      [UINib nibWithNibName:NSStringFromClass([FPMyCommentTableViewCell class])
                     bundle:nil];
  [self.tableView registerNib:cellNib
       forCellReuseIdentifier:@"FPMyCommentTableViewCell"];
  UINib *knowCellNib =
      [UINib nibWithNibName:NSStringFromClass([FPKnowTableViewCell class])
                     bundle:nil];
  [self.tableView registerNib:knowCellNib
       forCellReuseIdentifier:@"FPKnowTableViewCell"];
}

@end

/**
 *  TitleTableViewController
 */
@implementation QATotalTitleTableViewController

- (id)initWithQAType:(QAType)state {
  _type = state;

  if (self = [super init]) {
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  switch (_type) {
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

  _tableVC =
      [[QATotalTableViewController alloc] initWithFrame:self.clientView.bounds];
    _tableVC.type = _type;
  [self.clientView addSubview:_tableVC.view];
  [self addChildViewController:_tableVC];
  [_tableVC refreshButtonPressDown];
}

@end
