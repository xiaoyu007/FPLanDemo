//
//  QAViewController.m
//  优顾理财
//
//  Created by Mac on 15/7/23.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "QAViewController.h"
#import "QATableViewCell.h"
#import "QARequestListItem.h"
#import "knowDetailViewController.h"

@implementation QAViewController
- (id)initWithFrame:(CGRect)frame andType:(UserListType)type andUid:(NSString *)userId {
  self = [super initWithFrame:frame];
  if (self) {
    self.type = type;
    self.userId = userId;
    self.isStatus = NO;
    refrash_is_have = NO;
    //    数据 数组
    self.mainArray = [[NSMutableArray alloc] initWithCapacity:0];
    num = 0;
    NSString *refreshLabel =
        YouGu_StringWithFormat_Third(@"UserListRefresh", [@(self.type) stringValue], _userId);
    userTableView = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.childView.height)
                                                   pullingDelegate:self
                                                     andRefresh_id:refreshLabel];
    userTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    userTableView.delegate = self;
    userTableView.dataSource = self;
    userTableView.backgroundColor = [UIColor clearColor];
    [self.childView addSubview:userTableView];
    self.loading.hidden = NO;
    [self refreshNewInfo];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
}
- (void)refreshNewInfo {
  if (self.type == QuestionType) {
    //用户发表的帖子
    HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
    __weak QAViewController *weakSelf = self;
    callBack.onCheckQuitOrStopProgressBar = ^{
      QAViewController *strongSelf = weakSelf;
      if (strongSelf) {
        [userTableView tableViewDidFinishedLoading];
        return NO;
      } else {
        return YES;
      }
    };
    callBack.onSuccess = ^(NSObject *obj) {
      QAViewController *strongSelf = weakSelf;
      if (strongSelf) {
        QTRequestList *listObject = (QTRequestList *)obj;
        if (num == 0) {
          [self.mainArray removeAllObjects];
        }
        if (listObject.mainArray.count > 0) {
          [self.mainArray addObjectsFromArray:listObject.mainArray];
        }
        if (self.mainArray.count > 0) {
          self.loading.hidden = YES;
          QTRequestItem *item = self.mainArray[0];
          //用户签名
          [_delegate getArrayNum:[listObject.totalNum intValue]
                     andUserSign:item.userListItem.signature
                         andtype:self.type];
        } else {
          //用户签名
          [_delegate getArrayNum:[listObject.totalNum intValue] andUserSign:@"" andtype:self.type];
          [self.loading notDataStatus];
        }
        [userTableView reloadData];
      }
    };
    [QTRequestList getQTListWithUid:self.userId AndStart:num * 20 withCallback:callBack];
  } else {
    //用户发表的帖子
    HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
    __weak QAViewController *weakSelf = self;
    callBack.onCheckQuitOrStopProgressBar = ^{
      QAViewController *strongSelf = weakSelf;
      if (strongSelf) {
        [userTableView tableViewDidFinishedLoading];
        return NO;
      } else {
        return YES;
      }
    };
    callBack.onSuccess = ^(NSObject *obj) {
      QAViewController *strongSelf = weakSelf;
      if (strongSelf) {
        AWRequestList *listObject = (AWRequestList *)obj;
        if (num == 0) {
          [self.mainArray removeAllObjects];
        }
        if (listObject.mainArray.count > 0) {
          [self.mainArray addObjectsFromArray:listObject.mainArray];
        }
        if (self.mainArray.count > 0) {
          self.loading.hidden = YES;
          QTRequestItem *item = self.mainArray[0];
          //        用户签名
          [_delegate getArrayNum:[listObject.totalNum intValue]
                     andUserSign:item.userListItem.signature
                         andtype:self.type];

        } else {
          //        用户签名
          [_delegate getArrayNum:[listObject.totalNum intValue] andUserSign:@"" andtype:self.type];
          [self.loading notDataStatus];
        }
        [userTableView reloadData];
      }
    };
    [AWRequestList getAWListWithUid:self.userId AndStart:num * 20 withCallback:callBack];
  }
}
#pragma mark - PullingRefreshTableViewDelegate
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView {
  if (![FPYouguUtil isExistNetwork]) {
    [userTableView tableViewDidFinishedLoading];
    return;
  }
  num = 0;
  [self performSelector:@selector(refreshNewInfo) withObject:nil afterDelay:1.f];
}

- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView {
  if (![FPYouguUtil isExistNetwork]) {
    [userTableView tableViewDidFinishedLoading];
    return;
  }
  num++;
  if (num < 0) {
    num = 0;
  }
  [self performSelector:@selector(refreshNewInfo) withObject:nil afterDelay:1.f];
}
//刷新结束后，更变，更新刷新时间
- (NSDate *)pullingTableViewRefreshingFinishedDate {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";

  NSString *signLable = YouGu_StringWithFormat_Third(@"_refresh_time_date_UserListRefresh",
                                                     [@(self.type) stringValue], self.userId);
  //    特点的一片文章的评论
  NSDate *date = [dateFormatter dateFromString:signLable];
  if (refrash_is_have) {
    date = [NSDate date];
    NSString *date_ttime = [dateFormatter stringFromDate:date];
    [YouGu_default setObject:date_ttime forKey:signLable];
    refrash_is_have = NO;
  }
  return date;
}
#pragma mark - Scroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  //    任何情况下，下拉刷新，都是要可以的
  CGPoint offset = scrollView.contentOffset;
  if (offset.y < 0) {
    [userTableView tableViewDidScroll:scrollView];
    return;
  }

  //    其他情况，及，上拉刷新，是要再array_tableview数据不为0时，才可以刷新
  if ([self.mainArray count] < 20) {
    [userTableView My_add_hidden_view];
  } else if ([self.mainArray count] >= 20) {
    [userTableView My_add_cancel_hidden_view];
    [userTableView tableViewDidScroll:scrollView];
  }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
  [userTableView tableViewDidEndDragging:scrollView];
}
#pragma mark - 计算cell的高度，和，html的形成
//计算cell的高度
- (CGFloat)set_Cell_Height:(NSInteger)row {
  RTLabel *rtLabel = [QATableViewCell textLabel];
  [rtLabel setFont:[UIFont systemFontOfSize:15.0f]];
  [rtLabel setText:[self set_html_text:row]];
  rtLabel.lineSpacing = 10.0f;
  CGSize optimumSize = [rtLabel optimumSize];

  return optimumSize.height;
}
//组成html，的文本，
- (NSString *)set_html_text:(NSInteger)row {
  QTRequestItem *qtItem = self.mainArray[row];
  NSString *content = qtItem.userSummary;
  if ([qtItem.userBeNickname length] > 0) {
    content =
        [NSString stringWithFormat:@"<font size=15><font color=#14a5f0>回复%@:</font>%@</font>", qtItem.userBeNickname, content];
  }
  return content;
}
#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 60 + [self set_Cell_Height:indexPath.row];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.mainArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"QATableViewCell";
  QATableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] firstObject];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
  }
  [cell JudgeFirst:(indexPath.row == 0 ? YES : NO)];
  QTRequestItem *item = self.mainArray[indexPath.row];
  //    cell被选择一会的背景效果颜色
  cell.creatTimeLable.text = item.userCreattime;
  cell.contentLable.text = [self set_html_text:indexPath.row];
  return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:NO];

  QTRequestItem *qtItem = self.mainArray[indexPath.row];
  KnowDetailViewController *knowDetailVC = [[KnowDetailViewController alloc] initWithTalkId:qtItem.aid];
  [AppDelegate pushViewControllerFromRight:knowDetailVC];
  [tableView reloadData];
}

@end
