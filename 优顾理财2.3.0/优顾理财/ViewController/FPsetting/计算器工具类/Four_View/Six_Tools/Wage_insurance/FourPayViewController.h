//
//  FourPayViewController.h
//  优顾理财
//
//  Created by Mac on 14/10/20.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "ToolBaseViewController.h"
#import "Textfield+btn.h"
#import "ExpressTextField.h"
#import "My_PickerView.h"
#import "NALMatrixTableView.h"
@interface FourPayViewController
    : ToolBaseViewController <My_PickerView_Delegate, UITextFieldDelegate> {
  ///    城市 选择器
  My_PickerView *defaultPickerView;
  ///    税前，与 税后的选择
  My_PickerView *tax_pickerView;

  ///   城市集合
  NSMutableArray *YG_Citys;
  ///   税前，和税后，数组
  NSArray *YG_Tax;

  ///   城市 选择器  按钮
  Textfield_btn *city_textfield_btn;
  ///   税前，与 税后的选择  按钮
  Textfield_btn *Pre_tax_btn;

  ///   个税，和  计算后工资  列表
  NALMatrixTableView *result_tableView;
  ///   社保 和  公积金 的各项比例、计算结果  列表
  NALMatrixTableView *Detail_tableView;

  ///    工资输入框
  ExpressTextField *tax_money_field;

  ///    社保输入框
  ExpressTextField *tax_Social_field;
  ///    公积金输入框
  ExpressTextField *tax_Social_field_Fund;

  ///    社保基数，是否被填写
  BOOL Socail_base_Whether;
  ///    启征税_基数点
  int Since_tax_point;
}

/// 记录，税前，税后状态,
@property(nonatomic, strong) NSString *title_label;
/// 各城市社保和公积金  各项比例及上下线区间，的对象，集合
@property(nonatomic, strong) NSMutableArray *Socail_array;
//  工资，征税， 区间
@property(nonatomic, strong) NSMutableArray *Pay_array;

/**比例区间*/
@property(nonatomic, strong) NSMutableArray *Pay_Rate_array;
/**个税补差*/
@property(nonatomic, strong) NSMutableArray *Pay_Tax_makeup;
@end
