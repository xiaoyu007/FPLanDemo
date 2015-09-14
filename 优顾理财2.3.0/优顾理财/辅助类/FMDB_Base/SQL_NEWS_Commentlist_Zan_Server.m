//
//  SQL_NEWS_Commentlist_Zan_Server.m
//  优顾理财
//
//  Created by Mac on 14-5-27.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#define kUserTableName @"PUser_Commentlist"
#define kDefaultDBName @"NEWS_Collection_zan.sqlite"

static SQL_NEWS_Commentlist_Zan_Server *_SQL_NEWS_Commentlist_Zan_Server = nil;

@implementation SQL_NEWS_Commentlist_Zan_Server

+ (SQL_NEWS_Commentlist_Zan_Server *)sharedManager {
  // 沙盒Docu目录
  if ([[NSFileManager defaultManager]
          fileExistsAtPath:pathInCacheDirectory([NSString
                               stringWithFormat:@"/Collection.xmly/%@",
                                                kDefaultDBName])] == NO) {
    _SQL_NEWS_Commentlist_Zan_Server = nil;
  }
  @synchronized([SQL_NEWS_Commentlist_Zan_Server class]) {
    if (!_SQL_NEWS_Commentlist_Zan_Server)
      _SQL_NEWS_Commentlist_Zan_Server = [[self alloc] init];
    return _SQL_NEWS_Commentlist_Zan_Server;
  }

  return nil;
}

+ (id)alloc {

  @synchronized([SQL_NEWS_Commentlist_Zan_Server class]) {
    NSAssert(_SQL_NEWS_Commentlist_Zan_Server == nil,
             @"Attempted to allocated a second instance_SQLDataHtmlstring");
    _SQL_NEWS_Commentlist_Zan_Server = [super alloc];
    return _SQL_NEWS_Commentlist_Zan_Server;
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
  _SQL_NEWS_Commentlist_Zan_Server = nil;
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

  if ([set intForColumnIndex:0]) {
    // TODO:是否更新数据库
    //        [AppDelegate showStatusWithText:@"数据库已经存在" duration:2];
  } else {
    // TODO: 插入新的数据库
    [_db executeUpdate:@"CREATE TABLE PUser_Commentlist (uid INTEGER PRIMARY "
                       @"KEY AUTOINCREMENT  NOT NULL, name VARCHAR(50), "
                       @"praise VARCHAR(2))"];
  }
}

//判断是否已经赞过了
- (BOOL)PUser_zan:(NSString *)name {
  FMResultSet *rs = [_db
      executeQuery:[NSString
                       stringWithFormat:
                           @"select * from PUser_Commentlist WHERE name = '%@'",
                           name]];

  BOOL returnBool = [rs next];

  [rs close];

  return returnBool;
}
//保存被赞过的文章id
- (void)save_PUser:(NSString *)name {
  NSMutableString *query =
      [NSMutableString stringWithFormat:@"INSERT INTO  PUser_Commentlist"];
  NSMutableString *keys = [NSMutableString stringWithFormat:@" ("];
  NSMutableString *values = [NSMutableString stringWithFormat:@" ( "];
  NSMutableArray *arguments = [NSMutableArray arrayWithCapacity:5];
  if (name) {
    [keys appendString:@"name,"];
    [values appendString:@"?,"];
    [arguments addObject:name];
  }
  if (1) {
    [keys appendString:@"praise,"];
    [values appendString:@"?,"];
    [arguments addObject:@"1"];
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
//删除被赞过的文章id
- (void)delete_PUser:(NSString *)name {
  NSString *query = [NSString
      stringWithFormat:@"DELETE FROM PUser_Commentlist WHERE name = '%@'",
                       name];

  [_db executeUpdate:query];
}
- (NSArray *)PUser_array {
  //    NSString * query = @"SELECT * FROM PUser_Commentlist ORDER BY uid DESC";

  FMResultSet *rs =
      [_db executeQuery:@"SELECT * FROM PUser_Commentlist ORDER BY uid DESC"];
  NSMutableArray *array = [NSMutableArray arrayWithCapacity:[rs columnCount]];
  while ([rs next]) {
    NSMutableArray *user = [[NSMutableArray alloc] initWithCapacity:0];
    NSString *uid = [rs stringForColumn:@"uid"];
    [user addObject:uid];
    NSString *name = [rs stringForColumn:@"name"];
    [user addObject:name];
    NSString *description = [rs stringForColumn:@"praise"];
    [user addObject:description];
    [array addObject:user];
  }
  [rs close];

  return array;
}

@end
