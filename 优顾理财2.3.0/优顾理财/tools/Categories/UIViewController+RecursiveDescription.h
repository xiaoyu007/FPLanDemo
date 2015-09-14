//
//  UIViewController+RecursiveDescription.h
//  SimuStock
//
//  Created by Mac on 15/2/13.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIViewController (RecursiveDescription)

/** 打印当前的UIViewController的层次关系 */
- (NSString *)recursiveDescription;

@end
