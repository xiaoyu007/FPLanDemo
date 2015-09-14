//
//  NewsArrayWithALLNewsId.m
//  优顾理财
//
//  Created by Mac on 15/8/24.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "NewsArrayWithALLNewsId.h"
#import "FileChangelUtil.h"
@implementation NewsWithItem

- (id)initWithNewsId:(NSString *)newsId andType:(int)type {
  self = [super init];
  if (self) {
    self.type = type;
    self.newsId = newsId;
  }
  return self;
}

@end
static NewsArrayWithALLNewsId *_newsIdArrayManager;
@implementation NewsArrayWithALLNewsId
+ (NewsArrayWithALLNewsId *)sharedManager {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _newsIdArrayManager = [[NewsArrayWithALLNewsId alloc] init];
    _newsIdArrayManager.dic = [[NSMutableDictionary alloc] init];
    _newsIdArrayManager.array = [[NSMutableArray alloc] init];
    NewsArrayWithALLNewsId *object = [FileChangelUtil loadALLNewsId];
    if (object.array && object.array.count > 0) {
      _newsIdArrayManager.fileLength = object.fileLength;
      [_newsIdArrayManager.array addObjectsFromArray:object.array];
      [object.array enumerateObjectsUsingBlock:^(NewsWithItem *item, NSUInteger idx, BOOL *stop) {
        [_newsIdArrayManager.dic addEntriesFromDictionary:@{item.newsId : item.newsId}];
      }];
    }
  });
  return _newsIdArrayManager;
}
- (NSArray *)getArray {
  return _array;
}

- (NSDictionary *)mappingDictionary {
  return @{
    @"array" : NSStringFromClass([NewsWithItem class]),
    @"dic" : @{NSStringFromClass([NSString class]) : NSStringFromClass([NSString class])}
  };
}
///是否(已经缓存过)
- (BOOL)isReadNewsWithID:(NewsWithItem *)item {
  for (NewsWithItem *obj in self.array) {
    if ([obj.newsId isEqualToString:item.newsId] && item.type == obj.type) {
      return YES;
    }
  }
  return NO;
}
- (void)addItem:(NewsWithItem *)item andFileLength:(CGFloat)length andSaveObject:(BOOL)save {
  if (item && item.newsId.length > 0) {
    NSString *value = [self.dic objectForKey:item.newsId];
    if (!value) {
      self.fileLength += length;
      self.dic[item.newsId] = item.newsId;
      [self.array addObject:item];
     if (save) {
        [FileChangelUtil saveALLNewsIdData:self];
      }
    }
  }
}
- (void)addItem:(NewsWithItem *)item AndFileLength:(CGFloat)length {
  [self addItem:item andFileLength:length andSaveObject:YES];
}
- (void)removeWithItem:(NewsWithItem *)item {
  if (item && item.newsId.length > 0) {
    NSString *value = [self.dic objectForKey:item.newsId];
    if (value && value.length > 0) {
      [self.dic removeObjectForKey:item.newsId];
      [self.array removeObject:item];
      [FileChangelUtil saveALLNewsIdData:self];
    }
  }
}
///删除所有新闻缓存
- (void)delegateAllNewsID {
  NSArray *mArray = [_array copy];
  for (NewsWithItem *item in mArray) {
    if (item.type == 1) {
      [FileChangelUtil removeNewsDetailInfoWithNewsId:item.newsId];
    } else if (item.type == 2) {
      [FileChangelUtil removeKnowDetailInfoWithId:item.newsId];
    }
  }
  self.fileLength = 0;
  [self.dic removeAllObjects];
  [self.array removeAllObjects];
  [FileChangelUtil saveALLNewsIdData:self];
}

@end
