//
//  MyOptionalShareManager.h
//  优顾理财
//
//  Created by Mac on 15-5-11.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FPMyOptionalItem.h"
#import "FPFundItem.h"

@interface FPMyOptionalShareManager : NSObject {
  /** 缓存我的自选列表 */
  NSMutableArray *myOptionalCacheArray;
  /** 数据加载成功 */
  BOOL dataLoadSuccess;
}
+ (FPMyOptionalShareManager *)shareManager;

/** 查找基金是否缓存 */
- (BOOL)judgeDataRepeat:(NSString *)localFundid;
/** 加载缓存数据 */
- (void)loadMyOptionalData;
/** 缓存参数不完整自选信息 */
- (void)saveMyOptionalListWith:(FPFundItem *)item;
/** 删除一条基金自选 */
- (void)deleteMyOptionalListWithID:(NSString *)tempFundId;

@end
