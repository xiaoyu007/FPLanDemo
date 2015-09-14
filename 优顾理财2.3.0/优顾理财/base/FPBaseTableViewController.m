//
//  FPBaseTableViewController.m
//  优顾理财
//
//  Created by Mac on 15/7/8.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

@interface FPBaseTableViewController ()

@end

@implementation FPBaseTableViewController
- (id)initWithFrame:(CGRect)frame
    AndRefreshLable:(NSString *)labletext{
  self = [super initWithFrame:frame];
  if (self) {
    self.isStatus = NO;
    _RefreshLable = labletext;
    
    //资讯新闻页下方的新闻标题
    _mainArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    _tableView = [[PullingRefreshTableView alloc]
                       initWithFrame:CGRectMake(0, 0, 320, self.childView.height)
                       pullingDelegate:self
                       andRefresh_id:labletext];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.childView addSubview:_tableView];
  }
  return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - 数据上啦，下拉 加载
- (void)loadData_Start {
  if (YouGu_Not_NetWork == YES) {
    [self.loading btn_click];
    [_tableView tableViewDidFinishedLoading];
    return;
  }
}
- (void)loadData_End {
  if (YouGu_Not_NetWork == YES) {
    [self.loading btn_click];
    [_tableView tableViewDidFinishedLoading];
    return;
  }
}

#pragma mark - PullingRefreshTableViewDelegate
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView*)tableView {
  [self performSelector:@selector(loadData_Start) withObject:nil afterDelay:1.0f];
}
- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView*)tableView {
  [self performSelector:@selector(loadData_End) withObject:nil afterDelay:1.0f];
}
//刷新结束后，更变，更新刷新时间
- (NSDate*)pullingTableViewRefreshingFinishedDate {
  NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
  
  //    特点的一片文章的评论
  NSString* key = YouGu_StringWithFormat_double(@"NewsListRefrash_",_RefreshLable);
  NSString* date_time = YouGu_defaults(key);
  NSDate* date = [dateFormatter dateFromString:date_time];
  
  YouGu_defaults_double(date_time, key);
  if (_isSuccess) {
    date = [NSDate date];
    NSString* date_ttime = [dateFormatter stringFromDate:date];
    YouGu_defaults_double(date_ttime, key);
    _isSuccess = NO;
  }
  return date;
}
#pragma mark - Scroll
- (void)scrollViewDidScroll:(UIScrollView*)scrollView {
  //    任何情况下，下拉刷新，都是要可以的
  CGPoint offset = scrollView.contentOffset;
  if (offset.y < 0) {
    [_tableView tableViewDidScroll:scrollView];
    return;
  }
  //    其他情况，及，上拉刷新，是要再array_tableview数据不为0时，才可以刷新
  if (_mainArray.count < 20) {
    [_tableView My_add_hidden_view];
  } else if (_mainArray.count >= 20) {
    [_tableView My_add_cancel_hidden_view];
    [_tableView tableViewDidScroll:scrollView];
  }
}

- (void)scrollViewDidEndDragging:(UIScrollView*)scrollView
                  willDecelerate:(BOOL)decelerate {
  [_tableView tableViewDidEndDragging:scrollView];
}

#pragma mark - Table view data source
/** 默认返回一个section */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

/** 默认返回数组的长度 */
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return _mainArray.count;
}

/** 子类必须实现的方法 */
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSException *ex =
  [NSException exceptionWithName:@"not implement exception"
                          reason:@"[tableView:cellForRowAtIndexPath:] "
   @"method is not implemented"
                        userInfo:nil];
  [ex raise];
  return nil;
}

/** 子类必须实现的方法 */
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSException *ex =
  [NSException exceptionWithName:@"not implement exception"
                          reason:@"[tableView:heightForRowAtIndexPath:] "
   @"method is not implemented"
                        userInfo:nil];
  [ex raise];
  return 0.0f;
}
@end
