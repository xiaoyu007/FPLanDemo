//
//  MyAssetViewController.m
//  优顾理财
//
//  Created by Mac on 15-4-8.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPMyAssetViewController.h"
#import "FPFundDetailCell.h"
#import "FPFundDetailItem.h"
#import "FPCheckAndCncelViewController.h"
//#import "FPTradeViewController.h"
#import "TradeTitleTableViewController.h"
#import "FPOpenAccountInfo.h"
#import "FundWarningUrl.h"
#import "RemindLists.h"
#import "FPFundDetailedViewController.h"
#import "FPFundTradeRuleViewController.h"

#define navigationBarheight 50.0f
#define tableviewHeight 188.0f

@implementation FPMyAssetViewController {
  ///刷新按钮
  UIButton *refreshButton;
  /** 请求时菊花控件 */
  UIActivityIndicatorView *indicator;
}
///移除当前界面
- (void)removeCurrentView {
  //注意：使用完通知后，立即将观察者注销
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  [self removeFromParentViewController];
}
- (void)viewDidLoad {
  [super viewDidLoad];
  [self CreatNavBarWithTitle:@"我的资产"];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(removeCurrentView)
                                               name:@"remove_before_view"
                                             object:nil];
  [self createTableview];
  //没账户，不刷新数据
  if ([self showNotHaveAccount]) {
    return;
  }
  fundListArray = [[NSMutableArray alloc] init];
  [self createMainView];
  //查询途中数
  [self getNumberOnTheWay];
  //查询我的资产
  [self sendRequestWithUserId:YouGu_User_USerid];
  HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
  __weak FPMyAssetViewController *weakSelf = self;
  callBack.onSuccess = ^(NSObject *obj) {
    FPMyAssetViewController *strongSelf = weakSelf;
    if (strongSelf) {
    }
  };
  [RemindLists getUserAllProfitAndLossDetailwithCallback:callBack];
}
#pragma mark - 界面
- (void)createMainView {
  //刷新按钮
  refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
  refreshButton.frame = CGRectMake(windowWidth - 50.0f, 0, 50.0f, 50.0f);
  [refreshButton setImage:[UIImage imageNamed:@"刷新小图标"] forState:UIControlStateNormal];
  [refreshButton setImage:[UIImage imageNamed:@"刷新小图标"] forState:UIControlStateHighlighted];
  refreshButton.imageEdgeInsets = UIEdgeInsetsMake(16.0f, 15.0f, 16.0f, 15.0f);
  [refreshButton addTarget:self
                    action:@selector(refeshAssetData)
          forControlEvents:UIControlEventTouchUpInside];
  UIImage *highLightImage = [FPYouguUtil createImageWithColor:btnAccordingToTheNormal];
  [refreshButton setBackgroundImage:highLightImage forState:UIControlStateHighlighted];
  [self.topNavView addSubview:refreshButton];
  //规则按钮
  UIButton *earningRuleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  earningRuleBtn.frame = CGRectMake(windowWidth - 100.0f, 0, 50.0f, 50.0f);
  earningRuleBtn.backgroundColor = [UIColor clearColor];
  [earningRuleBtn setBackgroundImage:highLightImage forState:UIControlStateHighlighted];
  [earningRuleBtn setImage:[UIImage imageNamed:@"说明小图标"] forState:UIControlStateNormal];
  [earningRuleBtn setImage:[UIImage imageNamed:@"说明小图标"] forState:UIControlStateHighlighted];
  earningRuleBtn.imageEdgeInsets = UIEdgeInsetsMake(16.0f, 16.0f, 16.0f, 15.0f);
  [earningRuleBtn addTarget:self
                     action:@selector(showRules)
           forControlEvents:UIControlEventTouchUpInside];
  [self.topNavView addSubview:earningRuleBtn];
  //刷新菊花
  [self createIndicator];
}
- (void)showRules {
  FPFundTradeRuleViewController *rule = [[FPFundTradeRuleViewController alloc] init];
  [AppDelegate pushViewControllerFromRight:rule];
}
/** 菊花控件 */
- (void)createIndicator {
  indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
  indicator.center = refreshButton.center;
  indicator.hidden = YES;
  [self.childView addSubview:indicator];
}
/** 创建表格 */
- (void)createTableview {
  fundDetailTableView =
      [[UITableView alloc] initWithFrame:CGRectMake(0, navigationBarheight, windowWidth, windowHeight - navigationBarheight - statusBarHeight)];
  fundDetailTableView.delegate = self;
  fundDetailTableView.dataSource = self;
  fundDetailTableView.backgroundColor = [Globle colorFromHexRGB:customBGColor];
  [self.childView addSubview:fundDetailTableView];
  [fundDetailTableView setTableHeaderView:[self createTableViewHeadView]];
  [fundDetailTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
  fundDetailTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
  fundDetailTableView.separatorColor = [Globle colorFromHexRGB:lightCuttingLine];
  [self registerNibCell];
}

#pragma mark - 注册NibCell
- (void)registerNibCell {
  UINib *cellNib = [UINib nibWithNibName:NSStringFromClass([FPFundDetailCell class]) bundle:nil];
  [fundDetailTableView registerNib:cellNib forCellReuseIdentifier:@"FPFundDetailCell"];
}

/** 创建表头 */
- (UIView *)createTableViewHeadView {
  tbHeadView =
      [[[NSBundle mainBundle] loadNibNamed:@"FPAssetsHeadView" owner:self options:nil] firstObject];
  [tbHeadView.tradeHistoryBtn addTarget:self
                                 action:@selector(showHistoryLists:)
                       forControlEvents:UIControlEventTouchUpInside];
  [tbHeadView.delegateRevokeBtn addTarget:self
                                   action:@selector(queryDelegateOrCancel:)
                         forControlEvents:UIControlEventTouchUpInside];
  return tbHeadView;
}
/** 交易记录 */
- (void)showHistoryLists:(id)sender {
  TradeTitleTableViewController *tradeVC = [[TradeTitleTableViewController alloc] init];
  [AppDelegate pushViewControllerFromRight:tradeVC];
}
/** 查委托/撤单 */
- (void)queryDelegateOrCancel:(id)sender {
  FPCheckAndCncelViewController *checkAndCancelVC = [[FPCheckAndCncelViewController alloc] init];
  [AppDelegate pushViewControllerFromRight:checkAndCancelVC];
}
/** 创建表尾 */
- (UIView *)createTableviewFootView {
  UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowWidth, 100.0f)];
  footView.backgroundColor = [UIColor clearColor];
  //暂无商品
  UILabel *noneProductLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 33.0f, windowWidth, 15.0f)];
  noneProductLabel.textAlignment = NSTextAlignmentCenter;
  noneProductLabel.font = [UIFont systemFontOfSize:15.0f];
  noneProductLabel.textColor = [Globle colorFromHexRGB:@"84929e"];
  noneProductLabel.text = @"您暂未持有任何产品";
  [footView addSubview:noneProductLabel];
  return footView;
}
#pragma mark - 请求
/** 点击重新刷新数据 */
- (void)refeshAssetData {
  [self sendRequestWithUserId:YouGu_User_USerid];
}
/** 发送请求 */
- (void)sendRequestWithUserId:(NSString *)userId {
  [indicator startAnimating];
  refreshButton.hidden = YES;
  indicator.hidden = NO;
  __weak FPMyAssetViewController *weakSelf = self;
  [[WebServiceManager sharedManager]
      loadFundDetailWithUserId:userId
                withCompletion:^(id response) {
                  FPMyAssetViewController *strongSelf = weakSelf;
                  if (strongSelf) {
                    if (response && [[response objectForKey:@"status"] isEqualToString:@"0000"]) {
                      [indicator stopAnimating];
                      refreshButton.hidden = NO;
                      indicator.hidden = YES;
                      //解析
                      [self showFundDetailWithResponse:response];
                    } else {
                      [indicator stopAnimating];
                      refreshButton.hidden = NO;
                      indicator.hidden = YES;

                      NSString *message =
                          [NSString stringWithFormat:@"%@", [response objectForKey:@"message"]];
                      if (!message || [message length] == 0 ||
                          [message isEqualToString:@"(null)"]) {
                        message = networkFailed;
                      }
                      if (response &&
                          [[response objectForKey:@"status"] isEqualToString:@"100006"]) {
                        //无数据
                        if ([fundListArray count] < 1) {
                          [fundDetailTableView setTableFooterView:[self createTableviewFootView]];
                        } else {
                          [fundDetailTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
                        }
                      } else if (response && [[response objectForKey:@"status"] isEqualToString:@"0101"]) {
                      } else
                        YouGu_animation_Did_Start(message);
                    }
                  }
                }];
}
/** 获取资产在途中数 */
- (void)getNumberOnTheWay {
  HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
  __weak FPMyAssetViewController *weakSelf = self;
  callBack.onSuccess = ^(NSObject *obj) {
    FPMyAssetViewController *strongSelf = weakSelf;
    if (strongSelf) {
      FundUserTradeOrdersNumber *info = (FundUserTradeOrdersNumber *)obj;
      if ([info.number integerValue] > 0) {
        tbHeadView.tradeNumLabel.hidden = NO;
        tbHeadView.tradeNumLabel.text =
            [NSString stringWithFormat:@"（您有%@笔在途交易）", info.number];
      } else {
        tbHeadView.tradeNumLabel.hidden = YES;
      }
    }
  };
  [FundUserTradeOrdersNumber getUserTradeOrdersNumberwithCallback:callBack];
}
/** 显示请求数据 */
- (void)showFundDetailWithResponse:(NSDictionary *)dict {
  if ([fundListArray count] > 0) {
    [fundListArray removeAllObjects];
  }
  FPMyFundItem *item = [DicToArray parseMyFundDetailWithList:dict];
  //表头
  tbHeadView.phoneLabel.text = item.userName;
  if ([item.yesterdayProfit floatValue] > 0) {
    tbHeadView.yesterdayProfitLabel.textColor = [Globle colorFromHexRGB:DataUpColor];
    tbHeadView.yesterdayYuanLabel.textColor = [Globle colorFromHexRGB:DataUpColor];
  } else if ([item.yesterdayProfit floatValue] == 0) {
    tbHeadView.yesterdayProfitLabel.textColor = [Globle colorFromHexRGB:DataZeroColor];
    tbHeadView.yesterdayYuanLabel.textColor = [Globle colorFromHexRGB:DataZeroColor];
  } else {
    tbHeadView.yesterdayProfitLabel.textColor = [Globle colorFromHexRGB:DataDownColor];
    tbHeadView.yesterdayYuanLabel.textColor = [Globle colorFromHexRGB:DataDownColor];
  }
  if ([item.countProfit floatValue] > 0) {
    tbHeadView.allProfitLabel.textColor = [Globle colorFromHexRGB:DataUpColor];
    tbHeadView.allProfitYuanLabel.textColor = [Globle colorFromHexRGB:DataUpColor];
  } else if ([item.countProfit floatValue] == 0) {
    tbHeadView.allProfitLabel.textColor = [Globle colorFromHexRGB:DataZeroColor];
    tbHeadView.allProfitYuanLabel.textColor = [Globle colorFromHexRGB:DataZeroColor];
  } else {
    tbHeadView.allProfitLabel.textColor = [Globle colorFromHexRGB:DataDownColor];
    tbHeadView.allProfitYuanLabel.textColor = [Globle colorFromHexRGB:DataDownColor];
  }
  //昨日收益
  CGSize size = [item.yesterdayProfit sizeWithFont:[UIFont boldSystemFontOfSize:30.0f]];
  tbHeadView.yesterdayProfitLabel.width = size.width;
  tbHeadView.yesterdayProfitLabel.center =
      CGPointMake(tbHeadView.yesterdayProfitNameLabel.centerX, tbHeadView.yesterdayProfitLabel.centerY);
  CGRect yestFrame = tbHeadView.yesterdayProfitLabel.frame;
  tbHeadView.yesterdayYuanLabel.origin = CGPointMake(yestFrame.origin.x + yestFrame.size.width + 3.0f,
                                                     tbHeadView.yesterdayYuanLabel.origin.y);
  tbHeadView.yesterdayProfitLabel.text = item.yesterdayProfit;
  //累计收益
  NSString *allProStr = [NSString stringWithFormat:@"%0.2f", [item.countProfit floatValue]];

  CGSize countSize = [allProStr sizeWithFont:[UIFont boldSystemFontOfSize:30.0f]];
  tbHeadView.allProfitLabel.width = countSize.width;
  tbHeadView.allProfitLabel.center =
      CGPointMake(tbHeadView.allProfitNameLabel.centerX, tbHeadView.allProfitLabel.centerY);
  CGRect allFrame = tbHeadView.allProfitLabel.frame;
  tbHeadView.allProfitYuanLabel.origin = CGPointMake(allFrame.origin.x + allFrame.size.width + 3.0f,
                                                     tbHeadView.allProfitYuanLabel.origin.y);

  tbHeadView.allProfitLabel.text = allProStr;

  //总资产
  NSString *allAssetStr = [NSString stringWithFormat:@"%0.2f", [item.countAssets floatValue]];
  CGRect assetFrame = tbHeadView.allAssetsLabel.frame;

  CGSize assetSize = [allAssetStr sizeWithFont:[UIFont boldSystemFontOfSize:49.0f]];

  //防止超出过多
  if (assetSize.width >= windowWidth - 40.0f) {
    tbHeadView.allAssetsLabel.frame =
        CGRectMake(assetFrame.origin.x, assetFrame.origin.y, windowWidth - 40.0f, assetFrame.size.height);
  } else {
    tbHeadView.allAssetsLabel.frame =
        CGRectMake(assetFrame.origin.x, assetFrame.origin.y, assetSize.width, assetFrame.size.height);
  }

  tbHeadView.allAssetsLabel.text = allAssetStr;
  tbHeadView.allAssetYuanLabel.origin = CGPointMake(CGRectGetMaxX(tbHeadView.allAssetsLabel.frame) + 3.0f,
                                                    tbHeadView.allAssetYuanLabel.origin.y);

  //列表
  [fundListArray addObjectsFromArray:item.fundLists];
  NSLog(@"%@", fundListArray);
  [fundDetailTableView reloadData];
  //无数据
  if ([fundListArray count] < 1) {
    [fundDetailTableView setTableFooterView:[self createTableviewFootView]];
  } else {
    [fundDetailTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
  }
}
/** 显示未开户界面 */
- (BOOL)showNotHaveAccount {
  if ([[SimuControl myAssetOpenAcountType] integerValue] == 1) {
    return NO;
  }
  //透明背景
  shieldingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowWidth, windowHeight)];
  shieldingView.backgroundColor = [Globle colorFromHexRGB:@"000000" withAlpha:0.5f];
  shieldingView.userInteractionEnabled = YES;
  [self.childView addSubview:shieldingView];
  //单击事件
  UITapGestureRecognizer *tap =
      [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelClicked)];
  tap.delegate = self;
  [shieldingView addGestureRecognizer:tap];
  //开户按钮
  openAccountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  openAccountBtn.frame = CGRectMake(45.0f, windowHeight - 95.0f, windowWidth - 90.0f, 40.0f);
  [openAccountBtn.layer setMasksToBounds:YES];
  [openAccountBtn.layer setCornerRadius:20.0f];
  [openAccountBtn setTitle:@"马上开户 马上赚钱" forState:UIControlStateNormal];
  [openAccountBtn setBackgroundColor:[Globle colorFromHexRGB:@"d9540d"]];
  UIImage *highLightImage = [FPYouguUtil createImageWithColor:buttonHighLightColor];
  [openAccountBtn setBackgroundImage:highLightImage forState:UIControlStateHighlighted];
  openAccountBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
  [openAccountBtn addTarget:self
                     action:@selector(showOpenAccountPage)
           forControlEvents:UIControlEventTouchUpInside];
  [self.childView addSubview:openAccountBtn];
  return YES;
}
//释放界面
- (void)cancelClicked {
  [AppDelegate popViewController:YES];
}
/** 跳转开户界面 */
- (void)showOpenAccountPage {
  //界面跳转代码
  [[FPOpenAccountInfo shareInstance] openAccountStatusJudgementWithFromPage:OpenAccountSwitchTypeMyAssets];
}
#pragma mark - tableviewdelegate
/** 自定义分割线长度 */
- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  if ([fundDetailTableView respondsToSelector:@selector(setSeparatorInset:)]) {
    [fundDetailTableView setSeparatorInset:UIEdgeInsetsMake(0, 18.0f, 0, 18.0f)];
  }
  if ([fundDetailTableView respondsToSelector:@selector(setLayoutMargins:)]) {
    [fundDetailTableView setLayoutMargins:UIEdgeInsetsMake(0, 18.0f, 0, 18.0f)];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [fundListArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return tableviewHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellId = @"FPFundDetailCell";
  FPFundDetailCell *cell = (FPFundDetailCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
  FPFundDetailItem *item = fundListArray[indexPath.row];
  cell.cellFundId = item.fundId;
  cell.cellFundName = item.fundName;
  cell.productNameLabel.text = item.fundName;
  cell.cellTradeacco = item.tradeacco;
  cell.holdNumberLabel.text = item.holdNum;
  cell.cellRemindStatus = item.remindStatus;
  cell.assetsLabel.text = [NSString stringWithFormat:@"%0.2f 元", [item.assets floatValue]];
  if ([item.profit floatValue] > 0) {
    cell.proAndLossLabel.textColor = [Globle colorFromHexRGB:DataUpColor];
  } else if ([item.profit floatValue] == 0) {
    cell.proAndLossLabel.textColor = [Globle colorFromHexRGB:DataZeroColor];
  } else {
    cell.proAndLossLabel.textColor = [Globle colorFromHexRGB:DataDownColor];
  }
  [cell refreshWarningButtonWithIsRemind:item.remindStatus];
  cell.proAndLossLabel.text = [NSString stringWithFormat:@"%0.2f 元", [item.profit floatValue]];
  return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  FPFundDetailItem *item = fundListArray[indexPath.row];
  FPFundDetailedViewController *fundDetailVC = [[FPFundDetailedViewController alloc] init];
  fundDetailVC.currentFundId = item.fundId;
  fundDetailVC.currentFundName = item.fundName;
  [AppDelegate pushViewControllerFromRight:fundDetailVC];
}
@end
