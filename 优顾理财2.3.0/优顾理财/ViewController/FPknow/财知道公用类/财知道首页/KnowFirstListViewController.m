//
//  KnowFirstListViewController.m
//  优顾理财
//
//  Created by Mac on 15/8/9.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "KnowFirstListViewController.h"
#import "FPKnowTableViewCell.h"
#import "KnowDetailViewController.h"

@implementation KnowFirstListViewController
- (id)initWithFrame:(CGRect)frame AndStart:(KnowFirstListType)state {
  type = state;
  if (state == NEWListViewController) {
    self = [super initWithFrame:frame AndRefreshLable:@"KnowFirstNewListVC"];
    if (self) {
      [[NSNotificationCenter defaultCenter] addObserver:self
                                               selector:@selector(refreshNewInfo)
                                                   name:@"refrashKnowNewListSend"
                                                 object:nil];
      //      [self registerNibCell];
    }
    return self;
  } else if (state == RotPointViewController) {
    self = [super initWithFrame:frame AndRefreshLable:@"KnowFirstRotPointVC"];
    if (self) {
      //      [self registerNibCell];
    }
    return self;
  } else {
    NSLog(@"我的提问或我的回答传值的type不对");
  }

  return nil;
}

#pragma mark - 注册NibCell
- (void)registerNibCell {
  UINib *cellNib = [UINib nibWithNibName:NSStringFromClass([FPKnowTableViewCell class]) bundle:nil];
  [self.tableView registerNib:cellNib forCellReuseIdentifier:@"FPKnowTableViewCell"];
}

#pragma mark - loading 代理
- (void)refreshNewInfo {
  if ([FPYouguUtil isExistNetwork]) {
    self.refrashIndex = 0;
    self.dataArray.dataComplete = NO;
    [self requestData];
  }
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.loading.hidden = NO;
  color_Normal = [Globle colorFromHexRGB:@"808080"];
  color_Selected = [Globle colorFromHexRGB:@"505050"];
  [self registerNibCell];
  [self Save_being_data];
  if ([FPYouguUtil isExistNetwork]) {
    [self refreshNewInfo];
  } else {
    if (self.dataArray.array && self.dataArray.array.count > 0) {
    } else {
      [self.loading animationNoNetWork];
    }
  }
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(refrashCommentCount:)
                                               name:@"RefrashKnowFirstList"
                                             object:nil];
}

-(void)refrashCommentCount:(NSNotification *)notification
{
  if (self.dataArray.array.count>0) {
    NSString * commentCount =[notification object];
    if (commentCount) {
      [self.dataArray.array enumerateObjectsUsingBlock:^(knownewItem * item, NSUInteger idx, BOOL *stop) {
        if ([item.talkId isEqualToString:commentCount]) {
          item.commentNum = [@([item.commentNum intValue]+1) stringValue];
          [self.tableView reloadData];
          *stop =YES;
        }
      }];
      
    }
  }
}

#pragma mark - 复写fpNOtitleTableview的方法
#pragma mark - 复写父类fpNOtitleTableview的方法
/*
 + (void)saveKnowFirstNEWListItem:(KnowNewList *)data
 ///财知道热点列表数据
 + (void)saveKnowFirstRotPointListItem:(KnowRotList *)data
 */
- (void)returnBlock:(NSObject *)obj {
  if (type == NEWListViewController) {
    KnowNewList *list = (KnowNewList *)obj;
    [FileChangelUtil saveKnowFirstNEWListItem:list];
    [super jsonToDic:list.listArray];
  } else if (type == RotPointViewController) {
    KnowRotList *list = (KnowRotList *)obj;
    [FileChangelUtil saveKnowFirstRotPointListItem:list];
    [super jsonToDic:list.listArray];
  }
}

- (void)requestData {
  if (![FPYouguUtil isExistNetwork]) {
    [self.loading animationNoNetWork];
    [self.tableView tableViewDidFinishedLoading];
    return;
  }
  //  self.loading.hidden = YES;
  //  [[NSNotificationCenter defaultCenter] postNotificationName:@"changeBtnType"
  //                                                      object:self
  //                                                    userInfo:nil];
  HttpRequestCallBack *callBack = [self getHttpCallBack];
  if (type == NEWListViewController) {
    [KnowNewList getNewListWithstart:[@(self.refrashIndex * 20) stringValue]
                            Andlimit:@"20"
                        withCallback:callBack];
  } else if (type == RotPointViewController) {
    [KnowRotList getRotListWithStart:[@(self.refrashIndex * 20) stringValue] withCallback:callBack];
  } else {
    NSLog(@"财知道首页列表的type，不对");
  }
}

//先读取后去，保存到本地的数据
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

#pragma mark - Table view data source
//计算cell的高度
- (CGFloat)getCellHeight:(NSInteger)row {
  knownewItem *item = self.dataArray.array[row];
  return [FTLabel getLableHeightWithText:[self setHtmlText:row] andTitle:item.title];
}

//组成html，的文本，
- (NSString *)setHtmlText:(NSInteger)row {
  knownewItem *item = self.dataArray.array[row];
  NSString *content = item.summary;
  //小编发的文章
  if (item.sourceType == 2) {
    content = [NSString stringWithFormat:@"#%@#%@", item.title, content];
  } else if ([item.rotBeNickname length] > 0) {
    content = [NSString stringWithFormat:@"@%@:%@", item.rotBeNickname, content];
  }
  return content;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  knownewItem *item = self.dataArray.array[indexPath.row];
  if (item.title && item.title.length > 0) {
    return 60 + 20 + [self getCellHeight:indexPath.row];
  }
  return 60 + [self getCellHeight:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"FPKnowTableViewCell";
  FPKnowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  knownewItem *item = self.dataArray.array[indexPath.row];
  cell.timeLable.text = item.creatTime;
  cell.userListItem = item.userListItem;
  cell.praiseNum.text = [NSString stringWithFormat:@"回答数 : %@", item.commentNum];
  if (item.title && item.title.length > 0) {
    cell.titleLabel.text = item.title;
    cell.contentLable.lineLimit = 2;
  } else {
    cell.titleLabel.text = nil;
    cell.contentLable.lineLimit = 3;
  }
  if (item.isreading) {
    cell.contentLable.mainColor = color_Normal;
  } else {
    cell.contentLable.mainColor = color_Selected;
  }
  if (item.sourceType == 2) {
    cell.contentLable.nameNick = [NSString stringWithFormat:@"#%@#", item.title];
  } else if (item.rotBeNickname && item.rotBeNickname.length > 0) {
    cell.contentLable.nameNick = [NSString stringWithFormat:@"@%@:", item.rotBeNickname];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if ([self.dataArray.array count] > indexPath.row) {
    knownewItem *item = self.dataArray.array[indexPath.row];
    item.isreading = YES;
    KnowDetailViewController *knowDetailVC = [[KnowDetailViewController alloc] initWithTalkId:item.aid];
    [AppDelegate pushViewControllerFromRight:knowDetailVC];
  }
  [tableView reloadData];
}
#pragma mark - 注销
- (void)dealloc {
  [self.view removeAllSubviews];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
