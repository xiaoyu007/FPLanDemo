//
//  NewsWithDidCollect.h
//  优顾理财
//
//  Created by Mac on 15/8/25.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "BaseRequestObject.h"
#import "MyCollectRequest.h"
@interface NewsWithDidCollect : JsonRequestObject
@property(nonatomic,strong) NSMutableArray * array;

+ (NewsWithDidCollect *)sharedManager;
///是否看过
-(BOOL)isCollectWithNewsID:(MyCollectItem *)item;
/** 添加一个新闻的收藏 **/
-(void)addNewsId:(MyCollectItem *)item;
/** 删除一个新闻的收藏 */
-(void)removeWithId:(MyCollectItem *)item;
///删除所有新闻收藏
- (void)delegateAllNewsID;
@end
