//
//  MyInfoTableViewController.m
//  优顾理财
//
//  Created by Yuemeng on 15/9/7.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "MyInfoTitleTableViewController.h"
#import "FPMyInfoTableViewCell.h"
#import "KnowDetailViewController.h"

@implementation MyInfoTableAdapter

- (NSString *)nibName {
  static NSString *nibFileName;
  if (nibFileName == nil) {
    nibFileName = NSStringFromClass([FPMyInfoTableViewCell class]);
  }
  return nibFileName;
}

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 60 + [self getCellOnLabelHeight:indexPath.row];
}

- (CGFloat)getCellOnLabelHeight:(NSInteger)row {
  CGFloat height = [FTLabel getLableHeightWithText:[self cell_text:row]];
  return height;
}

- (NSString *)cell_text:(NSInteger)row {
  knownewItem *item = [self.dataArray.array objectAtIndex:row];
  NSString *content = item.summary;
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

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"FPMyInfoTableViewCell";
  FPMyInfoTableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

  if ([self.dataArray.array count] > 0) {
    knownewItem *item = [self.dataArray.array objectAtIndex:indexPath.row];
    cell.timeLable.text = item.creatTime;
    if (item.sourceType == 6) {
      [cell systemDefaultWithPic:@"喇叭.png" andNickname:@"系统消息"];
    } else {
      cell.userListItem = item.userListItem;
    }
    //颜色
    if (item.sourceType == 7) {
      cell.contentLable.nameNick = [NSString stringWithFormat:@"回复我:"];
    } else if (item.sourceType == 2) {
      cell.contentLable.nameNick = [NSString stringWithFormat:@"@我:"];
    } else if (item.sourceType == 3) {
      cell.contentLable.nameNick = [NSString stringWithFormat:@"评论我:"];
    } else if (item.sourceType == 4) {
      cell.contentLable.nameNick =
          [NSString stringWithFormat:@"%@:", @"消息通知"];
    } else {
      cell.contentLable.nameNick = nil;
    }

    cell.isRead = item.isreading;
    //内容
    NSString *contentStr = [self cell_text:indexPath.row];
    if (contentStr && contentStr.length > 0) {
      [cell.contentLable setOfUILablewithContent:contentStr];
    } else {
      cell.contentLable.text = nil;
    }
    cell.longPress.minimumPressDuration = 25.0f;
  }

  return cell;
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if ([self.dataArray.array count] > indexPath.row) {
    knownewItem *item = [self.dataArray.array objectAtIndex:indexPath.row];
    KnowDetailViewController *knowDetailVC =
        [[KnowDetailViewController alloc] initWithTalkId:item.talkId];
    [AppDelegate pushViewControllerFromRight:knowDetailVC];
  }
  [tableView reloadData];
}

@end

/**
 *  TableViewController
 */
@implementation MyInfoTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.loading.hidden = NO;
  if ([FPYouguUtil isExistNetwork]) {
    [self refreshButtonPressDown];
  } else {
    [self.loading animationNoNetWork];
  }
}

/** 请求最新数据，此方法子类必须实现 */
- (void)requestDataListWithRefreshType:(RefreshType)refreshType
                         withDataArray:(DataArray *)existDataList
                          withCallBack:(HttpRequestCallBack *)callback {
  [KnowMessageList
      getMessageListWithDic:[self
                                getRequestParamertsWithRefreshType:refreshType]
               withCallback:callback];
}

- (NSDictionary *)getRequestParamertsWithRefreshType:(RefreshType)refreshType {
  NSString *fromId = @"0";

  if (refreshType == RefreshTypeLoaderMore) {
    knownewItem *item = [self.dataArray.array lastObject];
    fromId = item.aid;
  }

  return @{ @"fromId" : fromId };
}

- (BOOL)isDataValidWithResponseObject:(NSObject<Collectionable> *)latestData
                withRequestParameters:(NSDictionary *)parameters
                      withRefreshType:(RefreshType)refreshType {
  if (refreshType == RefreshTypeLoaderMore) {
    knownewItem *item = [self.dataArray.array lastObject];
    if (![item.aid isEqualToString:parameters[@"fromId"]]) {
      return NO;
    }
  }

  return YES;
}

/** 返回表格数据适配器，此方法子类必须实现 */
- (BaseTableAdapter *)getBaseTableAdaperWithDataList:(DataArray *)dataList {
  if (_tableAdapter == nil) {
    _tableAdapter =
        [[MyInfoTableAdapter alloc] initWithTableViewController:self
                                                  withDataArray:self.dataArray];
    UINib *cellNib = [UINib nibWithNibName:_tableAdapter.nibName bundle:nil];
    [self.tableView registerNib:cellNib
         forCellReuseIdentifier:_tableAdapter.nibName];
  }
  return _tableAdapter;
}

@end

/**
 *  TitleTableView
 */
@implementation MyInfoTitleTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.topNavView.mainLableString = @"我的消息";
  _tableVC =
      [[MyInfoTableViewController alloc] initWithFrame:self.clientView.bounds];
  [self.clientView addSubview:_tableVC.view];
  [self addChildViewController:_tableVC];
  [_tableVC refreshButtonPressDown];
}

@end
