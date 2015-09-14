//
//  NoNetWorkViewController.m
//  优顾理财
//
//  Created by Mac on 15/8/11.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "NoNetWorkViewController.h"
#import "NewsListViewController.h"
#import "Collection_Cell.h"
#import "NewsChannelList.h"
#import "NewsDetailViewController.h"
@interface NoNetWorkViewController ()

@end

@implementation NoNetWorkViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.topNavView.mainLableString = @"趣理财";
  main_array = [[NSMutableArray alloc] initWithCapacity:0];
//  NewsListViewController *newsVC = [[NewsListViewController alloc] initWithFrame:self.childView.bounds
//                                                                   withChannelID:@"25"
//                                                                 withChannelName:@"趣理财"];
//  newsVC.isOfflineRead = YES;
//  newsVC.loading.noNetWorkBtn.hidden = YES;
//  [self addChildViewController:newsVC];
//  [newsVC refreshButtonPressDown];
  //列表
  tableview                 = [[UITableView alloc]
               initWithFrame:self.childView.bounds];
  tableview.dataSource      = self;
  tableview.delegate        = self;
  tableview.backgroundColor = [UIColor clearColor];
  tableview.separatorColor  = [Globle colorFromHexRGB:lightCuttingLine];
  tableview.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
  [self.childView addSubview:tableview];
   [self request];
}
-(void)request{

  NewsListInChannel *list = [FileChangelUtil loadNewsTeamListData:@"25"];
    [main_array addObjectsFromArray:list.newsList];
  if (main_array.count==0) {
    YouGu_animation_Did_Start(@"暂时没有数据，请链接网络");
    return;
      }
  [tableview reloadData];
  
}

#pragma mark - UITableViewDataSource
/** 自定义分割线长度 */
- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  if ([tableview respondsToSelector:@selector(setSeparatorInset:)]) {
    [tableview setSeparatorInset:UIEdgeInsetsMake(0, 18.0f, 0, 18.0f)];
  }
  
  if ([tableview respondsToSelector:@selector(setLayoutMargins:)]) {
    [tableview setLayoutMargins:UIEdgeInsetsMake(0, 18.0f, 0, 18.0f)];
  }
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
  if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
    
    [cell setSeparatorInset:UIEdgeInsetsMake(0, 18.0f, 0, 18.0f)];
  }
  if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
    [cell setLayoutMargins:UIEdgeInsetsMake(0, 18.0f, 0, 18.0f)];
  }
}
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 50;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return [main_array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *CellIdentifier = @"CellIdentifier_Collection";
  Collection_Cell *cell =
  [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[Collection_Cell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:CellIdentifier];
  }
  NewsInChannelItem *item = main_array[indexPath.row];
  
  //    cell被选择一会的背景效果颜色
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  
  /*
   * Content in this cell should be inset the size of kMenuOverlayWidth
   */
  cell.label_data.text = item.title;
//  [[main_array objectAtIndex:indexPath.row] objectAtIndex:1];
  
  return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   if (main_array.count > indexPath.row) {
  NewsInChannelItem *item = main_array[indexPath.row];
  
  NewsDetailViewController * newsDetailVC = [[NewsDetailViewController alloc]initWithChannlId:item.newsChannlid andNewsId:item.newsID Andxgsj:item.xgsj];
    [AppDelegate pushViewControllerFromRight:newsDetailVC];
    [tableView reloadData];
}
}
@end
