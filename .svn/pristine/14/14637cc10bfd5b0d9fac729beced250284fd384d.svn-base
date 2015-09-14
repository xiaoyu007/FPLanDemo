//
//  MyCommentViewController.m
//  优顾理财
//
//  Created by Mac on 15-4-9.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPMyCommentViewController.h"
#import "FPMyCommentCell.h"
#import "FPMyCommentItem.h"
#import "DateChangeSimple.h"
#import "NoNetWorkViewController.h"
#import "NewsDetailViewController.h"

#define cellFixedHeight 70.0f
#define pageSize @"20"

@implementation FPMyCommentViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self CreatNavBarWithTitle:@"我的评论"];
  commentListArray = [[NSMutableArray alloc] init];
  [self createTableview];
}
/** 创建表格 */
- (void)createTableview {
  myCommentTableview =
      [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, navigationHeght, windowWidth, windowHeight - navigationHeght - statusBarHeight)
                                     pullingDelegate:self
                                       andRefresh_id:@"My_Comment_VC"];
  myCommentTableview.dataSource = self;
  myCommentTableview.delegate = self;
  myCommentTableview.backgroundColor = [UIColor clearColor];
  myCommentTableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
  myCommentTableview.separatorColor = [Globle colorFromHexRGB:lightCuttingLine];
  [self.childView addSubview:myCommentTableview];
  //去除多余的分割线
  [myCommentTableview setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];

  //底部控件
  reloadingView = [[BottomDefaultView alloc] initWithFrame:myCommentTableview.bounds];
  [myCommentTableview addSubview:reloadingView];
  reloadingView.hidden = YES;

  [self refreshNewInfo];
  pageNumber = 0;

  self.view.backgroundColor = [Globle colorFromHexRGB:customBGColor];
  [myCommentTableview reloadData];
}
//刷新数据
- (void)refrash_loadData {
  pageNumber = 0;
  [self sendRequestWithCommentListWithStartNum:@"0"];
}
#pragma mark - NEWS_Nav_View 自定义导航条  按钮delegate 点击函数
- (void)leftButtonPress {
  [self.view endEditing:NO];
  [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - loading 代理方法
- (void)refreshNewInfo {
  if ([FPYouguUtil isExistNetwork]) {
    pageNumber = 0;
    [self sendRequestWithCommentListWithStartNum:@"0"];
  }
}
- (void)InfoManagementBtnClick {
  NoNetWorkViewController *defautVC = [[NoNetWorkViewController alloc] init];
  [AppDelegate pushViewControllerFromRight:defautVC];
}

#pragma mark - 获取数据
- (void)sendRequestWithCommentListWithStartNum:(NSString *)startNum {
  [[WebServiceManager sharedManager]
      loadCommentListWithUserId:YouGu_User_USerid
                   withStartNum:startNum
                   withPageSize:pageSize
                 withCompletion:^(id response) {
                   if (response && [[response objectForKey:@"status"] isEqualToString:@"0000"]) {
                     refrash_is_have = YES;
                     //解析
                     [self showCommentListsWithResponse:response];
                   } else {
                     // 访问失败
                     //      [reloadingView btn_click];
                     NSString *message =
                         [NSString stringWithFormat:@"%@", [response objectForKey:@"message"]];
                     if (!message || [message length] == 0 || [message isEqualToString:@"(null)"]) {
                       message = networkFailed;
                     }
                     YouGu_animation_Did_Start(message);
                   }
                   [myCommentTableview tableViewDidFinishedLoading];
                 }];
}
- (void)showCommentListsWithResponse:(NSDictionary *)dict {
  if (pageNumber == 0) {
    [commentListArray removeAllObjects];
    [commentListArray addObjectsFromArray:[DicToArray parseCommentListsWithDict:dict]];
    if ([commentListArray count] == 0) {
      //提示语，动画
      reloadingView.hidden = NO;
    } else {
      reloadingView.hidden = YES;
    }
  } else {
    reloadingView.hidden = YES;
    NSMutableArray *m_array = [DicToArray parseCommentListsWithDict:dict];
    if ([m_array count] == 0) {
      //提示语，动画
      YouGu_animation_Did_Start(@"没有更多数据");
    } else {
      [commentListArray addObjectsFromArray:[DicToArray parseCommentListsWithDict:dict]];
    }
  }
  [myCommentTableview reloadData];
}
#pragma mark -tableView的代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [commentListArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  FPMyCommentItem *item = commentListArray[indexPath.row];
  return cellFixedHeight + item.commentContentHeight;
}
/** 自定义分割线长度 */
- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  if ([myCommentTableview respondsToSelector:@selector(setSeparatorInset:)]) {
    [myCommentTableview setSeparatorInset:UIEdgeInsetsMake(0, 18.0f, 0, 18.0f)];
  }

  if ([myCommentTableview respondsToSelector:@selector(setLayoutMargins:)]) {
    [myCommentTableview setLayoutMargins:UIEdgeInsetsMake(0, 18.0f, 0, 18.0f)];
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
  static NSString *ID = @"FPMyCommentCell";
  FPMyCommentCell *cell = (FPMyCommentCell *)[tableView dequeueReusableCellWithIdentifier:ID];
  if (!cell) {
    cell = [[[NSBundle mainBundle] loadNibNamed:ID owner:self options:nil] firstObject];
  }
  FPMyCommentItem *item = commentListArray[indexPath.row];
  cell.commentTitleLabel.text = item.commentTitle;
  cell.commentTimeLabel.text = [[DateChangeSimple sharedManager] get_time_date:item.commentTime];
  cell.commentContentLabel.height = item.commentContentHeight;

  cell.commentContentLabel.attributedText = item.attrString;

  return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [UIView animateWithDuration:0.3f
                   animations:^{
                     [tableView deselectRowAtIndexPath:indexPath animated:YES];
                   }];
  //跳转
  FPMyCommentItem *item = commentListArray[indexPath.row];

  NewsDetailViewController *detailVC = [[NewsDetailViewController alloc] initWithChannlId:@"1"
                                                                                andNewsId:item.articleId
                                                                                  Andxgsj:@"1"];
  [AppDelegate pushViewControllerFromRight:detailVC];
}
#pragma mark - 注销
- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - PullingRefreshTableViewDelegate
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView {
  pageNumber = 0;
  [self performSelector:@selector(sendRequest) withObject:nil afterDelay:1.f];
}
/** 延迟加载 */
- (void)sendRequest {
  [self sendRequestWithCommentListWithStartNum:[NSString stringWithFormat:@"%d", pageNumber * 20]];
}
- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView {
  pageNumber++;
  [self performSelector:@selector(sendRequest) withObject:nil afterDelay:1.0f];
}

#pragma mark - 刷新结束后，更新刷新时间
//刷新结束后，更变，更新刷新时间
- (NSDate *)pullingTableViewRefreshingFinishedDate {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  //    特指的一片文章的评论
  NSString *date_time = [defaults objectForKey:@"_refresh_time_date_My_Comment_VC"];
  NSDate *date = [[DateChangeSimple sharedManager] dateStringSwitchToDate:date_time];
  if (refrash_is_have) {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    date = [NSDate date];
    NSString *date_ttime = [dateFormatter stringFromDate:date];
    [defaults setObject:date_ttime forKey:@"_refresh_time_date_My_Comment_VC"];
    refrash_is_have = NO;
  }

  return date;
}

#pragma mark - Scroll

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  //    任何情况下，下拉刷新，都是要可以的
  CGPoint offset = scrollView.contentOffset;
  if (offset.y < 0) {
    [myCommentTableview tableViewDidScroll:scrollView];
    return;
  }
  //    其他情况，及，上拉刷新，是要再array_tableview数据不为0时，才可以刷新
  if ([commentListArray count] < 20) {
    [myCommentTableview My_add_hidden_view];
  } else if ([commentListArray count] >= 20) {
    [myCommentTableview My_add_cancel_hidden_view];
    [myCommentTableview tableViewDidScroll:scrollView];
  }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
  [myCommentTableview tableViewDidEndDragging:scrollView];
}

@end
