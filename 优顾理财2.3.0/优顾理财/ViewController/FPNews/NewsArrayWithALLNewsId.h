//
//  NewsArrayWithALLNewsId.h
//  优顾理财
//
//  Created by Mac on 15/8/24.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "BaseRequestObject.h"

@interface NewsWithItem : JsonRequestObject
/// ID类型 1 为新闻 2 为帖子
@property(nonatomic) int type;
///文章或帖子id
@property(nonatomic, strong) NSString *newsId;
- (id)initWithNewsId:(NSString *)newsId andType:(int)type;
@end

@interface NewsArrayWithALLNewsId : JsonRequestObject
@property(nonatomic, strong) NSMutableDictionary *dic;
@property(nonatomic, strong) NSMutableArray *array;
///缓存新闻的文件大小
@property(nonatomic) CGFloat fileLength;

+ (NewsArrayWithALLNewsId *)sharedManager;
///是否(已经下载缓存过了)
- (BOOL)isReadNewsWithID:(NewsWithItem *)item;
/** 添加一个新闻的缓存 **/
- (void)addItem:(NewsWithItem *)item andFileLength:(CGFloat)length andSaveObject:(BOOL)save;
- (void)addItem:(NewsWithItem *)item AndFileLength:(CGFloat)length;
/** 删除一个新闻的缓存 */
- (void)removeWithItem:(NewsWithItem *)item;
///删除所有新闻缓存
- (void)delegateAllNewsID;
@end
