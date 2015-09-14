//
//  SearchFundViewController.h
//  优顾理财
//
//  Created by Mac on 15-4-16.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 搜索基金 */
@interface FPSearchFundViewController
    : UIViewController <UITableViewDataSource, UITableViewDelegate,
                        UITextFieldDelegate> {
  /** 基金列表 */
  NSMutableArray *fundListArray;
  /** 历史基金列表 */
  NSMutableArray *historyListArray;
  /** 历史基金列表 */
  NSMutableArray *historyDicArray;
  /** 当前输入 */
  NSString *currentString;
  /** 未搜索到，提示文本 */
  UILabel *notFoundLabel;
}
/** 搜索栏背景 */
@property(weak, nonatomic) IBOutlet UIView *searchBarBackView;
/** 输入框 */
@property(weak, nonatomic) IBOutlet UITextField *searchFundTextField;
/** 取消按钮 */
@property(weak, nonatomic) IBOutlet UIButton *cancelButton;
/** 基金表格 */
@property(weak, nonatomic) IBOutlet UITableView *searchFundTableView;

@end
