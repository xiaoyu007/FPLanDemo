//
//  SQL_Data_html_string.h
//  DDMenuController
//
//  Created by moulin wang on 13-8-17.
//
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
@interface SQL_Data_html_string : NSObject {

  FMDatabase *_db;
  //    FMDatabaseQueue * _db;
  NSString *_name;
}
+ (SQL_Data_html_string *)sharedManager;
+ (id)alloc;
- (id)init;

/**
 * @brief 创建数据库
 */
- (void)createDataBase;

/**
 * @brief 查看是否存在某条信息
 *
 * @param user 看看用户是否已经收藏的了改条信息
 */
- (BOOL)View_user_exists:(NSString *)name andChannlid:(NSString *)channlid;
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
  andSynchronous:(NSString *)sync;

/**
 * @brief 根据 name（新闻id） ，查找 fid（后台存储的 新闻id）
 *
 * @param uid 需要删除的用户的id
 */
- (NSString *)Search_UserWithfid:(NSString *)uid
                     andChannlid:(NSString *)channlid;
/**
 * @brief 删除一条用户数据
 *
 * @param uid 需要删除的用户的id
 */
- (void)deleteUserWithId:(NSString *)uid andChannlid:(NSString *)channlid;

/**
 * @brief 修改用户的信息
 *
 * @param user 需要修改的用户信息
 */
- (void)mergeWithUser:(NSString *)name
          andChannlid:(NSString *)channlid
        andadd_cancle:(NSString *)add_cancle
           andSync_is:(NSString *)sync;

- (void)deleteUser_ALL_WithId;
///**
// * @brief 修改用户的信息
// *
// * @param user 需要修改的用户信息
// */
//- (void) mergeWithUser:(NSString *)name andPraise:(int)praise;

/**
 * @brief 模拟分页查找数据。取uid大于某个值以后的limit个数据
 *
 * @param uid
 * @param limit 每页取多少个
 */
- (NSArray *)findWithALL_uids;

//判断是否已经赞过了
- (BOOL)PUser_zan:(NSString *)name;

//保存被赞过的文章id
- (void)save_PUser:(NSString *)name;

//删除被赞过的文章id
- (void)delete_PUser:(NSString *)name;
- (NSArray *)PUser_array;
@end
