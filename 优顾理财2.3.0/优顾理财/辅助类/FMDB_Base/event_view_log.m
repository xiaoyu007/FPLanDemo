//
//  event_view_log.m
//  DDMenuController
//
//  Created by moulin wang on 13-9-7.
//
//

//判断是否用waifi上网

#define kTableName @"EVENT_LOG"
#define kDefDBName @"EVENT.sqlite"

static event_view_log *_event_view_log = nil;

@implementation event_view_log
@synthesize my_event_id;

+ (event_view_log *)sharedManager {
  // 沙盒Docu目录
  if ([[NSFileManager defaultManager]
          fileExistsAtPath:pathInCacheDirectory([NSString
                               stringWithFormat:@"/Collection.xmly/%@",
                                                kDefDBName])] == NO) {
    _event_view_log = nil;
  }
  @synchronized([event_view_log class]) {
    if (!_event_view_log)
      _event_view_log = [[self alloc] init];
    return _event_view_log;
  }

  return nil;
}

+ (id)alloc {

  @synchronized([event_view_log class]) {
    NSAssert(_event_view_log == nil,
             @"Attempted to allocated a second instance_SQLDataHtmlstring");
    _event_view_log = [super alloc];
    return _event_view_log;
  }
  return nil;
}

- (id)init {
  self = [super init];
  if (self) {
    //    // 沙盒Docu目录
    _name = pathInCacheDirectory(
        [NSString stringWithFormat:@"/Collection.xmly/%@", kDefDBName]);

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
  _event_view_log = nil;
}

/**
 * @brief 创建数据库
 */
- (void)createDataBase {
  FMResultSet *set =
      [_db executeQuery:[NSString stringWithFormat:@"select count(*) from "
                                                   @"sqlite_master where type "
                                                   @"='table' and name = '%@'",
                                                   kTableName]];

  [set next];

  if ([set intForColumnIndex:0]) {
    // TODO:是否更新数据库
    // nslog(@"数据库已存在");
  } else {
    // TODO: 插入新的数据库
    [_db executeUpdate:@"CREATE TABLE EVENT_LOG (uid INTEGER PRIMARY KEY "
                       @"AUTOINCREMENT  NOT NULL, name VARCHAR(20), "
                       @"description VARCHAR(20))"];
  }
}
/**
 * @brief 保存一条用户记录
 *
 * @param user 需要保存的用户数据
 */
- (void)saveUser:(NSString *)name andDescription:(NSString *)description {
  NSMutableString *query =
      [NSMutableString stringWithFormat:@"INSERT INTO EVENT_LOG"];
  NSMutableString *keys = [NSMutableString stringWithFormat:@" ("];
  NSMutableString *values = [NSMutableString stringWithFormat:@" ( "];
  NSMutableArray *arguments = [NSMutableArray arrayWithCapacity:5];
  if (name) {
    [keys appendString:@"name,"];
    [values appendString:@"?,"];
    [arguments addObject:name];
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
/**
 * @brief 修改用户的信息
 *
 * @param user 需要修改的用户信息
 */
- (void)mergeWithUser:(NSString *)name {
  if (!name) {
    return;
  }
  NSString *description = [self findWithName:name];
  NSString *query = [NSString
      stringWithFormat:@"UPDATE EVENT_LOG set description='%d' where name='%@'",
                       [description intValue] + 1, name];
  [_db executeUpdate:query];
}
- (NSString *)findWithName:(NSString *)name {
  NSString *query = [NSString
      stringWithFormat:@"SELECT description FROM EVENT_LOG where name='%@'",
                       name];

  FMResultSet *rs = [_db executeQuery:query];

  [rs next];

  NSString *description = [rs stringForColumn:@"description"];

  [rs close];
  return description;
}
- (NSArray *)findWithUid {
  NSString *query = @"SELECT * FROM EVENT_LOG ORDER BY uid DESC limit 20";

  FMResultSet *rs = [_db executeQuery:query];
  //    计入取出来的所有的uids
  NSMutableArray *array_uids = [[NSMutableArray alloc] initWithCapacity:0];
  NSMutableArray *array = [NSMutableArray arrayWithCapacity:[rs columnCount]];
  while ([rs next]) {
    NSMutableArray *user = [[NSMutableArray alloc] initWithCapacity:0];
    NSString *uid = [rs stringForColumn:@"uid"];
    [user addObject:uid];
    //        存储uid
    [array_uids addObject:uid];
    NSString *name = [rs stringForColumn:@"name"];
    [user addObject:name];
    NSString *description = [rs stringForColumn:@"description"];
    [user addObject:description];
    [array addObject:user];
  }
  //    取出20条数据，然后先删除
  [self deleteUserWithIds:array_uids];
  [rs close];
  return array;
}
//删除多个uid行
- (void)deleteUserWithIds:(NSArray *)uids {
  NSString *query =
      [NSString stringWithFormat:@"DELETE FROM EVENT_LOG WHERE uid in ("];
  for (int i = 0; i < [uids count]; i++) {
    query = [NSString stringWithFormat:@"%@'%@'", query, uids[i]];
    if (i < [uids count] - 1) {
      query = [NSString stringWithFormat:@"%@,", query];
    }
  }
  query = [NSString stringWithFormat:@"%@);", query];
  [_db executeUpdate:query];
}

/**
 *     //查找同一种类型的数据有多少条
 *
 *
 *      查找
 **/
- (int)Count_data_sql_name:(NSString *)name {
  NSString *query = [NSString
      stringWithFormat:@"SELECT count(1) FROM EVENT_LOG WHERE name = '%@'",
                       name];
  FMResultSet *rs = [_db executeQuery:query];
  while ([rs next]) {
    return [rs intForColumnIndex:0];
  }
  return 0;
}
/**
 *   操作event事件表
 *
 *
 *
 **/
- (void)event_view_log:(NSString *)name {
  name = [NSString stringWithFormat:@"10000%02d", [name intValue]];

  [MobClick event:name];

  //先判断event中是否有一个code=name的记录
  int is_not_exect = [self Count_data_sql_name:name];
  if (is_not_exect == 0) {
    //        说明，还没有code=name的记录，直接保存数据库就可以了
    [self saveUser:name andDescription:@"1"];
  } else {
    //      说明，数据库中已经有了code=name的记录，则只需要修改 des的值就可以了
    [self mergeWithUser:name];
  }

  //    然后判断是否需要上传数据
  if ([self IS_NOT_Need_upload:name]) {

    //        说明需要上传数据了
    [self NEED_uploade:name];
  }
}
// event事件
- (void)event_log:(NSString *)event_id {
  self.my_event_id = event_id;
  [NSThread detachNewThreadSelector:@selector(event_view_loading)
                           toTarget:self
                         withObject:nil];
}
- (void)event_view_loading {
  [self event_view_log:self.my_event_id];
}

//需要上传后台服务器的时候
- (void)NEED_uploade:(NSString *)name {
  //  从数据库中获取，需要的数据
  //    存储，数据库中获取的数据
  NSMutableArray *array_upload_data =
      [[NSMutableArray alloc] initWithCapacity:0];
  NSArray *Ary = [self findWithUid];

  for (NSArray *ary in Ary) {

    if ([ary count] >= 3) {

      NSDictionary *event_log_dic = [NSDictionary
          dictionaryWithObjectsAndKeys:ak_version, @"ak", name, @"code",
                                       [ary objectAtIndex:2], @"num", nil];
      [array_upload_data addObject:event_log_dic];
    }
  }

  [[WebServiceManager sharedManager]
      Log_post_data:@"eventstat"
            andData:array_upload_data
         completion:^(NSDictionary *dic) {

           if (dic && [[dic objectForKey:@"status"] isEqualToString:@"0000"]) {
             NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
             NSTimeInterval a = [dat timeIntervalSince1970] * 1000;
             NSString *update_time =
                 [NSString stringWithFormat:@"%llu", (long long)a];
             [[NSUserDefaults standardUserDefaults]
                 setObject:update_time
                    forKey:@"event_updata_time"];
           } else {
             //          从新将数据插回数据库
             [self ADD_saveUSer:array_upload_data];
           }

         }];
}
//插入多条数据
- (void)ADD_saveUSer:(NSArray *)array {
  NSArray *main_array = [array copy];
  for (NSDictionary *array_User in main_array) {
    NSString *name = [array_User objectForKey:@"code"];
    NSString *jsonStr = [array_User objectForKey:@"num"];

    if (name && jsonStr) {
      //        单条添加
      [self saveUser:name andDescription:jsonStr];
    }
  }
}

//是否需要上传——数据
- (BOOL)IS_NOT_Need_upload:(NSString *)name {
  //    判断是否用wifi上传
  if ([[self checkNetWork] isEqualToString:@"wifi"]) {
    return YES;
  }
  //        判断是否同属性的信息，是否超过20条
  int app_data = [self Count_data_sql_name:name];
  if (app_data >= 20) {
    return YES;
  }
  //离上次上传时间间隔是否超过十分钟
  if ([self Judgment_time:name] == YES) {
    return YES;
  }

  return NO;
}
//判断与上传一次，上传同种数据的类型的数据的时间，间隔是否大于10分钟
- (BOOL)Judgment_time:(NSString *)name {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSString *Last_Time = [defaults objectForKey:@"event_updata_time"];
  //   如果是没有上次上传时间，就不上传
  if ([Last_Time longLongValue] > 0) {
    //获取系统当前的时间戳
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970] * 1000;

    if (a - [Last_Time longLongValue] > 600) {
      return YES;
    }
  }
  return NO;
}
//获得手机上网方式
- (NSString *)checkNetWork {
  Reachability *reachability =
      [Reachability reachabilityWithHostName:@"www.youguu.com"];
  switch ([reachability currentReachabilityStatus]) {
  case NotReachable:
    return @"无网络";
  case ReachableViaWWAN:
    return @"3G或GPRS";
  case ReachableViaWiFi:
    return @"wifi";

  default:
    break;
  }
}

@end
