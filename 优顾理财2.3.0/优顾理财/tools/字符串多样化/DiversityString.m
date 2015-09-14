//
//  DiversityString.m
//  优顾理财
//
//  Created by Mac on 15-5-12.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "DiversityString.h"
#import <CoreText/CoreText.h>
@implementation DiversityString

- (id)init {
  self = [super init];
  if (self) {
  }
  return self;
}
- (NSAttributedString *)showFundWithFundName:(NSString *)fundName
                                  withFundId:(NSString *)fundId {
  NSString *jointStr = [NSString stringWithFormat:@"%@ %@", fundName, fundId];
  NSRange nameRange = [jointStr rangeOfString:fundName];
  NSRange fundidRange = [jointStr rangeOfString:fundId];
  //基金名称
  [self addAttribute:(NSString *)kCTForegroundColorAttributeName
               value:(id)[Globle colorFromHexRGB:customFilledColor].CGColor
               range:nameRange];
  [self addAttribute:(NSString *)kCTFontAttributeName
               value:(id)CFBridgingRelease(CTFontCreateWithName(
                         (CFStringRef)[UIFont boldSystemFontOfSize:14].fontName,
                         14, NULL))
               range:nameRange];
  //基金代码
  [self addAttribute:(NSString *)kCTForegroundColorAttributeName
               value:(id)[Globle colorFromHexRGB:customFilledColor].CGColor
               range:fundidRange];
  [self addAttribute:(NSString *)kCTFontAttributeName
               value:(id)CFBridgingRelease(CTFontCreateWithName(
                         (CFStringRef)[UIFont boldSystemFontOfSize:14].fontName,
                         14, NULL))
               range:fundidRange];
  //段落
  CTParagraphStyleSetting lineBreakMode;
  CTLineBreakMode lineBreak = kCTLineBreakByCharWrapping; //换行模式
  lineBreakMode.spec = kCTParagraphStyleSpecifierLineBreakMode;
  lineBreakMode.value = &lineBreak;
  lineBreakMode.valueSize = sizeof(CTLineBreakMode);
  //行间距
  CTParagraphStyleSetting LineSpacing;
  CGFloat spacing = 4.0; //指定间距
  LineSpacing.spec = kCTParagraphStyleSpecifierLineSpacingAdjustment;
  LineSpacing.value = &spacing;
  LineSpacing.valueSize = sizeof(CGFloat);

  CTParagraphStyleSetting settings[] = {lineBreakMode, LineSpacing};
  //第二个参数为settings的长度
  CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(settings, 2);
  [self addAttribute:(NSString *)kCTParagraphStyleAttributeName
               value:(__bridge id)paragraphStyle
               range:NSMakeRange(0, self.length)];
  return self;
}

@end
