//
//  MyCollectRequest.h
//  优顾理财
//
//  Created by Mac on 15/8/25.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "BaseRequestObject.h"
@interface MyCollectItem : JsonRequestObject
///收藏类型 1.新闻，2.财知道
@property (nonatomic) int type;
///新闻或财知道id
@property(nonatomic,strong) NSString * newsId;
///后台，收藏的序列号
@property(nonatomic,strong) NSString * fid;
///标题或简介
@property(nonatomic,strong) NSString * title;
///最后修改的时间
@property(nonatomic,strong) NSString * lastTime;
///是否已读
@property(nonatomic) BOOL isreading;
///是否被选择（删除收藏用）
@property(nonatomic) BOOL isRemove;

+(MyCollectItem *)creatMyCollectWithObject:(NSString *)newsId AndType:(int)type andTitle:(NSString *)title;
@end

@interface MyCollectRequest : JsonRequestObject
@property(nonatomic,strong) NSMutableArray * array;
+ (void)myCollectWithCallback:(HttpRequestCallBack *)callback;
@end
