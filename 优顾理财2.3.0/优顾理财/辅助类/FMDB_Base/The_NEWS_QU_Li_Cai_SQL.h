//
//  The_NEWS_QU_Li_Cai_SQL.h
//  优顾理财
//
//  Created by Mac on 14-6-19.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "sqlite3.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabase.h"
@interface The_NEWS_QU_Li_Cai_SQL : NSObject {

  FMDatabase *_db;
  NSString *_name;
}
+ (The_NEWS_QU_Li_Cai_SQL *)sharedManager;
+ (id)alloc;
- (id)init;

/**
 * @brief 创建数据库
 */
- (void)createDataBase;

/**
 * @brief 查看是否存在某条信息
 *
 * @param user 看看用户是否已经收藏的了改条信息
 */
- (BOOL)View_user_exists:(NSString *)name;
/**
 * @brief 保存一条用户记录
 *
 * @param user 需要保存的用户数据
 */
- (void)saveUser:(NSString *)name
     andchannlid:(NSString *)channlid
  andDescription:(NSString *)description;

/**
 * @brief 删除一条用户数据
 *
 * @param uid 需要删除的用户的id
 */
- (void)deleteUserWithId:(NSString *)uid;

//删除所有数据
- (void)deleteUserWith_ALL:(NSArray *)uids;
@end
