//
//  FeedbackViewController.m
//  优顾理财
//
//  Created by Mac on 14-3-27.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "FeedbackViewController.h"
#import "FackBackCell.h"
#import "Json+Data_Nsstring.h"

//三角箭头

@implementation FeedbackViewController
@synthesize main_array;
@synthesize refrash_is_have;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}
#pragma mark - pv, 选择正确的pvjiem
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [MobClick beginLogPageView:@"Feedback"];
  [[PV_view_sql sharedManager] PV_DB_DATA:@"Feedback"];
}
- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [MobClick endLogPageView:@"Feedback"];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  [self CreatNavBarWithTitle:@"意见反馈"];

  main_array = [[NSMutableArray alloc] initWithCapacity:0];

  tableview_back =
      [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 50, 320, self.childView.frame.size.height - 50)
                                     pullingDelegate:self
                                       andRefresh_id:@"feed_back_view"];
  tableview_back.dataSource = self;
  tableview_back.delegate = self;
  tableview_back.backgroundColor = [UIColor clearColor];
  tableview_back.separatorStyle = UITableViewCellSeparatorStyleNone;
  [self.childView addSubview:tableview_back];

  //    添加
  [self add_headerView];

  //    发送意见反馈 按钮
  Summit_btn = [[clickLabel alloc] initWithFrame:CGRectMake(windowWidth - 100.0f, 0.0, 100.0f, 50.0f)];
  Summit_btn.font = [UIFont systemFontOfSize:18];
  Summit_btn.textAlignment = NSTextAlignmentCenter;
  Summit_btn.text = @"我要反馈";
  Summit_btn.backgroundColor = [UIColor clearColor];
  Summit_btn.textColor = [Globle colorFromHexRGB:customFilledColor];
  [Summit_btn addTarget:self action:@selector(Summit_btn_click:)];
  [self.childView addSubview:Summit_btn];

  [self loadData];
  self.view.backgroundColor = [Globle colorFromHexRGB:@"f1f1f1"];
  [tableview_back reloadData];
}

- (void)dealloc {
  [self.view removeAllSubviews];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)refrash_tableview {
  //  保存反馈意见
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSString *string = [defaults objectForKey:@"Feedback_text_data"];
  NSMutableArray *array4 = [NSMutableArray array];
  [array4 addObject:string];
  [array4 addObject:@"0"];
  [array4 addObject:@"刚刚"];
  //    [table_array addObject:array4];
  [main_array insertObject:array4 atIndex:0];

  [tableview_back reloadData];

  tableview_back.contentOffset = CGPointMake(0, 0);
}

- (void)Summit_btn_click:(UIButton *)sender {
  FeedbackWriteViewController *feedbackWriteVC = [[FeedbackWriteViewController alloc] init];
  feedbackWriteVC.delegate = self;
  [AppDelegate pushViewControllerFromRight:feedbackWriteVC];
}

#pragma mark - NEWS_Nav_View 自定义导航条  按钮delegate 点击函数
- (void)leftButtonPress {
  [self.view endEditing:NO];
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)read_plist {
  NSDictionary *dic =
      [[Json_Data_Nsstring sharedManager] json_to_document_file:@"FackBack_List.json"];
  if (dic && [dic count] > 0) {
    [self dic_to_array:dic];
  }
}

#pragma mark - loading 代理方法
- (void)refreshNewInfo {
 if ([FPYouguUtil isExistNetwork]) {
  [self loadData];
 }
}

#pragma mark - 请求数据,解析
- (void)dic_to_array:(NSDictionary *)dic {
  NSArray *ary = dic[@"result"];
  if ([ary count] > 0) {
    [main_array removeAllObjects];
  }
  for (NSDictionary *dd in ary) {
    NSMutableArray *array1 = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *array2 = [[NSMutableArray alloc] initWithCapacity:0];

    NSString *q = dd[@"q"];
    [array1 addObject:q];
    [array1 addObject:@"0"];
    NSString *qtime = dd[@"qtime"];
    [array1 addObject:qtime];

    NSString *a = dd[@"a"];
    if (a && ![a isEqualToString:@""]) {
      [array2 addObject:a];
      [array2 addObject:@"1"];
      NSString *qtime2 = dd[@"atime"];
      if ([qtime2 length] > 0) {
        [array2 addObject:qtime2];
      } else {
        [array2 addObject:@""];
      }
    }

    if ([array2 count] > 0) {
      [main_array addObject:array2];
    }
    [main_array addObject:array1];
  }
  [tableview_back reloadData];
}

#pragma mark - 请求数据
//请求数据
- (void)loadData {
  refrash_is_have = NO;

  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }

  [[WebServiceManager sharedManager] ShowFeedBackList_completion:^(NSDictionary *dic) {
    if (dic && [dic[@"status"] isEqualToString:@"0000"]) {
      [self dic_to_array:dic];
      refrash_is_have = YES;
    } else {
      NSString *message = [NSString stringWithFormat:@"%@", dic[@"message"]];
      if (!message || [message length] == 0 || [message isEqualToString:@"(null)"]) {
        message = networkFailed;
      }
      if (dic &&
          [dic[@"status"] isEqualToString:@"0101"]){
      }else{
        YouGu_animation_Did_Start(message);
      }
    }

    //        收回，刷新
    [tableview_back tableViewDidFinishedLoading];

  }];
}

#pragma mark - UITableViewDataSource
//计算cell的高度
- (CGFloat)set_Cell_Height:(NSInteger)row {
  NSString *cell_content_label_string = [main_array[row] objectAtIndex:0];

  RTLabel *rtLabel = [FackBackCell textLabel];
  [rtLabel setText:cell_content_label_string];
  CGSize optimumSize = [rtLabel optimumSize];
  return optimumSize.height;
}

//给tableview，加一个headerView
- (void)add_headerView {
  UIView *Header_View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 220)];
  Header_View.backgroundColor = [UIColor clearColor];

  PIC_View = [[PicUserHeader alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
  PIC_View.picImage.image = [UIImage imageNamed:@"小优.png"];
  [Header_View addSubview:PIC_View];

  TriangleView *San_Jioa = [[TriangleView alloc] initWithFrame:CGRectMake(54, 10, 250, 200)];
  [Header_View addSubview:San_Jioa];

  RTLabel *label_1 = [[RTLabel alloc] initWithFrame:CGRectMake(20, 10, 220, 100)];
  label_1.backgroundColor = [UIColor clearColor];
  [label_1 setFont:[UIFont systemFontOfSize:16.0f]];
  [label_1 setTextAlignment:RTTextAlignmentJustify];
  label_1.lineSpacing = 10;
  label_1.text =
      @"您好!" @"我" @"是" @"客服小优，您对我们的产品有什么意见或建议"
      @"欢迎您反馈给我" @"哦，我会尽力为您解答！我更多的联系方式:";
  [label_1 setParagraphReplacement:@""];
  [San_Jioa addSubview:label_1];

  UILabel *label_2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 120, 75, 20)];
  label_2.backgroundColor = [UIColor clearColor];
  label_2.text = @"客服电话:";
  label_2.textAlignment = NSTextAlignmentLeft;
  [label_2 setFont:[UIFont systemFontOfSize:16.0f]];
  [San_Jioa addSubview:label_2];

  NSString *html = @"<html>"
                    "<head>"
                    "<meta name='viewport'"
                    "content='width=device-width; initial-scale=1.0; maximum-scale=10.0;'"
                    ">"
                    "<style type=\"text/css\">"
                    "body"
                    "{"
                    "margin: 0px;"
                    "padding: 5px;"
                    "}"
                    "#Content a:link {"
                    "color:#0E89E1;"
                    "text-decoration:underline;"
                    "}"
                    "#Content a:visiteid,"
                    "#Content a:hover,"
                    "#Content a:active,"
                    "</style>"
                    "</head>"
                    "<body>"
                    "<div>"
                    "<div id=\"Content\"><a>010-80443260</a></div>"
                    "</div>"
                    "</body>"
                    "</html>";
  UIWebView *webview_telephone = [[UIWebView alloc] initWithFrame:CGRectMake(90, 115, 130, 20)];
  webview_telephone.dataDetectorTypes = UIDataDetectorTypeAll;
  webview_telephone.delegate = self;
  //    给webview的背景色，色透明
  webview_telephone.backgroundColor = [UIColor clearColor];
  [webview_telephone setOpaque:NO];
  [(UIScrollView *) [webview_telephone subviews][0] setScrollEnabled:NO];
  //    防止头部和底部，在往外滑动
  [(UIScrollView *) [webview_telephone subviews][0] setBounces:NO];
  [San_Jioa addSubview:webview_telephone];
  [webview_telephone loadHTMLString:html baseURL:nil];

  UILabel *label_3 = [[UILabel alloc] initWithFrame:CGRectMake(20, 145, 220, 20)];
  label_3.backgroundColor = [UIColor clearColor];
  label_3.text = @"客服微信: yougulicai";
  label_3.textAlignment = NSTextAlignmentLeft;
  [label_3 setFont:[UIFont systemFontOfSize:16.0f]];
  [San_Jioa addSubview:label_3];

  UILabel *label_4 = [[UILabel alloc] initWithFrame:CGRectMake(20, 170, 220, 20)];
  label_4.backgroundColor = [UIColor clearColor];
  label_4.text = @"客服QQ:  1794375331";
  label_4.textAlignment = NSTextAlignmentLeft;
  [label_4 setFont:[UIFont systemFontOfSize:16.0f]];
  [San_Jioa addSubview:label_4];

  label_1.textColor = [UIColor blackColor];
  label_2.textColor = [UIColor blackColor];
  label_3.textColor = [UIColor blackColor];
  label_4.textColor = [UIColor blackColor];

  tableview_back.tableHeaderView = Header_View;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
  // Disable user selection
  //    [webView
  //    stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
  // Disable callout
  [webView stringByEvaluatingJavaScriptFromString:
               @"document.documentElement.style.webkitTouchCallout='none';"];
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if ([main_array count] == 0) {
    return 0;
  }

  return 55 + [self set_Cell_Height:indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  // Return the number of rows in the section.
  return [main_array count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"Feedback_Cell";
  FackBackCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

  if (!cell) {
    cell = [[FackBackCell alloc] initWithStyle:UITableViewCellStyleDefault
                               reuseIdentifier:CellIdentifier];
  }
  NSString *cell_data = [main_array[indexPath.row] objectAtIndex:1];
  cell.Text_Content.text = [main_array[indexPath.row] objectAtIndex:0];

  [cell Select_Users:[cell_data intValue] andHeight:[self set_Cell_Height:indexPath.row]];
  cell.lable_time.text = [main_array[indexPath.row] objectAtIndex:2];
  //    cell被选择一会的背景效果颜色
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  return cell;
}
#pragma mark - PullingRefreshTableViewDelegate
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView {
  //    刷新数据
  [self performSelector:@selector(loadData) withObject:nil afterDelay:1.f];
}
- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView {
}
//刷新结束后，更变，更新刷新时间
- (NSDate *)pullingTableViewRefreshingFinishedDate {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
  
  //    特点的一片文章的评论
  NSString *key = YouGu_StringWithFormat_double(@"NewsListRefrash_", @"feed_back_view");
  NSString *date_time = YouGu_defaults(key);
  NSDate *date = [dateFormatter dateFromString:date_time];
  
  YouGu_defaults_double(date_time, key);
  if (refrash_is_have) {
    date = [NSDate date];
    NSString *date_ttime = [dateFormatter stringFromDate:date];
    YouGu_defaults_double(date_ttime, key);
    refrash_is_have = NO;
  }
  return date;
}

#pragma mark - Scroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  //    任何情况下，下拉刷新，都是要可以的
  CGPoint offset = scrollView.contentOffset;
  if (offset.y < 0) {
    [tableview_back tableViewDidScroll:scrollView];
    return;
  } else {
    [tableview_back My_add_hidden_view];
  }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
  [tableview_back tableViewDidEndDragging:scrollView];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
