//
//  SQL_Data_Old_Collection.h
//  优顾理财
//
//  Created by Mac on 14-8-22.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
@interface SQL_Data_Old_Collection : NSObject {
  FMDatabase *_db;

  NSString *_name;
}
+ (SQL_Data_Old_Collection *)sharedManager;
+ (id)alloc;
- (id)init;

/**
 * @brief 创建数据库
 */
- (void)createDataBase;
/**
 * @brief 删除一条用户数据
 *
 * @param uid 需要删除的用户的id
 */
- (void)deleteUser_ALL_WithId;

/**
 * @brief 模拟分页查找数据。取uid大于某个值以后的limit个数据
 *
 * @param uid
 * @param limit 每页取多少个
 */
- (void)deleteUserWithId:(NSString *)uid andChannlid:(NSString *)channlid;

- (NSArray *)findWithUid_All;

@end
