//
//  RotTableViewController.m
//  优顾理财
//
//  Created by Mac on 15/7/9.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "SpecialTopicViewController.h"
#import "NewsListTableViewCell.h"
#import "FPNewsPushUtil.h"

@implementation SpecialTopicViewController

- (id)initWithTopicid:(NSString *)topicid {
  NSString *topicStr = [NSString stringWithFormat:@"Topic_%@", topicid];
  self = [super initWithRefreshLable:topicStr];
  if (self) {
    self.topicid = topicid;
  }
  return self;
}

#pragma mark - 注册NibCell
- (void)registerNibCell {
  UINib *cellNib =
      [UINib nibWithNibName:NSStringFromClass([NewsListTableViewCell class]) bundle:nil];
  [self.tableView registerNib:cellNib forCellReuseIdentifier:@"NewsListTableViewCell"];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  //默认值
  self.topNavView.mainLableString = @"专题";
  self.loading.hidden = YES;
  self.refrashIndex = 0;
  [self registerNibCell];
  [self requestData];
}
#pragma mark - 数据刷新
- (void)returnBlock:(NSObject *)obj {
  NewsRotList *itemObject = (NewsRotList *)obj;
  if (itemObject) {
    [self bindSpecialData:itemObject];
  }
}
/** 失败 */
- (void)returnFail {
  if ([self.dataArray.array count] == 0) {
    [self.loading animationNoNetWork];
    self.loading.hidden = NO;
  }
}
- (void)requestData {
  if ([FPYouguUtil isExistNetwork]) {
    self.loading.hidden = YES;
  } else {
    [self.loading animationNoNetWork];
    self.loading.hidden = NO;
  }
  HttpRequestCallBack *callBack = [super getHttpCallBack];
  [NewsRotList requestNewsRotItemWithtopicId:self.topicid
                                    andStart:(int)self.refrashIndex * 20 + 1
                                 andPagesize:@"20"
                                withCallback:callBack];
}

- (void)bindSpecialData:(NewsRotList *)item {
  self.loading.hidden = YES;
  self.topNavView.mainLableString = item.name;
  if (self.refrashIndex == 0) {
    [self.dataArray.array removeAllObjects];
  }
  [self.dataArray.array addObjectsFromArray:item.newsList];
  if ([self.dataArray.array count] == 0) {
    YouGu_animation_Did_Start(@"该专题暂无数据");
  }
  [self.tableView reloadData];
}
#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 50 + [self set_Cell_Height:indexPath.row];
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"NewsListTableViewCell";
  NewsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:NO];

  if (self.dataArray.array.count > indexPath.row) {
    NewsInChannelItem *newsObject = self.dataArray.array[indexPath.row];
    newsObject.newsChannlid = _Channlid;
    newsObject.is_or_read = YES;
    __weak SpecialTopicViewController *selfString = self;
    [FPNewsPushUtil PushToOtherViewController:newsObject
                                isOfflineRead:NO
                            andPraiseCallBack:^(BOOL isPraise) {
                              SpecialTopicViewController *weakString = selfString;
                              if (weakString) {
                                [weakString.tableView reloadRowsAtIndexPaths:@[ indexPath ]
                                                            withRowAnimation:UITableViewRowAnimationNone];
                              }
                            }];
  }
  [tableView reloadData];
}
@end
