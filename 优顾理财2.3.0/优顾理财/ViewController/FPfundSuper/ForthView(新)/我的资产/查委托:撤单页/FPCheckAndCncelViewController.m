//
//  CheckAndCncelViewController.m
//  优顾理财
//
//  Created by jhss on 15-4-8.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPCheckAndCncelViewController.h"
#import "FPCheckAndCancelTableViewCell.h"
#import "NetLoadingWaitView.h"

@interface FPCheckAndCncelViewController () <UITableViewDataSource,
                                             UITableViewDelegate> {

  IBOutlet UIView *backNameView;
  ///设置表尾
  UIView *footerView;
  ///刷新按钮
  UIButton *refreshButton;
  /** 请求时菊花控件 */
  UIActivityIndicatorView *indicator;
}
@end

@implementation FPCheckAndCncelViewController

- (void)refeshCheckData {
  /** 刷新数据*/
  [self sendRequestWithDelegateCheckAndCancel];
}
- (void)viewDidLoad {
  [super viewDidLoad];
  _delegateListArray = [[NSMutableArray alloc] init];

  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(removeFromSuper)
                                               name:@"removeView"
                                             object:nil];

  /**  注册观察者观察是否撤单成功*/
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(refeshCheckData)
                                               name:@"refeshCheckData"
                                             object:nil];
  [self CreatNavBarWithTitle:@"查委托/撤单"];
  [self createTableView];
  [self createMainView];
  //  [self createTipView];
  //请求数据
  [self sendRequestWithDelegateCheckAndCancel];
  self.selectedIndex = -1;
}
#pragma mark - 界面创建
- (void)createMainView {
  //普通基金背景颜色
  backNameView.backgroundColor =
      [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.00f];
  //刷新按钮
  refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
  refreshButton.frame = CGRectMake(windowWidth - 50.0f, 0, 50.0f, 50.0f);
  [refreshButton setImage:[UIImage imageNamed:@"刷新小图标"]
                 forState:UIControlStateNormal];
  [refreshButton setImage:[UIImage imageNamed:@"刷新小图标"]
                 forState:UIControlStateHighlighted];
  refreshButton.imageEdgeInsets = UIEdgeInsetsMake(16.0f, 15.0f, 16.0f, 15.0f);
  [refreshButton addTarget:self
                    action:@selector(refeshCheckData)
          forControlEvents:UIControlEventTouchUpInside];
  UIImage *highLightImage =
      [FPYouguUtil createImageWithColor:btnAccordingToTheNormal];
  [refreshButton setBackgroundImage:highLightImage
                           forState:UIControlStateHighlighted];
  [self.childView addSubview:refreshButton];
  //刷新菊花
  [self createIndicator];
}
/** 菊花控件 */
- (void)createIndicator {
  indicator = [[UIActivityIndicatorView alloc]
      initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
  indicator.center = refreshButton.center;
  indicator.hidden = YES;
  [self.childView addSubview:indicator];
}
/** 创建表*/
- (void)createTableView {
  self.checkAndCancelTableView = [[UITableView alloc]
      initWithFrame:CGRectMake(0, 130, windowWidth, windowHeight - 130.0f)];
  self.checkAndCancelTableView.delegate = self;
  self.checkAndCancelTableView.dataSource = self;
  [self.view addSubview:self.checkAndCancelTableView];
  _checkAndCancelTableView.tableFooterView =
      [[UIView alloc] initWithFrame:CGRectZero];
  _checkAndCancelTableView.separatorStyle =
      UITableViewCellSeparatorStyleSingleLine;
  _checkAndCancelTableView.separatorColor = [Globle colorFromHexRGB:@"e8e8e8"];
  [self createFootView];
  [self registerNibCell];
}

#pragma mark - 注册NibCell
- (void)registerNibCell {
  UINib *cellNib = [UINib
      nibWithNibName:NSStringFromClass([FPCheckAndCancelTableViewCell class])
              bundle:nil];
  [self.checkAndCancelTableView registerNib:cellNib
                     forCellReuseIdentifier:@"FPCheckAndCancelTableViewCell"];
}

- (void)createFootView {
  ///设置表尾
  footerView = [[UIView alloc]
      initWithFrame:CGRectMake(0, 0, windowWidth, windowHeight - 130)];
  footerView.backgroundColor = [UIColor whiteColor];

  UILabel *lab = [[UILabel alloc]
      initWithFrame:CGRectMake(30, footerView.frame.size.height / 2 - 65,
                               windowWidth - 60, 40)];
  lab.text = @"暂无委托";
  lab.textAlignment = NSTextAlignmentCenter;
  lab.textColor = [Globle colorFromHexRGB:@"cfcfcf"];
  [footerView addSubview:lab];
}

#pragma mark - 数据加载
- (void)sendRequestWithDelegateCheckAndCancel {
  [indicator startAnimating];
  indicator.hidden = NO;
  refreshButton.hidden = YES;
  [[WebServiceManager sharedManager]
      sendRequestWithDelegateCheckUserId:YouGu_User_USerid
                          withCompletion:^(id response) {
                            if (response && [[response objectForKey:@"status"]
                                                isEqualToString:@"0000"]) {
                              [indicator stopAnimating];
                              indicator.hidden = YES;
                              refreshButton.hidden = NO;
                              //解析
                              [self showCheckAndCancelWithResponse:response];
                            } else {
                              [indicator stopAnimating];
                              refreshButton.hidden = NO;
                              indicator.hidden = YES;

                              NSString *message = [NSString
                                  stringWithFormat:
                                      @"%@",
                                      [response objectForKey:@"message"]];
                              if (!message || [message length] == 0 ||
                                  [message isEqualToString:@"(null)"]) {
                                message = networkFailed;
                              }
                              if (response &&
                                  [response[@"status"] isEqualToString:@"0101"]){
                              }else{
                                YouGu_animation_Did_Start(message);
                              }                            }
                          }];
}
/** 显示请求数据 */
- (void)showCheckAndCancelWithResponse:(NSDictionary *)dict {
  if ([_delegateListArray count] > 0) {
    [_delegateListArray removeAllObjects];
  }
  [_delegateListArray
      addObjectsFromArray:[DicToArray parseCheckAndCancelWithLists:dict]];
  //自适应高度
  [self fundNameIdAutoHeight];
  if (_delegateListArray.count == 0) {
    self.checkAndCancelTableView.tableFooterView = footerView;
  } else {
    _checkAndCancelTableView.tableFooterView =
        [[UIView alloc] initWithFrame:CGRectZero];
  }
  [_checkAndCancelTableView reloadData];
}
/** 名称代码高度 */
- (void)fundNameIdAutoHeight {
  for (FPCheckAndCancelItem *item in _delegateListArray) {
    NSString *fundNameIdStr =
        [NSString stringWithFormat:@"%@  %@", item.fundname, item.fundid];
    NSMutableAttributedString *attr =
        [[NSMutableAttributedString alloc] initWithString:fundNameIdStr];
    //名称范围
    NSRange nameRange = [fundNameIdStr rangeOfString:item.fundname];
    NSRange idRange = [fundNameIdStr rangeOfString:item.fundid];
    [attr addAttribute:NSForegroundColorAttributeName
                 value:(id)[Globle colorFromHexRGB:textNameColor]
                 range:nameRange];
    [attr addAttribute:NSFontAttributeName
                 value:[UIFont systemFontOfSize:13.0f]
                 range:nameRange];

    [attr addAttribute:NSForegroundColorAttributeName
                 value:(id)[Globle colorFromHexRGB:textfieldContentColor]
                 range:idRange];
    [attr addAttribute:NSFontAttributeName
                 value:[UIFont systemFontOfSize:11.0f]
                 range:idRange];
    item.fundNameIdHeight = (attr.size.width / 130 + 1.0f) * 13.0f + 20.0f;
    item.attr = attr;
  }
}
#pragma mark---tableViewDelegate
/** 自定义分割线长度 */
- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  if ([_checkAndCancelTableView
          respondsToSelector:@selector(setSeparatorInset:)]) {
    [_checkAndCancelTableView
        setSeparatorInset:UIEdgeInsetsMake(0, 18.0f, 0, 18.0f)];
  }

  if ([_checkAndCancelTableView
          respondsToSelector:@selector(setLayoutMargins:)]) {
    [_checkAndCancelTableView
        setLayoutMargins:UIEdgeInsetsMake(0, 18.0f, 0, 18.0f)];
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
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return [_delegateListArray count];
}
- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  FPCheckAndCancelItem *item = _delegateListArray[indexPath.row];
  return item.fundNameIdHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellId = @"FPCheckAndCancelTableViewCell";
  FPCheckAndCancelTableViewCell *cell = (FPCheckAndCancelTableViewCell *)
      [tableView dequeueReusableCellWithIdentifier:cellId];
  FPCheckAndCancelItem *item = _delegateListArray[indexPath.row];
  cell.applyType.text =
      [NSString stringWithFormat:@"%@\n%@", item.type, item.status];
  cell.fundNameAndId.attributedText = item.attr;
  cell.fundNameAndId.height = item.fundNameIdHeight;
  cell.applyMoney.text = item.money;
  return cell;
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [UIView animateWithDuration:0.3f
                   animations:^{
                     [tableView deselectRowAtIndexPath:indexPath animated:YES];
                   }];

  ///记录点击的哪一行
  self.selectedIndex = 1000 + indexPath.row;
  currentItem = _delegateListArray[indexPath.row];
  if (![currentItem.cancancel boolValue]) {
    YouGu_animation_Did_Start(@"此" @"订"
                                     @"单不可撤单，如有疑问请联系客服人员。");
    return;
  }
  [self confirmButtonClicked];
  //  tipVC.view.hidden = NO;
}
#pragma mark -确认撤单
/*
 tradeacco	交易帐号
 mctserialno	众禄交易流水号
 cancancel	撤单状态
 */
- (void)confirmButtonClicked {
  [NetLoadingWaitView startAnimating];
  [[WebServiceManager sharedManager]
      sendRequestWithDelegateCheckUserId:YouGu_User_USerid
                             TradeaccoId:currentItem.tradeacco
                              serialnoId:currentItem.mctserialno
                               AndStatus:currentItem.cancancel
                          withCompletion:^(NSDictionary *response) {
                            if (response &&
                                [response[@"status"] isEqualToString:@"0000"]) {
                              [NetLoadingWaitView stopAnimating];
                              //解析
                              [self showJumpCheckCancelWithResponse:response];
                            } else {
                              [NetLoadingWaitView stopAnimating];
                              NSString *message = [NSString
                                  stringWithFormat:@"%@", response[@"message"]];
                              if (!message || [message length] == 0 ||
                                  [message isEqualToString:@"(null)"]) {
                                message = networkFailed;
                              }
                              if (response &&
                                  [response[@"status"] isEqualToString:@"0101"]){
                              }else{
                                YouGu_animation_Did_Start(message);
                              }                            }
                          }];
}
- (void)showJumpCheckCancelWithResponse:(NSDictionary *)dict {
  //  tipVC.view.hidden = YES;
  //跳转到确认界面
  FPCancelDetermineViewController *cancelDeterVC =
      [[FPCancelDetermineViewController alloc] init];
  FPCancellationInfoItem *item =
      [DicToArray parseCheckJumpCancelWithLists:dict];
  cancelDeterVC.tradeType = currentItem.type;
  cancelDeterVC.tradeacco = currentItem.tradeacco;
  cancelDeterVC.serialno = currentItem.mctserialno;
  cancelDeterVC.item = item;
  [AppDelegate pushViewControllerFromRight:cancelDeterVC];
}
//移除提示视图
- (void)removeFromSuper {

  UIView *grayView = (UIView *)[self.view viewWithTag:10000];
  [grayView removeFromSuperview];
  UIView *promptView = (UIView *)[self.view viewWithTag:10001];
  [promptView removeFromSuperview];

  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
