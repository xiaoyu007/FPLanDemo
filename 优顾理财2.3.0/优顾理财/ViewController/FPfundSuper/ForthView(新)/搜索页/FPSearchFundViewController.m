//
//  SearchFundViewController.m
//  优顾理财
//
//  Created by Mac on 15-4-16.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPSearchFundViewController.h"
#import "FPFundCell.h"
#import "FPFundItem.h"
#import "FundListsSqlite.h"
#import "FPFundDetailedViewController.h"
#import "PlistOperation.h"
#import "UIButton+Block.h"
#import "FPMyOptionalShareManager.h"

#define textfieldMaxLength 20

@implementation FPSearchFundViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  //加载一次自选数据
  [[FPMyOptionalShareManager shareManager] loadMyOptionalData];
  [self addjustViewAfterShowXib];
  [self isLoadFundListsAgain];
  //读历史数据
  [self readItemOfSaved];
}
/** 是否重新加载码表 */
- (void)isLoadFundListsAgain {
  NSUserDefaults *myUser = [NSUserDefaults standardUserDefaults];
  NSDate *lastUpdateDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastUpdateTime"];
  NSDate *currentDate = [NSDate date];
  //一天后更新
  if (lastUpdateDate && (-[lastUpdateDate timeIntervalSinceDate:currentDate]) > 60 * 30) {
    [self requestSearchListWithModtime:@"0"];
  } else {
    if ([myUser objectForKey:@"fundListLastUpdateTime"]) {
      [self requestSearchListWithModtime:[myUser objectForKey:@"fundListLastUpdateTime"]];
    } else {
      [self requestSearchListWithModtime:@"0"];
    }
  }
}
/** xib加载完后微调 */
- (void)addjustViewAfterShowXib {
  if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
    //在ios7以上版本主背景界面
    UIView *ios7View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowWidth, statusBarHeight)];
    ios7View.backgroundColor = [UIColor blackColor];
    [self.view addSubview:ios7View];
  }
  [_searchBarBackView.layer setBorderWidth:1.0f];
  [_searchBarBackView.layer setBorderColor:[Globle colorFromHexRGB:customFilledColor].CGColor];
  UIImage *highlightImage = [FPYouguUtil createImageWithColor:btnAccordingToTheNormal];
  [_cancelButton setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
  [_cancelButton addTarget:self
                    action:@selector(cancelButtonClicked:)
          forControlEvents:UIControlEventTouchUpInside];
  _searchFundTableView.tableFooterView = [self createTableviewFootView];
  _searchFundTableView.tableFooterView.hidden = YES;
  _searchFundTableView.delaysContentTouches = NO;
  _searchFundTextField.delegate = self;

  [_searchFundTextField addTarget:self
                           action:@selector(textfieldDidChange:)
                 forControlEvents:UIControlEventEditingChanged];
  _searchFundTextField.returnKeyType = UIReturnKeySearch;
  _searchFundTableView.dataSource = self;
  _searchFundTableView.delegate = self;
  [self registerNibCell];
}

#pragma mark - 注册NibCell
- (void)registerNibCell {
  UINib *cellNib = [UINib nibWithNibName:NSStringFromClass([FPFundCell class]) bundle:nil];
  [_searchFundTableView registerNib:cellNib forCellReuseIdentifier:@"FPFundCell"];
}

/** 文本变化 */
- (void)textfieldDidChange:(UITextField *)textfield {
  if (textfield && [textfield.text length] > 0) {
    //实时查询基金
    [self showFundListWithInput:textfield.text];
  }
}
/** 取消按钮 */
- (void)cancelButtonClicked:(id)sender {
  ///注册通知使我的自选界面自动刷新界面
  [[NSNotificationCenter defaultCenter] postNotificationName:@"refishCustomizeList"
                                                      object:self
                                                    userInfo:nil];

  [AppDelegate popViewController:YES];
}
/** 查询 */
- (void)queryFundList:(id)sender {
  [self showFundListWithInput:_searchFundTextField.text];
}
/** 显示基金列表 */
- (void)showFundListWithInput:(NSString *)inputStr {
  //输入为空的情况
  if ([inputStr length] < 1) {
    //显示历史信息
    _searchFundTableView.tableFooterView.hidden = YES;
    [_searchFundTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    return;
  }
  if ([fundListArray count] > 0) {
    [fundListArray removeAllObjects];
  }
  [fundListArray addObjectsFromArray:[[FundListsSqlite sharedManager] queryFundListWithInputStr:inputStr]];
  [self refreshIsMyOptional:fundListArray];
  [_searchFundTableView reloadData];
  if ([fundListArray count] < 1) {
    _searchFundTableView.tableFooterView.hidden = NO;
    _searchFundTableView.tableFooterView = [self createTableviewFootView];
    notFoundLabel.text = [NSString stringWithFormat:@"很抱歉，没有找到%@", inputStr];
  } else {
    _searchFundTableView.tableFooterView.hidden = YES;
    [_searchFundTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
  }
}
/** 创建表尾 */
- (UIView *)createTableviewFootView {
  UIView *notFoundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowWidth, 78.0f)];
  notFoundView.backgroundColor = [UIColor clearColor];

  notFoundLabel = [[UILabel alloc] initWithFrame:CGRectMake(18.0f, 31.0f, windowWidth - 36.0f, 16.f)];
  notFoundLabel.backgroundColor = [UIColor clearColor];
  notFoundLabel.textAlignment = NSTextAlignmentCenter;
  notFoundLabel.font = [UIFont systemFontOfSize:16.0f];
  notFoundLabel.textColor = [Globle colorFromHexRGB:@"84929e"];
  [notFoundView addSubview:notFoundLabel];
  return notFoundView;
}
- (void)requestSearchListWithModtime:(NSString *)modTime {
  fundListArray = [[NSMutableArray alloc] init];
  historyListArray = [[NSMutableArray alloc] init];
  historyDicArray = [[NSMutableArray alloc] init];

  HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
  __weak FPSearchFundViewController *weakSelf = self;
  callBack.onSuccess = ^(NSObject *obj) {
    FPSearchFundViewController *strongSelf = weakSelf;
    if (strongSelf) {
      if ([modTime isEqualToString:@"0"]) {
        //保存更新时间
        NSDate *currentDate = [NSDate date];
        [[NSUserDefaults standardUserDefaults] setObject:currentDate forKey:@"lastUpdateTime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
      }
      NSLog(@"码表更新成功");
    }
  };
  //保存modtime（仅在判断是否重新刷新时）
  [[NSUserDefaults standardUserDefaults] setObject:modTime forKey:@"currentModTime"];
  [[NSUserDefaults standardUserDefaults] synchronize];
  [FPSearchFundList getFundTableWithLastModtime:modTime withCallback:callBack];
}
/** 更新本地库列表 */
- (void)showFundListWithResponse:(NSDictionary *)dict {
  [DicToArray parseFundlists:dict];
}
#pragma mark - uitextfieldDelegate
- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string {
  if ([string isEqualToString:@"\n"]) {
    return YES;
  }
  NSString *toBeString =
      [textField.text stringByReplacingCharactersInRange:range withString:string];
  if ([toBeString length] > textfieldMaxLength) {
    //实时查询基金
    [self showFundListWithInput:toBeString];
    //更改显示效果，设置为输入就可以验证
    textField.text = [toBeString substringToIndex:textfieldMaxLength];
    return NO;
  } else {
    currentString = toBeString;
    //实时查询基金
    [self showFundListWithInput:toBeString];
    if ([toBeString length] == 0) {
      //显示历史数据
      [self readItemOfSaved];
    }
    return YES;
  }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  //释放第一响应者
  [textField resignFirstResponder];
  return YES;
}
#pragma mark - 表格加载
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  [_searchFundTextField resignFirstResponder];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 25.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  UIView *headBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowWidth, 25.0f)];
  headBGView.backgroundColor = [Globle colorFromHexRGB:@"f2f3f3"];
  UILabel *headTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 6.0f, 100.0f, 14.0f)];
  headTitleLabel.backgroundColor = [UIColor clearColor];
  headTitleLabel.textAlignment = NSTextAlignmentLeft;
  headTitleLabel.font = [UIFont systemFontOfSize:14.0f];
  headTitleLabel.clipsToBounds = YES;
  headTitleLabel.textColor = [Globle colorFromHexRGB:@"84929e"];
  [headBGView addSubview:headTitleLabel];
  if ([currentString length] > 0) {
    headTitleLabel.text = @"投资";
  } else {
    headTitleLabel.text = @"搜索历史";
  }
  return headBGView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  //写入搜索内容/
  if ([currentString length] > 0 || [fundListArray count] < 1) {
    return 0.0f;
  } else {
    return 25.0f;
  }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
  UIView *footBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowWidth, 25.0f)];
  footBGView.backgroundColor = [Globle colorFromHexRGB:@"f2f3f3"];

  UIButton *footTitleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  footTitleBtn.frame = CGRectMake(0, 0, windowWidth, 25.0f);
  [footTitleBtn setBackgroundColor:[UIColor clearColor]];
  [footTitleBtn setTitle:@"清除查询记录" forState:UIControlStateNormal];
  footTitleBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
  [footTitleBtn setTitleColor:[Globle colorFromHexRGB:@"84929e"] forState:UIControlStateNormal];
  UIImage *highlightImage = [FPYouguUtil createImageWithColor:btnAccordingToTheNormal];
  [footTitleBtn setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
  [footTitleBtn addTarget:self
                   action:@selector(clearQueryRecord)
         forControlEvents:UIControlEventTouchUpInside];
  [footBGView addSubview:footTitleBtn];
  if ([currentString length] > 0) {
    [footTitleBtn setTitle:@"" forState:UIControlStateNormal];
  } else {
    [footTitleBtn setTitle:@"清除查询记录" forState:UIControlStateNormal];
  }
  return footBGView;
}
/** 清除历史记录 */
- (void)clearQueryRecord {
  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                      message:@"确认清除历史记录吗？"
                                                     delegate:self
                                            cancelButtonTitle:@"取消"
                                            otherButtonTitles:@"确认", nil];
  [alertView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  //清除历史记录
  if (buttonIndex == 1) {
    NSString *plistPath = [PlistOperation getPlistPath:@"fundHistoryList.plist"];
    [historyDicArray removeAllObjects];
    //文件擦除
    [historyDicArray writeToFile:plistPath atomically:YES];
    //数组清空
    [historyListArray removeAllObjects];
    [fundListArray removeAllObjects];
    [_searchFundTableView reloadData];
  }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [fundListArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellId = @"FPFundCell";
  FPFundCell *cell = (FPFundCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
  //底部按钮存在按下态延时问题
  for (UIView *currentView in tableView.subviews) {
    if ([currentView isKindOfClass:[UIScrollView class]]) {
      ((UIScrollView *)currentView).delaysContentTouches = NO;
      ((UIScrollView *)currentView).canCancelContentTouches = NO;
      break;
    }
  }

  FPFundItem *item = fundListArray[indexPath.row];
  cell.fundNameLabel.text = item.fundName;
  cell.fundIdLabel.text = [self numberSwitchNsstring:[item.fundId integerValue]];
  cell.addOptionalBtn.tag = indexPath.row + 100;

  __weak FPSearchFundViewController *weakSelf = self;
  ButtonPressed buttonPressed = ^{
    FPSearchFundViewController *strongSelf = weakSelf;
    if (strongSelf) {
      [strongSelf addMyOptional:cell.addOptionalBtn];
    }
  };
  [cell.addOptionalBtn setOnButtonPressedHandler:buttonPressed];
  if ([item.isSelected integerValue]) {
    cell.addOptionalBtn.hidden = YES;
    cell.bgOptionalBtn.hidden = YES;
    cell.selectedLabel.hidden = NO;
  } else {
    cell.bgOptionalBtn.hidden = NO;
    cell.addOptionalBtn.hidden = NO;
    cell.selectedLabel.hidden = YES;
  }
  return cell;
}
#pragma mark - 加入自选
/** 添加自选操作 */
- (void)addMyOptional:(UIButton *)sender {
  __block FPSearchFundViewController *weakSelf = self;
  [Login_ViewController checkLoginStatusWithCallback:^(BOOL logonSuccess) {
    FPSearchFundViewController *strongSelf = weakSelf;
    if (logonSuccess) {
      [strongSelf clickedButtonTagIndex:sender.tag - 100];
    }
  }];
}
- (void)clickedButtonTagIndex:(NSInteger)buttonIndex {
  FPFundItem *item = fundListArray[buttonIndex];
  __block FPSearchFundViewController *weakSelf = self;
  [[WebServiceManager sharedManager]
      addMyOptionalWithFundId:[self numberSwitchNsstring:[item.fundId integerValue]]
                     withType:item.invstType
                   withUserId:YouGu_User_USerid
               withCompletion:^(id response) {
                 if (response && [[response objectForKey:@"status"] isEqualToString:@"0000"]) {
                   FPSearchFundViewController *strongSelf = weakSelf;
                   if (strongSelf) {
                     [strongSelf addMyOptionalSuccess:item];
                   }
                 } else {
                   NSString *message = [NSString stringWithFormat:@"%@", [response objectForKey:@"message"]];
                   if (!message || [message length] == 0 || [message isEqualToString:@"(null)"]) {
                     message = networkFailed;
                   }
                   if (response && [response[@"status"] isEqualToString:@"0101"]) {
                   } else {
                     YouGu_animation_Did_Start(message);
                   }
                 }
               }];
}
/** 加入自选成功 */
- (void)addMyOptionalSuccess:(FPFundItem *)item {
  //选中
  item.isSelected = @"1";
  //刷新数据
  [[FundListsSqlite sharedManager] updateOneList:item];
  [_searchFundTableView reloadData];
}
/** 数字转化为字符串 */
- (NSString *)numberSwitchNsstring:(NSInteger)num {
  NSString *str = [NSString stringWithFormat:@"%d", (int)(num + 1000000)];
  str = [str substringFromIndex:1];
  return str;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [UIView animateWithDuration:0.3f
                   animations:^{
                     [tableView deselectRowAtIndexPath:indexPath animated:YES];
                   }];
  FPFundItem *item = fundListArray[indexPath.row];
  [self saveItemOfSkined:item];
  FPFundDetailedViewController *fundDetailVC =
      [[FPFundDetailedViewController alloc] initWithCallback:^(BOOL isAddOptional) {
        if (isAddOptional) {
          item.isSelected = @"1";
        } else {
          item.isSelected = @"0";
        }
        [tableView reloadData];
      }];
  fundDetailVC.currentFundId = item.fundId;
  fundDetailVC.currentFundName = item.fundName;
  fundDetailVC.invsttypeStr = item.invstType;
  [_searchFundTextField resignFirstResponder];
  [AppDelegate pushViewControllerFromRight:fundDetailVC];
}
#pragma mark - 缓存处理
/** 读取缓存 */
- (void)readItemOfSaved {
  historyDicArray =
      [NSMutableArray arrayWithArray:[NSMutableArray arrayWithContentsOfFile:[PlistOperation getPlistPath:@"fundHistoryList.plist"]]];
  //清除显示数据
  if ([fundListArray count] > 0) {
    [fundListArray removeAllObjects];
  }
  //清空数组
  if ([historyListArray count] > 0) {
    [historyListArray removeAllObjects];
  }
  int historyCount = ((int)[historyDicArray count] - 1);
  for (int st = historyCount; st >= 0; st--) {
    NSDictionary *dict = historyDicArray[st];
    FPFundItem *item = [[FPFundItem alloc] init];
    item.fundId = dict[@"fundid"];
    item.fundName = dict[@"fundname"];
    item.pinyin = dict[@"pinyin"];
    item.invstType = dict[@"invsttype"];
    [historyListArray addObject:item];
    //最多保存10条
    if (historyCount - st >= 9) {
      break;
    }
  }
  [fundListArray addObjectsFromArray:historyListArray];
  if ([fundListArray count] > 0) {
    [self refreshIsMyOptional:fundListArray];
  }
  [_searchFundTableView reloadData];
}
/** 刷新是否已加入自选参数 */
- (void)refreshIsMyOptional:(NSArray *)quertLists {
  for (FPFundItem *item in quertLists) {
    if (![[FPMyOptionalShareManager shareManager] judgeDataRepeat:item.fundId]) {
      item.isSelected = @"1";
    } else {
      item.isSelected = @"0";
    }
  }
}
/** 历史数据判重 */
- (BOOL)judgeDataRepeat:(NSString *)localFundid {
  for (FPFundItem *item in historyListArray) {
    if ([item.fundId isEqualToString:localFundid]) {
      return NO;
    }
  }
  return YES;
}
/** 缓存已读信息（plist） */
- (void)saveItemOfSkined:(FPFundItem *)selectedItem {
  if ([self judgeDataRepeat:selectedItem.fundId]) {
    NSMutableDictionary *selectedDict = [[NSMutableDictionary alloc] init];
    selectedDict[@"fundid"] = selectedItem.fundId;
    selectedDict[@"fundname"] = selectedItem.fundName;
    //加入自选
    selectedDict[@"isSelected"] = selectedItem.isSelected;

    [historyListArray addObject:selectedItem];
    [historyDicArray addObject:selectedDict];
  }
  //输入写入
  [historyDicArray writeToFile:[PlistOperation getPlistPath:@"fundHistoryList.plist"]
                    atomically:YES];
}

@end
