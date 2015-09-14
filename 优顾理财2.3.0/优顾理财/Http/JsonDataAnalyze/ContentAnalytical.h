//
//  ContentAnalytical.h
//  SimuStock
//
//  Created by moulin wang on 14-5-27.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContentAnalytical : NSObject
//获取标记里的内容
- (NSMutableArray *)getMarkContent:(NSString *)content;
@end
