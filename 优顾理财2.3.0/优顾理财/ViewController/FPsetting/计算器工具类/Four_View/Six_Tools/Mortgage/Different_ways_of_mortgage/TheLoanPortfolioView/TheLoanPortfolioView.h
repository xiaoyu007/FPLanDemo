//
//  TheLoanPortfolioView.h
//  优顾理财
//
//  Created by Mac on 14/10/22.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "HouseLoanScrollView.h"
#import "My_PickerView.h"
#import "YL_SelectionButton.h"
@interface TheLoanPortfolioView
    : HouseLoanScrollView <My_PickerView_Delegate, UITextFieldDelegate,
                             YL_SelectionButton_delegate>

/// 最新基准利率（五年以下）
@property(nonatomic, assign) double Benchmark_rate_5Below;

/// 最新基准利率（五年以上）
@property(nonatomic, assign) double Benchmark_rate_5Above;

/// 最新公积金利率（五年以下）
@property(nonatomic, assign) double Fund_rate_5Below;

/// 最新公积金利率（五年以上）
@property(nonatomic, assign) double Fund_rate_5Above;

@end
