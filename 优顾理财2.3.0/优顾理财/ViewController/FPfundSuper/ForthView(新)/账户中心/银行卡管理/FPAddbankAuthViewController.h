//
//  AddbankAuthViewController.h
//  优顾理财
//
//  Created by jhss on 15-4-26.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "YGBaseViewController.h"

@interface FPAddbankAuthViewController : YGBaseViewController<UITextFieldDelegate>

///绑卡流水号
@property(nonatomic, strong) NSString *serianoStr;
///用户银行卡ID
@property(nonatomic, strong) NSString *userBankidStr;

@end
