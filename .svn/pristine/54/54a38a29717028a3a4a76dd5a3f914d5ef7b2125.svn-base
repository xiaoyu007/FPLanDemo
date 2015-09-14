//
//  MyOptionalFundVController.h
//  优顾理财
//
//  Created by Mac on 15-4-19.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "YGBaseViewController.h"

typedef NS_ENUM(NSUInteger, OptionalFundType) {
  /** 其它基金类型 */
  OptionalFundTypeOtherFund,
  /** 货币基金 */
  OptionalFundTypeMoneyFund = 4,
  /** 理财型基金 */
  OptionalFundTypeFinancialFund = 5,
};
/** 我的自选 */
@interface FPMyOptionalFundVController
    : YGBaseViewController <UITableViewDataSource, UITableViewDelegate> {
  /** 我的自选 */
  UITableView *myOptionalTableview;
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
  /** 无数据界面 */
  UIView *noDataView;
  ///自选管理按钮
  UIButton *manageButton;
  /** 请求时菊花控件 */
  UIActivityIndicatorView *indicator;
  /** 刷新按钮 */
  UIButton *refreshButton;
}
@end
