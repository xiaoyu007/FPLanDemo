//
//  CommonFunc.m
//  DDMenuController
//
//  Created by moulin wang on 13-8-6.
//
//

//引入IOS自带密码库
#import <CommonCrypto/CommonCryptor.h>

//空字符串
#define     LocalStr_None           @""

//static char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
//static  char encodingTable[] ="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_-";
static  char * ard[]= {
    "789_-ABCDEFGHIJKLMNOPQRSTUVWXYZ6abcdefghijklmnopqrstuvwxyz501234",
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_-",
    "3456789_-ABCDEFGHIJKLMNOPQRSTUVWX2YZabcdefghijklmnopqr1stuvwxyz0",
    "-ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz9012345678",
    "_-ABCDEFGHIJKLMNOPQRSTUVWXYZ9abcdefghijklmnopqrstuvwxyz801234567",
    "9_-ABCDEFGHIJKLMNOPQRSTUVWXYZ8abcdefghijklmnopqrstuvwxyz70123456",
    "6789_-ABCDEFGHIJKLMNOPQRSTUVWXYZ5abcdefghijklmnopqrstuvwxyz40123",
    "89_-ABCDEFGHIJKLMNOPQRSTUVWXYZ7abcdefghijklmnopqrstuvwxyz6012345",
    "456789_-ABCDEFGHIJKLMNOPQRSTUVWXY3Zabcdefghijklmnopqrs2tuvwxyz01",
    "56789_-ABCDEFGHIJKLMNOPQRSTUVWXYZ4abcdefghijklmnopqrstuvwxyz3012" };
@implementation CommonFunc
+ (NSString *)base64StringFromText:(NSString *)text
{
    if (text && ![text isEqualToString:LocalStr_None]) {
        //取项目的bundleIdentifier作为KEY  改动了此处
        //NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
        //IOS 自带DES加密 Begin  改动了此处
        //data = [self DESEncrypt:data WithKey:key];
        //IOS 自带DES加密 End
        return [self base64EncodedStringFrom:data];
    }
    else {
        return @"~1";
    }
}

+ (NSString *)textFromBase64String:(NSString *)base64
{
     @synchronized(self)
    {
        if (base64 && ![base64 isEqualToString:LocalStr_None]) {
            //取项目的bundleIdentifier作为KEY   改动了此处
            //NSString *key = [[NSBundle mainBundle] bundleIdentifier];
            NSData *data = [self dataWithBase64EncodedString:base64];
            //IOS 自带DES解密 Begin    改动了此处
            //data = [self DESDecrypt:data WithKey:key];
            //IOS 自带DES加密 End
            return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        }
        else {
            return LocalStr_None;
        }
    }
}

/******************************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES加密
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/
+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer);
    return nil;
}

/******************************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES解密
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/
+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer);
    return nil;
}

/******************************************************************************
 函数名称 : + (NSData *)dataWithBase64EncodedString:(NSString *)string
 函数描述 : base64格式字符串转换为文本数据
 输入参数 : (NSString *)string
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 :
 ******************************************************************************/
+ (NSData *)dataWithBase64EncodedString:(NSString *)string
{
    if (string == nil)
        [NSException raise:NSInvalidArgumentException format:nil];
    if ([string length] == 0)
        return [NSData data];
    if ([string length]<=2) {
        return [NSData data];
    }
    
    const char *characters = [string cStringUsingEncoding:NSUTF8StringEncoding];
    if (characters[0]!='~') {
        return [string dataUsingEncoding: NSUTF8StringEncoding];
    }
    int nkey=characters[1]-'0';
    
    char *decodingTable = NULL;
    if (decodingTable == NULL)
    {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++)
            decodingTable[(short)ard[nkey][i]] = i;
    }
    
    
    
    if (characters == NULL)     //  Not an ASCII string!
    {
        free(decodingTable);
        return nil;
    }
    char *bytes = malloc((([string length] + 3) / 4) * 3);
    if (bytes == NULL){
        free(decodingTable);
        return nil;
    }
    NSUInteger length = 0;
    
    NSUInteger i = 2;
    while (YES)
    {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++)
        {
            if (characters[i] == '\0')
                break;
            if (isspace(characters[i]) || characters[i] == '*')
                continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
            {
                free(decodingTable);
                free(bytes);
                return nil;
            }
        }
        
        if (bufferLength == 0)
            break;
        if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
        {
            free(decodingTable);
            free(bytes);
            return nil;
        }
        
        //  Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2)
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3)
            bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    
    bytes = realloc(bytes, length);
    free(decodingTable);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}

///******************************************************************************
// 函数名称 : + (NSString *)base64EncodedStringFrom:(NSData *)data
// 函数描述 : 文本数据转换为base64格式字符串
// 输入参数 : (NSData *)data
// 输出参数 : N/A
// 返回参数 : (NSString *)
// 备注信息 :
// ******************************************************************************/
+ (NSString *)base64EncodedStringFrom:(NSData *)data
{
//    随机值，当key
    int key = arc4random() % 10;
    if ([data length] == 0)
        return @"";
    
    char *characters = malloc((([data length] + 2) / 3) * 4+2);
    if (characters == NULL)
        return nil;
    NSUInteger length = 2;
    characters[0]='~';
    characters[1]=key+'0';
    
    NSUInteger i = 0;
    while (i < [data length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = ard[key][(buffer[0] & 0xFC) >> 2];
        characters[length++] = ard[key][((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = ard[key][((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
       else characters[length++] = '*';
        if (bufferLength > 2)
            characters[length++] = ard[key][buffer[2] & 0x3F];
        else characters[length++] = '*';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSUTF8StringEncoding freeWhenDone:YES];
}
@end
