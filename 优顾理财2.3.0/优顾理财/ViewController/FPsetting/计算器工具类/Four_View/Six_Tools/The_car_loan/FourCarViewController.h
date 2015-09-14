//
//  FourCarViewController.h
//  优顾理财
//
//  Created by Mac on 14/10/20.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "ToolBaseViewController.h"

#import "Textfield+btn.h"
#import "NALMatrixTableView.h"
#import "ExpressTextField.h"
#import "SettingButton.h"
#import "My_PickerView.h"
#import "YL_SelectionButton.h"
@interface FourCarViewController
    : ToolBaseViewController <My_PickerView_Delegate, UITextFieldDelegate,
                           YL_SelectionButton_delegate> {
  ///   计算结果，列表
  NALMatrixTableView *Detail_tableView;
  ///  贷款总金额
  ExpressTextField *Push_money_textfield;

  /// 首付 选择器
  My_PickerView *First_ratio_PickerView;
  /// 贷款期限  选择器
  My_PickerView *The_period_pickerView;
  /// 银行  选择器
  My_PickerView *Bank_PickerView;

  ///  首付  按钮
  Textfield_btn *First_ratio_textfield_btn;
  ///  贷款期限  按钮
  Textfield_btn *The_period_textfield_btn;
  ///  银行选择  按钮
  Textfield_btn *Bank_textfield_btn;

  /// 等额本息
  SettingButton *btn2;
  ///  等额本金
  SettingButton *btn3;

  /// 贷款年利率
  ExpressTextField *interest_rate_textfield;
  /// 贷款期限  所指向的位置
  int The_period_num;

  /// 选择还款方式，1，等额本息  2 等额本金
  int Repayment;

  /// 还款期数（每期一个月）
  int Period_Installments;

  ///  首付比例
  int Down_payment;
}

///车贷首付
@property(nonatomic, strong) NSMutableArray *YG_Downpayment;
///车贷期限
@property(nonatomic, strong) NSMutableArray *YG_Loan_period;
/// 银行
@property(nonatomic, strong) NSMutableArray *YG_bank;

///贷款年利率
@property(nonatomic, strong) NSMutableArray *YG_Year_Rate;
@end
