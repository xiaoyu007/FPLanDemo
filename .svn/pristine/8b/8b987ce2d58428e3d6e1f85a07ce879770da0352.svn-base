//
//  FundListImeSQL.m
//  优顾理财
//
//  Created by Mac on 15-4-16.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FundListsSqlite.h"
#import "ConditionsWithKeyBoardUsing.h"
#import "FPMyOptionalShareManager.h"

#define FundListsTable @"FundListName"
#define kDefaultDBName @"fundLists.sqlite"

static FundListsSqlite *fundListSqlite = nil;

@implementation FundListsSqlite
+ (FundListsSqlite *)sharedManager {
  // 沙盒Docu目录
  if ([[NSFileManager defaultManager]
          fileExistsAtPath:pathInCacheDirectory([NSString
                               stringWithFormat:@"/Collection.xmly/%@",
                                                kDefaultDBName])] == NO) {
    fundListSqlite = nil;
  }
  @synchronized([FundListsSqlite class]) {
    if (!fundListSqlite)
      fundListSqlite = [[self alloc] init];
    return fundListSqlite;
  }

  return nil;
}

+ (id)alloc {

  @synchronized([FundListsSqlite class]) {
    NSAssert(fundListSqlite == nil,
             @"Attempted to allocated a second instance_sql_data_html_string");
    fundListSqlite = [super alloc];
    return fundListSqlite;
  }
  return nil;
}

- (id)init {
  self = [super init];
  if (self) {
    // 沙盒目录 XXX/Collection.xmly/fundLists.sqlite
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
  fundListSqlite = nil;
}

/**
 * @brief 创建数据库
 */
- (void)createDataBase {
  FMResultSet *set =
      [_db executeQuery:[NSString stringWithFormat:@"select count(*) from "
                                                   @"sqlite_master where type "
                                                   @"='table' and name = '%@'",
                                                   FundListsTable]];

  [set next];

  NSInteger count = [set intForColumnIndex:0];

  BOOL existTable = !!count;

  if (existTable) {
    // TODO:是否更新数据库
    //        [AppDelegate showStatusWithText:@"数据库已经存在" duration:2];
  } else {
// TODO: 插入新的数据库
#if 1
    BOOL iscreate =
        [_db executeUpdate:
                 [NSString
                     stringWithFormat:
                         @"CREATE TABLE %@ (fundid VARCHAR(20) "
                         @"NOT NULL UNIQUE, fundname " @"VARCHAR(30) NOT NULL, pinyin "
                         @"VARCHAR(40), invsttype INTEGER "
                         @", isSelected VARCHAR(30), inctime VARVHAR(20) )",
                         FundListsTable]];
#else
    BOOL iscreate = [_db
        executeUpdate:
            [NSString stringWithFormat:
                          @"CREATE TABLE %@ (fundid INTEGER PRIMARY "
                          @"KEY AUTOINCREMENT NOT NULL, fundname "
                          @"VARCHAR(30) NOT NULL, pinyin "
                          @"VARCHAR(40), invsttype INTEGER "
                          @", isSelected VARCHAR(30), inctime VARVHAR(20) )",
                          FundListsTable]];
#endif
    NSLog(@"%d", iscreate);
  }
}
/** 列表是否存在某只基金 */
- (BOOL)fundListsExist:(NSString *)name {
  //定义一个可变数组，用来存放查询的结果，返回给调用者
  //定义一个结果集，存放查询的数据
  FMResultSet *rs = [_db
      executeQuery:
          [NSString stringWithFormat:@"select * from %@ WHERE fundname = '%@'",
                                     FundListsTable, name]];

  BOOL returnBool = [rs next];

  [rs close];

  //判断结果集中是否有数据，如果有则取出数据
  return returnBool;
}
/** 查询 */
- (NSArray *)queryFundListWithInputStr:(NSString *)inputStr {
  NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
  NSString *resultStr;
  NSString *otherStr;
  if ([ConditionsWithKeyBoardUsing isNumbers:inputStr]) {
    resultStr =
        [NSString stringWithFormat:@"select * from %@ WHERE fundid like'%@%%'  order by fundid",
                                   FundListsTable, inputStr];
    otherStr = [NSString stringWithFormat:@"select * from %@ WHERE fundname like'%%%@%%'  order by fundid",
                FundListsTable, inputStr];
  } else if ([ConditionsWithKeyBoardUsing isWord:inputStr]) {
    resultStr =
        [NSString stringWithFormat:@"select * from %@ WHERE pinyin like'%@%%' order by fundid",
                                   FundListsTable, inputStr];
  } else {
    resultStr = [NSString
        stringWithFormat:@"select * from %@ WHERE fundname like'%%%@%%' order by fundid",
                          FundListsTable, inputStr];
  }
  FMResultSet *resultSet = [_db executeQuery:resultStr];
  NSInteger start = 0;
  while ([resultSet next]) {
    FPFundItem *item = [[FPFundItem alloc] init];
    item.fundId = [NSString
        stringWithFormat:@"%@", [resultSet stringForColumn:@"fundid"]];
    item.fundName = [resultSet stringForColumn:@"fundname"];
    item.pinyin = [resultSet stringForColumn:@"pinyin"];
    item.invstType = [NSString
        stringWithFormat:@"%d", [resultSet intForColumn:@"invsttype"]];
    item.incTime = [resultSet stringForColumn:@"inctime"];
    item.isSelected = [resultSet stringForColumn:@"isSelected"];
    [array addObject:item];
    start++;
    //只显示20条
    if (start >= 20) {
      break;
    }
  }
  //名称中有数字
  if ([otherStr length] > 0&&[array count] < 20) {
    FMResultSet *otherResultSet = [_db executeQuery:otherStr];
    NSInteger otherStart = [array count];
    while ([otherResultSet next]) {
      FPFundItem *item = [[FPFundItem alloc] init];
      item.fundId = [NSString
                     stringWithFormat:@"%@", [otherResultSet stringForColumn:@"fundid"]];
      //过滤到重复的fundid
      for (FPFundItem *previousItem in array) {
        if ([previousItem.fundId isEqualToString:item.fundId]) {
          break;
        }
      }
      item.fundName = [otherResultSet stringForColumn:@"fundname"];
      item.pinyin = [otherResultSet stringForColumn:@"pinyin"];
      item.invstType = [NSString
                        stringWithFormat:@"%d", [otherResultSet intForColumn:@"invsttype"]];
      item.incTime = [otherResultSet stringForColumn:@"inctime"];
      item.isSelected = [otherResultSet stringForColumn:@"isSelected"];
      [array addObject:item];
      otherStart++;
      //只显示20条
      if (otherStart >= 20) {
        break;
      }
    }
  }
  [self refreshIsMyOptional:array];
  return array;
}
/** 刷新显示的自选列表 */
- (void)refreshIsMyOptional:(NSArray *)quertLists {
  for (FPFundItem *item in quertLists) {
    if (![[FPMyOptionalShareManager shareManager] judgeDataRepeat:item.fundId]) {
      item.isSelected = @"1";
    } else {
      item.isSelected = @"0";
    }
  }
}
/** 首页基金列表缓存 */
- (void)saveRecommendList:(NSMutableArray *)recommendLists{
  [_db beginTransaction];
  BOOL isRollBack = NO;
  NSInteger fundListNum = [recommendLists count];
  @try {
    for (int i = 0; i < fundListNum; i++) {
      FPFundItem *item = [recommendLists objectAtIndex:i];
      NSString *sql = @"INSERT INTO FundListName (fundid, fundname, pinyin, "
      @"invsttype, inctime, isSelected) VALUES (?,?,?,?,?,?)";
      BOOL isQuerySuccess =
      [_db executeUpdate:sql, item.fundId, item.fundName, item.pinyin,
       item.invstType, item.incTime, item.isSelected];
      if (!isQuerySuccess) {
        NSLog(@"添加失败 _ %d %@", i, item);
      }
    }
  } @catch (NSException *exception) {
    isRollBack = YES;
    [_db rollback];
  } @finally {
    if (!isRollBack) {
      [_db commit];
    }
  }
}
/** 我的自选列表缓存 */
- (void)saveMyOptionalList:(NSMutableArray *)myOptionalLists{
  
}
/** 缓存码表 */
- (void)saveFundLists:(NSMutableArray *)fundLists {
  [_db beginTransaction];
  BOOL isRollBack = NO;
  NSInteger fundListNum = [fundLists count];
  @try {
    for (int i = 0; i < fundListNum; i++) {
      FPFundItem *item = [fundLists objectAtIndex:i];
      NSString *sql = @"INSERT INTO FundListName (fundid, fundname, pinyin, "
                      @"invsttype, inctime, isSelected) VALUES (?,?,?,?,?,?)";
      BOOL isQuerySuccess =
          [_db executeUpdate:sql, item.fundId, item.fundName, item.pinyin,
                             item.invstType, item.incTime, item.isSelected];
      if (!isQuerySuccess) {
        NSLog(@"添加失败 _ %d %@", i, item);
      }
    }
  } @catch (NSException *exception) {
    isRollBack = YES;
    [_db rollback];
  } @finally {
    if (!isRollBack) {
      [_db commit];
    }
  }
}
/** 更新一条基金 */
- (void)updateOneList:(FPFundItem *)item {
  BOOL isUpdate = [_db
      executeUpdateWithFormat:
          @"UPDATE FundListName SET 'isSelected' = '%@' WHERE 'fundid' = '%@'",
          item.isSelected, item.fundId];
  if (!isUpdate) {
    NSLog(@"更新失败 = %@", item);
  }
  //加入一条自选
  if ([item.isSelected integerValue] > 0) {
    [[FPMyOptionalShareManager shareManager] saveMyOptionalListWith:item];
  } else {
    [[FPMyOptionalShareManager shareManager]
        deleteMyOptionalListWithID:item.fundId];
  }
}
- (void)updateMyOptionalLists:(NSMutableArray *)myOptionalLists {
  [_db beginTransaction];
  BOOL isRollBack = NO;
  NSInteger optionalNum = [myOptionalLists count];
  @try {
    for (int i = 0; i < optionalNum; i++) {
      FPFundItem *item = [myOptionalLists objectAtIndex:i];

      NSString *sql = @"UPDATE FundListName (fundid, fundname, pinyin, "
                      @"invsttype, inctime, isSelected) VALUES (?,?,?,?,?,?)";

      BOOL isUpdateSuccess =
          [_db executeUpdate:sql, item.fundId, item.fundName, item.pinyin,
                             item.invstType, item.incTime, item.isSelected];

      [_db executeUpdateWithFormat:@"UPDATE FundListName SET 'isSelected' = "
                                   @"'%@' WHERE 'fundid' = '%@'",
                                   item.isSelected, item.fundId];
      if (!isUpdateSuccess) {
        NSLog(@"更新失败 %d = %@", i, item);
      }
    }
  } @catch (NSException *exception) {
    isRollBack = YES;
    [_db rollback];
  } @finally {
    if (!isRollBack) {
      [_db commit];
    }
  }
}
/** 更新 */
- (void)updateFundId:(NSString *)fundId
        withFundName:(NSString *)fundName
          withPinYin:(NSString *)pinyin
       withInvsttype:(FundItemType)fundItemType
         withIncTime:(NSString *)inctime
      withIsSelected:(NSString *)isSelected {
  if (fundId && fundName && pinyin) {
    NSMutableString *query =
        [NSMutableString stringWithFormat:@"UPDATE %@", FundListsTable];
    NSMutableString *keys = [NSMutableString stringWithFormat:@" ("];
    NSMutableString *values = [NSMutableString stringWithFormat:@" ("];
    NSMutableArray *arguments = [NSMutableArray arrayWithCapacity:5];
    if (fundId) {
      [keys appendString:@"fundid,"];
      [values appendString:@"?,"];
      [arguments addObject:fundId];
    }
    if (fundName) {
      [keys appendString:@"fundname,"];
      [values appendString:@"?,"];
      [arguments addObject:fundName];
    }
    if (pinyin) {
      [keys appendString:@"pinyin,"];
      [values appendString:@"?,"];
      [arguments addObject:pinyin];
    }
    if (fundItemType) {
      [keys appendString:@"invsttype,"];
      [values appendString:@"?,"];
      [arguments addObject:[NSString stringWithFormat:@"%ld", fundItemType]];
    }

    if (inctime) {
      [keys appendString:@"inctime,"];
      [values appendString:@"?,"];
      [arguments addObject:inctime];
    }
    if (isSelected) {
      [keys appendString:@"isSelected,"];
      [values appendString:@"?,"];
      [arguments addObject:isSelected];
    }
    [keys appendString:@")"];
    [values appendString:@")"];
    [query appendFormat:@" %@ VALUES%@",
                        [keys stringByReplacingOccurrencesOfString:@",)"
                                                        withString:@")"],
                        [values stringByReplacingOccurrencesOfString:@",)"
                                                          withString:@")"]];

    BOOL isUpdate = [_db executeUpdate:query withArgumentsInArray:arguments];
  }
}
/** 保存 */
- (void)saveFundId:(NSString *)fundId
      withFundName:(NSString *)fundName
        withPinYin:(NSString *)pinyin
     withInvsttype:(FundItemType)fundItemType
       withIncTime:(NSString *)inctime
    withIsSelected:(NSString *)isSelected {
  if (fundId && fundName && pinyin && inctime) {
    NSMutableString *query =
        [NSMutableString stringWithFormat:@"INSERT INTO %@", FundListsTable];
    NSMutableString *keys = [NSMutableString stringWithFormat:@" ("];
    NSMutableString *values = [NSMutableString stringWithFormat:@" ("];
    NSMutableArray *arguments = [NSMutableArray arrayWithCapacity:5];
    if (fundId) {
      [keys appendString:@"fundid,"];
      [values appendString:@"?,"];
      [arguments addObject:fundId];
    }
    if (fundName) {
      [keys appendString:@"fundname,"];
      [values appendString:@"?,"];
      [arguments addObject:fundName];
    }
    if (pinyin) {
      [keys appendString:@"pinyin,"];
      [values appendString:@"?,"];
      [arguments addObject:pinyin];
    }
    if (fundItemType) {
      [keys appendString:@"invsttype,"];
      [values appendString:@"?,"];
      [arguments addObject:[NSString stringWithFormat:@"%ld", fundItemType]];
    }

    if (inctime) {
      [keys appendString:@"inctime,"];
      [values appendString:@"?,"];
      [arguments addObject:inctime];
    }
    if (isSelected) {
      [keys appendString:@"isSelected,"];
      [values appendString:@"?,"];
      [arguments addObject:isSelected];
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
/** 删除基金 */
- (void)deleteListWithFundName:(NSString *)fundName {
  NSString *query =
      [NSString stringWithFormat:@"DELETE FROM %@ WHERE name = '%@'",
                                 FundListsTable, fundName];

  [_db executeUpdate:query];
}
- (void)deleteFundLists {
  NSString *query =
      [NSString stringWithFormat:@"DELETE FROM %@", FundListsTable];

  [_db executeUpdate:query];
}

//删除所有数据
- (void)deleteUserWith_ALL:(NSArray *)fundnamesArray {
  NSString *query = [NSString
      stringWithFormat:@"DELETE FROM %@ WHERE fundname in (", FundListsTable];
  for (int i = 0; i < [fundnamesArray count]; i++) {
    query = [NSString stringWithFormat:@"%@'%@'", query, fundnamesArray[i]];
    if (i < [fundnamesArray count] - 1) {
      query = [NSString stringWithFormat:@"%@,", query];
    } else {
    }
  }
  query = [NSString stringWithFormat:@"%@);", query];
  [_db executeUpdate:query];
}
@end
