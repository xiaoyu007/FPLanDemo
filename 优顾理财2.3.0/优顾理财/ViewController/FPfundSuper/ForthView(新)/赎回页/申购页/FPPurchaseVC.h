//
//  FPPurchaseViewController.h
//  优顾理财
//
//  Created by Mac on 15/7/17.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPBaseViewController.h"
#import "FPBuuyViewController.h"

@interface FPPurchaseVC : FPBaseViewController
{
  /** 主界面 */
  FPBuuyViewController *buyVC;
}
/** 银行列表 */
@property(nonatomic, strong)NSMutableArray *bankArray;
/** 费率数组 */
@property(nonatomic, strong)NSMutableArray *mutFeeList;
/** 基金名称 */
@property(nonatomic, strong)NSString *fundName;
/** 最小输入金额 */
@property(nonatomic, strong)NSString *minMoney;
/** 传过来的众禄费率 */
@property(nonatomic, strong)NSString *fundFeeRate;
/** 基金代码 */
@property(nonatomic, strong)NSString *fundId;
@end
