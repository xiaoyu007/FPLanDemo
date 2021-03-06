//
//  Globle.h
//  SlideSwitchDemo
//
//  Created by liulian on 13-4-23.
//  Copyright (c) 2013年 liulian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Globle : NSObject

@property(nonatomic, assign) float globleWidth;
@property(nonatomic, assign) float globleHeight;
@property(nonatomic, assign) float globleAllHeight;

+ (Globle *)shareInstance;
/** 自定义色值（16进制） */
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;
/** 自定义色值（16进制） + 透明度 */
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString withAlpha:(float)alpha;

@end
