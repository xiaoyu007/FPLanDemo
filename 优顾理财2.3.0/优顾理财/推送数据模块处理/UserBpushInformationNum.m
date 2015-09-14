//
//  UserBpushInformationNum.m
//  SimuStock
//
//  Created by Mac on 15/3/18.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

//#import "RealTradeRequester.h"

@implementation UserBpushInformationNum

- (instancetype)init {
  if (self = [super init]) {
    self.unReadCountDic = [@{} mutableCopy];
    for (NSInteger i = UserBpushAllCount; i <= UserFundWarning; i++) {
      _unReadCountDic[@(i)] = @0;
    }
  }
  return self;
}

- (void)jsonToObject:(NSDictionary *)dic {
  [super jsonToObject:dic];

  NSDictionary *result = dic[@"result"];
  NSInteger count = [result[@"count"] integerValue];
  NSInteger commentCount = [result[@"commentCount"] integerValue];
  NSInteger mentionCount = [result[@"mentionCount"] integerValue];
  NSInteger followCount = [result[@"followCount"] integerValue];

  _unReadCountDic[@(UserBpushAllCount)] = @(count);
  _unReadCountDic[@(UsercommentCount)] = @(commentCount);
  _unReadCountDic[@(UsermentionCount)] = @(mentionCount);
  _unReadCountDic[@(UserReplyCount)] = @(followCount);

  ///服务端无法返回此三类提醒的未读数
  _unReadCountDic[@(UserSystemMessageCount)] = @(0);
  _unReadCountDic[@(UserFundWarning)] = @(0);
}

- (NSDictionary *)mappingDictionary {
  return @{
    @"unReadCountDic" : @{
      NSStringFromClass([NSNumber class]) : NSStringFromClass([NSNumber class])
    }
  };
}

- (void)computeUnReadSum {
  NSInteger sum = 0;
  for (NSInteger i = UsercommentCount; i <= UserFundWarning; i++) {
      sum += [_unReadCountDic[@(i)] integerValue];
  }
  _unReadCountDic[@(UserBpushAllCount)] = @(sum);
}
+ (void)resetUnReadAllCount {
  UserBpushInformationNum *savedCount =
      [UserBpushInformationNum getUnReadObject];
  [savedCount computeUnReadSum];
  [FileChangelUtil saveUserBpushInformationNum:savedCount];
}

- (NSInteger)getCount:(YLBpushType)type {
  NSNumber *unRead = _unReadCountDic[@(type)];
  return unRead ? [unRead integerValue] : 0;
}

+(void)clearAllUnReadCount
{
  UserBpushInformationNum *savedCount =
  [FileChangelUtil loadUserBpushInformationNum];
  for (YLBpushType i = UserBpushAllCount; i <= UserFundWarning; i++) {
    savedCount.unReadCountDic[@(i)] = @(0);
  }
  [FileChangelUtil saveUserBpushInformationNum:savedCount];
  [[NSNotificationCenter defaultCenter]postNotificationName:@"UnreadPushInfo" object:nil];
}

+ (void)clearUnReadCountWithMessageType:(YLBpushType)bpushType {
  UserBpushInformationNum *savedCount =
      [UserBpushInformationNum getUnReadObject];
  savedCount.unReadCountDic[@(bpushType)] = @(0);
  [savedCount computeUnReadSum];
  [FileChangelUtil saveUserBpushInformationNum:savedCount];
}

+ (void)increaseUnReadCountWithMessageType:(YLBpushType)bpushType {
//  if (bpushType == UsercommentCount || bpushType == UsermentionCount ||
//      bpushType == UserReplyCount) {
//    //此4种类型不直接增加，通过请求服务端未读数据+1
//    [UserBpushInformationNum requestUnReadStaticData];
//    return;
//  }
  UserBpushInformationNum *savedCount =
      [UserBpushInformationNum getUnReadObject];
  NSInteger sum = [savedCount getCount:bpushType] + 1;
  savedCount.unReadCountDic[@(bpushType)] = @(sum);
  [savedCount computeUnReadSum];
  [FileChangelUtil saveUserBpushInformationNum:savedCount];
}

///获取未读的统计数据
+ (UserBpushInformationNum *)getUnReadObject {
  UserBpushInformationNum *savedCount =
      [FileChangelUtil loadUserBpushInformationNum];
  if (savedCount == nil) {
    savedCount = [[UserBpushInformationNum alloc] init];
  }
  return savedCount;
}

@end
