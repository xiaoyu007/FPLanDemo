//
//  SQL_Data_Log_server.m
//  DDMenuController
//
//  Created by moulin wang on 13-9-3.
//
//

#import "SQL_Data_Log_server.h"
#import "JSONKit.h"
//#import "event_view_log.h"
//判断是否用waifi上网

#define kUserTableName @"APP_LOG"
#define kDefaultDBName @"LOG.sqlite"

static SQL_Data_Log_server *_SQL_Data_Log_server = nil;

@implementation SQL_Data_Log_server

+ (SQL_Data_Log_server *)sharedManager {
  // 沙盒Docu目录
  if ([[NSFileManager defaultManager] fileExistsAtPath:pathInCacheDirectory([NSString stringWithFormat:@"/Collection.xmly/%@", kDefaultDBName])] ==
      NO) {
    _SQL_Data_Log_server = nil;
  }
  @synchronized([SQL_Data_Log_server class]) {
    if (!_SQL_Data_Log_server)
      _SQL_Data_Log_server = [[self alloc] init];
    return _SQL_Data_Log_server;
  }

  return nil;
}

+ (id)alloc {

  @synchronized([SQL_Data_Log_server class]) {
    NSAssert(_SQL_Data_Log_server == nil,
             @"Attempted to allocated a second instance_SQLDataHtmlstring");
    _SQL_Data_Log_server = [super alloc];
    return _SQL_Data_Log_server;
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
  _SQL_Data_Log_server = nil;
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
    // nslog(@"数据库已存在");
  } else {
    // TODO: 插入新的数据库
    [_db executeUpdate:@"CREATE TABLE APP_LOG (uid INTEGER PRIMARY KEY "
         @"AUTOINCREMENT  NOT NULL, name VARCHAR(20), " @"description VARCHAR(500))"];
  }
}
/**
  * @brief 将NSDictionary或NSArray转化为JSON串
  *
  * @param dic->json
 **/
- (NSString *)toJSONData:(NSDictionary *)theData {

  NSError *error = nil;
  id result = [NSJSONSerialization dataWithJSONObject:theData options:kNilOptions error:&error];
  if (error != nil)
    return nil;
  return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
}
/**
 * @brief 保存一条用户记录
 *
 * @param user 需要保存的用户数据
 */
- (void)saveUser:(NSString *)name andDescription:(NSDictionary *)description {
  if (name && description) {
    //    将nsdic字典转化成nsstring字符串
    NSError *err;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:description options:0 error:&err];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    NSMutableString *query = [NSMutableString stringWithFormat:@"INSERT INTO APP_LOG"];
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
      [arguments addObject:jsonStr];
    }
    [keys appendString:@")"];
    [values appendString:@")"];
    [query appendFormat:@" %@ VALUES%@",
                        [keys stringByReplacingOccurrencesOfString:@",)" withString:@")"],
                        [values stringByReplacingOccurrencesOfString:@",)" withString:@")"]];
    //    插入一条信息
    [_db executeUpdate:query withArgumentsInArray:arguments];

    //    判断是否需要上传
    if ([self IS_NOT_Need_upload]) {
      //        另起一个线程去完成上传log日志
      [self NEED_uploade:name];
    }
  }
}
//需要上传后台服务器的时候
- (void)NEED_uploade:(NSString *)name {
  //  从数据库中获取，需要的数据
  //    存储，数据库中获取的数据
  NSMutableArray *array_upload_data = [[NSMutableArray alloc] initWithCapacity:0];
  NSArray *array_dic = [[NSArray alloc] initWithArray:[self findWithUid]];
  //将获取到的数据中，有用的数据，组一放入数组array_upload_data中
  for (NSArray *ary in array_dic) {
    if ([ary count] >= 3) {
      NSString *jsonText = [ary objectAtIndex:2];
      NSDictionary *dd_dic = [jsonText objectFromJSONString];
      [array_upload_data addObject:dd_dic];
    }
  }
  //    如果数组有空，就不上传了
  if (array_upload_data && [array_upload_data count] > 0) {
    //上传后台服务器
    [[WebServiceManager sharedManager]
        Log_post_data:name
              andData:array_upload_data
           completion:^(NSDictionary *dic) {
             if (dic && [[dic objectForKey:@"status"] isEqualToString:@"0000"]) {
               NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
               NSTimeInterval a = [dat timeIntervalSince1970] * 1000;
               NSString *update_time = [NSString stringWithFormat:@"%llu", (long long)a];
               [[NSUserDefaults standardUserDefaults] setObject:update_time
                                                         forKey:@"pv_updata_time"];
             } else {
               //          从新将数据插回数据库
               [self ADD_saveUSer:array_dic];
             }
           }];
  }
}

//插入多条数据
- (void)ADD_saveUSer:(NSArray *)array {
  for (NSArray *array_User in array) {
    if ([array count] >= 3) {
      NSString *name = [array_User objectAtIndex:1]; // objectForKey:@"name"];

      NSString *jsonStr = [array_User objectAtIndex:2]; // objectForKey:@"description"];

      if (name && jsonStr) {
        NSMutableString *query = [NSMutableString stringWithFormat:@"INSERT INTO APP_LOG"];
        NSMutableString *keys = [NSMutableString stringWithFormat:@" ("];
        NSMutableString *values = [NSMutableString stringWithFormat:@" ( "];
        NSMutableArray *arguments = [NSMutableArray arrayWithCapacity:5];
        if (name) {
          [keys appendString:@"name,"];
          [values appendString:@"?,"];
          [arguments addObject:name];
        }
        if (jsonStr) {
          [keys appendString:@"description,"];
          [values appendString:@"?,"];
          [arguments addObject:jsonStr];
        }
        [keys appendString:@")"];
        [values appendString:@")"];
        [query appendFormat:@" %@ VALUES%@",
                            [keys stringByReplacingOccurrencesOfString:@",)" withString:@")"],
                            [values stringByReplacingOccurrencesOfString:@",)" withString:@")"]];
        [_db executeUpdate:query withArgumentsInArray:arguments];
      }
    }
  }
}
/**
 * @brief 删除一条用户数据
 *
 * @param uid 需要删除的用户的id
 */
- (void)deleteUserWithId:(NSString *)uid {
  NSString *query = [NSString stringWithFormat:@"DELETE FROM APP_LOG WHERE uid = '%@'", uid];

  [_db executeUpdate:query];
}
//删除多个uid行
- (void)deleteUserWithIds:(NSArray *)uids {
  NSString *query = [NSString stringWithFormat:@"DELETE FROM APP_LOG WHERE uid in ("];
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
/**
 *   插入一条数据的时候判断一下，该条信息，同种类型的数据条数是否大于20
 *       是否是waifi上网
 *
 *      是否，和上次上传的时间大于 10分钟
 **/
//获得手机上网方式
- (NSString *)checkNetWork {
  Reachability *reachability = [Reachability reachabilityWithHostName:@"www.youguu.com"];
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
//查找同一种类型的数据有多少条
- (int)Count_data_sql_name {
  NSString *query = @"SELECT count(1) FROM APP_LOG";
  FMResultSet *rs = [_db executeQuery:query];
  while ([rs next]) {
    return [rs intForColumnIndex:0];
  }
  return 0;
}
//判断与上传一次，上传同种数据的类型的数据的时间，间隔是否大于10分钟
- (BOOL)Judgment_time {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSString *Last_Time = [defaults objectForKey:@"pv_updata_time"];
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
//是否需要上传——数据
- (BOOL)IS_NOT_Need_upload {
  //    判断是否用wifi上传
  if ([[self checkNetWork] isEqualToString:@"wifi"]) {
    return YES;
  }
  //    判断是否同属性的信息，是否超过20条
  int app_data = [self Count_data_sql_name];
  if (app_data >= 20) {
    return YES;
  }
  //离上次上传时间间隔是否超过十分钟
  if ([self Judgment_time]) {
    return YES;
  }

  return NO;
}
/**
 * @brief 模拟分页查找数据。取uid大于某个值以后的limit个数据
 *
 * @param uid
 * @param limit 每页取多少个
 * @获取数据库中所有数据
**/
- (NSArray *)findWithUid //:(NSString *) name
{
  NSString *query = @"SELECT * FROM APP_LOG ORDER BY uid DESC limit 20";
  //    query = [query stringByAppendingFormat:@" WHERE name = '%@' ORDER BY uid
  //    DESC limit 20",name];

  FMResultSet *rs = [_db executeQuery:query];

  NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:[rs columnCount]];
  while ([rs next]) {
    NSMutableArray *user = [[NSMutableArray alloc] initWithCapacity:0];
    NSString *uid = [rs stringForColumn:@"uid"];
    [user addObject:uid];
    NSString *name = [rs stringForColumn:@"name"];
    [user addObject:name];
    NSString *description = [rs stringForColumn:@"description"];
    [user addObject:description];
    [array addObject:user];

    //        单个删除 uid
    [self deleteUserWithId:uid];
  }
  [rs close];

  return array;
}

@end
