//
//  YGForthViewController.h
//  优顾理财
//
//  Created by Mac on 15/3/15.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "YGBaseViewController.h"
#import "FinacingShopHeadView.h"
#import "TipViewController.h"
#import "Youguu_Loading_View.h"
#import "SRRefreshView.h"
#import "CycleScrollView.h"
#import "PullingRefreshTableView.h"

typedef NS_ENUM(NSUInteger, FundType) {
  /** 未评测 */
  FundTypeNoneEvaluate,
  /** 默认低收益 */
  FundTypeLow = 1,
  /** 默认中等收益 */
  FundTypeMiddle,
  /** 默认高收益 */
  FundTypeHigh,
  /** 不足100元低收益组合 */
  FundTypeLessThanHundred = 10,
  /** 青年低收益 */
  FundTypeYouthLow,
  /** 青年中等收益 */
  FundTypeYouthMiddle,
  /** 青年高收益 */
  FundTypeYouthHigh,
  /** 中年低收益 */
  FundTypeMiddleAgeLow,
  /** 中年中等收益 */
  FundTypeMiddleAgeMiddle,
  /** 中年高收益 */
  FundTypeMiddleAgeHigh,
  /** 老年低收益 */
  FundTypeOldAgeLow,
  /** 老年中等收益 */
  FundTypeOldAgeMiddle,
  /** 老年高收益 */
  FundTypeOldAgeHigh,
};
/** 理财超市首页 */
@interface FundShopViewController
    : YGBaseViewController <youguu_loading_View_delegate,
                            UIScrollViewDelegate,
                            PullingRefreshTableViewDelegate> {
  /** 承载滚动视图 */
  CycleScrollView *finacingScr;
  /** 低收益表格 */
  PullingRefreshTableView *finacingLowTBview;
  /** 中等收益表格 */
  PullingRefreshTableView *finacingMiddleTBview;
  /** 高收益表格 */
  PullingRefreshTableView *finacingHighTBview;
  /** 是否加载成功 */
  BOOL isLoadSuccess;
  /** 搜索栏 */
  UITextField *searchTextfield;
  /** 低收益产品列表 */
  NSMutableArray *lowFundShopArray;
  /** 中收益产品列表 */
  NSMutableArray *midFundShopArray;
  /** 高收益产品列表 */
  NSMutableArray *highFundShopArray;
  /** 当前收益类型 */
  NSUInteger currentProfitType;
  /** 表格表头title高度 */
  float titleHeight;
  /** 表头文本 */
  NSString *sectionTitle;
  /** 表头label */
  UILabel *tbTitleLabel;
  /** 是否是评测列表 */
  BOOL isLoadingRiskEvaluatList;
  /** 表格数组 */
  // NSMutableArray *tableviewArrays;
}
@property(nonatomic, strong) UILabel *nameLbel;
/** 顶部视图 */
@property(nonatomic, strong) FinacingShopHeadView *headView;
/** 风险评测 */
- (void)riskEvaluateButtonClicked;

@end
