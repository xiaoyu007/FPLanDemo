//
//  SQL_Data_Log_server.h
//  DDMenuController
//
//  Created by moulin wang on 13-9-3.
//
//

#import <Foundation/Foundation.h>
#import "FMDatabaseAdditions.h"
#import "FMDatabase.h"

@interface SQL_Data_Log_server : NSObject {

  FMDatabase *_db;
  NSString *_name;
}
+ (SQL_Data_Log_server *)sharedManager;
+ (id)alloc;
- (id)init;
/**
 * @brief 创建数据库
 */
- (void)createDataBase;

/**
 * @brief 保存一条用户记录
 *
 * @param user 需要保存的用户数据
 */
- (void)saveUser:(NSString *)name andDescription:(NSDictionary *)description;

/**
 * @brief 删除一条用户数据
 *
 * @param uid 需要删除的用户的id
 */
- (void)deleteUserWithId:(NSString *)uid;

/**
 * @brief 模拟分页查找数据。取uid大于某个值以后的limit个数据
 *
 * @param uid
 * @param limit 每页取多少个
 */
- (NSArray *)findWithUid; //:(NSString *) name;

///**
// *   事件的点击统计，
// *
// *
// *   取消数据库的数据，修改事件的点击次数
// *
// **/
//-(void)Modification_Data_Click:(int)code_event;
@end
