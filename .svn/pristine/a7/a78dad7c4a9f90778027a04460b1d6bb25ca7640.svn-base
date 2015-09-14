//
//  PV_view_sql.m
//  DDMenuController
//
//  Created by moulin wang on 13-9-5.
//
//

// log日志统计
#import "SQL_Data_Log_server.h"
static PV_view_sql *_PV_view_sql = nil;
@implementation PV_view_sql
@synthesize my_pv_view;
+ (PV_view_sql *)sharedManager {
  @synchronized([PV_view_sql class]) {
    if (!_PV_view_sql)
      _PV_view_sql = [[self alloc] init];
    return _PV_view_sql;
  }
  return nil;
}

+ (id)alloc {
  @synchronized([PV_view_sql class]) {
    NSAssert(_PV_view_sql == nil, @"Attempted to allocated a second instance_______PV_view_sql");
    _PV_view_sql = [super alloc];
    return _PV_view_sql;
  }
  return nil;
}

- (id)init {
  self = [super init];
  if (self) {
  }
  return self;
}
//获取pv统计的，单条数据
- (NSDictionary *)PV_sql_data_view:(NSString *)pv_view {
  //    创建一条pv数据
  NSDictionary *pv_dic = @{
    @"ak" : ak_version,
    @"uid" : YouGu_User_USerid,
    @"code" : pv_view,
    @"vt" : TodayTimeToString()
  };

  return pv_dic;
}

//将数据存储到数据库中
- (void)PV_DB_DATA:(NSString *)pv_view {
  [[SQL_Data_Log_server sharedManager] saveUser:@"pvstat"
                                 andDescription:[self PV_sql_data_view:pv_view]];
}
@end
