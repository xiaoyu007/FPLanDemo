//
//  The_NEWS_IsNot_Read.m
//  优顾理财
//
//  Created by Mac on 14-6-19.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#define kUserTableName @"SUser_NEWS_IsNot_Read_list"
#define kDefaultDBName @"The_NEWS_IsNot_Read.sqlite"

static The_NEWS_IsNot_Read *_the_NEWS_IsNot_Read = nil;

@implementation The_NEWS_IsNot_Read

+ (The_NEWS_IsNot_Read *)sharedManager {
  // 沙盒Docu目录
  if ([[NSFileManager defaultManager]
          fileExistsAtPath:pathInCacheDirectory([NSString
                               stringWithFormat:@"/Collection.xmly/%@",
                                                kDefaultDBName])] == NO) {
    _the_NEWS_IsNot_Read = nil;
  }
  @synchronized([The_NEWS_IsNot_Read class]) {
    if (!_the_NEWS_IsNot_Read)
      _the_NEWS_IsNot_Read = [[self alloc] init];
    return _the_NEWS_IsNot_Read;
  }

  return nil;
}

+ (id)alloc {

  @synchronized([The_NEWS_IsNot_Read class]) {
    NSAssert(_the_NEWS_IsNot_Read == nil,
             @"Attempted to allocated a second instance_SQLDataHtmlstring");
    _the_NEWS_IsNot_Read = [super alloc];
    return _the_NEWS_IsNot_Read;
  }
  return nil;
}

- (id)init {
  self = [super init];
  if (self) {
    //    // 沙盒Docu目录
    _name = pathInCacheDirectory(
        [NSString stringWithFormat:@"/Collection.xmly/%@", kDefaultDBName]);

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
  _the_NEWS_IsNot_Read = nil;
}

/**
 * @brief 创建数据库
 */
- (void)createDataBase {
  FMResultSet *set =
      [_db executeQuery:[NSString stringWithFormat:@"select count(*) from "
                                                   @"sqlite_master where type "
                                                   @"='table' and name = '%@'",
                                                   kUserTableName]];

  [set next];

  NSInteger count = [set intForColumnIndex:0];

  BOOL existTable = !!count;

  if (existTable) {
    // TODO:是否更新数据库
    //        [AppDelegate showStatusWithText:@"数据库已经存在" duration:2];
  } else {
    // TODO: 插入新的数据库
    [_db executeUpdate:@"CREATE TABLE SUser_NEWS_IsNot_Read_list (uid INTEGER "
         @"PRIMARY KEY AUTOINCREMENT  NOT NULL, name "
         @"VARCHAR(50),channlid VARCHAR(20), description " @"VARCHAR(200))"];
  }
}
/**
 * @brief 查看是否存在某条信息
 *
 * @param user 看看用户是否已经收藏的了改条信息
 */
- (BOOL)View_user_exists:(NSString *)name {
  //定义一个可变数组，用来存放查询的结果，返回给调用者
  //定义一个结果集，存放查询的数据
  FMResultSet *rs =
      [_db executeQuery:[NSString stringWithFormat:@"select * from "
                                                   @"SUser_NEWS_IsNot_Read_"
                                                   @"list WHERE name = '%@'",
                                                   name]];

  BOOL returnBool = [rs next];

  [rs close];

  //判断结果集中是否有数据，如果有则取出数据
  return returnBool;
}
/**
 * @brief 保存一条用户记录
 *
 * @param user 需要保存的用户数据
 */
- (void)saveUser:(NSString *)name
     andchannlid:(NSString *)channlid
  andDescription:(NSString *)description {
  if (name && channlid && description) {
    NSMutableString *query = [NSMutableString
        stringWithFormat:@"INSERT INTO SUser_NEWS_IsNot_Read_list"];
    NSMutableString *keys = [NSMutableString stringWithFormat:@" ("];
    NSMutableString *values = [NSMutableString stringWithFormat:@" ( "];
    NSMutableArray *arguments = [NSMutableArray arrayWithCapacity:5];
    if (name) {
      [keys appendString:@"name,"];
      [values appendString:@"?,"];
      [arguments addObject:name];
    }
    if (channlid) {
      [keys appendString:@"channlid,"];
      [values appendString:@"?,"];
      [arguments addObject:channlid];
    }
    if (description) {
      [keys appendString:@"description,"];
      [values appendString:@"?,"];
      [arguments addObject:description];
    }
    [keys appendString:@")"];
    [values appendString:@")"];
    [query appendFormat:@" %@ VALUES%@",
                        [keys stringByReplacingOccurrencesOfString:@",)"
                                                        withString:@")"],
                        [values stringByReplacingOccurrencesOfString:@",)"
                                                          withString:@")"]];

    [_db executeUpdate:query withArgumentsInArray:arguments];
  }
}

/**
 * @brief 删除一条用户数据
 *
 * @param uid 需要删除的用户的id
 */
- (void)deleteUserWithId:(NSString *)uid {
  NSString *query = [NSString
      stringWithFormat:
          @"DELETE FROM SUser_NEWS_IsNot_Read_list WHERE name = '%@'", uid];

  [_db executeUpdate:query];
}
- (void)deleteUser_ALL_WithId {
  NSString *query =
      [NSString stringWithFormat:@"DELETE FROM SUser_NEWS_IsNot_Read_list"];

  [_db executeUpdate:query];
}

//删除所有数据
- (void)deleteUserWith_ALL:(NSArray *)uids {
  NSString *query =
      [NSString stringWithFormat:
                    @"DELETE FROM SUser_NEWS_IsNot_Read_list WHERE uid in ("];
  for (int i = 0; i < [uids count]; i++) {
    query = [NSString stringWithFormat:@"%@'%@'", query, uids[i]];
    if (i < [uids count] - 1) {
      query = [NSString stringWithFormat:@"%@,", query];
    } else {
    }
  }
  query = [NSString stringWithFormat:@"%@);", query];
  [_db executeUpdate:query];
}

@end
