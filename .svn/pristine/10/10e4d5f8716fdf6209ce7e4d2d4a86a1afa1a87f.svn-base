//
//  UserDataSaveToDefault.m
//  优顾理财
//
//  Created by jhss on 15-4-28.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "UserDataSaveToDefault.h"

@implementation UserDataSaveToDefault
///登入成功以后,做数据处理和存储
+ (void)saveUserToData:(NSDictionary *)dic {
  //  //           已经绑定过了，直接登陆
  UserListItem *item = [[UserListItem alloc] init];
  [item jsonToObject:dic];
  ///保存当前用户登录的信息
  [FileChangelUtil saveUserListItem:item];
}

///登入成功后，发送的所有消息中心
+ (void)sendNotificationCenter {
  //             刷新收藏列表
  [[NSNotificationCenter defaultCenter] postNotificationName:@"Main_Collect_refrash_VC" object:nil];
  //            收藏回调
  [[PraiseObject sharedManager] reloadPraiseArray];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginNotificationCenter" object:nil];
}

///获取保存用户 登录成功后的用户名
+ (NSArray *)getArrayLogiWithNickname:(NSString *)nickname {
  NSMutableArray *array =
      [[NSMutableArray alloc] initWithContentsOfFile:pathInCacheDirectory(@"Login_nickname.plist")];
  if (!nickname) {
    return array;
  }
  NSMutableArray *mArray = [[NSMutableArray alloc] init];
  [array enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
    if ([obj isEqualToString:nickname]) {
    } else {
      [mArray addObject:obj];
    }
  }];
  [mArray insertObject:nickname atIndex:0];
  if (mArray.count > 5) {
    NSArray *dArray = [mArray subarrayWithRange:NSMakeRange(0, 5)];
    [mArray removeAllObjects];
    [mArray addObjectsFromArray:dArray];
  }
  [mArray writeToFile:pathInCacheDirectory(@"Login_nickname.plist") atomically:YES];
  return mArray;
}
@end
