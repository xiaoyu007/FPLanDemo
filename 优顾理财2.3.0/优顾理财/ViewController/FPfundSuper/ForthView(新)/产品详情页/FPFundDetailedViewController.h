//
//  FundDetailedViewController.h
//  优顾理财
//
//  Created by Mac on 15/3/16.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

/*
 该页为web页，显示基金详情，并对所加载的那支基金的申购、赎回、加入自选和取消自选做相应处理
*/

#import "FPBaseViewController.h"
#import "SRRefreshView.h"
#import "FPFundItem.h"
#import "FPFundDetailWebVC.h"
#import "MyOptionalNotificationUtil.h"

typedef void (^fundDetailCallback) (BOOL isAddOptional);
typedef NS_ENUM(NSUInteger, myFundType) {
  /** 其它基金类型 */
  MyFundTypeOtherFund,
  /** 股票型 */
  MyFundTypeEquityFund = 1,
  /** 债券型 */
  MyFundTypeBondTypeFund = 2,
  /** 混合型 */
  MyFundTypeHybridFund = 3,
  /** 货币基金 */
  MyFundTypeMoneyFund = 4,
  /** 理财型基金 */
  MyFundTypeFinancialFund = 5,
};
/** 产品详情页面 */
@interface FPFundDetailedViewController : FPBaseViewController<UIScrollViewDelegate,SRRefreshDelegate,UIWebViewDelegate>
{
  /** 回调 */
  fundDetailCallback currentCallback;
  /** 当前page */
  NSInteger currentPage;
  /** 主界面 */
  FPFundDetailWebVC *fundDetailVC;
}
/** 自选状态变更通知 */
@property(nonatomic, strong)MyOptionalNotificationUtil *myOptionalNotificationUtl;
/** 产品id */
@property(nonatomic, strong) NSString *currentFundId;
/** 当前产品名称 */
@property(nonatomic, strong) NSString *currentFundName;
/**  当前产品的类型*/
@property(nonatomic, strong) NSString *invsttypeStr;
/**  当前产品的申购状态*/
@property(nonatomic,strong)NSString *isBuyStr;
/**  当前产品的赎回状态*/
@property(nonatomic,strong)NSString *isRedStr;
/**  当前基金详情 */
@property(nonatomic, strong) FPFundItem *item;
/** 带回调的初始化 */
- (id)initWithCallback:(fundDetailCallback)callback;
/** 是否需要进入费率界面 */
@property(nonatomic)BOOL isDeatil;
@end
