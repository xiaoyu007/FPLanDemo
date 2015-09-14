//
//  BaseRequestObject.h
//  SimuStock
//
//  Created by Mac on 14-8-27.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark Protocol

/** 可以通过Json方式解析数据 */
@protocol ParseJson <NSObject>
- (void)jsonToObject:(NSDictionary *)dic;
@end

/** 可以以二进制流的方式解析 */
@protocol ParseStream <NSObject>
- (void)streamToObject:(NSData *)data;
@end

//逐点压缩二进制流Packet解析协议
@protocol ParseCompressPointPacket <NSObject>
- (void)packetCompressPointToObject:(NSMutableArray *)tableDataArray;
@end

/** 可以生成一个数据数组 */
@protocol Collectionable <NSObject>
- (NSArray *)getArray;
@end

@interface BaseRequestObject2 : NSObject

/** 使用字典初始化 */
- (id)initWithDictionary:(NSDictionary *)data;

/** 使用字典设置属性 */
- (void)setAttributes:(NSDictionary *)data;

/** 返回所有属性构成的字典 */
- (NSDictionary *)attributeMapDictionary;

/** 返回对象映射列表 */
- (NSDictionary *)mappingDictionary;

@end

#pragma mark BaseRequestObject

@interface BaseRequestObject : BaseRequestObject2

@property(nonatomic, strong) NSString *status;
@property(nonatomic, strong) NSString *message;

@end

#pragma mark JsonRequestObject

@interface JsonRequestObject : BaseRequestObject <ParseJson>

- (BOOL)isOK;

@end

@interface JsonErrorObject : JsonRequestObject

@property(nonatomic, strong) NSDictionary *errorDetailInfo;

@end
