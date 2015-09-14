//
//  CheckAndCancelTableViewCell.h
//  优顾理财
//
//  Created by jhss on 15-4-9.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FPCheckAndCancelTableViewCell : UITableViewCell
///类型
@property(weak, nonatomic) IBOutlet UILabel *applyType;
//状态
@property (weak, nonatomic) IBOutlet UILabel *fundStatusLabel;

///名称代码
@property(weak, nonatomic) IBOutlet UILabel *fundNameAndId;
///申请金额
@property(weak, nonatomic) IBOutlet UILabel *applyMoney;
@end
