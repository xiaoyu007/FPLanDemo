//
//  QATableViewController.m
//  优顾理财
//
//  Created by Mac on 15/8/13.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "QATableViewController.h"
#import "QAMyTalkRequestItem.h"
#import "KnowDetailViewController.h"
#import "QATableViewCell.h"
#import "QARequestListItem.h"
#import "FPMyCommentTableViewCell.h"
#import "NewsDetailViewController.h"
@interface QATableViewController ()

@end

@implementation QATableViewController
- (id)initWithFrame:(CGRect)frame andQAType:(QAUserListType)state {
  type = state;
  if (state == QuestionType) {
    self = [super initWithFrame:frame AndRefreshLable:@"MyQuestionVC"];
    //    [self registerNibCell];
    return self;
  } else if (state == AnswerType) {
    self = [super initWithFrame:frame AndRefreshLable:@"MyAnswerVC"];
    //    [self registerNibCell];
    return self;
  } else if (state == MyCommentType) {
    self = [super initWithFrame:frame AndRefreshLable:@"MyCommentVC"];
    //    [self registerNibCell];
    return self;
  } else {
    NSLog(@"我的提问或我的回答传值的type不对");
  }
  return nil;
}

#pragma mark - 注册NibCell
- (void)registerNibCell {
  UINib *cellNib =
      [UINib nibWithNibName:NSStringFromClass([QATableViewCell class])
                     bundle:nil];
  [self.tableView registerNib:cellNib
       forCellReuseIdentifier:@"QATableViewCell"];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.loading.hidden = NO;
  [self registerNibCell];
  if ([FPYouguUtil isExistNetwork]) {
    [self refreshNewInfo];
  } else {
    [self.loading animationNoNetWork];
  }
}
- (void)refreshNewInfo {
  if ([FPYouguUtil isExistNetwork]) {
    self.refrashIndex = 0;
    [self requestData];
  }
}
#pragma mark - 复写父类fpNOtitleTableview的方法
- (void)returnBlock:(NSObject *)obj {
  if (type == QATypeMyQuestion) {
    QTRequestList *list = (QTRequestList *)obj;
    [super jsonToDic:list.mainArray];
    [self numWithDelegateMethod:list.mainArray andNum:list.totalNum];
  } else if (type == QATypeMyAnswer) {
    AWRequestList *list = (AWRequestList *)obj;
    [super jsonToDic:list.mainArray];
    [self numWithDelegateMethod:list.mainArray andNum:list.totalNum];
  }
}
- (void)requestData {
  HttpRequestCallBack *callBack = [self getHttpCallBack];
  if (type == QATypeMyQuestion) {
    [QTRequestList getQTListWithUid:self.userId
                           AndStart:self.refrashIndex * 20
                       withCallback:callBack];
  } else if (type == QATypeMyAnswer) {
    [AWRequestList getAWListWithUid:self.userId
                           AndStart:self.refrashIndex * 20
                       withCallback:callBack];
  }
}
- (void)numWithDelegateMethod:(NSArray *)array andNum:(NSString *)num {
  if (array.count > 0) {
    QTRequestItem *item = array[0];
    //用户签名
    [_delegate getArrayNum:[num intValue]
               andUserSign:item.userListItem.signature
                   andtype:type];
  } else {
    //用户签名
    [_delegate getArrayNum:[num intValue] andUserSign:@"" andtype:type];
    [self.loading notDataStatus];
  }
}
#pragma mark - 计算cell的高度，和，html的形成
//组成html，的文本，
- (NSString *)set_html_text:(NSInteger)row {
  QTRequestItem *qtItem = self.dataArray.array[row];
  NSString *content = qtItem.userSummary;
  if ([qtItem.userBeNickname length] > 0) {
    if (type == QuestionType) {
      content =
          [NSString stringWithFormat:@"@%@:%@", qtItem.userBeNickname, content];
    } else {
      content = [NSString
          stringWithFormat:@"回复%@:%@", qtItem.userBeNickname, content];
    }
  }
  return content;
}
//计算cell的高度
- (CGFloat)getContentLableHeightWithIndexPathRow:(NSInteger)row {
  CGFloat height = [FTLabel getLableHeightWithText:[self set_html_text:row]];
  return height;
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 45 + [self getContentLableHeightWithIndexPathRow:indexPath.row];
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"QATableViewCell";
  QATableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  [cell JudgeFirst:(indexPath.row == 0 ? YES : NO)];
  QTRequestItem *item = self.dataArray.array[indexPath.row];
  //    cell被选择一会的背景效果颜色
  cell.creatTimeLable.text = item.userCreattime;
  if (type == QATypeMyQuestion) {
    cell.num.text = [NSString stringWithFormat:@"回答数 : %@", item.commentNum];
  } else {
    cell.num.hidden = YES;
  }
  //改变颜色
  if ([item.userBeNickname length] > 0) {
    if (type == QuestionType) {
      cell.contentLable.nameNick =
      [NSString stringWithFormat:@"@%@:", item.userBeNickname];
    } else {
      cell.contentLable.nameNick = [NSString
                 stringWithFormat:@"回复%@:", item.userBeNickname];
    }
  }else {
    cell.contentLable.nameNick = nil;
  }
  //内容赋值
  NSString *contentStr = [self set_html_text:indexPath.row];
  if (contentStr && contentStr.length > 0) {
    [cell.contentLable setOfUILablewithContent:contentStr];
  } else {
    cell.contentLable.text = nil;
  }
  return cell;
}
- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:NO];
  QTRequestItem *qtItem = self.dataArray.array[indexPath.row];
  if (type == AnswerType) {
    KnowDetailViewController *knowDetailVC =
        [[KnowDetailViewController alloc] initWithTalkId:qtItem.articleId];
    [AppDelegate pushViewControllerFromRight:knowDetailVC];
  } else {
    KnowDetailViewController *knowDetailVC =
        [[KnowDetailViewController alloc] initWithTalkId:qtItem.aid];
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
    __weak QATableViewController *weakSelf = self;
    callBack.onSuccess = ^(NSObject *obj) {
      QATableViewController *strongSelf = weakSelf;
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
    QTRequestItem *item = [self.dataArray.array objectAtIndex:longProcessIndex];
    [QAMyTalkRequestItem
        delegateKnowQuestionAndAnswerWithTalkId:item.aid
                                    AndNickname:item.userListItem.nickName
                                   withCallback:callBack];
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
