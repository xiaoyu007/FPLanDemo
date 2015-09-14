//
//  NSURL+QueryComponent.h
//  SimuStock
//
//  Created by Mac on 14/12/31.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (QueryComponent)

/** 返回query部分，以字典的方式 */
-(NSDictionary *)queryComponents;

@end
