//
//  HouseLoanScrollView.h
//  优顾理财
//
//  Created by Mac on 14/12/2.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HouseLoanScrollView : UIScrollView

/// 最新基准利率（五年以下）
@property(nonatomic, assign) double Benchmark_rate_5Below;

/// 最新基准利率（五年以上）
@property(nonatomic, assign) double Benchmark_rate_5Above;

/// 最新公积金利率（五年以下）
@property(nonatomic, assign) double Fund_rate_5Below;

/// 最新公积金利率（五年以上）
@property(nonatomic, assign) double Fund_rate_5Above;

///贷款年利率
@property(nonatomic, retain) NSMutableArray *YG_Year_Rate;

@end
