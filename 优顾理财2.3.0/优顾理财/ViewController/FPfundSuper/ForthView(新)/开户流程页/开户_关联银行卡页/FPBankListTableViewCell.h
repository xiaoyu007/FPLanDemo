//
//  BankListTableViewCell.h
//  优顾理财
//
//  Created by jhss on 15-4-22.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//
/**
 
 本类为设计银行卡名称及logo的位置
 */
#import <UIKit/UIKit.h>
@class FPBankItem;
@interface FPBankListTableViewCell : UITableViewCell

///银行logo
@property(nonatomic, strong) UIImageView *bankImageView;
///银行名称
@property(nonatomic, strong) UILabel *bankNameLabel;

@end
