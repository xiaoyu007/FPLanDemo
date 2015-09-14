//
//  PV_view_sql.h
//  DDMenuController
//
//  Created by moulin wang on 13-9-5.
//
//

#import <Foundation/Foundation.h>

@interface PV_view_sql : NSObject {
  NSString *my_pv_view;
}
@property(nonatomic, strong) NSString *my_pv_view;
+ (PV_view_sql *)sharedManager;
//获取pv统计的，单条数据
- (NSDictionary *)PV_sql_data_view:(NSString *)pv_view;
//将数据存储到数据库中
- (void)PV_DB_DATA:(NSString *)pv_view;
@end
