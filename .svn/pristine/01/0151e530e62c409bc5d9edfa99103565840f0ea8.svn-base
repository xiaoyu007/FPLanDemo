//
//  PraiseObject.h
//  优顾理财
//
//  Created by Mac on 15/8/14.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "BaseRequestObject.h"
@interface PraiseItem : JsonRequestObject
@property(nonatomic, strong) NSString *userId;
@property(nonatomic, strong) NSString *talkId;
@property(nonatomic) int type;
@end

@interface PraiseObject : JsonRequestObject
@property(nonatomic, strong) NSMutableArray *array;
+ (PraiseObject *)sharedManager;
- (void)addPraise:(int)type andTalkId:(NSString *)talkid;
- (BOOL)isDonePraise:(NSString *)talkid;

///当切换用户的时候重新获取数据
- (void)reloadPraiseArray;
@end
