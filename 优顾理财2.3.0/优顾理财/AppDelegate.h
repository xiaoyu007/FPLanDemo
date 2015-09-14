//
//  AppDelegate.h
//  优顾理财
//
//  Created by Mac on 14-2-19.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPMainViewController.h"
//提示动画
#import "AnimationLabelAlterView.h"
#import "Reachability.h"
#import "RootViewController.h"
#define UMENG_APPKEY @"52d60a3556240bc0b70209b5"
typedef enum {
  BPushAllExpert = 1,              // 模拟炒股牛人数据推送（群发）
  BPushFinancialSingle = 2,        // 理财@数据推送(单发)
  BPushTalkingStockNewsCenter = 3, // 聊股消息中心提醒
  BPushExpertTraceMessage = 4,     //牛人追踪消息推送
  BPushTongAccountProfitability = 5,             //账户盈利通知
  BPushStrategyPlatformNotice = 6,               //策略平台通知
  BPushStrategyPlatformEarningsAnnouncement = 7, //策略平台盈利通知
  BPushVipTransactionMessageNotification = 8,    // Vip交易消息通知
  
  BPushSoonerOrLaterTheNewspaper = 11, //早晚报推送
  BPushTheSystemMessage = 12,          //系统消息（单发）
  
  BPushStockPricesEarlyWarning = 21, //股价预警
  BPushMarketTransaction = 22,       //行情异动(智能预警)
  
  BPushNodePostedWarning = 31,     //结贴警报
  BPushOptimalGuXiaobianPost = 32, //优顾小编推送帖子
  BPushAssignSomebody = 33,        //@某人
  BPushCommentPush = 34,           //评论
  BPushRewardsPush = 35,           //打赏
  BPushAutomaticRewardsFee = 36,   //自动打赏（扣手续费）
  BPushreplyPush = 37,             //回复
  BPushExcellentFinancialConsulting = 38, //优顾理财理财咨询（优顾小编推送新闻）
  BPushRecommendandpurchaseProducts = 39, //推荐优购产品
  BPushPromotionActivities = 40,          //推广活动
  BPushMasterPlanMessageTrace = 41,          //牛人计划追踪消息
  BPushShopFundPriceWarning = 42    ///理财超市涨跌提醒推送消息
} BPushTypeMNCG;

@interface AppDelegate
    : UIResponder <UIApplicationDelegate, UIAlertViewDelegate,
                   UIScrollViewDelegate> {
@private
  Reachability *hostReach;
}

@property(strong, nonatomic) UIWindow *window;
/** 根视图 */
@property(strong, nonatomic) RootViewController *rvc;
@property(nonatomic, strong) UINavigationController *navigationController;
@property(nonatomic, strong) FPMainViewController *main_viewController;
///推送数据
@property(nonatomic, strong) NSMutableDictionary *app_userinfo;
#pragma mark - 提示动画
///******************************************************************************
// 函数名称 :-(void)YouGu_animation_Did_Start:(NSString *)text
// 函数描述 : 提示动画
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************/
- (void)YouGu_animation_Did_Start:(NSString *)text;
/** 启动新的页面，使用从右到左的动画类型*/
+ (void)pushViewControllerFromRight:(UIViewController *)toViewController;

/** 启动新的页面，使用从下到上的动画类型*/
+ (void)pushViewControllerFromBottom:(UIViewController *)toViewController;

/** 退出页面，自动使用反向的动画类型。例如：从右至左进入，则从左到右退出*/
+ (void)popViewController:(BOOL)animated;

/** 退出页面，向下弹出 */
+ (void)popViewControllerToBottom;

/** 退出页面，退到指定页面*/
+ (void)popToViewController:(UIViewController *)viewController
                   aminited:(BOOL)animated;

/** 退出页面，退到基类*/
+ (void)popToRootViewController:(BOOL)animated;

///0101
+(void)addAlertView;

///有无网络存在
- (BOOL)isExistNetwork;
///判断网络的状态类型
-(NetworkStatus)getNetworkStatus;
@end
