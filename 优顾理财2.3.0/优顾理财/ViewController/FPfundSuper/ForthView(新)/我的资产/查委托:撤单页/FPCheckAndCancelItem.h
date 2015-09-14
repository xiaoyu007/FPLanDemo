//
//  CheckAndCancelItem.h
//  优顾理财
//
//  Created by jhss on 15-4-14.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FPCheckAndCancelItem : NSObject
///类型
@property(nonatomic, strong) NSString *type;
///订单状态
@property(nonatomic, strong) NSString *status;
///基金名称
@property(nonatomic, strong) NSString *fundname;
/** 名称代码高度 */
@property(nonatomic, assign) CGFloat fundNameIdHeight;
///名称代码
@property(nonatomic, strong) NSString *fundid;
///交易账号
@property(nonatomic, strong) NSString *tradeacco;
///众禄交易流水号
@property(nonatomic, strong) NSString *mctserialno;
///撤单状态
@property(nonatomic, strong) NSString *cancancel;
///快取状态
@property(nonatomic, strong) NSString *chkflag;
///时间
@property(nonatomic, strong) NSString *time;
///金额
@property(nonatomic, strong) NSString *money;
/** 名称代码自定义字符串 */
@property(nonatomic, strong)NSMutableAttributedString *attr;
///撤单确认

///交易密码
@property(nonatomic, strong) NSString *tradecode;
///众禄交易流水号
@property(nonatomic, strong) NSString *serialno;
/**************   跳转撤单数据*/

/**   申请金额*/
@property(nonatomic,strong)NSString *subamt;
/**  订单状态*/
@property(nonatomic,strong)NSString *payStatus;
/**   展示名称*/
@property(nonatomic,strong)NSString *bankName;

@property(nonatomic, strong) NSMutableArray *delegateLists;

@end
