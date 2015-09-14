//
//  NewsIdWithDidRead.m
//  优顾理财
//
//  Created by Mac on 15/8/24.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "NewsIdWithDidRead.h"
static NewsIdWithDidRead *_newsIdReadManager;
@implementation NewsIdWithDidRead
+ (NewsIdWithDidRead *)sharedManager {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _newsIdReadManager = [[NewsIdWithDidRead alloc] init];
    _newsIdReadManager.array = [[NSMutableArray alloc] init];
    NewsIdWithDidRead *object = [FileChangelUtil loadDidReadWithNews];
    if (object.array && object.array.count > 0) {
      [_newsIdReadManager.array addObjectsFromArray:object.array];
    }
  });
  return _newsIdReadManager;
}
- (NSArray *)getArray {
  return _array;
}

- (NSDictionary *)mappingDictionary {
  return @{ @"array" : NSStringFromClass([NewsWithItem class]) };
}

- (id)init {
  self = [super init];
  if (self) {
    //登陆成功，刷新赞的数据
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateWithArray)
                                                 name:@"LoginNotificationCenter"
                                               object:nil];
  }
  return self;
}
///当切换用户的时候从新获取数据
- (void)updateWithArray {
  [self.array removeAllObjects];
  NewsIdWithDidRead *object = [FileChangelUtil loadDidReadWithNews];
  if (object && object.array.count > 0) {
    [self.array addObjectsFromArray:object.array];
  }
}

///是否看过
- (BOOL)isReadNewsWithID:(NewsWithItem *)item {
  if (item) {
    for (NewsWithItem *obj in self.array) {
      if ([obj.newsId isEqualToString:item.newsId] && obj.type == item.type) {
        ///看看缓存数据中是否有这个数据
        return YES;
//        if ([[NewsArrayWithALLNewsId sharedManager] isReadNewsWithID:item]) {
//          return YES;
//        } else {
//          ///如何缓存数据已经被删除，那么该文章修改成未读
//          [self removeWithId:item];
//          return NO;
//        }
      }
    }
  } else {
    NSLog(@"测试的NewsWithItem为空");
  }
  return NO;
}

- (void)addNewsId:(NewsWithItem *)item {
  if (item && item.newsId.length > 0) {
    if (![self isReadNewsWithID:item]) {
       [self.array addObject:item];
    }
//    [self.array removeObject:item];
  }
}
- (void)removeWithId:(NewsWithItem *)item {
  if (item && item.newsId.length > 0) {
    [self.array removeObject:item];
  }
}
///删除所有新闻缓存
- (void)delegateAllNewsID {
  for (NewsWithItem *item in self.array) {
    [FileChangelUtil removeNewsDetailInfoWithNewsId:item.newsId];
  }
}

- (void)dealloc {
  [FileChangelUtil saveDidReadWithNews:self];
}
@end
