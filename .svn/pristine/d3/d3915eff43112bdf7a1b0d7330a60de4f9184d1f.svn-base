//
//  NewsIdWithDidRead.h
//  优顾理财
//
//  Created by Mac on 15/8/24.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "BaseRequester.h"
#import "NewsArrayWithALLNewsId.h"
//已读新闻
@interface NewsIdWithDidRead : JsonRequestObject
@property(nonatomic,strong) NSMutableArray * array;

+ (NewsIdWithDidRead *)sharedManager;
///是否看过
-(BOOL)isReadNewsWithID:(NewsWithItem *)item;
/** 添加一个新闻的缓存 **/
-(void)addNewsId:(NewsWithItem *)item;
/** 删除一个新闻的缓存 */
-(void)removeWithId:(NewsWithItem *)item;
@end
