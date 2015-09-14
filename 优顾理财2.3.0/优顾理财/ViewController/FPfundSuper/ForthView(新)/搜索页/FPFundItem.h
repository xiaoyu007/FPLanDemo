//
//  FundItem.h
//  优顾理财
//
//  Created by Mac on 15-4-16.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRequestObject.h"
#import "JsonFormatRequester.h"
/** 基金搜索模型类 */
@interface FPFundItem :NSObject
/** 基金id */
@property(nonatomic, strong) NSString *fundId;
/** 基金名称 */
@property(nonatomic, strong) NSString *fundName;
/** 基金拼音 */
@property(nonatomic, strong) NSString *pinyin;
/** 投资类型 */
@property(nonatomic, strong) NSString *invstType;
/** 增量修改类型 */
@property(nonatomic, strong) NSString *incType;
/** 增量修改时间 */
@property(nonatomic, strong) NSString *incTime;
/** 判断是否添加到自选 */
@property(nonatomic, strong) NSString *isSelected;

@end
/** 基金列表 */
@interface FPSearchFundList : JsonRequestObject
/** 基金列表 */
@property(nonatomic, strong) NSMutableArray *fundLists;
/** 加载码表 */
+ (void)getFundTableWithLastModtime:(NSString *)lastModtime
                      withCallback:(HttpRequestCallBack *)callback;

@end