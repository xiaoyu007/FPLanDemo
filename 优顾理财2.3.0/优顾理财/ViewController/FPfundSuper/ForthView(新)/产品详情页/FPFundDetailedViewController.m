//
//  FundDetailedViewController.m
//  优顾理财
//
//  Created by Mac on 15/3/16.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPFundDetailedViewController.h"
#import "FPRedemViewController.h"
#import "FPMyOptionalShareManager.h"
#import "FundListsSqlite.h"
#import "FPOpenAccountInfo.h"
#import "UIButton+Block.h"
#import "RedeemAndBuyStatusItem.h"

@implementation FPFundDetailedViewController {
  UIView *btnBackgroundView;

  UILabel *title; //下面三个按钮的名称
  /** 基金的名称及类型*/
  NSString *fundNameAndTypestr;
  /**基金名称 */
  NSString *fundNameLabel;
  /** 费率*/
  NSString *feeLabel;
  /** 最少购买金额*/
  NSString *minMoneyLabel;
  /** 银行卡名称*/
  NSString *bankNameLabel;

  ///最小赎回份额
  NSString *minredantLabel;
  ///持仓份额
  NSString *balanceLabel;

  ///存储用户的银行卡信息
  NSMutableArray *bankArray;
  ///取消自选
  //  UIImageView *cancelImageView;
  ///
  //  UIImageView *butImgView;
  BOOL isSelect;

  BOOL isBuySelect;
  BOOL isRedeemSelect;
  NSString *fundStr;

  CGFloat userContentOffsetX;
  ///无网络状态
  //  LoadingView *loadingView;
  UIWebView *currentView;
}
- (id)initWithCallback:(fundDetailCallback)callback {
  self = [super init];
  if (self) {
    currentCallback = callback;
  }
  return self;
}
- (void)viewDidDisappear:(BOOL)animated {
  /**  将信息发给我的自选界面使刷新我的自选数据*/
  [[NSNotificationCenter defaultCenter] postNotificationName:@"refishCustomizeListData"
                                                      object:self
                                                    userInfo:nil];
}
/** 创建观察者 */
- (void)createNotification {
  _myOptionalNotificationUtl = [[MyOptionalNotificationUtil alloc] init];
  __weak FPFundDetailedViewController *weakSelf = self;
  MyOptionalFundChange action = ^{
    FPFundDetailedViewController *strongSelf = weakSelf;
    if (strongSelf) {
      [strongSelf refreshBottomButton];
    }
  };
  _myOptionalNotificationUtl.myOptionalFundchange = action;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  [self createNavBar];
  [self createNotification];
  //主界面
  fundDetailVC = [[FPFundDetailWebVC alloc] initWithNibName:@"FPFundDetailWebVC" bundle:nil];
  fundDetailVC.view.frame = self.childView.bounds;
  fundDetailVC.currentFundId = _currentFundId;
  [self.childView addSubview:fundDetailVC.view];
  [self addChildViewController:fundDetailVC];
  [self createWebView];
  [self performSelector:@selector(optionalButtonAddTarget) withObject:nil afterDelay:0.3f];
  [self refreshBottomButton];
  [self sendRefreshButtonStatusRequest];
  //加载一次自选数据
  [[FPMyOptionalShareManager shareManager] loadMyOptionalData];
  [self createOpenAccountNotification];
  if (![FPYouguUtil isExistNetwork]) {
    self.loading.hidden = NO;
    CGRect frame = fundDetailVC.scrollowBgView.frame;
    self.loading.frame =
        CGRectMake(0, frame.origin.y + navigationHeght + statusBarHeight, windowWidth, frame.size.height);
    [self.loading animationNoNetWork];
    return;
  } else {
    self.loading.hidden = YES;
  }
}
#pragma mark - 创建视图
///创建导航栏
- (void)createNavBar {
  NSString *tempId = [NSString stringWithFormat:@"%d", (int)[_currentFundId intValue]];
  NSMutableString *currentFundStr = [[NSMutableString alloc] initWithString:@"000000"];
  [currentFundStr replaceCharactersInRange:NSMakeRange(currentFundStr.length - tempId.length, tempId.length)
                                withString:tempId];
  fundNameAndTypestr = [NSString stringWithFormat:@"%@", _currentFundName];
  [self.topNavView leftAlignmentOfViewWithMainTitle:fundNameAndTypestr withSubTitle:currentFundStr];
}
///创建底部的三个按钮
- (void)optionalButtonAddTarget {
  if (_isDeatil == YES) {
    [fundDetailVC switchToFeeRate];
  }
  __weak FPFundDetailedViewController *weakSelf = self;
  ButtonPressed buttonPressed = ^{
    FPFundDetailedViewController *strongSelf = weakSelf;
    if (strongSelf) {
      [strongSelf optionalButtonClicked:fundDetailVC.optionalFundButton];
    }
  };
  [fundDetailVC.optionalFundButton setOnButtonPressedHandler:buttonPressed];
}
/** 刷新按钮状态 */
- (void)sendRefreshButtonStatusRequest {
  return;
  HttpRequestCallBack *callback = [[HttpRequestCallBack alloc] init];
  __weak FPFundDetailedViewController *weakSelf = self;
  callback.onSuccess = ^(NSObject *obj) {
    FPFundDetailedViewController *strongSelf = weakSelf;
    if (strongSelf) {
      RedeemAndBuyStatusItem *item = (RedeemAndBuyStatusItem *)obj;
      [strongSelf refreshButtonStatusWithItem:item];
    }
  };
  [RedeemAndBuyStatusItem getButtonStatusOfRedeemAndBuyWithFundId:_currentFundId
                                                     withCallback:callback];
}
- (void)refreshButtonStatusWithItem:(RedeemAndBuyStatusItem *)item {
  NSLog(@"xxx");
}
#pragma mark - 加载web页
/** 创建webview */
- (void)createWebView {
  for (int i = 0; i < 4; i++) {
    UIWebView *fundDetailWebView =
        [[UIWebView alloc] initWithFrame:CGRectMake(windowWidth * i, 0, windowWidth, self.childView.bounds.size.height - 90.0f)];
    fundDetailWebView.delegate = self;
    fundDetailWebView.scrollView.bounces = NO;
    [fundDetailVC.fundDetailScrView addSubview:fundDetailWebView];
    fundDetailWebView.tag = 100 + i;
    [self loadDataWithIndex:i + 100];
  }
}
- (void)loadDataWithIndex:(NSInteger)index {
  currentView = (UIWebView *)[self.view viewWithTag:index];
  switch (index) {
  case 100: {
    // 1.创建资源路径
    NSURL *url = [NSURL
        URLWithString:[NSString
                          stringWithFormat:@"%@mobile/fund/detail/fund_performance.html?id=%@", FundDetailIP, _currentFundId]];
    [self sendRequestOfUrl:url];
  } break;
  case 101: {
    // 1.创建资源路径
    NSURL *url = [NSURL
        URLWithString:[NSString stringWithFormat:@"%@mobile/fund/detail/fund_situation.html?id=%@", FundDetailIP, _currentFundId]];
    [self sendRequestOfUrl:url];
  } break;
  case 102: {
    // 1.创建资源路径
    NSURL *url = [NSURL
        URLWithString:[NSString stringWithFormat:@"%@mobile/fund/detail/fund_manager.html?id=%@", FundDetailIP, _currentFundId]];
    [self sendRequestOfUrl:url];
  } break;
  case 103: {
    // 1.创建资源路径
    NSURL *url =
        [NSURL URLWithString:[NSString stringWithFormat:@"%@mobile/fund/detail/rate.html?id=%@", FundDetailIP, _currentFundId]];
    [self sendRequestOfUrl:url];
  } break;
  default:
    break;
  }
}
///加载网页数据
- (void)sendRequestOfUrl:(NSURL *)url {
  // 2.创建请求
  NSURLRequest *request = [NSURLRequest requestWithURL:url
                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                       timeoutInterval:30.0f];
  // 3下载请求的数据
  [currentView loadRequest:request];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
  //加载完成，隐藏菊花
  self.loading.hidden = YES;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
  if (error) {
    if (error.code == -1009 || error.code == -1003) {
      YouGu_animation_Did_Start(networkFailed);
    } else
      YouGu_animation_Did_Start(error.userInfo[@"NSLocalizedDescription"]);
  }
}
#pragma mark - 按钮点击事件处理函数
/** 创建开户成工跳转 */
- (void)createOpenAccountNotification {
  //接到通知后跳转申购界面
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(refshBuyBtn)
                                               name:@"Go_to_buy_to_buy"
                                             object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(redeemBtnClick)
                                               name:@"redeemBtnClick"
                                             object:nil];
}
///开户完成后跳转赎回界面
- (void)redeemBtnClick {
  [[FPOpenAccountInfo shareInstance] openAccountStatusJudgementWithFromRedeem:YouGu_User_USerid
                                                             andCurrentFundId:_currentFundId
                                                               andTradeaccoId:@""
                                                                 withCallBack:^(BOOL isSuccess) {
                                                                   //赎回成功
                                                                   if (isSuccess) {
                                                                   }
                                                                 }];
}

///开户完成后跳转申购界面
- (void)refshBuyBtn {
  [[FPOpenAccountInfo shareInstance] openAccountStatusJudgementWithFromPage:YouGu_User_USerid
                                                           andCurrentFundId:_currentFundId];
}
#pragma mark - 自选状态处理
/** 自选按钮点击 */
- (void)optionalButtonClicked:(UIButton *)btn {
  //自选
  [Login_ViewController checkLoginStatusWithCallback:^(BOOL logonSuccess) {
    if (logonSuccess) {
      [self optionalOperation];
    }
  }];
}
/** 自选操作 */
- (void)optionalOperation {
  {
    if (![FPYouguUtil isExistNetwork]) {
      YouGu_animation_Did_Start(networkFailed);
      return;
    }
    self.item = [[FPFundItem alloc] init];
    self.item.fundId = [NSString stringWithFormat:@"%@", _currentFundId];

    if (isSelect == NO) {
      [[WebServiceManager sharedManager]
          addMyOptionalWithFundId:self.item.fundId
                         withType:self.item.invstType
                       withUserId:YouGu_User_USerid
                   withCompletion:^(id response) {
                     if (response && [[response objectForKey:@"status"] isEqualToString:@"0000"]) {
                       [self addMyOptionalSuccess:self.item];
                       if (currentCallback) {
                         currentCallback(YES);
                       }
                     } else {
                       NSString *message =
                           [NSString stringWithFormat:@"%@", [response objectForKey:@"message"]];
                       if (!message || [message length] == 0 ||
                           [message isEqualToString:@"(null)"]) {
                         message = networkFailed;
                       }
                       if (response && [response[@"status"] isEqualToString:@"0101"]) {
                       } else {
                         YouGu_animation_Did_Start(message);
                       }
                     }
                   }];

    } else {
      [[WebServiceManager sharedManager]
          deleteFundWithFundId:self.item.fundId
                    withUserId:YouGu_User_USerid
                withCompletion:^(id response) {
                  if (response && [[response objectForKey:@"status"] isEqualToString:@"0000"]) {
                    ///调用删除方法
                    [self mySelectionDeleteSuccess:self.item];
                    if (currentCallback) {
                      currentCallback(NO);
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
  }
}
/** 加入自选成功 */
- (void)addMyOptionalSuccess:(FPFundItem *)item {
  //加入自选成功
  isSelect = YES;
  //选中
  item.isSelected = @"1";
  YouGu_animation_Did_Start(@"添加自选成功");
  //刷新数据
  [[FundListsSqlite sharedManager] updateOneList:item];
  /** 多层 */
  [[NSNotificationCenter defaultCenter] postNotificationName:NT_MyOptionalFundChange object:nil];
}
/** 删除自选成功
 */
- (void)mySelectionDeleteSuccess:(FPFundItem *)item {
  isSelect = NO;
  item.isSelected = @"0";
  //本地缓存中清除掉
  [[FPMyOptionalShareManager shareManager] deleteMyOptionalListWithID:item.fundId];
  YouGu_animation_Did_Start(@"已取消自选基金");
  //刷新数据
  [[FundListsSqlite sharedManager] updateOneList:item];
  /** 多层 */
  [[NSNotificationCenter defaultCenter] postNotificationName:NT_MyOptionalFundChange object:nil];
}
/** 刷新自选状态 */
- (void)refreshBottomButton {
  if (![[FPMyOptionalShareManager shareManager] judgeDataRepeat:_currentFundId] &&
      [SimuControl OnLoginType]) { //已添加自选,登录
    fundDetailVC.optionalLabel.text = @"取消自选";
    fundDetailVC.optionalLabel.textColor = [Globle colorFromHexRGB:@"f07533"];
    [fundDetailVC.optionalImageView setImage:[UIImage imageNamed:@"取消自选"]];
    isSelect = YES;
  } else { //未添加自选
    fundDetailVC.optionalLabel.text = @"自选";
    fundDetailVC.optionalLabel.textColor = [Globle colorFromHexRGB:@"858585"];
    [fundDetailVC.optionalImageView setImage:[UIImage imageNamed:@"自选小图"]];
    isSelect = NO;
  }
}

#pragma mark - loading 代理方法
- (void)refreshNewInfo {
  if ([FPYouguUtil isExistNetwork]) {
    self.loading.hidden = YES;
    if (_isDeatil == YES) {
      [fundDetailVC switchToFeeRate];
      [self loadDataWithIndex:3];
    } else { //重新加载
      for (int i = 0; i < 4; i++) {
        [self loadDataWithIndex:i + 100];
      }
    }
    //刷新按钮状态
    [self refreshBottomButton];
  }
}
- (void)leftButtonPress {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  [fundDetailVC.view removeFromSuperview];
  [fundDetailVC removeFromParentViewController];
  NSLog(@"subviews = %@", self.view.subviews);
  [super leftButtonPress];
}
- (void)dealloc {
  NSLog(@"我释放了");
}

@end
