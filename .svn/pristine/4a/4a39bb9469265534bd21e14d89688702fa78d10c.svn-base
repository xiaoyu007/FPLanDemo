//
//  OptionalManageViewController.h
//  优顾理财
//
//  Created by Mac on 15-4-21.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "YGBaseViewController.h"

/** 删除自选回调 */
typedef void (^onReturnObject)(BOOL listChanged);
/** 我的自选管理界面 */
@interface FPOptionalManageViewController
    : YGBaseViewController <UITableViewDataSource, UITableViewDelegate,
                            UIAlertViewDelegate> {
  /** 我的自选基金列表 */
  UITableView *optionalManageTableview;
  /** 我的自选数据 */
  NSMutableArray *myOptionalArray;

  /** 其它基金 */
  NSMutableArray *otherArray;
  /** 存在其它基金 */
  NSInteger existOtherFund;
  /** 货币基金列表 */
  NSMutableArray *moneyFundArray;
  /** 存在货币基金 */
  NSInteger existMoneyFund;
  /** 理财基金列表 */
  NSMutableArray *financialFundArray;
  /** 存在理财基金 */
  NSInteger existFinancialFund;
  /** 基金类型数组 */
  NSMutableArray *fundTypeArray;

  /** 所选fundids */
  NSMutableArray *selectedFundArray;

  /** 删除自选回调 */
  onReturnObject currentCallback;
}
/** 管理界面数组 */
@property(nonatomic, strong) NSMutableArray *optionalManageArray;
/** 自选对象初始化 */
- (id)initWithCallBack:(onReturnObject)callBack;

@end
