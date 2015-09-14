//
//  SpecialViewController.m
//  优顾理财
//
//  Created by Mac on 14-3-10.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "SpecialViewController.h"

#import "SepcialtableViewCell.h"
#import "YGImageDown.h"
#import "NewsDetailViewController.h"

@implementation SpecialViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}
- (id)initWithTopicid:(NSString *)topicid {
  self = [super init];
  if (self) {
    self.topicID = topicid;
  }
  return self;
}

- (void)viewDidAppear:(BOOL)animated {
  [MobClick beginLogPageView:@"SpecialViewController"];
  [[PV_view_sql sharedManager] PV_DB_DATA:@"SpecialViewController"];

  [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [MobClick endLogPageView:@"SpecialViewController"];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.topNavView.mainLableString = @"热点";
  // Do any additional setup after loading the view.
  self.item = [[TopicRequestItem alloc] init];
  //
  //  //    数组初始化
  //  Rot_array = [[NSMutableArray alloc] initWithCapacity:0];
  //  Titles_array = [[NSMutableArray alloc] initWithCapacity:0];
  //
  //  topic_tableheader = [[Topic_General_tableheader alloc] init];
  //  self.topic_news_name = @"";
  //
  //    初始化Rot_tableview
  _specialTableview =
      [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.childView.frame.size.height)];
  _specialTableview.delegate = self;
  _specialTableview.dataSource = self;
  _specialTableview.backgroundColor = [UIColor clearColor];
  _specialTableview.separatorColor = [Globle colorFromHexRGB:lightCuttingLine];
  [self.childView addSubview:_specialTableview];
  [_specialTableview setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];

  [self data_quest];

  //    调背景颜色
  //  self.view.backgroundColor = [Globle colorFromHexRGB:customBGColor];
  label_text.textColor = [Globle colorFromHexRGB:@"1c1c1c"];
  image_pic_yinying.hidden = YES;
  //  [_specialTableview reloadData];

  ///
}
#pragma mark - 正在加载，回调
- (void)refreshNewInfo {
  [self data_quest];
}
#pragma mark - NEWS_Nav_View 自定义导航条  按钮delegate 点击函数
- (void)leftButtonPress {
  [self.view endEditing:NO];
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)data_quest {
  HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
  __weak SpecialViewController *weakSelf = self;
  callBack.onSuccess = ^(NSObject *obj) {
    SpecialViewController *strongSelf = weakSelf;
    if (strongSelf) {
      strongSelf.loading.hidden = YES;
      //            解析数据
      strongSelf.item = (TopicRequestItem *)obj;
      [strongSelf special_image:strongSelf.item.imageUrl andLabel_text:strongSelf.item.summary];
    }
  };
  [TopicRequestItem getTopicWithTopicId:self.topicID withCallback:callBack];
}
//专题图片
- (void)special_image:(NSString *)image_url andLabel_text:(NSString *)text {
  UIView *Header_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];

  UIFont *font = [UIFont systemFontOfSize:16];
  CGFloat height = [text sizeWithFont:font
                       constrainedToSize:CGSizeMake(320, 2000)
                           lineBreakMode:NSLineBreakByCharWrapping]
                       .height;

  label_text = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, height)];
  label_text.backgroundColor = [UIColor clearColor];
  label_text.font = font;
  label_text.text = text;
  label_text.numberOfLines = 0;
  label_text.textAlignment = NSTextAlignmentLeft;
  [Header_view addSubview:label_text];

  UIImageView *view__image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
  view__image.image = [UIImage imageNamed:@"专题_默认.png"];
  [Header_view addSubview:view__image];

  image_pic_yinying = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
  image_pic_yinying.hidden = YES;
  image_pic_yinying.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.4];
  [view__image addSubview:image_pic_yinying];

  [[YGImageDown sharedManager] add_image:image_url
                              completion:^(UIImage *img) {
                                if (img) {
                                  view__image.image = img;
                                }
                              }];
  label_text.top = 110;
  Header_view.height = 120 + label_text.height;

  _specialTableview.tableHeaderView = Header_view;

  [_specialTableview reloadData];
}
#pragma mark - tableView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  if (section == 0) {
    return nil;
  }
  if (self.item && self.item.array.count > 0) {
    TopicObjectItem *object = self.item.array[section];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 25.0f)];
    label.font = [UIFont systemFontOfSize:15.0f];
    label.textAlignment = NSTextAlignmentLeft;
    label.text = object.title;
    label.backgroundColor = [Globle colorFromHexRGB:customGrayCuttingLine];
    label.textColor = [Globle colorFromHexRGB:@"989898"];
    return label;
  }
  return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  if (section == 0) {
    return 0;
  }
  return 25.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (self.item) {
    TopicObjectItem *object = self.item.array[section];
    if (object && object.listArray) {
      return object.listArray.count;
    }
  }
  return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  if (self.item) {
    return self.item.array.count;
  }
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"Cell_Special";
  SepcialtableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[SepcialtableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:CellIdentifier];
  }
  TopicObjectItem *object = self.item.array[indexPath.section];
  NewsInChannelItem *newsItem = object.listArray[indexPath.row];
  if (newsItem.is_or_read == NO) {
    cell.imageview_head.image = [UIImage imageNamed:@"圆.png"];
  } else {
    cell.imageview_head.image = nil;
    [cell cell_backgroundcolor_label];
  }
  cell.label_data.text = newsItem.title;
  return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  if (self.item && self.item.array.count > indexPath.section) {
    TopicObjectItem *object = self.item.array[indexPath.section];
    NewsInChannelItem *newsItem = object.listArray[indexPath.row];
    //    标记已读过的
    newsItem.is_or_read = YES;
    NewsDetailViewController *detailVC =
        [[NewsDetailViewController alloc] initWithChannlId:newsItem.newsChannlid
                                                 andNewsId:newsItem.newsID
                                                   Andxgsj:newsItem.xgsj];
    [AppDelegate pushViewControllerFromRight:detailVC];
  }
  [_specialTableview reloadData];
}

- (void)dealloc {
  [self.view removeAllSubviews];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
