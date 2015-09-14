//
//  NSDataCategory.h
//  Author: Jory Lee
//
//  Created by dev on 09-9-29.
//  Copyright 2009 Netgen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (DataParser)

//************************************
//读取数据流中的单精度(4个字节的数据)
- (float)readFloatAt:(NSInteger)startIndex;

//************************************
//读取数据流中双精度(8个字节的数据)
- (double)readDoubleAt:(NSInteger)startIndex;

//************************************
//读取数据流中的整型数据(4个字节的数据)
- (int)readIntAt:(NSInteger)startIndex;

//************************************
//读取数据流中的整型数据(8个字节的数据)
- (int64_t)readInt64At:(NSInteger)startIndex;

//************************************
//读取数据流中的短整型数据(2个字节的数据)
- (short)readshortAt:(NSInteger)startIndex;

//************************************
//读取数据流中压缩整型数据(字节数不定)
- (int)readCompressIntAt:(NSNumber **)startIndex;

//************************************
//读取数据流中压缩long型数据(字节数不定)
- (int64_t)readCompressLongAt:(NSNumber **)startIndex;

//************************************
//读取数据流中压缩日期数据(4个字节的数据)
- (int64_t)readCompressDateTimeAt:(NSInteger)startIndex;

@end
