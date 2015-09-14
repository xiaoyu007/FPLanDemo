//
//  SpecialTopicTitleTableViewController.m
//  优顾理财
//
//  Created by Yuemeng on 15/9/9.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "SpecialTopicTitleTableViewController.h"
#import "NewsListTableViewCell.h"
#import "FPNewsPushUtil.h"

@implementation SpecialTopicTableAdapter

- (NSString *)nibName {
  static NSString *nibFileName;
  if (nibFileName == nil) {
    nibFileName = NSStringFromClass([NewsListTableViewCell class]);
  }
  return nibFileName;
}

- (CGFloat)tableView:(UITableView *)tableView
    heightForHeaderInSection:(NSInteger)section {
  if (section == 0) {
    return 0;
  }
  return 3.0;
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

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 50 + [self set_Cell_Height:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"NewsListTableViewCell";
  NewsListTableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  //    中间变量
  NewsInChannelItem *item = self.dataArray.array[indexPath.row];
  cell.titleName.text = item.title;
  cell.isRead = item.is_or_read;
  cell.newsIntroduction.text = item.newsIntroduction;
  cell.isTopicid = [item.wzlx intValue];
  cell.praiseBtn.hidden = YES;
  if ([item.praise integerValue] > 0) {
    cell.praiseNum.hidden = NO;
    cell.praisePic.hidden = NO;
  } else {
    cell.praiseNum.hidden = YES;
    cell.praisePic.hidden = YES;
  }
  return cell;
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:NO];

  if (self.dataArray.array.count > indexPath.row) {
    NewsInChannelItem *newsObject = self.dataArray.array[indexPath.row];
    newsObject.newsChannlid = _channlid;
    newsObject.is_or_read = YES;
    __weak SpecialTopicTableAdapter *weakSelf = self;
    [FPNewsPushUtil
        PushToOtherViewController:newsObject
                    isOfflineRead:NO
                andPraiseCallBack:^(BOOL isPraise) {
                  SpecialTopicTableAdapter *weakString = weakSelf;
                  if (weakString) {
                    [weakString.baseTableViewController.tableView
                        reloadRowsAtIndexPaths:@[ indexPath ]
                              withRowAnimation:UITableViewRowAnimationNone];
                  }
                }];
  }
  [tableView reloadData];
}
@end

/**
 *  tableViewController
 */
@implementation SpecialTopicTableViewController
/** 请求最新数据，此方法子类必须实现 */
- (void)requestDataListWithRefreshType:(RefreshType)refreshType
                         withDataArray:(DataArray *)existDataList
                          withCallBack:(HttpRequestCallBack *)callback {

  [NewsRotList requestNewsRotItemWithDic:
                   [self getRequestParamertsWithRefreshType:refreshType]
                            withCallback:callback];
}

- (NSDictionary *)getRequestParamertsWithRefreshType:(RefreshType)refreshType {
  NSString *start = @"1";

  if (refreshType == RefreshTypeLoaderMore) {
    start = [@((self.dataArray.array.count + 19) / 20 + 1) stringValue];
  }

  return @{ @"topicid" : _topicid, @"start" : start };
}

- (BOOL)isDataValidWithResponseObject:(NSObject<Collectionable> *)latestData
                withRequestParameters:(NSDictionary *)parameters
                      withRefreshType:(RefreshType)refreshType {
  if (refreshType == RefreshTypeLoaderMore) {
    if (((self.dataArray.array.count + 19) / 20 + 1) !=
        [parameters[@"start"] integerValue]) {
      return NO;
    }
  }
  return YES;
}

/** 返回表格数据适配器，此方法子类必须实现 */
- (BaseTableAdapter *)getBaseTableAdaperWithDataList:(DataArray *)dataList {
  if (_tableAdapter == nil) {
    _tableAdapter = [[SpecialTopicTableAdapter alloc]
        initWithTableViewController:self
                      withDataArray:self.dataArray];
    UINib *cellNib = [UINib nibWithNibName:_tableAdapter.nibName bundle:nil];
    [self.tableView registerNib:cellNib
         forCellReuseIdentifier:_tableAdapter.nibName];
    ((SpecialTopicTableAdapter *)_tableAdapter).channlid = self.channlid;
  }
  return _tableAdapter;
}

- (NSString *)headerViewKey {
  return [[NSString stringWithFormat:@"Topic_%@", _topicid] copy];
}

@end

/**
 *  titleViewController
 */
@implementation SpecialTopicTitleTableViewController

- (id)initWithTopicid:(NSString *)topicid {
  self = [super init];
  if (self) {
    self.topicid = topicid;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.topNavView.mainLableString = @"专题";

  _tableVC = [[SpecialTopicTableViewController alloc]
      initWithFrame:self.clientView.bounds];
  _tableVC.topicid = _topicid;
  _tableVC.channlid = _channlid;
  [self.clientView addSubview:_tableVC.view];
  [self addChildViewController:_tableVC];
  [_tableVC refreshButtonPressDown];
}

@end
