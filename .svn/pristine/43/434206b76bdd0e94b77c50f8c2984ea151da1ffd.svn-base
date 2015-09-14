//
//  ContentAnalytical.m
//  SimuStock
//
//  Created by moulin wang on 14-5-27.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "ContentAnalytical.h"
#import "NSString+HTML.h"
@implementation ContentAnalytical
/*
 * html分离正则
 public final static String TAGS = "[^<>]+|<(\"[^\"]*\"|'[^']*'|[^'\">])*>";
 * html正则
 public final static String HTML_TAG = "<(?:.|\\s)*?>";

 public static final Pattern tagNamePattern =
 Pattern.compile("<[\\s]*([^\\s]+)",Pattern.DOTALL);

 public static final Pattern attrPattern =
 Pattern.compile("([^\\s]*)=\\s*\"([^\"]*)\"",Pattern.DOTALL);
 */
- (NSMutableArray *)getMarkContent:(NSString *)content {
  NSMutableArray *mutArr = [[NSMutableArray alloc] init];
  //标记类型
  NSInteger speciesInt = 0;
  //标记类型
  NSArray *speciesArr = @[
    @"<stock",
    @"<user",
    @"<atuser",
    @"<lbslon",
    @"<a",
    @"<font",
    @"<match"
  ];
  for (NSString *speciesStr in speciesArr) {
    speciesInt += 1;
    //判断字符串是否包含
    NSRange range = [content rangeOfString:speciesStr];
    if (range.location == NSNotFound) {

      if (speciesInt == 7) {
        speciesInt = 0;
      }
      continue;
    } else {
      [mutArr addObject:speciesStr];
      break;
    }
  }
  if (speciesInt) //包含
  {
    NSRegularExpression *Regular = [NSRegularExpression
        regularExpressionWithPattern:@"[^<>]+|<(\"[^\"]*\"|'[^']*'|[^'\">])*>"
                             options:NSRegularExpressionCaseInsensitive
                               error:nil];
    NSArray *array = nil;
    array = [Regular matchesInString:content
                             options:0
                               range:NSMakeRange(0, [content length])];
    NSMutableArray *interceptionArr =
        [self returnsArrayOfInterception:array
                                 content:content
                             speciestype:speciesInt];
    if (interceptionArr) {
      [mutArr addObject:interceptionArr];
    }
  } else //不包含
  {
    return nil;
  }
  return mutArr;
}
//返回截取的数组
- (NSMutableArray *)returnsArrayOfInterception:(NSArray *)array
                                       content:(NSString *)content
                                   speciestype:(NSInteger)speciestype {
  NSMutableArray *arr = [[NSMutableArray alloc] init];
  for (NSTextCheckingResult *b in array) {
    // str1 是每个和表达式匹配好的字符串。
    NSString *str = nil;
    str = [content substringWithRange:b.range];
    //判断字符串是否包含
    NSRange range = [str rangeOfString:@"<"];
    if (range.location == NSNotFound) {
      [arr addObject:str];
    } else {
      NSRegularExpression *regul = [NSRegularExpression
          regularExpressionWithPattern:@"([^\\s]*)=\\s*\"([^\"]*)\""
                               options:NSRegularExpressionCaseInsensitive
                                 error:nil];
      NSArray *regularArr = nil;
      regularArr = [regul matchesInString:str
                                  options:0
                                    range:NSMakeRange(0, [str length])];
      if (speciestype == 1) //股票：
      {
        NSMutableDictionary *stockDirectory = [self stock:regularArr str:str];
        if (stockDirectory) {
          [arr addObject:stockDirectory];
        }
      } else if (speciestype == 2) //用户:
      {
        NSMutableDictionary *stockDirectory = [self user:regularArr str:str];
        if (stockDirectory) {
          [arr addObject:stockDirectory];
        }
      } else if (speciestype == 3) //@用户:
      {
        NSMutableDictionary *stockDirectory = [self atuser:regularArr str:str];
        if (stockDirectory) {
          [arr addObject:stockDirectory];
        }
      } else if (speciestype == 4) //位置:
      {

      } else if (speciestype == 5) //网页：
      {

      } else if (speciestype == 6) //字体:
      {
        NSMutableDictionary *stockDirectory = [self font:regularArr str:str];
        if (stockDirectory) {
          [arr addObject:stockDirectory];
        }
      } else if (speciestype == 7) //系统通知:
      {
        NSMutableDictionary *stockDirectory = [self match:regularArr str:str];
        if (stockDirectory) {
          [arr addObject:stockDirectory];
        }
      }
    }
  }
  if ([arr count] == 0) {
    return nil;
  }
  return arr;
}

#pragma mark-------
//股票：<stock code=”11600000” name=”民生银行”/>
- (NSMutableDictionary *)stock:(NSArray *)arr str:(NSString *)str {
  NSMutableDictionary *diction = [[NSMutableDictionary alloc] init];
  for (NSTextCheckingResult *check in arr) {
    NSString *str1 = nil;
    str1 = [str substringWithRange:check.range];
    if ([str1 rangeOfString:@"name"].length > 0) {
      NSArray *array = [str1 componentsSeparatedByString:@"\""];
      if ([array count] >= 1) {
        diction[@"name"] = array[1];
      }
    } else if ([str1 rangeOfString:@"code"].length > 0) {
      NSArray *array = [str1 componentsSeparatedByString:@"\""];
      if ([array count] >= 1) {
        diction[@"code"] = array[1];
      }
    }
  }
  if (diction.count < 2) {
    return nil;
  }
  return diction;
}
//用户:  <user uid=”123” nick=”失踪”/>
- (NSMutableDictionary *)user:(NSArray *)arr str:(NSString *)str {
  NSMutableDictionary *diction = [[NSMutableDictionary alloc] init];
  for (NSTextCheckingResult *check in arr) {
    NSString *str1 = nil;
    str1 = [str substringWithRange:check.range];
    if ([str1 rangeOfString:@"uid"].length > 0) {
      NSArray *array = [str1 componentsSeparatedByString:@"\""];
      if ([array count] >= 1) {
        diction[@"uid"] = array[1];
      }
    } else if ([str1 rangeOfString:@"nick"].length > 0) {
      NSArray *array = [str1 componentsSeparatedByString:@"\""];
      if ([array count] >= 1) {
        NSString *nick = [NSString stringWithFormat:@"%@", array[1]];
        nick = [nick stringByDecodingHTMLEntities];
        diction[@"nick"] = nick;
      }
    }
  }
  if (diction.count < 2) {
    return nil;
  }
  return diction;
}

//@用户: <atuser uid=”123” nick=”失踪”/>
- (NSMutableDictionary *)atuser:(NSArray *)arr str:(NSString *)str {
  NSMutableDictionary *diction = [[NSMutableDictionary alloc] init];
  for (NSTextCheckingResult *check in arr) {
    NSString *str1 = nil;
    str1 = [str substringWithRange:check.range];
    if ([str1 rangeOfString:@"uid"].length > 0) {
      NSArray *array = [str1 componentsSeparatedByString:@"\""];
      if ([array count] >= 1) {
        diction[@"uid"] = array[1];
      }
    } else if ([str1 rangeOfString:@"nick"].length > 0) {
      NSArray *array = [str1 componentsSeparatedByString:@"\""];
      if ([array count] >= 1) {
        NSString *nick = [NSString stringWithFormat:@"@%@", array[1]];
        nick = [nick stringByDecodingHTMLEntities];
        diction[@"nick"] = nick;
      }
    }
  }
  if (diction.count < 2) {
    return nil;
  }
  return diction;
}

//字体:<font size=”12” color=”#666666” text=”文字”  style=”bold”/>
- (NSMutableDictionary *)font:(NSArray *)arr str:(NSString *)str {
  NSMutableDictionary *diction = [[NSMutableDictionary alloc] init];
  for (NSTextCheckingResult *check in arr) {
    NSString *str1 = nil;
    str1 = [str substringWithRange:check.range];
    if ([str1 rangeOfString:@"size"].length > 0) {
      NSArray *array = [str1 componentsSeparatedByString:@"\""];
      if ([array count] >= 1) {
        diction[@"size"] = array[1];
      }
    } else if ([str1 rangeOfString:@"color"].length > 0) {
      NSArray *array = [str1 componentsSeparatedByString:@"\""];
      if ([array count] >= 1) {
        NSString *color = [NSString stringWithFormat:@"%@", array[1]];
        diction[@"color"] = color;
      }
    } else if ([str1 rangeOfString:@"text"].length > 0) {
      NSArray *array = [str1 componentsSeparatedByString:@"\""];
      if ([array count] >= 1) {
        NSString *text = [NSString stringWithFormat:@"%@", array[1]];
        text = [text stringByDecodingHTMLEntities];
        diction[@"text"] = text;
      }
    } else if ([str1 rangeOfString:@"style"].length > 0) {
      NSArray *array = [str1 componentsSeparatedByString:@"\""];
      if ([array count] >= 1) {
        NSString *style = [NSString stringWithFormat:@"%@", array[1]];
        diction[@"style"] = style;
      }
    }
  }
  if (diction.count < 2) {
    return nil;
  }
  return diction;
}

//炒股大赛：<match id=”12” text=”比赛名称”/>
- (NSMutableDictionary *)match:(NSArray *)arr str:(NSString *)str {
  NSMutableDictionary *diction = [[NSMutableDictionary alloc] init];
  for (NSTextCheckingResult *check in arr) {
    NSString *str1 = nil;
    str1 = [str substringWithRange:check.range];
    if ([str1 rangeOfString:@"id"].length > 0) {
      NSArray *array = [str1 componentsSeparatedByString:@"\""];
      if ([array count] >= 1) {
        diction[@"id"] = array[1];
      }
    } else if ([str1 rangeOfString:@"text"].length > 0) {
      NSArray *array = [str1 componentsSeparatedByString:@"\""];
      if ([array count] >= 1) {
        NSString *str2 = array[1];
        str2 = [str2 stringByDecodingHTMLEntities];
        diction[@"text"] = str2;
      }
    }
  }
  if (diction.count < 2) {
    return nil;
  }

  return diction;
}

@end
