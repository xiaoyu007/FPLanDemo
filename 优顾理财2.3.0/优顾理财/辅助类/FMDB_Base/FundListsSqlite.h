//
//  FundListImeSQL.h
//  优顾理财
//
//  Created by Mac on 15-4-16.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabase.h"
#import "FPFundItem.h"

typedef NS_ENUM(NSUInteger, FundItemType) {
  /** 股票型 */
  FundItemTypeStock = 1,
  /** 债券型 */
  FundItemTypeBond,
  /** 混合型 */
  FundItemTypeMix,
  /** 货币型 */
  FundItemTypeCurrency,
  /** 理财型 */
  FundItemTypeFinancing,
  /** 其他 */
  FundItemTypeOther,
};
typedef NS_ENUM(NSUInteger, OperatingType) {
  /** 增加 */
  OperatingTypeAdd = 1,
  /** 修改 */
  OperatingTypeChange,
  /** 删除 */
  OperatingTypeDelete,
};
/** 存储基金列表 */
@interface FundListsSqlite : NSObject {
  /** 数据库对象 */
  FMDatabase *_db;
  /** 路径名称 */
  NSString *_name;
}
+ (FundListsSqlite *)sharedManager;
+ (id)alloc;
- (id)init;

/**
 * @brief 创建数据库
 */
- (void)createDataBase;
/** 查询 */
- (NSArray *)queryFundListWithInputStr:(NSString *)inputStr;
/** 列表是否存在某只基金 */
- (BOOL)fundListsExist:(NSString *)name;
/** 保存基金信息 */
- (void)saveFundId:(NSString *)fundId
      withFundName:(NSString *)fundName
        withPinYin:(NSString *)pinyin
     withInvsttype:(FundItemType)fundItemType
       withIncTime:(NSString *)inctime
    withIsSelected:(NSString *)isSelected;
/** 更新基金信息 */
- (void)updateFundId:(NSString *)fundId
        withFundName:(NSString *)fundName
          withPinYin:(NSString *)pinyin
       withInvsttype:(FundItemType)fundItemType
         withIncTime:(NSString *)inctime
      withIsSelected:(NSString *)isSeleced;

/** 删除基金 */
- (void)deleteListWithFundName:(NSString *)fundName;
/** 删除表 */
- (void)deleteFundLists;
/** 删除所有数据 */
- (void)deleteUserWith_ALL:(NSArray *)uids;
/** 批量缓存数据 */
- (void)saveFundLists:(NSMutableArray *)fundLists;
/** 更新一条基金 */
- (void)updateOneList:(FPFundItem *)item;
/**更新一组基金 */
- (void)updateMyOptionalLists:(NSMutableArray *)myOptionalLists;
@end
