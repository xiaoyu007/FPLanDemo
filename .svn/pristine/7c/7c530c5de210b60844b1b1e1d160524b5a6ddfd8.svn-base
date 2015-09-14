//
//  NSDataCategory.m
//  Author: Jory Lee
//
//  Created by dev on 09-9-29.
//  Copyright 2009 Netgen. All rights reserved.
//

//---------------------------------------
//从字节数组读取长整型数据
// Byte* ds : 8个字节
// int index: 起始索引
static int64_t readInt64(const Byte *ds, int index) {
  int64_t temp;
  Byte mb[8];
  mb[0] = ds[index++];
  mb[1] = ds[index++];
  mb[2] = ds[index++];
  mb[3] = ds[index++];
  mb[4] = ds[index++];
  mb[5] = ds[index++];
  mb[6] = ds[index++];
  mb[7] = ds[index++];
  temp = (((int64_t)mb[0] & 0xff) << 56) | (((int64_t)mb[1] & 0xff) << 48) |
         (((int64_t)mb[2] & 0xff) << 40) | (((int64_t)mb[3] & 0xff) << 32) |
         (((int64_t)mb[4] & 0xff) << 24) | (((int64_t)mb[5] & 0xff) << 16) |
         (((int64_t)mb[6] & 0xff) << 8) | ((int64_t)mb[7] & 0xff);

  return temp;
}

//---------------------------------------
//从字节数组中读取双精度浮点数
// Byte* ds : 8个字节
// int index: 起始索引
static double readDouble(const Byte *ds, int index) {
  int64_t v = readInt64(ds, index);
  int64_t s = (v >> 63) == 0 ? 1 : -1, e = (v >> 52) & 0x7ff,
          m = (e == 0) ? (v & 0xfffffffffffff) << 1
                       : (v & 0xfffffffffffff) | 0x10000000000000;
  return s * m * (double)pow(2, e - 1075);
}

//---------------------------------------
//从字节数组中读取int类型数据
// Byte* ds : 4个字节
// int index: 起始索引
static int readInt(const Byte *ds, int index) {
  int temp;
  Byte mb[4];
  mb[0] = ds[index++];
  mb[1] = ds[index++];
  mb[2] = ds[index++];
  mb[3] = ds[index++];
  temp = (((int)mb[0] & 0xff) << 24) | (((int)mb[1] & 0xff) << 16) |
         (((int)mb[2] & 0xff) << 8) | ((int)mb[3] & 0xff);
  return temp;
}

//---------------------------------------
//从字节数中读取Float数据
// Byte *ds : 4个字节
// int index: 起始索引
static float readFloat(const Byte *ds, int index) {
  int v = readInt(ds, index);
  int s = (v >> 31) == 0 ? 1 : -1, e = (v >> 23) & 0xff,
      m = (e == 0) ? (v & 0x7fffff) << 1 : (v & 0x7fffff) | 0x800000;
  return s * m * (float)pow(2, e - 150);
}
//---------------------------------------
//从字节数中读取short数据
// Byte *ds : 2个字节
// int index: 起始索引
static short readshort(const Byte *ds, short index) {
  short temp;
  Byte mb[2];
  mb[0] = ds[index++];
  mb[1] = ds[index++];
  temp = (((int)mb[0] & 0xff) << 8) | ((int)mb[1] & 0xff);
  return temp;
}

//--------------------------------------
//从字节中读取压缩的INT数据
// Byte *ds : 不定字节数
// NSNumber** : 起始索引
static int readCompressInt(const Byte *ds, NSNumber **index) {
  int start_index = [(*index)intValue];
  int val = 0;
  Byte b[1];
  int ind = 0;

  do {
    b[0] = ds[start_index + ind];
    if (ind == 0 && (b[0] & 0x40) != 0) {
      val = 0xffffffff;
    }
    ind++;
    val = (val << 7) | (b[0] & 0x7f);
  } while ((b[0] & 0x80) == 0);
  (*index) = @(start_index + ind);
  return val;
}
//--------------------------------------
//从字节中读取压缩的Long数据
// Byte *ds : 不定字节数
// NSNumber** : 起始索引
static int64_t readCompressLong(const Byte *ds, NSNumber **index) {
  int start_index = [(*index)intValue];
  int64_t val = 0;
  Byte b[1];
  int ind = 0;
  do {
    b[0] = ds[start_index + ind];
    if (ind == 0 && (b[0] & 0x40) != 0) {
      val = 0xffffffffffffffffl;
    }
    ind++;
    val = (val << 7) | (b[0] & 0x7f);
  } while ((b[0] & 0x80) == 0);
  (*index) = @(start_index + ind);
  return val;
}

//--------------------------------------
//从字节中读取压缩的日期数据
// Byte *ds : 4个节数
// index: 起始索引
static int64_t readCompressDateTime(const Byte *ds, int index) {
  int temp;
  Byte mb[4];
  mb[0] = ds[index++];
  mb[1] = ds[index++];
  mb[2] = ds[index++];
  mb[3] = ds[index++];
  temp = (((int)mb[0] & 0xff) << 24) | (((int)mb[1] & 0xff) << 16) |
         (((int)mb[2] & 0xff) << 8) | ((int)mb[3] & 0xff);

  int intDateTime = temp;
  int minute = intDateTime & 0x3F;
  int hour = (intDateTime >> 6) & 0x1F;
  int day = (intDateTime >> 11) & 0x1F;
  int month = (intDateTime >> 16) & 0x0F;
  int year = (intDateTime >> 20) & 0x0FFF;

  long long longDateTime =
      ((long long)year) * 10000000000L + ((long long)month) * 100000000L +
      ((long long)day) * 1000000L + ((long long)hour) * 10000L +
      ((long long)minute) * 100L;
  return longDateTime;
}

@implementation NSData (DataParser)

- (float)readFloatAt:(NSInteger)startIndex {
  return readFloat([self bytes], (int)startIndex);
}

- (double)readDoubleAt:(NSInteger)startIndex {
  return readDouble([self bytes], (int)startIndex);
}

- (int)readIntAt:(NSInteger)startIndex {
  return readInt([self bytes], (int)startIndex);
}

- (short)readshortAt:(NSInteger)startIndex {
  return readshort([self bytes], startIndex);
}

- (int64_t)readInt64At:(NSInteger)startIndex {
  return readInt64([self bytes], (int)startIndex);
}
- (int)readCompressIntAt:(NSNumber **)startIndex {
  return readCompressInt([self bytes], startIndex);
}
- (int64_t)readCompressLongAt:(NSNumber **)startIndex {
  return readCompressLong([self bytes], startIndex);
}
- (int64_t)readCompressDateTimeAt:(NSInteger)startIndex {
  return readCompressDateTime([self bytes], (int)startIndex);
}

@end
