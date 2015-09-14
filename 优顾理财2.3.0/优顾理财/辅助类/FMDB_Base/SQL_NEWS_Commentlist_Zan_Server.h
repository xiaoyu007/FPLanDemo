//
//  SQL_NEWS_Commentlist_Zan_Server.h
//  优顾理财
//
//  Created by Mac on 14-5-27.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "sqlite3.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabase.h"
@interface SQL_NEWS_Commentlist_Zan_Server : NSObject {

  FMDatabase *_db;
  NSString *_name;
}
+ (SQL_NEWS_Commentlist_Zan_Server *)sharedManager;
+ (id)alloc;
- (id)init;

/**
 * @brief 创建数据库
 */
- (void)createDataBase;

//判断是否已经赞过了
- (BOOL)PUser_zan:(NSString *)name;

//保存被赞过的文章id
- (void)save_PUser:(NSString *)name;

//删除被赞过的文章id
- (void)delete_PUser:(NSString *)name;
- (NSArray *)PUser_array;

@end
