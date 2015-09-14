//
//  AddBankCardViewController.h
//  优顾理财
//
//  Created by jhss on 15-4-13.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "YGBaseViewController.h"

@interface FPAddBankCardViewController
    : YGBaseViewController <UITableViewDataSource, UITableViewDelegate>

///点击银行卡，，弹出银行列表
@property(weak, nonatomic) IBOutlet UIButton *bankListBtn;
@property(nonatomic, strong) UILabel *bankName;
///银行卡编号
@property(nonatomic, strong) NSString *bankNumber;
///索引选中的哪一行的银行
@property(nonatomic, assign) NSInteger selectedIndex;

///输入银行卡号
@property(weak, nonatomic) IBOutlet UITextField *bankNumTextField;
///预留手机号码
@property(weak, nonatomic) IBOutlet UITextField *iphoneNumTextField;
///按钮下的textField
@property(weak, nonatomic) IBOutlet UITextField *btnTextField;

///开户流水号---开户验证所需流水
@property(nonatomic, strong) NSString *serialno;
///用户银行卡ID---开户验证所需流水
@property(nonatomic, strong) NSString *userbankid;

///返回上一界面
- (IBAction)navBtn:(id)sender;
///提交按钮
- (IBAction)presentBtn:(id)sender;

@end
