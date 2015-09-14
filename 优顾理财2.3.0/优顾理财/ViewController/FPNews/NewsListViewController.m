//
//  NewsListViewController.m
//  优顾理财
//
//  Created by Mac on 15/6/30.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "NewsListViewController.h"
#import "NewsListTableViewCell.h"
#import "SQLDataHtmlstring.h"
#import "FPNewsPushUtil.h"

#import "StockMarketTableViewCell.h"
#import "Stock_Market_ViewController.h"

@implementation NewsListViewController
#pragma mark - init 初始化
- (id)initWithFrame:(CGRect)frame
      withChannelID:(NSString *)channelId
    withChannelName:(NSString *)name {
  NSString *newsRefrashLable = YouGu_StringWithFormat_double(@"NEWS_refresh_", channelId);
  self = [super initWithFrame:frame AndRefreshLable:newsRefrashLable];
  if (self) {
    _Channlid = channelId;
    _Name = name;
    ///消息中心
    [self creatNSNotificationCenter];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.loading.hidden = NO;
  self.isStatus = NO;
  [self registerNibCell];
  //资讯新闻页上方的滚动图片
  _headerArray = [[NSMutableArray alloc] initWithCapacity:0];
}

//注册NibCell
- (void)registerNibCell {
  UINib *newsCellNib =
      [UINib nibWithNibName:NSStringFromClass([NewsListTableViewCell class]) bundle:nil];
  [self.tableView registerNib:newsCellNib forCellReuseIdentifier:@"NewsListTableViewCell"];

  UINib *marketCellNib =
      [UINib nibWithNibName:NSStringFromClass([StockMarketTableViewCell class]) bundle:nil];
  [self.tableView registerNib:marketCellNib forCellReuseIdentifier:@"StockMarketTableViewCell"];
}

- (void)creatNSNotificationCenter {
  ///闭市时刷新
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(Refrash_stock_Market)
                                               name:@"Refrash_stock_Market"
                                             object:nil];
  ///是否自动刷新
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(isAutoRefresh)
                                               name:@"isAutoRefresh"
                                             object:_Channlid];
  //登陆成功，刷新赞的数据
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(refreshPraiseData)
                                               name:@"LoginNotificationCenter"
                                             object:nil];
}
- (void)refreshPraiseData {
  [self.dataArray.array enumerateObjectsUsingBlock:^(NewsInChannelItem *item, NSUInteger idx, BOOL *stop) {
    item.isPraise = [[PraiseObject sharedManager] isDonePraise:item.newsID];
  }];
  if (self.dataArray.array && self.dataArray.array.count > 0) {
    [self.tableView reloadData];
  }
}

#pragma mark - 行情数据刷新
- (void)Refrash_stock_Market {
  if ([_Channlid isEqualToString:@"1"]) {
    if ([FPYouguUtil isOpening]) {
      if (self.dataArray.array && self.dataArray.array.count > 0) {
        [self.tableView reloadData];
      }
    }
  }
}
#pragma mark - 无网络时，重新刷新数据
- (void)refreshNewInfo {
  if (![FPYouguUtil isExistNetwork]) {
    self.loading.hidden = NO;
    [self.loading animationNoNetWork];
  } else {
    [self refreshButtonPressDown];
  }
}
- (void)refreshButtonPressDown {
  //    读取本地数据
  if (!self.dataArray.dataBinded) {
    NewsListInChannel *list = [FileChangelUtil loadNewsTeamListData:self.Channlid];
    if (list && list.newsList.count > 0) {
      self.loading.hidden = YES;
      [self refreshTableView:list];
    }
  }

  //如果是离线阅读，不进行网络请求
  if (!_isOfflineRead) {
    if (![FPYouguUtil isExistNetwork]) {
      YouGu_animation_Did_Start(networkFailed);
      [self.loading animationNoNetWork];
      return;
    }
    self.refrashIndex = 0;
    [self requestData];
    return;
  } else {
    if (!self.dataArray.dataBinded) {
      YouGu_animation_Did_Start(networkFailed);
      [self.loading animationNoNetWork];
    }
  }
}
#pragma mark - 新闻首页的头图
//增加头部轮动图
- (void)addScrollTableViewHeader {
  if (!_tableHeader) {
    _tableHeader = [[EScrollerView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 160)];
    _tableHeader.clipsToBounds = YES;
    _tableHeader.delegate = self;
  }
  [_tableHeader change_images:self.headerArray];
  self.tableView.tableHeaderView = self.tableHeader;
}
//点击小scrollview，跳转
- (void)EScrollerViewDidClicked:(NSUInteger)index {
  //    判断是，0，普通文章，1热点专题 3普通专题
  NewsInChannelItem *headerObject = _headerArray[index];
  headerObject.newsChannlid = _Channlid;
  [FPNewsPushUtil PushToOtherViewController:headerObject
                              isOfflineRead:self.isOfflineRead
                          andPraiseCallBack:^(BOOL isPraise){
                          }];
}
#pragma mark - 复写父类fpNOtitleTableview的方法
- (void)returnBlock:(NSObject *)obj {
  NewsListInChannel *listObject = (NewsListInChannel *)obj;
  if (listObject && listObject.newsList.count > 0) {
    if (self.refrashIndex == 0) {
      [FileChangelUtil saveNewsTeamListData:listObject andChanleId:self.Channlid];
    }
    [self refreshTableView:listObject];
  }
  //  [self autoRefrashList];
}
- (void)returnFail {
  if (self.dataArray.array && self.dataArray.array.count > 0) {

  } else {
    self.loading.hidden = NO;
    [self.loading animationNoNetWork];
  }
}
- (void)requestData {
  HttpRequestCallBack *callBack = [self getHttpCallBack];
  [NewsListInChannel requestNewsListWithChannlid:_Channlid
                                        andStart:self.refrashIndex * 20
                                    withCallback:callBack];
  if (self.refrashIndex == 0) {
    if (![FPYouguUtil isOpening]) {
      if ([_Channlid isEqualToString:@"1"] || [_Channlid isEqualToString:@"2"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshStockInfoManual"
                                                            object:nil];
      }
    }
  }
}
- (void)refreshTableView:(NewsListInChannel *)listObject {
  if (listObject) {
    self.dataArray.dataBinded = YES;
    if (self.refrashIndex == 0) {
      [self.dataArray.array removeAllObjects];
      //清空inford_array数据从新加载
      [_headerArray removeAllObjects];
    }
    if (listObject.headerList.count > 0) {
      [_headerArray removeAllObjects];
      [_headerArray addObjectsFromArray:listObject.headerList];
    }
    if (_headerArray.count > 0) {
      [self addScrollTableViewHeader];
    }
    if (listObject.newsList.count > 0) {
      [self.dataArray.array addObjectsFromArray:listObject.newsList];
    }
    if (self.dataArray.array.count > 0) {
      [self.tableView reloadData];
      self.loading.hidden = YES;
    } else {
      //      [self.loading notDataStatus];
      //      self.loading.hidden = NO;
    }
  }
}
#pragma mark - Tableview data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  if (section == 0) {
    return 0;
  }
  return 0.1;
}
//计算cell的高度
- (CGFloat)set_Cell_Height:(NSInteger)row {
  if (self.dataArray.array.count <= 0)
    return 0;
  NewsInChannelItem *news_list = self.dataArray.array[row];
  RTLabel *rtLabel = [NewsListTableViewCell textLabel];
  [rtLabel setText:news_list.newsIntroduction];
  CGSize optimumSize = [rtLabel optimumSize];
  return optimumSize.height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    return 87;
  }
  if (indexPath.section == 1) {
    return 50 + [self set_Cell_Height:indexPath.row];
  }
  return 0;
}
/** 默认返回数组的长度 */
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  if (self.dataArray.array.count>0) {
    if (section == 0) {
      if (([_Channlid isEqualToString:@"1"]&&[FPYouguUtil isOpening]) || [_Channlid isEqualToString:@"2"]) {
        return 1;
      }
    }else if (section == 1) {
      return self.dataArray.array.count;
    }
  }
  return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    static NSString *cellId = @"StockMarketTableViewCell";
    StockMarketTableViewCell *cell =
        (StockMarketTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];

    //    //    cell被选择一会的背景效果颜色
    //    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
  }

  static NSString *cellId = @"NewsListTableViewCell";
  NewsListTableViewCell *cell = (NewsListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];

  //    中间变量
  NewsInChannelItem *item = self.dataArray.array[indexPath.row];
  cell.titleName.text = item.title;
  cell.isRead = item.is_or_read;
  cell.newsIntroduction.text = item.newsIntroduction;
  cell.isTopicid = [item.wzlx intValue];
  cell.praisenum = [item.praise intValue];
  cell.isPraise = item.isPraise;
  cell.praiseBtn.tag = 5000 + indexPath.row;
  cell.praiseLable.hidden = YES;
  [cell.praiseBtn addTarget:self
                     action:@selector(praiseBtnClick:)
           forControlEvents:UIControlEventTouchUpInside];
  return cell;
}
- (void)praiseBtnClick:(UIButton *)sender {
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  if (self.dataArray.array.count > sender.tag - 5000) {
    NewsInChannelItem *newsObject = self.dataArray.array[sender.tag - 5000];
    if (newsObject.isPraise) {
      YouGu_animation_Did_Start(@"您已赞过了");
    } else {
      HttpRequestCallBack *callback = [[HttpRequestCallBack alloc] init];
      __weak NewsListViewController *weakSelf = self;
      callback.onSuccess = ^(NSObject *obj) {
        NewsListViewController *strongSelf = weakSelf;
        if (strongSelf) {
          [[PraiseObject sharedManager] addPraise:1 andTalkId:newsObject.newsID];
          newsObject.praise = [@([newsObject.praise intValue] + 1) stringValue];
          newsObject.isPraise = YES;
        }
      };
      [NewsItemPraise requestNewsItemWithNewsId:newsObject.newsID
                                    AndChannlid:_Channlid
                                   withCallback:callback];
    }
  }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:NO];
  if (indexPath.section == 0) {
//    Stock_Market_ViewController *stockVC = [[Stock_Market_ViewController alloc] init];
//    [AppDelegate pushViewControllerFromRight:stockVC];
  }else if (indexPath.section == 1) {
    if (self.dataArray.array.count > indexPath.row) {
      NewsInChannelItem *newsObject = self.dataArray.array[indexPath.row];
      __weak NewsListViewController *weakSelf = self;
      newsObject.newsChannlid = _Channlid;
      newsObject.is_or_read = YES;
      [FPNewsPushUtil
          PushToOtherViewController:newsObject
                      isOfflineRead:self.isOfflineRead
                  andPraiseCallBack:^(BOOL isPraise) {
                    if (isPraise) {
                      NewsListViewController *strongSelf = weakSelf;
                      if (strongSelf) {
                        [strongSelf refreshOneCellWithTableview:tableView withIndexPath:indexPath];
                      }
                    }
                  }];
      [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
  }
}
/** 赞成功刷新表格 */
- (void)refreshOneCellWithTableview:(UITableView *)tableview
                      withIndexPath:(NSIndexPath *)indexPath {
  NewsInChannelItem *newsObject = self.dataArray.array[indexPath.row];
  newsObject.isPraise = YES;
  newsObject.praise = [NSString stringWithFormat:@"%ld", (long)[newsObject.praise integerValue] + 1];

  [self.tableView reloadRowsAtIndexPaths:@[ indexPath ]
                        withRowAnimation:UITableViewRowAnimationNone];
}
#pragma mark - 消息中心的方法 methods
//导航条上的刷新按钮
- (void)isAutoRefresh {
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  //   当前页是否超过30分钟，刷新当前页
  BOOL isRefrash = [FPYouguUtil isAutoRefrashList:self.Channlid];
  if (isRefrash) {
    NSString *key = YouGu_StringWithFormat_double(@"start_time_", _Channlid);
    NSString *start_time = TodayTimeToString();
    [[NSUserDefaults standardUserDefaults] setObject:start_time forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self autoRefrashList];
    [self.tableView launchRefreshing];
  }
}
///自动下拉刷新
- (void)autoRefrashList {
  if (![FPYouguUtil isExistNetwork]) {
    if (self.dataArray.array.count == 0 && _headerArray.count == 0) {
      [self.loading animationNoNetWork];
    }
  }
  if (self.dataArray && self.dataArray.array.count > 0) {
    self.loading.hidden = YES;
  } else {
    self.loading.hidden = YES;
  }
}
@end
