//
//  CommercialLoansView.h
//  优顾理财
//
//  Created by Mac on 14/10/22.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "HouseLoanScrollView.h"

#import "Textfield+btn.h"
#import "NALMatrixTableView.h"
#import "ExpressTextField.h"
#import "SettingButton.h"
#import "My_PickerView.h"
#import "YL_SelectionButton.h"
@interface CommercialLoansView
    : HouseLoanScrollView <My_PickerView_Delegate, UITextFieldDelegate,
                             YL_SelectionButton_delegate> {
  /// 结果表格
  NALMatrixTableView *Detail_tableView;

  /// 贷款总金额
  ExpressTextField *Push_money_textfield;

  ///  贷款期限  选择器
  My_PickerView *Time_PickerView;
  ///  年利率  选择器
  My_PickerView *Rate_PickerView;

  NSArray *YG_Time;
  NSArray *YG_Rate;

  ///   贷款期限  按钮
  Textfield_btn *Time_textfield_btn;
  ///   贷款期限 的num
  int Time_num;
  ///  年利率倍数
  int Year_Rate_num;
  ///   年利率   按钮
  Textfield_btn *Rate_textfield_btn;

  /// 等额本息
  SettingButton *btn2;
  ///  等额本金
  SettingButton *btn3;

  /// 选择还款方式，1，等额本息  2 等额本金
  int Repayment;
}

@end
