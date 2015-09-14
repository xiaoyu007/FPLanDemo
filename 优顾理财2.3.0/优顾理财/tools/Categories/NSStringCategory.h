#import <Foundation/Foundation.h>
#import <regex.h>

//为NSString正则扩展类
@interface NSStringCategory : NSObject {
  regex_t preg;
}

- (id)initWithPattern:(NSString *)pattern options:(int)options;
- (void)dealloc;

- (BOOL)matchesString:(NSString *)string;
- (NSString *)matchedSubstringOfString:(NSString *)string;
- (NSArray *)capturedSubstringsOfString:(NSString *)string;

+ (NSStringCategory *)regexWithPattern:(NSString *)pattern options:(int)options;
+ (NSStringCategory *)regexWithPattern:(NSString *)pattern;

+ (NSString *)null;

+ (void)initialize;

@end

//************************************
// NSString扩展类
// 1，添加正则匹配方法
// 2，添加Bases64编码与解码
@interface NSString (NSStringCategory)

//返回是否匹配字串
// pattern:匹配正则表达式
// options:匹配正则选项，如：REG_NOSUB,REG_ICASE
- (BOOL)matchedByPattern:(NSString *)pattern options:(int)options;

//返回是否匹配字串
// patter:匹配正则表达式
- (BOOL)matchedByPattern:(NSString *)pattern;

//返回匹配的字串
// pattern:匹配正则表达式
// options:匹配正则选项，如：REG_NOSUB,REG_ICASE
- (NSString *)substringMatchedByPattern:(NSString *)pattern
                                options:(int)options;

//返回匹配字串
// patter:匹配正则表达式
- (NSString *)substringMatchedByPattern:(NSString *)pattern;

//返回所有匹配字串的数组
// pattern:匹配正则表达式
// options:匹配正则选项，如：REG_NOSUB,REG_ICASE
- (NSArray *)substringsCapturedByPattern:(NSString *)pattern
                                 options:(int)options;

//返回所有匹配字串的数组
// pattern:匹配正则表达式
- (NSArray *)substringsCapturedByPattern:(NSString *)pattern;

//返回处理后特殊字符字串
//如："hello.com"返回"hello\.com"
- (NSString *)escapedPattern;

//返回Base64编码字串
- (NSString *)base64Encode;

//返回Base64解码后的字串
- (NSString *)base64DecodeAsString;

//返回Base64解码后的NSData对象
- (NSData *)base64Decode;

+ (NSString *)longToString:(int64_t)v;

- (NSString *)getSecuString;

- (NSString *)getStrMayBase64;

- (NSString *)getxxTeaBase64SecuString;

/** 是否为数字（0-9）构成的字符串*/
- (BOOL)isNumber;

/** 是否为字母（A-Za-Z）构成的字符串*/
- (BOOL)isLetter;

/** 是否为数字和字母（0-9A-Za-Z）构成的字符串*/
- (BOOL)isNumberOrText;

/** 返回字符串的md5 */
- (NSString *)md5:(NSString *)str;

// utf8编解码
- (NSString *)URLEncodedString;

// utf8解码
- (NSString *)URLDecodedString;

@end