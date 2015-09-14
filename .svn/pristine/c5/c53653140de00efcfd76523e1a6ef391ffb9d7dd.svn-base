//
//  FourFiscalViewController.h
//  优顾理财
//
//  Created by Mac on 14/10/20.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "ToolBaseViewController.h"
#import "NALMatrixTableView.h"
#import "ExpressTextField.h"

@interface FourFiscalViewController
    : ToolBaseViewController <UITextFieldDelegate> {
  ///   投资金额   输入框
  ExpressTextField *Investment_Money;
  ///   年化收益率  输入框
  ExpressTextField *Rate_year_Input;
  ///   投资期限  输入框
  ExpressTextField *Investment_period_Input;

  ///  计算理财收益
  NALMatrixTableView *Detail_tableView;
  ///  对比 活期利息
  NALMatrixTableView *Contrast_tableView;

  ///  基准活期利率
  float Datum_Current_Rate;
}
@end
