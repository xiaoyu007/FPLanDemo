//
//  FTLabel.m
//  优顾理财
//
//  Created by Mac on 15/8/21.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FTLabel.h"
// static int LIMIT_LINES = 3;
// static CGFloat FONT_SIZE = 18.f;
// static CGFloat LINE_SPACING = 15.f;
@implementation FTLabel
#pragma mark - init初始化函数
- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    self.fontSize = self.font;
    self.lineLimit = 3;
    self.linsSpacing = 10;
    self.nameColor = [Globle colorFromHexRGB:@"14a5f0"];
    self.mainColor = self.textColor;
  }
  return self;
}
#pragma mark - 算高度的方法
+ (FTLabel *)CreatFTLabel {
  FTLabel *label =
      [[FTLabel alloc] initWithFrame:CGRectMake(0, 0, windowWidth - 75, 0)];
  label.fontSize = [UIFont systemFontOfSize:15.0];
  label.lineLimit = 3;
  label.linsSpacing = 10;
  label.nameColor = [Globle colorFromHexRGB:@"14a5f0"];
  return label;
}
static FTLabel *ftLabel = nil;
+ (CGFloat)getLableHeightWithText:(NSString *)text {
  return [FTLabel getLableHeightWithText:text andTitle:nil];
}
+ (CGFloat)getLableHeightWithText:(NSString *)text andTitle:(NSString *)title {
  if (!ftLabel) {
    ftLabel = [FTLabel CreatFTLabel];
  }
  if (title && title.length>0) {
    ftLabel.lineLimit = 2;
  } else {
    ftLabel.lineLimit = 3;
  }
  return [FTLabel addNewLabel:text andLable:ftLabel];
}
+ (CGFloat)addNewLabel:(NSString *)text andLable:(FTLabel *)label {
  UILabel *measureLable = [[UILabel alloc] init];
  measureLable.font = label.fontSize;
  measureLable.frame = CGRectMake(0, 0, label.size.width, 0);
  NSInteger rows = [label rowsOfContent:text withUILable:measureLable];
  CGFloat cellHeight = [label heightOfCellWithRows:rows
                                     withLimitLine:label.lineLimit
                                    withFontHeight:label.fontSize.pointSize
                                   withLineSpacing:label.linsSpacing];
  //  NSLog(@"row = %@, cellHeight = %@", @(rows), @(cellHeight));
  return cellHeight;
}
#pragma mark - 文本显示的行数
- (NSInteger)rowsOfContent:(NSString *)content withUILable:(UILabel *)label {
  CGSize size =
      [content sizeWithFont:label.font
          constrainedToSize:CGSizeMake(label.bounds.size.width, NSIntegerMax)
              lineBreakMode:NSLineBreakByWordWrapping];

  return floor(size.height / label.font.pointSize);
}
#pragma mark - 限制行数情况下Label的高度
- (CGFloat)heightOfCellWithRows:(NSInteger)rows
                  withLimitLine:(NSInteger)limitLine
                 withFontHeight:(CGFloat)fontHeight
                withLineSpacing:(CGFloat)lineSpacing {

  NSInteger suggestRows;
  if (rows == 0) {
    suggestRows = 1;
  } else if (rows <= limitLine) {
    suggestRows = rows;
  } else {
    suggestRows = limitLine;
  }
  return fontHeight * suggestRows + lineSpacing * (suggestRows + 0.5);
}
#pragma mark - 给Label加行间距
- (void)setOfUILablewithContent:(NSString *)content {
  [self setOfUILableWithLimitLine:self.lineLimit
                         withFont:self.fontSize
                  withLineSpacing:self.linsSpacing
                      withContent:content];
}
- (void)setOfUILableWithLimitLine:(NSInteger)numberOfLines
                         withFont:(UIFont *)font
                  withLineSpacing:(CGFloat)lineSpacing
                      withContent:(NSString *)content {
  if (content && content.length > 0) {
    NSMutableParagraphStyle *paragraphStyle =
        [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.minimumLineHeight = font.pointSize + lineSpacing;
    paragraphStyle.maximumLineHeight = font.pointSize + lineSpacing;
    NSDictionary *nameAttributes = @{
      NSParagraphStyleAttributeName : paragraphStyle,
      NSBaselineOffsetAttributeName : @(numberOfLines),
      NSFontAttributeName : font,
    };
    NSMutableAttributedString *string =
        [[NSMutableAttributedString alloc] initWithString:content
                                               attributes:nameAttributes];
    ;
    if (_nameNick && _nameNick.length > 0) {
      NSRange range = NSMakeRange(0, _nameNick.length);
      [string addAttribute:NSForegroundColorAttributeName
                     value:self.nameColor
                     range:range];
      [string addAttribute:NSForegroundColorAttributeName
                     value:self.mainColor
                     range:NSMakeRange(_nameNick.length,
                                       content.length - _nameNick.length)];
    } else {

      [string addAttribute:NSForegroundColorAttributeName
                     value:self.mainColor
                     range:NSMakeRange(0, content.length)];
    }
    self.attributedText = string;
    self.lineBreakMode = NSLineBreakByTruncatingTail;
  } else {
    NSLog(@"FTlable的内容为空");
  }
}
@end
