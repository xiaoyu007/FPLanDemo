//
//  FTLabel.h
//  优顾理财
//
//  Created by Mac on 15/8/21.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTLabel : UILabel

///限制行数
@property(nonatomic) NSInteger  lineLimit;
///字体大小
@property(nonatomic,strong) UIFont * fontSize;
///行间距
@property(nonatomic) NSInteger linsSpacing;
///回复xx
@property(nonatomic,strong) NSString * nameNick;
///回复的颜色 color
@property(nonatomic,strong) UIColor * nameColor;
///内容的颜色
@property(nonatomic,strong) UIColor * mainColor;
////计算高度
+(CGFloat)getLableHeightWithText:(NSString *)text;
+ (CGFloat)getLableHeightWithText:(NSString *)text andTitle:(NSString *)title;
/** Label文本显示的行数 */
- (NSInteger)rowsOfContent:(NSString *)content withUILable:(UILabel *)label;
/** 给Label控件添加行间距 */
- (CGFloat)heightOfCellWithRows:(NSInteger)rows
                  withLimitLine:(NSInteger)limitLine
                 withFontHeight:(CGFloat)fontHeight
                withLineSpacing:(CGFloat)lineSpacing;

- (void)setOfUILablewithContent:(NSString *)content;
@end
