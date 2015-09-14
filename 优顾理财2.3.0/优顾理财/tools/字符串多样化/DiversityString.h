//
//  DiversityString.h
//  优顾理财
//
//  Created by Mac on 15-5-12.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiversityString : NSMutableAttributedString
//{
//  /** 可变字符串 */
//  NSMutableAttributedString *attriString;
//}
/** 基金名称和代码 */
- (NSMutableAttributedString *)showFundWithFundName:(NSString *)fundName
                                         withFundId:(NSString *)fundId;

@end
