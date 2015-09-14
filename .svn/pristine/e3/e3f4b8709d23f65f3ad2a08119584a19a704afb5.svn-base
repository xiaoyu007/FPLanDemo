//
//  NonetFPviewController.m
//  优顾理财
//
//  Created by Mac on 14-6-14.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

@implementation NonetFPviewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}
- (void)viewDidAppear:(BOOL)animated {
  [self setExclusiveTouchForButtons:self.view];
  [super viewDidAppear:animated];
  [self.view setNeedsLayout];
}

- (void)setExclusiveTouchForButtons:(UIView *)myView {
  for (UIView *v in [myView subviews]) {
    if ([v isKindOfClass:[UIButton class]])
      [((UIButton *)v)setExclusiveTouch:YES];
    else if ([v isKindOfClass:[UIView class]]) {
      [self setExclusiveTouchForButtons:v];
    }
  }
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  _mainArray = [[NSMutableArray alloc] initWithCapacity:0];
  // Do any additional setup after loading the view.

  [self CreatNavBarWithTitle:@"趣理财"];

  //列表
  tableview =
      [[UITableView alloc] initWithFrame:CGRectMake(0, 50, 320, self.childView.frame.size.height - 50)];
  tableview.dataSource = self;
  tableview.delegate = self;
  tableview.backgroundColor = [UIColor clearColor];
  tableview.separatorColor = [Globle colorFromHexRGB:lightCuttingLine];
  tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
  [self.childView addSubview:tableview];
  [tableview setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];

  animation_alter = [[AnimationLabelAlterView alloc] initWithFrame:CGRectMake(0, 50, 320, 30)];
  [self.childView addSubview:animation_alter];

  view_down_tap = [[UIView alloc] initWithFrame:CGRectMake(0, 50, 320, self.childView.height - 50)];
  view_down_tap.backgroundColor = [UIColor clearColor];
  view_down_tap.userInteractionEnabled = YES;
  view_down_tap.hidden = YES;
  [self.childView addSubview:view_down_tap];

  btn_view = [UIButton buttonWithType:UIButtonTypeCustom];
  btn_view.frame = CGRectMake(0, 0, 320, view_down_tap.height);
  [btn_view addTarget:self action:@selector(request) forControlEvents:UIControlEventTouchUpInside];
  //       UIEdgeInsets  edginset=UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat
  //       left#>, <#CGFloat bottom#>, <#CGFloat right#>)
  UIEdgeInsets edginset = UIEdgeInsetsMake(btn_view.height / 2 - 70, 115, btn_view.height / 2 - 30, 115);
  btn_view.imageEdgeInsets = edginset;
  [view_down_tap addSubview:btn_view];

  UILabel *lable_text = [[UILabel alloc] initWithFrame:CGRectMake(100, btn_view.height / 2 + 50, 120, 40)];
  lable_text.text = networkFailed;
  lable_text.textAlignment = NSTextAlignmentCenter;
  lable_text.font = [UIFont systemFontOfSize:12];
  lable_text.textColor = [UIColor grayColor];
  lable_text.backgroundColor = [UIColor clearColor];
  [view_down_tap addSubview:lable_text];

  [self Night_to_Day];
  //   趣理财，后台数据
  [self request];
}
#pragma mark - NEWS_Nav_View 自定义导航条  按钮delegate 点击函数
- (void)leftButtonPress {
  [self.view endEditing:NO];
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)request {
  NSMutableArray *array_tt =
      [NSMutableArray arrayWithContentsOfFile:pathInCacheDirectory(@"QU_LI_CAI_channlid.plist")];
  if ([array_tt count] == 0) {
    YouGu_animation_Did_Start(@"暂时没有数据，请连接网络");
    view_down_tap.hidden = NO;
    return;
  }
  view_down_tap.hidden = YES;
  [_mainArray addObjectsFromArray:array_tt];
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [_mainArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  static NSString *CellIdentifier = @"CellIdentifier_Collection";
  Collection_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[Collection_Cell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:CellIdentifier];
    //    cell被选择一会的背景效果颜色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
  }
  NewsInChannelItem *item = [self.mainArray objectAtIndex:indexPath.row];
  cell.label_data.text = item.title;

  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  //文章修改的时间
  NewsDetailViewController *detailVC =
      [[NewsDetailViewController alloc] initWithChannlId:@"25"
                                               andNewsId:[[_mainArray objectAtIndex:indexPath.row] objectAtIndex:0]
                                                 Andxgsj:@"1"];
  [AppDelegate pushViewControllerFromRight:detailVC];
  [tableView reloadData];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
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
  [btn_view setImage:[UIImage imageNamed:@"手"] forState:UIControlStateNormal];
  [btn_view setImage:[UIImage imageNamed:@"手1"] forState:UIControlStateHighlighted];
  [tableview reloadData];
}
@end
