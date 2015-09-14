//
//  RequesterForJsonData.h
//  SimuStock
//
//  Created by Mac on 14-8-27.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRequester.h"
#import "JSONKit.h"

@interface JsonFormatRequester : BaseRequester

/** 将二进制文件转化为json字典 */
+ (NSDictionary *)toDictionaryWithData:(NSData *)data;
@end
