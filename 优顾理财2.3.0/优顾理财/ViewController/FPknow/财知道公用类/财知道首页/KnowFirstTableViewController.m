//
//  KnowFirstTableViewController.m
//  优顾理财
//
//  Created by Yuemeng on 15/9/6.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "KnowFirstTableViewController.h"
#import "FPKnowTableViewCell.h"
//#import "KnowDetailViewController.h"
#import "KnowDetailTitleTableViewController.h"

@implementation KnowFirstTableAdapter

- (NSString *)nibName {
  static NSString *nibFileName;
  if (nibFileName == nil) {
    nibFileName = NSStringFromClass([FPKnowTableViewCell class]);
  }
  return nibFileName;
}

//组成html，的文本，
- (NSString *)setHtmlText:(NSInteger)row {
  knownewItem *item = self.dataArray.array[row];
  NSString *content = item.summary;
  //小编发的文章
  if (item.sourceType == 2) {
    content = [NSString stringWithFormat:@"#%@#%@", item.title, content];
  } else if ([item.rotBeNickname length] > 0) {
    content =
        [NSString stringWithFormat:@"@%@:%@", item.rotBeNickname, content];
  }
  return content;
}

//计算cell的高度
- (CGFloat)getCellHeight:(NSInteger)row {
  knownewItem *item = self.dataArray.array[row];
  return [FTLabel getLableHeightWithText:[self setHtmlText:row]
                                andTitle:item.title];
}

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  knownewItem *item = self.dataArray.array[indexPath.row];
  if (item.title && item.title.length > 0) {
    return 60 + 20 + [self getCellHeight:indexPath.row];
  }
  return 60 + [self getCellHeight:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  FPKnowTableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:self.nibName];
  knownewItem *item = self.dataArray.array[indexPath.row];
  cell.timeLable.text = item.creatTime;
  cell.userListItem = item.userListItem;
  cell.praiseNum.text =
      [NSString stringWithFormat:@"回答数 : %@", item.commentNum];
  if (item.title && item.title.length > 0) {
    cell.titleLabel.text = item.title;
    cell.contentLable.lineLimit = 2;
  } else {
    cell.titleLabel.text = nil;
    cell.contentLable.lineLimit = 3;
  }
  if (item.isreading) {
    cell.contentLable.mainColor = [Globle colorFromHexRGB:@"808080"];
  } else {
    cell.contentLable.mainColor = [Globle colorFromHexRGB:@"505050"];
  }
  if (item.sourceType == 2) {
    cell.contentLable.nameNick =
        [NSString stringWithFormat:@"#%@#", item.title];
  } else if (item.rotBeNickname && item.rotBeNickname.length > 0) {
    cell.contentLable.nameNick =
        [NSString stringWithFormat:@"@%@:", item.rotBeNickname];
  } else {
    cell.contentLable.nameNick = nil;
  }
  cell.isRead = item.isreading;
  NSString *contentStr = [self setHtmlText:indexPath.row];
  if (contentStr && contentStr.length > 0) {
    [cell.contentLable setOfUILablewithContent:contentStr];
  } else {
    cell.contentLable.text = nil;
  }

  return cell;
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if ([self.dataArray.array count] > indexPath.row) {
    knownewItem *item = self.dataArray.array[indexPath.row];
    item.isreading = YES;
//    KnowDetailViewController *knowDetailVC =
//        [[KnowDetailViewController alloc] initWithTalkId:item.aid];
//    [AppDelegate pushViewControllerFromRight:knowDetailVC];
      KnowDetailTitleTableViewController *knowDetailVC =
      [[KnowDetailTitleTableViewController alloc] initWithTalkId:item.aid];
      [AppDelegate pushViewControllerFromRight:knowDetailVC];
  }
  [tableView reloadData];
}

@end

/**
 *  TableViewController
 */
@implementation KnowFirstTableViewController

- (id)initWithFrame:(CGRect)frame AndStart:(KnowFirstListType)state {
  type = state;
  if (state == NEWListViewController) {
    self = [super initWithFrame:frame];
    if (self) {
      [[NSNotificationCenter defaultCenter]
          addObserver:self
             selector:@selector(refreshNewInfo)
                 name:@"refrashKnowNewListSend"
               object:nil];
    }
    return self;
  } else if (state == RotPointViewController) {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
  }
  return nil;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.loading.hidden = NO;
  [self Save_being_data];

  if ([FPYouguUtil isExistNetwork]) {
    [self refreshButtonPressDown];
  } else {
    if (self.dataArray.array.count == 0) {
      [self.loading animationNoNetWork];
    }
  }
  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(refrashCommentCount:)
             name:@"RefrashKnowFirstList"
           object:nil];
}

- (void)refrashCommentCount:(NSNotification *)notification {
  if (self.dataArray.array.count > 0) {
    NSString *commentCount = [notification object];
    if (commentCount) {
      [self.dataArray.array
          enumerateObjectsUsingBlock:^(knownewItem *item, NSUInteger idx,
                                       BOOL *stop) {
            if ([item.talkId isEqualToString:commentCount]) {
              item.commentNum = [@([item.commentNum intValue] + 1) stringValue];
              [self.tableView reloadData];
              *stop = YES;
            }
          }];
    }
  }
}

//先读取缓存，保存到本地的数据
- (void)Save_being_data {
  KnowNewList *list = [FileChangelUtil loadKnowFirstNEWListData];
  if (list && list.listArray.count > 0) {
    self.loading.hidden = YES;
    //  访问成功
    [self.dataArray.array addObjectsFromArray:list.listArray];
    self.dataArray.dataBinded = YES;
    [self.tableView reloadData];
  }
  return;
}

/** 请求最新数据，此方法子类必须实现 */
- (void)requestDataListWithRefreshType:(RefreshType)refreshType
                         withDataArray:(DataArray *)existDataList
                          withCallBack:(HttpRequestCallBack *)callback {
  if (type == NEWListViewController) {
    [KnowNewList
        getNewListWithDic:[self getRequestParamertsWithRefreshType:refreshType]
             withCallback:callback];
  } else if (type == RotPointViewController) {
    [KnowRotList
        getRotListWithDic:[self getRequestParamertsWithRefreshType:refreshType]
             withCallback:callback];
  }
}

- (NSDictionary *)getRequestParamertsWithRefreshType:(RefreshType)refreshType {
  NSString *start = @"0";

  if (refreshType == RefreshTypeLoaderMore) {
    start = [@((self.dataArray.array.count + 19) / 20) stringValue];
  }

  return @{ @"start" : start };
}

- (BOOL)isDataValidWithResponseObject:(NSObject<Collectionable> *)latestData
                withRequestParameters:(NSDictionary *)parameters
                      withRefreshType:(RefreshType)refreshType {
  if (refreshType == RefreshTypeLoaderMore) {
    if ((self.dataArray.array.count + 19) / 20 !=
        [parameters[@"start"] integerValue]) {
      return NO;
    }
  }
  return YES;
}

/** 返回表格数据适配器，此方法子类必须实现 */
- (BaseTableAdapter *)getBaseTableAdaperWithDataList:(DataArray *)dataList {
  if (_tableAdapter == nil) {
    _tableAdapter = [[KnowFirstTableAdapter alloc]
        initWithTableViewController:self
                      withDataArray:self.dataArray];
    UINib *cellNib = [UINib nibWithNibName:_tableAdapter.nibName bundle:nil];
    [self.tableView registerNib:cellNib
         forCellReuseIdentifier:_tableAdapter.nibName];
  }
  return _tableAdapter;
}

@end
