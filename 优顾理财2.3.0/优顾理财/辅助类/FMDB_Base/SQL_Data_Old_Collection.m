//
//  SQL_Data_Old_Collection.m
//  优顾理财
//
//  Created by Mac on 14-8-22.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "SQL_Data_Old_Collection.h"
#define kUserTableName @"SUser"
#define kDefaultDBName @"Collection_zan.sqlite"
static SQL_Data_Old_Collection *_SQL_Data_Old_Collection = nil;

@implementation SQL_Data_Old_Collection

+ (SQL_Data_Old_Collection *)sharedManager {
  // 沙盒Docu目录
  if ([[NSFileManager defaultManager] fileExistsAtPath:pathInCacheDirectory([NSString stringWithFormat:@"/Collection.xmly/%@", kDefaultDBName])] ==
      NO) {
    _SQL_Data_Old_Collection = nil;
  }
  @synchronized([SQL_Data_Old_Collection class]) {
    if (!_SQL_Data_Old_Collection)
      _SQL_Data_Old_Collection = [[self alloc] init];
    return _SQL_Data_Old_Collection;
  }

  return nil;
}

+ (id)alloc {

  @synchronized([SQL_Data_Old_Collection class]) {
    NSAssert(_SQL_Data_Old_Collection == nil,
             @"Attempted to allocated a second instance_SQLDataHtmlstring");
    _SQL_Data_Old_Collection = [super alloc];
    return _SQL_Data_Old_Collection;
  }
  return nil;
}

- (id)init {
  self = [super init];
  if (self) {
    //    // 沙盒Docu目录
    _name = pathInCacheDirectory([NSString stringWithFormat:@"/Collection.xmly/%@", kDefaultDBName]);

    [[NSFileManager defaultManager] fileExistsAtPath:_name];

    [self connect];
    [self createDataBase];
  }
  return self;
}

/// 连接数据库
- (void)connect {
  if (!_db) {
    _db = [[FMDatabase alloc] initWithPath:_name];
  }
  if (![_db open]) {
    // nslog(@"不能打开数据库 ++%@",_name);
  }
}
/// 关闭连接
- (void)close {
  [_db close];
  _SQL_Data_Old_Collection = nil;
}
/**
 * @brief 创建数据库
 */
- (void)createDataBase {
  FMResultSet *set = [_db
      executeQuery:[NSString stringWithFormat:@"select count(*) from " @"sqlite_master where type " @"='table' and name = '%@'", kUserTableName]];

  [set next];

  if ([set intForColumnIndex:0]) {
    // TODO:是否更新数据库
    //        [AppDelegate showStatusWithText:@"数据库已经存在" duration:2];
  } else {
    // TODO: 插入新的数据库
    [_db executeUpdate:@"CREATE TABLE SUser (uid INTEGER PRIMARY KEY "
         @"AUTOINCREMENT  NOT NULL, name VARCHAR(50),channlid "
         @"VARCHAR(20), description VARCHAR(200),add_cancle "
         @"VARCHAR(20),Fid VARCHAR(20),Sync_is VARCHAR(20))"];
  }
}

/**
 * @brief 模拟分页查找数据。取uid大于某个值以后的limit个数据
 *
 * @param uid
 * @param limit 每页取多少个
 * @获取数据库中所有数据
 */
- (NSArray *)findWithUid_All {
  NSString *query = @"SELECT * FROM SUser";
  query = [query stringByAppendingFormat:@" ORDER BY uid DESC "];

  FMResultSet *rs = [_db executeQuery:query];
  NSMutableArray *array = [NSMutableArray arrayWithCapacity:[rs columnCount]];
  while ([rs next]) {
    NSMutableArray *user = [[NSMutableArray alloc] initWithCapacity:0];
    NSString *uid = [rs stringForColumn:@"uid"];
    [user addObject:uid];
    NSString *name = [rs stringForColumn:@"name"];
    [user addObject:name];
    NSString *channlid = [rs stringForColumn:@"channlid"];
    [user addObject:channlid];
    NSString *description = [rs stringForColumn:@"description"];
    [user addObject:description];
    [array addObject:user];
  }
  [rs close];
  return array;
}

/**
 * @brief 删除一条用户数据
 *
 * @param uid 需要删除的用户的id
 */
- (void)deleteUserWithId:(NSString *)uid andChannlid:(NSString *)channlid {
  NSString *query =
      [NSString stringWithFormat:@"DELETE FROM SUser WHERE name = '%@' and channlid = '%@'", uid, channlid];

  [_db executeUpdate:query];
}

- (void)deleteUser_ALL_WithId {
  NSString *query = [NSString stringWithFormat:@"DELETE FROM SUser"];

  [_db executeUpdate:query];
}
@end
