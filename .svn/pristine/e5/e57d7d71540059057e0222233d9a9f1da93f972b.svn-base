//
//  MessageCenterViewController.m
//  优顾理财
//
//  Created by Mac on 14-7-7.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//
#import "BottomDefaultView.h"
#import "MessageCenterViewController.h"
#import "KnowDetailViewController.h"

#import "FPKnowTableViewCell.h"

@implementation MessageCenterViewController {
  BottomDefaultView *bottomView;
}
- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self start];
  }
  return self;
}
- (void)start {
  refrashIsHave = NO;
  //数据 数组
  self.backgroundColor = [Globle colorFromHexRGB:customBGColor];
  caiTableview =
      [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, windowWidth, self.frame.size.height)
                                     pullingDelegate:self
                                       andRefresh_id:@"MessageCenterVC"];
  caiTableview.backgroundColor = [UIColor clearColor];
  caiTableview.dataSource = self;
  caiTableview.delegate = self;
  [self addSubview:caiTableview];
  caiTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
  //去除多余的分割线
  [caiTableview setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
  bottomView = [[BottomDefaultView alloc] initWithFrame:caiTableview.bounds];
  [self addSubview:bottomView];
  bottomView.hidden = YES;

  requestIndex = 0;
  caiTableviewArray = [[NSMutableArray alloc] initWithCapacity:0];
  //数据请求
  [self refreshNewInfo];
  [caiTableview reloadData];
}

#pragma mark - refreshNewInfo
- (void)refreshNewInfo {
  if (requestIndex > 0) {
    //防止上拉重复
    if (requestIndex == lastRequestIndex) {
      [caiTableview tableViewDidFinishedLoading];
      return;
    } else {
      lastRequestIndex = requestIndex;
    }
  }
  HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
  __weak MessageCenterViewController *weakSelf = self;
  callBack.onCheckQuitOrStopProgressBar = ^{
    MessageCenterViewController *strongSelf = weakSelf;
    if (strongSelf) {
      [caiTableview tableViewDidFinishedLoading];
      return NO;
    } else {
      return YES;
    }
  };
  callBack.onSuccess = ^(NSObject *obj) {
    MessageCenterViewController *strongSelf = weakSelf;
    if (strongSelf) {
      KnowMessageList *object = (KnowMessageList *)obj;
      if (requestIndex == 0) {
        [caiTableviewArray removeAllObjects];
      }
      if (object.listArray.count > 0) {
        [caiTableviewArray addObjectsFromArray:object.listArray];
      } else { // 提示语，动画
        YouGu_animation_Did_Start(@"暂无更多数据");
      }
      if ([caiTableviewArray count] > 0) {
        bottomView.hidden = YES;
      } else {
        bottomView.hidden = NO;
      }
      //              刷新
      [caiTableview reloadData];
    }
  };
  [KnowMessageList getMessageListWithStart:[@(requestIndex) stringValue] withCallback:callBack];
}

#pragma mark - PullingRefreshTableViewDelegate
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView {
  requestIndex = 0;
  [self performSelector:@selector(refreshNewInfo) withObject:nil afterDelay:1.f];
}
- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView {
  [self performSelector:@selector(refreshNewInfo) withObject:nil afterDelay:1.f];
}

#pragma mark - 刷新结束后，更新刷新时间
//刷新结束后，更变，更新刷新时间
- (NSDate *)pullingTableViewRefreshingFinishedDate {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
  NSString *key = YouGu_StringWithFormat_double(@"NewsListRefrash_", @"MessageCenterVC");
  NSString *date_time = YouGu_defaults(key);
  NSDate *date = [dateFormatter dateFromString:date_time];
  YouGu_defaults_double(date_time, key);
  if (refrashIsHave) {
    date = [NSDate date];
    NSString *date_ttime = [dateFormatter stringFromDate:date];
    YouGu_defaults_double(date_ttime, key);
    refrashIsHave = NO;
  }
  return date;
}

#pragma mark - Scroll

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  //    任何情况下，下拉刷新，都是要可以的
  CGPoint offset = scrollView.contentOffset;
  if (offset.y < 0) {
    [caiTableview tableViewDidScroll:scrollView];
    return;
  }

  //    其他情况，及，上拉刷新，是要再array_tableview数据不为0时，才可以刷新
  if ([caiTableviewArray count] < 20) {
    [caiTableview My_add_hidden_view];
  } else if ([caiTableviewArray count] >= 20) {
    [caiTableview My_add_cancel_hidden_view];
    [caiTableview tableViewDidScroll:scrollView];
  }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
  [caiTableview tableViewDidEndDragging:scrollView];
}

//获取文本
- (NSString*)cell_text:(int)row {
  knownewItem* item = caiTableviewArray[row];
  NSString* content = [self changle_string:row];
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

- (NSString*)changle_string:(NSInteger)row {
  knownewItem* item = caiTableviewArray[row];
  while ([[item.summary componentsSeparatedByString:@"\n\n"] count] > 1) {
    item.summary = [item.summary stringByReplacingOccurrencesOfString:@"\n\n" withString:@"\n"];
  }
  return item.summary;
}

//计算cell的高度
- (CGFloat)set_Cell_Height:(NSInteger)row {
  RTLabel *rtLabel = [FPKnowTableViewCell textLabel];
  [rtLabel setText:[self cell_text:(int)row]];
  rtLabel.lineSpacing = 10.0f;
  CGSize optimumSize = [rtLabel optimumSize];
  return optimumSize.height;
}
//组成html，的文本，
- (NSString*)set_html_text:(NSInteger)row {
  knownewItem* item = caiTableviewArray[row];
  NSString *content = [self changle_string:row];
  //客户端发帖
  if (item.sourceType == 7) {
    content = [NSString stringWithFormat:@"<p><font color=#14a5f0>回复我:</font></p><p><font "
                                         @"color=#656565> %@</font></p>",
                                         content];
  } else if (item.sourceType == 2) {
    content = [NSString stringWithFormat:@"<p><font color=#14a5f0>@我:</font></p><p><font "
                                         @"color=#656565> %@</font></p>",
                                         content];
  } else if (item.sourceType == 3) {
    content = [NSString stringWithFormat:@"<p><font color=#14a5f0>评论我:</font></p><p><font "
                                         @"color=#656565> %@</font></p>",
                                         content];
  } else if (item.sourceType == 4) {
    content = [NSString stringWithFormat:@"<p><font color=#14a5f0>%@:</font></p><p><font "
                                         @"color=#656565> %@</font></p>",
                                         @"消息通知", content];
  }
  return content;
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 85 + [self set_Cell_Height:indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  // Return the number of rows in the section.
  return [caiTableviewArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"FPKnowTableViewCell";
  FPKnowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[FPKnowTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    //    cell被选择一会的背景效果颜色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
  }
  if ([caiTableviewArray count] > 0) {
    knownewItem* item = caiTableviewArray[indexPath.row];
    if (item.sourceType == 6) {
      [cell systemDefaultWithPic:@"喇叭.png" andNickname:@"系统消息"];
    } else {
      cell.userListItem = item.userListItem;
    }
    cell.timeLable.text = item.creatTime;
  }
  cell.praiseNum.hidden = YES;
  //cell的具体内容
  cell.contentLable.text = [self set_html_text:indexPath.row];
  cell.contentLable.text =@"skdjfakl;dafklsdjfklasjdflkajsdkl;fjadkls;jfakls;djflk";
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if ([caiTableviewArray count] > indexPath.row) {
    knownewItem* item = caiTableviewArray[indexPath.row];
    [YouGu_default setObject:@"0" forKey:@"is_unread_push"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Push_Cai_message_is_unread_push"
                                                        object:nil];
    KnowDetailViewController *knowDetailVC = [[KnowDetailViewController alloc] initWithTalkId:item.aid];
    [AppDelegate pushViewControllerFromRight:knowDetailVC];
  }
  [tableView reloadData];
}

#pragma mark - 注销
- (void)dealloc {
  [self removeAllSubviews];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
