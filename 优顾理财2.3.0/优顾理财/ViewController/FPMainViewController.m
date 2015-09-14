//
//  FPMainViewController1.m
//  优顾理财
//
//  Created by Mac on 15/7/27.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPNewsViewController.h"
#import "FPFundShopViewController.h"
#import "FPKnowViewController.h"
#import "FPSettingViewController.h"
#import "YouGuOpendingStatus.h"
#import "YouguuSchema.h"
#import "BaiDuPush.h"
#import "FPShareSDKUtil.h"

#import "GuideViewController.h"
#import "KeychainItemWrapper.h"
#import "FPGesturePasswordController.h"
#import "FundGuidingViewController.h"
#import "FPUserCenterViewController.h"

#define bottomHeight 50
static bool IsTradeOpened = NO;

@implementation FPMainViewController
#pragma mark - ViewDidLoad
- (id)init {
  self = [super init];
  if (self) {
    //推送消息中心
    [self creatNotificationCenter];
  }
  return self;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  self.isStatus = YES;
  self.childView.layer.masksToBounds = YES;
  self.childView.clipsToBounds = YES;
  page_Type = 0;
  // Do any additional setup after loading the view from its nib.
  [self performSelector:@selector(showGuidePageOrGesturePage) withObject:nil afterDelay:5.0f];
  viewControllers = [[NSMutableDictionary alloc] init];
  _MarketArray = [[NSMutableArray alloc] initWithCapacity:0];
  IsTradeOpened = [FPYouguUtil isOpening];
  [self WIFI_request];
  //数据行情，定时器
  [self initTrendTimer];
  [self creatSimubottomToolBarview];
  ///默认选中基金超市
  [self bottomButtonPressDown:0];
}
// bottomView
- (void)creatSimubottomToolBarview {
  simubottomToolBarview =
      [[SimuBottomToolBarView alloc] initWithFrame:CGRectMake(0, self.view.height - bottomHeight, self.view.width, bottomHeight)];
  simubottomToolBarview.delegate = self;
  [self.view addSubview:simubottomToolBarview];
}
//消息中心
- (void)creatNotificationCenter {
  //点击通知消息，导致的登录成功
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(notifactionLoginSucees:)
                                               name:NotifactionLoginSuccess
                                             object:nil];
  //设置通知中心
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(shareContentSDK:)
                                               name:@"shareContentSDK"
                                             object:nil];

  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(WIFI_request)
                                               name:@"RefreshStockInfoManual"
                                             object:nil];
}
#pragma mark - 手势密码
/**
 *  显示引导页及手势界面的逻辑
 */
- (void)showGuidePageOrGesturePage {
  NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
  NSString *appVersion = [info objectForKey:@"CFBundleShortVersionString"];
  NSString *key = [NSString stringWithFormat:@"welcome_start%@", appVersion];
  if (!YouGu_defaults(key)) {
    YouGu_defaults_double([NSNumber numberWithBool:YES], key);
    [self createFundGuideView];
    //首次启动页,app使用导航页
    GuideViewController *guideVC = [[GuideViewController alloc] init];
    [self addChildViewController:guideVC];
    [self.view addSubview:guideVC.view];
  } else {
    [self changeToGesPage];
  }
}
/**
 *  切换到手势登录页面
 */
- (void)changeToGesPage {
  //有手势密码时，切换到手势密码界面
  KeychainItemWrapper *keychin =
      [[KeychainItemWrapper alloc] initWithIdentifier:@"YouGuuGesture" accessGroup:nil];
  NSString *password = [keychin objectForKey:(__bridge id)kSecValueData];
  if (password && [password length] > 0 && [SimuControl OnLoginType] == 1) {
    FPGesturePasswordController *pass = [[FPGesturePasswordController alloc] init];
    pass.pageType = GesturePasswordPageTypeLogonVer;
    [self presentViewController:pass animated:YES completion:nil];
  }
}
/** 基金引导页 */
- (void)createFundGuideView {
  FundGuidingViewController *fundGuideVC =
      [[FundGuidingViewController alloc] initWithNibName:@"FundGuidingViewController" bundle:nil];
  [self addChildViewController:fundGuideVC];
  [self.view addSubview:fundGuideVC.view];
}
#pragma mark
#pragma mark 牛人追踪相关函数
//消息通知登录成功，展示牛人主页，并展示追踪牛人个人主页
- (void)notifactionLoginSucees:(NSNotification *)obj {
  [BaiDuPush sendApplePushToken];
  NSLog(@"userfn");
  [YouguuSchema forwardPageFromNoticfication:obj.userInfo];
}
#pragma mark - ShareSDK
- (void)shareContentSDK:(NSNotification *)info {
  NSNumber *num = [info object];
  switch ([num intValue]) {
  case 0:
    [FPShareSDKUtil contentShareTotype:ShareTypeSinaWeibo];
    break;
  case 1:
    [FPShareSDKUtil contentShareTotype:ShareTypeTencentWeibo];
    break;
  case 2:
    [FPShareSDKUtil contentShareTotype:ShareTypeWeixiSession];
    break;
  case 3:
    [FPShareSDKUtil contentShareTotype:ShareTypeWeixiTimeline];
    break;
  case 4:
    [FPShareSDKUtil contentShareTotype:ShareTypeQQ];
    break;
  case 5:
    [FPShareSDKUtil contentShareTotype:ShareTypeQQSpace];
    break;
  default:
    break;
  }
}
#pragma mark
#pragma mark--底部按钮点击回调 simuBottomToolBarViewDelegate------
//底部按钮点击
- (void)bottomButtonPressDown:(NSInteger)index {
  FPNoTitleViewController *selectedViewController = viewControllers[@(page_Type)];
  [selectedViewController.view removeFromSuperview];
  FPNoTitleViewController *viewController = viewControllers[@(index)];
  if (viewController == nil) {
    viewController = [self createSubViewControllerWithTabIndex:index];
    viewControllers[@(index)] = viewController;
    [self addChildViewController:viewController];
  }
  page_Type = index;

  [self.childView addSubview:viewController.view];
}
- (FPNoTitleViewController *)createSubViewControllerWithTabIndex:(NSInteger)index {
  CGRect frame = CGRectMake(0, 0, self.childView.width,
                            self.childView.height - bottomHeight - BOTTOM_TOOL_BAR_OFFSET_Y);
  FPNoTitleViewController *viewController;
  switch (index) {
  case 0: //基金超市
  {
    viewController = [[FPFundShopViewController alloc] initWithFrame:frame];
    break;
  }
  case 1: //新闻资讯
  {
    viewController = [[FPNewsViewController alloc] initWithFrame:frame];
    break;
  }
  case 2: //财知道
  {
    viewController = [[FPKnowViewController alloc] initWithFrame:frame];
    break;
  }
  case 3: //个人设置
  {
    viewController = [[FPSettingViewController alloc]initWithFrame:frame];
    break;
  }
  default:
    NSLog(@"主页上的Tab数不对导致崩溃了");
    abort();
    break;
  }
  return viewController;
}
#pragma mark
#pragma mark 定时器相关函数
//创建定时器
- (void)initTrendTimer {
  if (iKLTimer != nil) {
    if ([iKLTimer isValid]) {
      [iKLTimer invalidate];
    }
  }
  iKLTimer = [NSTimer scheduledTimerWithTimeInterval:5.0
                                              target:self
                                            selector:@selector(KLineHandleTimer:)
                                            userInfo:nil
                                             repeats:YES];
}

//定时器回调函数
- (void)KLineHandleTimer:(NSTimer *)theTimer {
  if (iKLTimer == theTimer) {
    //如果当前交易所状态为闭市，则什么也不做
    if ([FPYouguUtil isOpening]) {
      [self WIFI_request];
      // 如果不开市时间，将“焦点”页面的行情部分去了
      if (!IsTradeOpened) {
        IsTradeOpened = YES;
        YouGu_defaults_double(_MarketArray, YouGu_stock_market_key);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Refrash_stock_Market"
                                                            object:nil];
      }
    } else {
      // 如果不开市时间，就，将，“焦点”页面，行情去了
      if (IsTradeOpened) {
        IsTradeOpened = NO;
        YouGu_defaults_double(_MarketArray, YouGu_stock_market_key);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Refrash_stock_Market"
                                                            object:nil];
      }
    }
  }
}
#pragma mark - 行情数据的获取(添加定时器)
//网络请求
- (void)WIFI_request {
  if (![FPYouguUtil isExistNetwork]) {
    return;
  }
  [[WebServiceManager sharedManager] The_stock_market_code_completion:^(NSMutableArray *array) {
    //将请求来的数据，保存，并覆盖，原先行情数据
    if (array && [array count] > 0) {
      if (!_MarketArray) {
        _MarketArray = [[NSMutableArray alloc] init];
      }
      [self.MarketArray removeAllObjects];
      [self.MarketArray addObjectsFromArray:array];
      YouGu_defaults_double(_MarketArray, YouGu_stock_market_key);
      [[NSNotificationCenter defaultCenter] postNotificationName:@"RefrashStockMarket" object:nil];
    }
  }];
}
//定时器停止
- (void)stopMyTimer {
  if (iKLTimer != nil) {
    if ([iKLTimer isValid]) {
      [iKLTimer invalidate];
      iKLTimer = nil;
    }
  }
}
- (void)dealloc {
  [self stopMyTimer];
}
@end