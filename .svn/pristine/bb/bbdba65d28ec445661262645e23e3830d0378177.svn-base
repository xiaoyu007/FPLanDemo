//
//  DicToArray.h
//  优顾理财
//
//  Created by Mac on 14-3-5.
//  Copyright (c) 2014年 Youguu. All rights reserved.
// 提供所有json数据的解析

#import <Foundation/Foundation.h>
#import "CustomPageDada.h"
#import "FPMyFundItem.h"
#import "FPCheckAndCancelItem.h"
#import "FPTradeItem.h"
#import "FPBuyItem.h"
#import "FPRedemItem.h"
#import "FPConnectBankItem.h"
#import "FPBankItem.h"
#import "FPGoToBuyItem.h"
#import "FPGoToBuyDetailItem.h"
#import"FPRetrieveItem.h"
#import"FPCountCenterItem.h"
#import"FPCountCenterDeatilItem.h"
#import"FPJumpRedeemItem.h"
#import"FPCancellationInfoItem.h"
typedef NS_ENUM(NSUInteger, CustomFundType) {
  /** 低收益 */
  CustomFundTypeLowPro,
  /** 中收益 */
  CustomFundTypeMiddlePro,
  /** 高收益 */
  CustomFundTypeHighPro,
};

@interface DicToArray : NSObject

///******************************************************************************
// 函数名称 :+(NSMutableArray *)USER_Fa_dic_to_array:(NSDictionary * )dic;
// 函数描述 : 用户发言—— 数据解析
// 输入参数 : (NSDictionary *)dic    文本
// 输出参数 : N/A
// 返回参数 : (NSMutableArray *)    解析以后的数组
// 备注信息 :
// ******************************************************************************/
#pragma mark -  用户发言—— 数据解析
//发言解析
+(NSMutableArray *)USER_Fa_dic_to_array:(NSDictionary * )dic;

///******************************************************************************
// 函数名称 :+(NSMutableArray *)USER_Comment_dic_to_array:(NSDictionary * )dic;
// 函数描述 : 评论列表—— 数据解析
// 输入参数 : (NSDictionary *)dic    文本
// 输出参数 : N/A
// 返回参数 : (NSMutableArray *)    解析以后的数组
// 备注信息 :
// ******************************************************************************/
#pragma mark -评论列表—— 数据解析
//评论列表解析
+(NSMutableArray *)USER_Comment_dic_to_array:(NSDictionary * )dic;
///******************************************************************************
// 函数名称 :- (MyFundItem *)parseMyFundDetailWithList:(NSDictionary *)dict;
// 基金列表 - 数据解析
// 输入参数 : (NSDictionary *)dic    文本
// 输出参数 : N/A
// 返回参数 : (MyFundItem *)item
// 备注信息 :
// ******************************************************************************/
+ (FPMyFundItem *)parseMyFundDetailWithList:(NSDictionary *)dict;

///******************************************************************************
// 函数名称 :+(CheckAndCancelItem *)parseCheckAndCancelWithLists:(NSDictionary *)dict;
// 基金列表 - 数据解析
// 输入参数 : (NSDictionary *)dic    文本
// 输出参数 : N/A
// 返回参数 : (CheckAndCancelItem *)item
// 备注信息 :委托撤单
// ******************************************************************************/
+(NSMutableArray *)parseCheckAndCancelWithLists:(NSDictionary *)dict;

/** 跳转撤单页*/
+(FPCancellationInfoItem *)parseCheckJumpCancelWithLists:(NSDictionary *)dict;

///******************************************************************************
// 函数名称 :+(CheckAndCancelItem *)parseAffirmAndCancelWithLists:(NSDictionary *)dict;
// 基金列表 - 数据解析
// 输入参数 : (NSDictionary *)dic    文本
// 输出参数 : N/A
// 返回参数 : (CheckAndCancelItem *)item
// 备注信息 :
// ******************************************************************************/
+(FPCheckAndCancelItem *)parseAffirmAndCancelWithLists:(NSDictionary *)dict;
/** 基金搜索列表 */
+ (void)parseFundlists:(NSDictionary *)dict;
///******************************************************************************
// 函数名称 :+(TradeItem *)parseTradeWithLists:(NSDictionary *)dict;
// 基金列表 - 数据解析
// 输入参数 : (NSDictionary *)dic    文本
// 输出参数 : N/A
// 返回参数 : (TradeItem *)item
// 备注信息 :
// ******************************************************************************/
+(NSMutableArray *)parseTradeWithLists:(NSDictionary *)dict;
///******************************************************************************
// 函数名称 :+(BuyItem *)parseBuyWithLists:(NSDictionary *)dict;
// 基金列表 - 数据解析
// 输入参数 : (NSDictionary *)dic    文本
// 输出参数 : N/A
// 返回参数 : (TradeItem *)item
// 备注信息 :
// ******************************************************************************/
+(FPBuyItem *)parseBuyWithLists:(NSDictionary *)dict;
///******************************************************************************
// 函数名称 :+(RedemItem *)parseRedemWithLists:(NSDictionary *)dict;
// 基金列表 - 数据解析
// 输入参数 : (NSDictionary *)dic    文本
// 输出参数 : N/A
// 返回参数 : (TradeItem *)item
// 备注信息 :
// ******************************************************************************/
+(FPRedemItem *)parseRedemWithLists:(NSDictionary *)dict;
///******************************************************************************
// 函数名称 :+(ConnectBankItem *)parseConnectBankLists:(NSDictionary *)dict
// 基金列表 - 数据解析
// 输入参数 : (NSDictionary *)dic    文本
// 输出参数 : N/A
// 返回参数 : (TradeItem *)item
// 备注信息 :
// ******************************************************************************/
+(FPConnectBankItem *)parseConnectBankLists:(NSDictionary *)dict;

/** 我的自选解析 */
+ (NSMutableArray *)parseOptionalListWithDict:(NSDictionary *)dict;

/*** 添加银行列表*/
+(NSMutableArray  *)parseBankWithLists:(NSDictionary *)dict;

/** 跳转申购解析 */
+ (FPGoToBuyItem *)parseGoToBuyWithList:(NSDictionary *)dict;
/** 跳转赎回解析 */
+ (FPJumpRedeemItem *)parseGoToRedeemWithList:(NSDictionary *)dict;
/**  找回交易密码 */
+(FPRetrieveItem *)parseRetrieveList:(NSDictionary *)dict;
/**  账户中心 */
+(FPCountCenterItem *)pareseCountCenterList:(NSDictionary *)dict;
@end
