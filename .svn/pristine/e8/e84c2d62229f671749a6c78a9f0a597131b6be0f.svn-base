//
//  DataArray.h
//  SimuStock
//
//  Created by Mac on 14-10-27.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 数据列表排序类型 */
typedef NS_ENUM(NSUInteger, DataListOrder) {
  ///自然序
  DataListOrderNormal = 0,
  ///升序
  DataListOrderAsc = 1,
  ///降序
  DataListOrderDesc = -1,
};

@interface DataArray : NSObject

/** 是否已经数据绑定，用于区分：
 1. 因无网络导致的空数据
 2. 因无数据导致的空数据
 */
@property(nonatomic, assign) BOOL dataBinded;

/** 区分列表分页加载是否全部完成*/
@property(nonatomic, assign) BOOL dataComplete;

///当前数据列表的排序
@property(nonatomic, assign) DataListOrder dataOrder;

///当前数据列表的起始位置
@property(nonatomic, assign) int startIndex;

@property(nonatomic, strong) NSMutableArray *array;

- (void)reset;

@end
