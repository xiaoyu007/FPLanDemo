//
//  TradeStatusInfo.h
//  优顾理财
//
//  Created by Mac on 15/6/12.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 交易类型 */
typedef NS_ENUM(NSUInteger, TradeStatusType) {
  
  TradeStatusTypeOpenAccount = 1,
  TradeStatusTypeDeleteAccount,
  TradeStatusTypeChangeAccountInfo,
  TradeStatusTypeAccountFrozen,
  TradeStatusTypeUnfrozen,
  /** 认购 */
  TradeStatusTypeSubscribe = 20,
  /** 预约认购 */
  TradeStatusTypeSubscribeAppointment = 21,
  /** 申购 */
  TradeStatusTypePurchase = 22,
  /** 预约申购 */
  TradeStatusTypePurchaseAppointment = 23,
  /** 赎回 */
  TradeStatusTypeRedeem = 24,
  /** 预约赎回 */
  TradeStatusTypePlanRedeem = 25,
  /** 转托管 */
  TradeStatusTypeCustodyTransfer = 26,
  /** 转托管转入 */
  TradeStatusTypeIntoCustody = 27,
  /** 转托管转出 */
  TradeStatusTypeOutCustody = 28,
  /** 设置分红方式 */
  TradeStatusTypeSetDividends = 29,
  /** 认购结果 */
  TradeStatusTypeSubscriptionResults = 30,
  /** 份额冻结 */
  TradeStatusTypeShareFreeze = 31,
  /** 份额解冻 */
  TradeStatusTypeShareThaw = 32,
  /** 非交易过户 */
  TradeStatusTypeNonTransactionTransfer = 33,
  /** 非交易过户转入 */
  TradeStatusTypeNonTransferTransfer = 34,
  /** 非交易过户转出 */
  TradeStatusTypeNonOutTransferTransfer = 35,
  /** 基金转换 */
  TradeStatusTypeFundConversion = 36,
  /** 基金转换转入*/
  TradeStatusTypeInToFundConversion = 37,
  
  
  
  
  
  
};
@interface FPTradeStatusInfo : NSObject
/** 代码对应交易类型 */
+ (NSString *)getTradeTypeFromFundId:(NSString *)type;
/** 代码对应交易状态 */
+ (NSString *)getTradeStatusFromId:(NSString *)status;
@end
