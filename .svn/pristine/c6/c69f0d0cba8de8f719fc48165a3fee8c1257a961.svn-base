//
//  MyCollectionViewController.m
//  优顾理财
//
//  Created by Jhss on 15/8/21.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "Collection_Cell.h"
#import "SQLDataHtmlstring.h"
#import "NewsDetailViewController.h"
#import "SettingButton.h"
#import "MyCollectRequest.h"
//财知道 新闻正文页
#import "KnowDetailViewController.h"

@implementation MyCollectionViewController {

  BOOL refrash_is_have;

  clickLabel *btnSummit;

  //    编辑状态页
  UIView *OperateButtonsView;

  clickLabel *btnSelectAll;
  clickLabel *btnDelete;

  //    是否隐藏
  BOOL hidden;

  UIAlertView *alertViewDelete;
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self requestData];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.topNavView setMainLableString:@"我的收藏"];
  self.dataArray = [[DataArray alloc] init];

  //    列表
  _tableview = [[UITableView alloc] initWithFrame:self.childView.bounds];
  _tableview.dataSource = self;
  _tableview.delegate = self;
  _tableview.backgroundColor = [UIColor clearColor];
  _tableview.separatorColor = [Globle colorFromHexRGB:lightCuttingLine];
  [self.childView addSubview:_tableview];
  [_tableview setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];

  hidden = YES;

  //无数据的时候显示暂无收藏
  self.loading.noDataLabel.text = @"暂无收藏";
  self.loading.userInteractionEnabled = YES;

  //    编辑 按钮
  btnSummit = [[clickLabel alloc] initWithFrame:CGRectMake(WIDTH_OF_SCREEN - 70, 10, 70, 30)];
  btnSummit.font = [UIFont systemFontOfSize:18];
  btnSummit.textAlignment = NSTextAlignmentCenter;
  btnSummit.text = @"编辑";
  //  Summit_btn.hidden = YES;
  btnSummit.backgroundColor = [UIColor clearColor];
  btnSummit.textColor = [Globle colorFromHexRGB:customFilledColor];
  btnSummit.highlightedColor = [UIColor grayColor];
  [btnSummit addTarget:self action:@selector(Summit_btn_click:)];
  [self.topNavView addSubview:btnSummit];

  [self creatbottomView];
  //    设备背景颜色
  [self Night_to_Day];
  alertViewDelete = [[UIAlertView alloc] initWithTitle:@"通知"
                                               message:@"确定要删除选定的文章？"
                                              delegate:self
                                     cancelButtonTitle:@"取消"
                                     otherButtonTitles:@"确定", nil];
  alertViewDelete.tag = 1000;

  [self requestData];
}
- (void)creatbottomView {
  OperateButtonsView = [[UIView alloc] initWithFrame:CGRectMake(0, self.childView.height - 60, 320, 60)];
  OperateButtonsView.hidden = YES;
  [self.childView addSubview:OperateButtonsView];

  btnSelectAll = [[clickLabel alloc] initWithFrame:CGRectMake(40, 10, 100, 40)];
  [btnSelectAll addTarget:self action:@selector(clickSelectAllButton)];
  btnSelectAll.layer.cornerRadius = 20;
  btnSelectAll.clipsToBounds = YES;
  btnSelectAll.text = @"全选";
  btnSelectAll.textAlignment = NSTextAlignmentCenter;
  [OperateButtonsView addSubview:btnSelectAll];

  btnDelete = [[clickLabel alloc] initWithFrame:CGRectMake(180, 10, 100, 40)];
  [btnDelete addTarget:self action:@selector(clickDeleteButton)];
  btnDelete.layer.cornerRadius = 20;
  btnDelete.clipsToBounds = YES;
  btnDelete.text = @"删除";
  btnDelete.textAlignment = NSTextAlignmentCenter;
  [OperateButtonsView addSubview:btnDelete];
}

- (void)requestData {
  NewsWithDidCollect *object = [NewsWithDidCollect sharedManager];
  [self.dataArray.array removeAllObjects];
  if (object && object.array.count > 0) {
    [self.dataArray.array addObjectsFromArray:object.array];
  }
  refrash_is_have = YES;
  if (self.dataArray.array && [self.dataArray.array count] > 0) {
    btnSummit.hidden = NO;
    self.loading.hidden = YES;
  } else {
    //提示语，动画
    YouGu_animation_Did_Start(@"亲,您现在还没有收藏内容哦～");
    btnSummit.hidden = YES;
    self.loading.hidden = NO;
    [self.loading notDataStatus];
  }

  [self.tableview reloadData];
}
- (void)clickSelectAllButton {
  if ([@"全选" isEqualToString:btnSelectAll.text]) {
    btnSelectAll.text = @"取消";
    for (MyCollectItem *item in self.dataArray.array) {
      item.isRemove = YES;
    }
  } else {
    btnSelectAll.text = @"全选";
    for (MyCollectItem *item in self.dataArray.array) {
      item.isRemove = NO;
    }
  }
  [_tableview reloadData];
}
- (void)clickDeleteButton {
  if ([self is_changle_delete] == NO) {
    if ([self.dataArray.array count] == 0) {
      //提示语，动画
      YouGu_animation_Did_Start(@"您已没有可删除内容");
      btnSummit.hidden = YES;
      self.loading.hidden = NO;
      [self.loading notDataStatus];
      return;
    }
    //提示语，动画
    YouGu_animation_Did_Start(@"请选择您要删除的条目");
    return;
  }

  //    请选择要删除的条目
  [alertViewDelete show];
}
#pragma mark - UIalertviewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  //    删除数据库数据，和collect 数据
  if (buttonIndex != alertView.cancelButtonIndex) {
    NSArray *mArray = [self.dataArray.array copy];
    for (MyCollectItem *item in mArray) {
      if (item.isRemove == 1) {
        //         实名 ，取消收藏
        HttpRequestCallBack *callback = [[HttpRequestCallBack alloc] init];
        __weak MyCollectionViewController *weakSelf = self;
        callback.onSuccess = ^(NSObject *obj) {
          MyCollectionViewController *strongSelf = weakSelf;
          if (strongSelf) {
            //取消收藏
            [[NewsWithDidCollect sharedManager] removeWithId:item];
            [self.dataArray.array removeAllObjects];
            NewsWithDidCollect *object = [NewsWithDidCollect sharedManager];
            if (object.array && object.array.count > 0) {
              [self.dataArray.array addObjectsFromArray:object.array];
            }
            //清空时
            if ([self.dataArray.array count] == 0) {
              [self Summit_btn_click:btnSummit];
              self.loading.hidden = NO;
              [self.loading notDataStatus];
            }
            [self.tableview reloadData];
          }
        };
        [NewsCollectRequest getNewsCollectWithFid:item.fid withCallback:callback];
      }
    }
  }
}

- (BOOL)is_changle_delete {
  for (MyCollectItem *item in self.dataArray.array) {
    if (item.isRemove) {
      return YES;
    }
  }
  return NO;
}

- (void)Summit_btn_click:(clickLabel *)sender {
  if (hidden) {
    btnSummit.text = @"取消";
    hidden = NO;
    OperateButtonsView.hidden = NO;
    _tableview.frame = CGRectMake(0, 0, self.childView.width, self.childView.height - 60);
  } else {
    btnSummit.text = @"编辑";
    hidden = YES;
    OperateButtonsView.hidden = YES;
    _tableview.frame = self.childView.bounds;
    if ([self.dataArray.array count] == 0) {
      btnSummit.hidden = YES;
    }
  }

  btnSelectAll.text = @"全选";
  for (MyCollectItem *item in self.dataArray.array) {
    item.isRemove = NO;
  }

  [_tableview reloadData];
}
- (void)dealloc {
  alertViewDelete.delegate = nil;
  [self.view removeAllSubviews];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - UITableViewDataSource
- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  if ([_tableview respondsToSelector:@selector(setSeparatorInset:)]) {
    [_tableview setSeparatorInset:UIEdgeInsetsMake(0, 18.0f, 0, 18.0f)];
  }

  if ([_tableview respondsToSelector:@selector(setLayoutMargins:)]) {
    [_tableview setLayoutMargins:UIEdgeInsetsMake(0, 18.0f, 0, 18.0f)];
  }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.dataArray.array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"CellIdentifier_Collection";
  Collection_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[Collection_Cell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:CellIdentifier];
  }
  //    cell被选择一会的背景效果颜色
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  /*
   * Content in this cell should be inset the size of kMenuOverlayWidth
   */
  MyCollectItem *item = [self.dataArray.array objectAtIndex:indexPath.row];
  cell.label_data.text = item.title;

  SettingButton *btn1 =
      [[SettingButton alloc] initWithFrame:CGRectMake(280, 17, 36, 26) andWidth:20.0f];
  [btn1 addTarget:self
                action:@selector(clickCheckbox:)
      forControlEvents:UIControlEventTouchUpInside];
  btn1.selected = !item.isRemove;
  btn1.hidden = hidden;
  btn1.tag = 1000 + indexPath.row;
  cell.accessoryView = btn1;
  cell.is_Uncheck = !hidden;
  return cell;
}

- (void)clickCheckbox:(UIButton *)sender {
  sender.selected = !sender.selected;
  NSInteger index = sender.tag - 1000;
  MyCollectItem *item = [self.dataArray.array objectAtIndex:index];
  if (sender.selected) {
    item.isRemove = NO;
  } else {
    item.isRemove = YES;
  }
  __block BOOL selectAllItem = YES;
  __block BOOL selectNoItem = YES;
  [self.dataArray.array enumerateObjectsUsingBlock:^(MyCollectItem *item, NSUInteger idx, BOOL *stop) {
    if (item.isRemove) {
      selectNoItem = NO;
    } else {
      selectAllItem = NO;
    }
  }];

  if (selectAllItem) {
    btnSelectAll.text = @"取消";
  } else if (selectNoItem) {
    btnSelectAll.text = @"全选";
  } else {
    btnSelectAll.text = @"取消";
  }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if ([self.dataArray.array count] >= indexPath.row) {
    //    在编辑状态下，不可选中   点击整个cell
    if (!hidden) {
      Collection_Cell *cell = (Collection_Cell *)[tableView cellForRowAtIndexPath:indexPath];
      UIButton *btn = (UIButton *)[cell viewWithTag:indexPath.row + 1000];
      [self clickCheckbox:btn];
      return;
    }
    MyCollectItem *item = [self.dataArray.array objectAtIndex:indexPath.row];
    if (item.type == 2) {
      KnowDetailViewController *knowDetailVC = [[KnowDetailViewController alloc] initWithTalkId:item.newsId];
      [AppDelegate pushViewControllerFromRight:knowDetailVC];
    } else {
      NewsDetailViewController *detailVC = [[NewsDetailViewController alloc] initWithChannlId:@"1"
                                                                                    andNewsId:item.newsId
                                                                                      Andxgsj:item.lastTime];
      [AppDelegate pushViewControllerFromRight:detailVC];
    }
  }
  [tableView reloadRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - pv, 选择正确的pvjiem
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [MobClick beginLogPageView:@"My_Favorites_view"];
  [[PV_view_sql sharedManager] PV_DB_DATA:@"My_Favorites_view"];
}
- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [MobClick endLogPageView:@"My_Favorites_view"];
}
/**
 *
 *  //消息中心
 *
 **/
#pragma mark - 消息中心，回调，夜间、白天和无图、有图
//夜间模式和白天模式
- (void)Night_to_Day {
  self.childView.backgroundColor = [Globle colorFromHexRGB:customBGColor];
  btnSelectAll.NormalbackgroundColor = [Globle colorFromHexRGB:@"a0a0a0"];
  btnSelectAll.highlightedColor = [Globle colorFromHexRGB:@"696969"];
  btnSelectAll.backgroundColor = [Globle colorFromHexRGB:@"a0a0a0"];
  btnDelete.NormalbackgroundColor = [Globle colorFromHexRGB:@"cf0200"];
  btnDelete.highlightedColor = [Globle colorFromHexRGB:@"a90100"];
  btnDelete.backgroundColor = [Globle colorFromHexRGB:@"cf0200"];
  btnDelete.textColor = [UIColor whiteColor];
  btnSelectAll.textColor = [UIColor whiteColor];
  [_tableview reloadData];
}
@end
