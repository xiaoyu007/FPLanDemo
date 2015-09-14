//
//  HouseLoanScrollView.m
//  优顾理财
//
//  Created by Mac on 14/12/2.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "HouseLoanScrollView.h"
#import "Tools_data_object.h"

@implementation HouseLoanScrollView

- (void)layoutSubviews {
  self.YG_Year_Rate = [[NSMutableArray alloc] initWithCapacity:0];
  if (YouGu_fileExistsAtPath(
          pathInCacheDirectory(@"Car_year_rateyear.plist"))) {
    NSDictionary *dic = [NSDictionary
        dictionaryWithContentsOfFile:pathInCacheDirectory(
                                         @"Car_year_rateyear.plist")];

    [self Car_year_rateyear:dic];
  } else {
    NSString *path_3 =
        [[NSBundle mainBundle] pathForResource:@"Car_year_rateyear.plist"
                                        ofType:nil];

    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path_3];

    [self Car_year_rateyear:dic];
  }
}

/// 数据解析  获得新的 贷款年利率
- (void)Car_year_rateyear:(NSDictionary *)dic {
  NSMutableArray *array =
      [Tools_Car_Loan_object Car_Loan_Rate_reData_analysis:dic];

  [self.YG_Year_Rate removeAllObjects];
  [self.YG_Year_Rate addObjectsFromArray:array];

  /// 获取 五年以下的基准利率
  [self Setting_interest_rates:0 andBankName:@"基准利率"];
  /// 获取  五年以上的基准利率
  [self Setting_interest_rates:1 andBankName:@"基准利率"];

  ///  获取  五年以下 公积金利率
  [self Setting_interest_rates:2 andBankName:@"公积金"];
  ///  获取  五年以上  公积金利率
  [self Setting_interest_rates:3 andBankName:@"公积金"];
}

///确认，贷款年利率
- (void)Setting_interest_rates:(int)num andBankName:(NSString *)bankName {
  switch (num) {
  case 0: {
    Tools_Car_Loan_object *Car_object = [self Get_Car_Loan:bankName];

    self.Benchmark_rate_5Below = [Car_object.five_year_Rate doubleValue];
  } break;
  case 1: {
    Tools_Car_Loan_object *Car_object = [self Get_Car_Loan:bankName];

    self.Benchmark_rate_5Above = [Car_object.five_Above_Rate doubleValue];
  } break;
  case 2: {
    Tools_Car_Loan_object *Car_object = [self Get_Car_Loan:bankName];

    self.Fund_rate_5Below = [Car_object.five_below_Rate doubleValue];
  } break;
  case 3: {
    Tools_Car_Loan_object *Car_object = [self Get_Car_Loan:bankName];

    self.Fund_rate_5Above = [Car_object.five_Above_Rate doubleValue];
  } break;
  default:
    break;
  }
  return;
}

- (Tools_Car_Loan_object *)Get_Car_Loan:(NSString *)bankName {
  for (Tools_Car_Loan_object *car_Object in self.YG_Year_Rate) {
    if ([YouGu_StringWithFormat(bankName)
            isEqualToString:car_Object.bankName]) {
      return car_Object;
    }
  }
  return nil;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
