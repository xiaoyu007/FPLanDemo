//
//  RotTableViewController.m
//  优顾理财
//
//  Created by Mac on 15/7/9.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "RotTableViewController.h"
#import "NewsListTableViewCell.h"
#import "FPNewsPushUtil.h"

@implementation RotTableViewController
- (id)initWithTopicid:(NSString *)topicid {
  NSString * topicStr =[NSString stringWithFormat:@"Topic_%@",topicid];
  self = [super initWithRefreshLable:topicStr];
  if (self) {
    self.topicid = topicid;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  self.loading.hidden =NO;
  [self loadData_Start];
}
#pragma mark - 数据上啦，下拉 加载
- (void)loadData_Start {
  [super loadData_Start];
  _UP_Refrash_Num = 0;
  [self requrset_data];
}
- (void)loadData_End {
  [super loadData_End];
  _UP_Refrash_Num++;
  [self requrset_data];
}
- (void)requrset_data {
  HttpRequestCallBack *callback = [[HttpRequestCallBack alloc] init];
  __weak RotTableViewController *weakSelf = self;
  callback.onCheckQuitOrStopProgressBar = ^{
    RotTableViewController *strongSelf = weakSelf;
    if (strongSelf) {
      return NO;
    } else {
      return YES;
    }
  };
  callback.onSuccess = ^(NSObject *obj) {
    self.isSuccess=YES;
    [self.tableView tableViewDidFinishedLoading];
    RotTableViewController *strongSelf = weakSelf;
    if (strongSelf) {
      NewsRotList *itemObject = (NewsRotList *)obj;
      self.loading.hidden = YES;
      if (_UP_Refrash_Num == 0) {
        [self.mainArray removeAllObjects];
      }
      [self.mainArray addObjectsFromArray:itemObject.newsList];
      if ([self.mainArray count] == 0) {
        YouGu_animation_Did_Start(@"该专题暂无数据");
      }
      [self.tableView reloadData];
    }
  };
  callback.onError = ^(BaseRequestObject *err, NSException *ex) {
    [self.tableView tableViewDidFinishedLoading];
    [BaseRequester defaultErrorHandler](err, ex);
  };
  callback.onFailed = ^{
    [self.tableView tableViewDidFinishedLoading];
    [BaseRequester defaultFailedHandler]();
  };
  [NewsRotList requestNewsRotItemWithtopicId:self.topicid
                                    andStart:(int)_UP_Refrash_Num * 20 + 1
                                 andPagesize:@"20"
                                withCallback:callback];
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
  if (self.mainArray.count <= 0)
    return 0;
  NewsInChannelItem *news_list = self.mainArray[row];

  RTLabel *rtLabel = [NewsListTableViewCell textLabel];
  [rtLabel setText:news_list.newsIntroduction];
  CGSize optimumSize = [rtLabel optimumSize];
  return optimumSize.height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 35 + [self set_Cell_Height:indexPath.row];
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"NewsListTableViewCell";
  NewsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:nil options:nil] firstObject];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
  }
  //    中间变量
  NewsInChannelItem *item = self.mainArray[indexPath.row];
  cell.titleName.text = item.title;
  cell.isRead = item.is_or_read;
  cell.newsIntroduction.text = item.newsIntroduction;
  cell.isTopicid = [item.wzlx intValue];
  cell.praiseBtn.hidden = YES;
  return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:NO];

  if (self.mainArray.count > indexPath.row) {
    NewsInChannelItem *newsObject = self.mainArray[indexPath.row];
    newsObject.newsChannlid = _Channlid;
    newsObject.is_or_read = YES;
    [FPNewsPushUtil PushToOtherViewController:newsObject];
  }
  [tableView reloadData];
}
@end
