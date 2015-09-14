//
//  NewsWithDidCollect.m
//  优顾理财
//
//  Created by Mac on 15/8/25.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "NewsWithDidCollect.h"
static NewsWithDidCollect *_newsIdCollectManager;
@implementation NewsWithDidCollect
+ (NewsWithDidCollect *)sharedManager {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _newsIdCollectManager = [[NewsWithDidCollect alloc] init];
    _newsIdCollectManager.array = [[NSMutableArray alloc] init];
    NewsWithDidCollect * list =[FileChangelUtil loadDidCollectWithNewsId];
    if (list && list.array.count>0) {
       [_newsIdCollectManager.array addObjectsFromArray:list.array];
    }
  });
  return _newsIdCollectManager;
}
- (NSArray *)getArray {
  return _array;
}

- (NSDictionary *)mappingDictionary {
  return @{ @"array" : NSStringFromClass([MyCollectItem class]) };
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
  [FPYouguUtil performBlockOnGlobalThread:^{
    [self requestData];
  } withDelaySeconds:0.1];
}
- (void)requestData {
  HttpRequestCallBack *callback = [[HttpRequestCallBack alloc] init];
  __weak NewsWithDidCollect * selfStrong = self;
  callback.onSuccess = ^(NSObject *obj) {
    NewsWithDidCollect * weakSelf = selfStrong;
    if (weakSelf) {
      NewsWithDidCollect *object = (NewsWithDidCollect *)obj;
      if (object && object.array.count > 0) {
        [self.array addObjectsFromArray:object.array];
      }
    }
  };
  [MyCollectRequest myCollectWithCallback:callback];
}

///是否看过
- (BOOL)isCollectWithNewsID:(MyCollectItem *)item {
  if (item) {
    for (MyCollectItem *obj in self.array) {
      if (obj.type == item.type && [obj.newsId isEqualToString:item.newsId]) {
        item.fid = obj.fid;
        item.title = obj.title;
        item.lastTime = obj.lastTime;
        return YES;
      }
    }
    return NO;
  } else {
    NSLog(@"收藏文本为空");
  }

  return NO;
}

- (void)addNewsId:(MyCollectItem *)item {
  if (item && item.newsId.length > 0) {
    if (![self isCollectWithNewsID:item]) {
      [self.array addObject:item];
      [FileChangelUtil saveDidCollectWithNewsId:self];
    }
  }
}
- (void)removeWithId:(MyCollectItem *)item {
  if (item && item.newsId.length > 0) {
    NSArray *mArray = [self.array copy];
    [mArray enumerateObjectsUsingBlock:^(MyCollectItem *obj, NSUInteger idx, BOOL *stop) {
      if (obj.type == item.type && [obj.newsId isEqualToString:item.newsId]) {
        [self.array removeObjectAtIndex:idx];
        [FileChangelUtil saveDidCollectWithNewsId:self];
        *stop = YES;
      }
    }];
  }
}
///删除所有新闻收藏
- (void)delegateAllNewsID {
  [self.array removeAllObjects];
  [FileChangelUtil saveDidCollectWithNewsId:self];
}
@end
