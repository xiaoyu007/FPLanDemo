//
//  SQLDataHtmlstring.m
//  DDMenuController
//
//  Created by moulin wang on 13-8-17.
//
//

#import "SQLDataHtmlstring.h"

#define kUserTableName @"SUser"
#define kDefaultDBName @"Collection_Resources.sqlite"

static SQLDataHtmlstring *_SQLDataHtmlstring = nil;

@implementation SQLDataHtmlstring

+ (SQLDataHtmlstring *)sharedManager {
  // 沙盒Docu目录
  if ([[NSFileManager defaultManager] fileExistsAtPath:pathInCacheDirectory([NSString stringWithFormat:@"/Collection.xmly/%@", kDefaultDBName])] ==
      NO) {
    _SQLDataHtmlstring = nil;
  }
  @synchronized([SQLDataHtmlstring class]) {
    if (!_SQLDataHtmlstring)
      _SQLDataHtmlstring = [[self alloc] init];
    return _SQLDataHtmlstring;
  }

  return nil;
}

+ (id)alloc {

  @synchronized([SQLDataHtmlstring class]) {
    NSAssert(_SQLDataHtmlstring == nil,
             @"Attempted to allocated a second instance_SQLDataHtmlstring");
    _SQLDataHtmlstring = [super alloc];
    return _SQLDataHtmlstring;
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
  _SQLDataHtmlstring = nil;
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

  FMResultSet *set1 = [_db
      executeQuery:[NSString stringWithFormat:@"select count(*) from " @"sqlite_master where type " @"='table' and name = '%@'", @"PUser"]];

  [set1 next];

  if ([set1 intForColumnIndex:0]) {
    // TODO:是否更新数据库
    //        [AppDelegate showStatusWithText:@"数据库已经存在" duration:2];
  } else {
    // TODO: 插入新的数据库
    [_db executeUpdate:@"CREATE TABLE PUser (uid INTEGER PRIMARY KEY "
         @"AUTOINCREMENT  NOT NULL, name VARCHAR(50), praise " @"VARCHAR(2))"];
  }
}
/**
 * @brief 查看是否存在某条信息
 *
 * @param user 看看用户是否已经收藏的了改条信息
 */
- (BOOL)View_user_exists:(NSString *)name andChannlid:(NSString *)channlid {
  //定义一个可变数组，用来存放查询的结果，返回给调用者
  //定义一个结果集，存放查询的数据
  FMResultSet *rs = [_db
      executeQuery:[NSString stringWithFormat:@"select Fid from SUser " @"WHERE name = '%@' and " @"channlid = '%@'", name, channlid]];

  BOOL returnBool = [rs next];

  [rs close];

  return returnBool;
}
/**
 * @brief 根据 name（新闻id） ，查找 fid（后台存储的 新闻id）
 *
 * @param
 */
- (NSString *)Search_UserWithfid:(NSString *)uid andChannlid:(NSString *)channlid {
  //定义一个结果集，存放查询的数据
  FMResultSet *rs = [_db
      executeQuery:[NSString stringWithFormat:@"select Fid from SUser " @"WHERE name = '%@' and " @"channlid = '%@'", uid, channlid]];

  [rs next];
  NSString *fid = [rs objectForColumnName:@"Fid"];
  [rs close];

  return fid;
}

/**
 * @brief 修改用户的信息
 *
 * @param user 需要修改的用户信息
 */
- (void)mergeWithUser:(NSString *)name
          andChannlid:(NSString *)channlid
        andadd_cancle:(NSString *)add_cancle
           andSync_is:(NSString *)sync {
  if (!name) {
    return;
  }
  NSString *query = [NSString stringWithFormat:@"UPDATE SUser set add_cancle=%@ and "
                                               @"Sync_is=%@ where name=%@ and channlid = %@",
                                               add_cancle, sync, name, channlid];
  [_db executeUpdate:query];
}

/**
 * @brief 保存一条用户记录
 *
 * @param user 需要保存的用户数据
 */
- (void)saveUser:(NSString *)name
     andchannlid:(NSString *)channlid
  andDescription:(NSString *)description
   andAdd_cancle:(NSString *)add_cancle
          andFid:(NSString *)fid
  andSynchronous:(NSString *)sync {
  NSMutableString *query = [NSMutableString stringWithFormat:@"INSERT INTO SUser"];
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
  if (add_cancle) {
    [keys appendString:@"add_cancle,"];
    [values appendString:@"?,"];
    [arguments addObject:add_cancle];
  }
  if (fid) {
    [keys appendString:@"Fid,"];
    [values appendString:@"?,"];
    [arguments addObject:fid];
  }
  if (sync) {
    [keys appendString:@"Sync_is,"];
    [values appendString:@"?,"];
    [arguments addObject:sync];
  }

  [keys appendString:@")"];
  [values appendString:@")"];
  [query appendFormat:@" %@ VALUES%@",
                      [keys stringByReplacingOccurrencesOfString:@",)" withString:@")"],
                      [values stringByReplacingOccurrencesOfString:@",)" withString:@")"]];

  [_db executeUpdate:query withArgumentsInArray:arguments];

  //    NSLog(@"收藏新闻是否成功：%d",[_db executeUpdate:query
  //    withArgumentsInArray:arguments]);
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

/**
 * @brief 模拟分页查找数据。取uid大于某个值以后的limit个数据
 *
 * @param uid
 * @param limit 每页取多少个
 * @获取数据库中所有数据
 */
- (NSArray *)findWithALL_uids {
  NSString *query = @"SELECT * FROM SUser ORDER BY rowid desc";
  //    query = [query stringByAppendingFormat:@" ORDER BY uid desc "];

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
    NSString *add_cancle = [rs stringForColumn:@"add_cancle"];
    [user addObject:add_cancle];
    NSString *Fid = [rs stringForColumn:@"Fid"];
    [user addObject:Fid];
    NSString *Synchronous = [rs stringForColumn:@"Sync_is"];
    [user addObject:Synchronous];

    [array addObject:user];
  }
  [rs close];
  return array;
}

//判断是否已经赞过了
- (BOOL)PUser_zan:(NSString *)name {
  FMResultSet *rs =
      [_db executeQuery:[NSString stringWithFormat:@"select * from PUser WHERE name = '%@'", name]];

  BOOL returnBool = [rs next];

  [rs close];

  //判断结果集中是否有数据，如果有则取出数据
  return returnBool;
}
//保存被赞过的文章id
- (void)save_PUser:(NSString *)name {
  NSMutableString *query = [NSMutableString stringWithFormat:@"INSERT INTO  PUser"];
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
                      [keys stringByReplacingOccurrencesOfString:@",)" withString:@")"],
                      [values stringByReplacingOccurrencesOfString:@",)" withString:@")"]];

  [_db executeUpdate:query withArgumentsInArray:arguments];
}
//删除被赞过的文章id
- (void)delete_PUser:(NSString *)name {
  NSString *query = [NSString stringWithFormat:@"DELETE FROM PUser WHERE name = '%@'", name];

  [_db executeUpdate:query];
}
- (NSArray *)PUser_array {
  FMResultSet *rs = [_db executeQuery:@"SELECT * FROM PUser ORDER BY uid DESC"];
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
