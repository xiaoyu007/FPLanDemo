//
//  FourForeignViewController.h
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

@interface FourForeignViewController
    : ToolBaseViewController <My_PickerView_Delegate, UITextFieldDelegate> {
  ///   持有货币  的选择器
  My_PickerView *Hold_PickerView;
  ///   兑换货币  的选择器
  My_PickerView *Exchange_pickerView;

  //    ///   持有/兑换货币  数据
  //    NSMutableArray * YG_Currency_array;
  //    ///   两个货币兑换比率
  //    NSMutableArray * YG_exchange_rate;

  ///   持有货币  按钮
  Textfield_btn *Hold_textfield_btn;
  ///   兑换货币  按钮
  Textfield_btn *Exchange_textfield_btn;

  UILabel *sign_label_2;

  ///  持有的货币
  ExpressTextField *textfield_Currency_holdings;

  ///   兑换结果，表格
  NALMatrixTableView *Detail_tableView;
}

///   持有/兑换货币  数据
@property(nonatomic, retain) NSMutableArray *YG_Currency_array;
///   两个货币兑换比率
@property(nonatomic, retain) NSMutableArray *YG_exchange_rate;
@end
