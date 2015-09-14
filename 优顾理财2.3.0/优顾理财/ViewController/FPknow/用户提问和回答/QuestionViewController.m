//
//  QuestionViewController.m
//  优顾理财
//
//  Created by Mac on 14-5-21.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "QuestionViewController.h"
#import "RTLabel.h"
#import "NonetFPviewController.h"

#define tableviewFixedHeight 80.0f

@interface QuestionViewController ()

@end

@implementation QuestionViewController

#pragma mark - pv, 初始化
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [MobClick beginLogPageView:@"My_question_list_view"];
  [[PV_view_sql sharedManager] PV_DB_DATA:@"My_question_list_view"];
}
- (void)viewWillDisappear:(BOOL)animated {
  [MobClick endLogPageView:@"My_question_list_view"];
  [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  [self.childView setUserInteractionEnabled:YES];
  [self CreatNavBarWithTitle:@"我的提问"];

  //评论资料
  Cai_array_tableview = [[NSMutableArray alloc] initWithCapacity:0];
  //列表
  Cai_NEWS_Tableview = [[PullingRefreshTableView alloc]
        initWithFrame:CGRectMake(0, 50, windowWidth,
                                 self.childView.frame.size.height - 50)
      pullingDelegate:self
        andRefresh_id:@"My_Questiong_VC"];
  Cai_NEWS_Tableview.dataSource = self;
  Cai_NEWS_Tableview.delegate = self;
  Cai_NEWS_Tableview.backgroundColor = [UIColor clearColor];
  [self.childView addSubview:Cai_NEWS_Tableview];
  Cai_NEWS_Tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
  Cai_NEWS_Tableview.separatorColor = [Globle colorFromHexRGB:lightCuttingLine];
  //去除多余的分割线
  [Cai_NEWS_Tableview
      setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];

  loading = [[LoadingView alloc]
      initWithFrame:CGRectMake(0, 50, windowWidth,
                               self.childView.frame.size.height - 50)];
  loading.delegate = self;
  [self.childView addSubview:loading];
  //暂无数据
  //底部控件
  reloadingView =
  [[BottomDefaultView alloc] initWithFrame:Cai_NEWS_Tableview.bounds];
  [Cai_NEWS_Tableview addSubview:reloadingView];
  reloadingView.hidden = YES;
  
  num = 0;
  [self loadData_Cai_1];

  self.view.backgroundColor = [Globle colorFromHexRGB:customBGColor];
  [Cai_NEWS_Tableview reloadData];

  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(refrash_loadData)
                                               name:@"My_question_refrash_data"
                                             object:nil];
}
//刷新数据
- (void)refrash_loadData {
  num = 0;
  [self loadData_Cai_1];
}

#pragma mark - NEWS_Nav_View 自定义导航条  按钮delegate 点击函数
- (void)leftButtonPress {
  [self.view endEditing:NO];
  [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - loading 代理方法
- (void)loadData_Cai {
  if (YouGu_Not_NetWork == NO) {
    num = 0;
    [self loadData_Cai_1];
  }
}
- (void)InfoManagementBtnClick {
  NonetFPviewController * defautVC =
  [[NonetFPviewController alloc] init];
  [AppDelegate pushViewControllerFromRight:defautVC];
}
#pragma mark - 数据请求
/**
 *
 *  //消息中心
 *
 **/
#pragma mark - 财知道 ，新闻正文页，包括用户基本信息，新闻详情信息，

//下载文章详情内容
- (void)loadData_Cai_1 {
  NSString *start_num = [NSString stringWithFormat:@"%d", num * 20];

  [[WebServiceManager sharedManager]
      User_fayan_query_uid:YouGu_User_USerid
                  andstart:start_num
                completion:^(NSDictionary *dic) {
                  if (dic &&
                      [dic[@"status"] isEqualToString:@"0000"]) {
                    loading.hidden = YES;
                    refrash_is_have = YES;

                    if (num == 0) {
                      [Cai_array_tableview removeAllObjects];
                      [Cai_array_tableview
                          addObjectsFromArray:[DicToArray
                                                  USER_Fa_dic_to_array:dic]];
                     
                    } else {
                      NSMutableArray *m_array =
                          [DicToArray USER_Fa_dic_to_array:dic];

                      if ([m_array count] == 0) {
                        //提示语，动画
                        YouGu_animation_Did_Start(@"没有更多数据");
                      } else {
                        [Cai_array_tableview addObjectsFromArray:m_array];
                      }
                    }
                    
                    if ([Cai_array_tableview count] == 0) {
                      reloadingView.hidden = NO;
                    }else{
                      reloadingView.hidden = YES;
                    }
                    [Cai_NEWS_Tableview reloadData];
                  } else {
                    reloadingView.hidden = YES;
                    // 访问失败
                    [loading btn_click];
                    NSString *message = [NSString
                        stringWithFormat:@"%@", dic[@"message"]];
                    if (!message || [message length] == 0 ||
                        [message isEqualToString:@"(null)"]) {
                      message = networkFailed;
                    }
                    //提示语，动画
                    YouGu_animation_Did_Start(message);
                  }
                  [Cai_NEWS_Tableview tableViewDidFinishedLoading];
                }];
}

#pragma mark - 计算cell的高度，和，html的形成
//组成html，的文本，
- (NSString *)set_html_text:(NSInteger)row {
  Cai_fayan_or_answer_TableData *fayan_list =
      Cai_array_tableview[row];

  NSString *Content_text_string = [self changle_string:row];
  if ([fayan_list.User_be_Nickname length] > 0) {
    Content_text_string = [NSString
        stringWithFormat:
            @"<font size=15><p><font color=#14a5f0>@%@:</font>%@</p></font>",
            fayan_list.User_be_Nickname, Content_text_string];
  }

  return Content_text_string;
}
- (NSString *)changle_string:(NSInteger)row {
  Cai_fayan_or_answer_TableData *fayan_list =
      Cai_array_tableview[row];

  while ([[fayan_list.User_summary componentsSeparatedByString:@"\n\n"] count] >
         1) {
    fayan_list.User_summary =
        [fayan_list.User_summary stringByReplacingOccurrencesOfString:@"\n\n"
                                                           withString:@"\n"];
  }
  return fayan_list.User_summary;
}

#pragma mark - Table view data source
/** 自定义分割线长度 */
- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  if ([Cai_NEWS_Tableview respondsToSelector:@selector(setSeparatorInset:)]) {
    [Cai_NEWS_Tableview setSeparatorInset:UIEdgeInsetsMake(0, 18.0f, 0, 18.0f)];
  }

  if ([Cai_NEWS_Tableview respondsToSelector:@selector(setLayoutMargins:)]) {
    [Cai_NEWS_Tableview setLayoutMargins:UIEdgeInsetsMake(0, 18.0f, 0, 18.0f)];
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
- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  Cai_fayan_or_answer_TableData *item =
      Cai_array_tableview[indexPath.row];
  return tableviewFixedHeight + item.summaryHeight;
}
- (NSInteger)tableView:(UITableView *)tableView
    indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
  return [Cai_array_tableview count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"MyAnswersCell";
  MyAnswersCell *cell = (MyAnswersCell *)
      [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier
                                          owner:self
                                        options:nil] firstObject];
  }
  Cai_fayan_or_answer_TableData *fayan_list =
      Cai_array_tableview[indexPath.row];

  [cell.headImageView.headImageView
       setImageWithURL:[NSURL URLWithString:fayan_list.User_User_pic_url]
      placeholderImage:[UIImage imageNamed:@"头像无网络"]];
  [cell.userNickNameButton setTitle:fayan_list.User_nick_name
                           forState:UIControlStateNormal];
  cell.answerTimeLabel.text = fayan_list.User_creattime;
  cell.answerContentLabel.text = fayan_list.User_summary;
  cell.answerNumLabel.hidden = NO;
  [cell refreshContentLabel:fayan_list.summaryHeight];
  //加v
  [cell.headImageView ishasVtype:[fayan_list.User_vtype intValue]];
  cell.answerNumLabel.text =
      [NSString stringWithFormat:@"回答数:%@", fayan_list.User_comment_num];
  // cell长按
  [cell.longPress addTarget:self action:@selector(cellLongProcess:)];

  return cell;
}
/** 按钮长按 */
- (void)cellLongProcess:(UILongPressGestureRecognizer *)ges {
  if (ges.state == UIGestureRecognizerStateBegan) {
    CGPoint location = [ges locationInView:Cai_NEWS_Tableview];
    NSIndexPath *indexPath =
        [Cai_NEWS_Tableview indexPathForRowAtPoint:location];
    longProcessIndex = indexPath.row;
    NSLog(@"indexPath.row = %ld", indexPath.row);
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
    Cai_fayan_or_answer_TableData *list =
        Cai_array_tableview[longProcessIndex];
    //我的提问，删除一栏
    [[WebServiceManager sharedManager]
        deleteTalkWithTalkId:list.User_aid
                withNickName:list.User_nick_name
              withCompletion:^(id response) {
                if (response && [[response objectForKey:@"status"]
                                    isEqualToString:@"0000"]) {
                  if (longProcessIndex < [Cai_array_tableview count]) {
                    //数组清除对应数据
                    [Cai_array_tableview removeObjectAtIndex:longProcessIndex];
                    [Cai_NEWS_Tableview reloadData];
                  }
                }
              }];
  }
}
- (BOOL)tableView:(UITableView *)tableView
    shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}
- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [UIView animateWithDuration:0.3f
                   animations:^{
                     [tableView deselectRowAtIndexPath:indexPath animated:YES];
                   }];
  Cai_fayan_or_answer_TableData *fayan_list =
      Cai_array_tableview[indexPath.row];

  //    获取talk_id
  YouGu_defaults_double(fayan_list.User_aid, @"Cai_NEWS_talk_id");

  KnowDetailViewController *knowDetailVC =
      [[KnowDetailViewController alloc] initWithTalkId:fayan_list.User_aid];
  [AppDelegate pushViewControllerFromRight:knowDetailVC];

  [tableView reloadData];
}
///** 删除某一行 */
//- (void)tableView:(UITableView *)tableView
// commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
// forRowAtIndexPath:(NSIndexPath *)indexPath{
//  [Cai_array_tableview removeObjectAtIndex:indexPath.row];
//  [tableView reloadData];
//}
#pragma mark - 注销
- (void)dealloc {
  [self.view removeAllSubviews];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - PullingRefreshTableViewDelegate
- (void)pullingTableViewDidStartRefreshing:
        (PullingRefreshTableView *)tableView {
  num = 0;
  [self performSelector:@selector(loadData_Cai_1)
             withObject:nil
             afterDelay:1.f];
}
- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView {
  num++;
  [self performSelector:@selector(loadData_Cai_1)
             withObject:nil
             afterDelay:1.f];
}

#pragma mark - 刷新结束后，更新刷新时间
//刷新结束后，更变，更新刷新时间
- (NSDate *)pullingTableViewRefreshingFinishedDate {
  NSString *Comment_refresh_id =
      [NSString stringWithFormat:@"_refresh_time_date_My_Questiong_VC"];

  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  //    特指的一片文章的评论
  NSString *date_time = [defaults objectForKey:Comment_refresh_id];
  NSDate *date = [dateFormatter dateFromString:date_time];
  if (refrash_is_have) {
    date = [NSDate date];
    NSString *date_ttime = [dateFormatter stringFromDate:date];
    [defaults setObject:date_ttime forKey:Comment_refresh_id];
    refrash_is_have = NO;
  }

  return date;
}

#pragma mark - Scroll

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  //    任何情况下，下拉刷新，都是要可以的
  CGPoint offset = scrollView.contentOffset;
  if (offset.y < 0) {
    [Cai_NEWS_Tableview tableViewDidScroll:scrollView];
    return;
  }

  //    其他情况，及，上拉刷新，是要再array_tableview数据不为0时，才可以刷新
  if ([Cai_array_tableview count] < 20) {
    [Cai_NEWS_Tableview My_add_hidden_view];
  } else if ([Cai_array_tableview count] >= 20) {
    [Cai_NEWS_Tableview My_add_cancel_hidden_view];
    [Cai_NEWS_Tableview tableViewDidScroll:scrollView];
  }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate {
  [Cai_NEWS_Tableview tableViewDidEndDragging:scrollView];
}

@end
