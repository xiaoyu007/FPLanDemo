//
//  DelegationViewController.h
//  优顾理财
//
//  Created by jhss on 15-4-3.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "YGBaseViewController.h"
#import "FPBuyItem.h"

@interface FPDelegationViewController : UIViewController

///金额
@property (weak, nonatomic) IBOutlet UILabel *moneyNumber;
///产品名称
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
///银行卡名称及尾号
@property (weak, nonatomic) IBOutlet UILabel *cardNameLabel;
///时间
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
///下面返回按钮
@property (weak, nonatomic) IBOutlet UIButton *backNameBtn;
///基金份额确认日期
@property (weak, nonatomic) IBOutlet UILabel *downTimeLabel;

@end
