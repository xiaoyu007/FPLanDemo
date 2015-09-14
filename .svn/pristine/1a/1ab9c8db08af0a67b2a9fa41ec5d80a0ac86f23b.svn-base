//
//  FourDepositViewController.h
//  优顾理财
//
//  Created by Mac on 14/10/20.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "ToolBaseViewController.h"

#import "Textfield+btn.h"
#import "NALMatrixTableView.h"
#import "ExpressTextField.h"
#import "My_PickerView.h"

@interface FourDepositViewController
    : ToolBaseViewController <My_PickerView_Delegate, UITextFieldDelegate> {
  ///   本息
  ExpressTextField *Capital_money_textfield;

  ///   存款类型  选择器
  My_PickerView *Type_PickerView;
  ///   活期存款单位  选择器（月，天）
  My_PickerView *Days_PickerView;
  ///   银行简称  选择器
  My_PickerView *Bank_PickerView;

  ///   存款类型  数据
  NSArray *YG_type;
  ///   活期存款单位  数据
  NSArray *YG_days;
  ///   银行简称   数据
  NSMutableArray *YG_bank;

  ///   存款类型 按钮
  Textfield_btn *Type_textfield_btn;
  ///   活期存款单位  按钮
  Textfield_btn *Days_textfield_btn;
  ///   银行简称   按钮
  Textfield_btn *Bank_textfield_btn;

  ///   活期存款 天数 ，控制是否隐藏的UI
  UIView *Second_time_View;
  ///   活期天数，输入框
  ExpressTextField *Day_Input_box;

  ///   计算结果，列表
  NALMatrixTableView *Detail_tableView;
  ///   年利率
  ExpressTextField *APR_rate_textfield;
  ///   选择存款类型的 第几个
  int Type_num;

  ///   利息比例
  double Rate_Proportion;

  /// 年利率为零时，提示语
  UILabel *Prompt_label;
}

///  不同银行，不同时间 不同利率 的数据
@property(nonatomic, strong) NSMutableArray *deposit_array;

@end
