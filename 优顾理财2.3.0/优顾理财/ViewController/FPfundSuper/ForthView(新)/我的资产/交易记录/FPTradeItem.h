//
//  TradeItem.h
//  优顾理财
//
//  Created by jhss on 15-4-16.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRequestObject.h"
#import "JsonFormatRequester.h"
/** 交易记录模型 */
@interface FPTradeItem : NSObject
///基金名称
@property(nonatomic, strong) NSString *fundname;
///操作
@property(nonatomic, strong) NSString *action;
///金额
@property(nonatomic, strong) NSString *money;
///时间
@property(nonatomic, strong) NSString *time;
//交易结果描述
@property(nonatomic, strong) NSString *traderemark;
/** 交易状态 */
@property(nonatomic, strong) NSString *status;
@end

/**
 *  交易记录列表
 */
@interface FPTradeList : JsonRequestObject <Collectionable>

@property(nonatomic, strong) NSMutableArray *tradeLists;
/**
 *  获取交易记录
 *
 *  @param pageIndex 起始位置
 *  @param pageSize  每页大小
 */
+ (void)sendRequestWithTradeWithPageIndex:(NSInteger)pageIndex
                             withPageSize:(NSInteger)pageSize
                             withCallback:(HttpRequestCallBack *)callback;
+ (void)sendRequestWithTradeWithDic:(NSDictionary *)dic
                       withCallback:(HttpRequestCallBack *)callback;
@end
