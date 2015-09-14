//
//  PraiseObject.m
//  优顾理财
//
//  Created by Mac on 15/8/14.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "PraiseObject.h"

static PraiseObject *_praiseManager;

@implementation PraiseItem

@end

@implementation PraiseObject
- (void)jsonToObject:(NSDictionary *)dic {
  [super jsonToObject:dic];
}

- (NSArray *)getArray {
  return _array;
}

- (NSDictionary *)mappingDictionary {
  return @{ @"array" : NSStringFromClass([PraiseItem class]) };
}

+ (PraiseObject *)sharedManager {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _praiseManager = [[PraiseObject alloc] init];
    _praiseManager.array = [[NSMutableArray alloc] initWithCapacity:0];
    PraiseObject *object = [FileChangelUtil loadFPUserPraise];
    if (object && object.array.count > 0) {
      [_praiseManager.array addObjectsFromArray:object.array];
    }
  });
  return _praiseManager;
}

///当切换用户的时候从新获取数据
- (void)reloadPraiseArray {
  [self.array removeAllObjects];
  PraiseObject *object = [FileChangelUtil loadFPUserPraise];
  if (object && object.array.count > 0) {
    [_praiseManager.array addObjectsFromArray:object.array];
  }
}

- (void)addPraise:(int)type andTalkId:(NSString *)talkid {
  PraiseItem *item = [[PraiseItem alloc] init];
  item.talkId = talkid;
  item.type = type;
  item.userId = [FPYouguUtil getUserID];
  [self.array addObject:item];
  [FileChangelUtil saveFPUserPraise:self];
}

- (BOOL)isDonePraise:(NSString *)talkid {
  for (PraiseItem *item in self.array) {
    if (item) {
      if ([item.talkId isEqualToString:talkid]) {
        return YES;
      }
    }
  }
  return NO;
}
//-(void)dealloc
//{
//  [FileChangelUtil saveFPUserPraise:self];
//}
@end
