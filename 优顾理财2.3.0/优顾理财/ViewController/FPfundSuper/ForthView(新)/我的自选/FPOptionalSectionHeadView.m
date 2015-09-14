//
//  OptionalSectionHeadView.m
//  优顾理财
//
//  Created by Mac on 15-4-19.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPOptionalSectionHeadView.h"

@implementation FPOptionalSectionHeadView

- (void)awakeFromNib {
  _cuttingLineView.frame = CGRectMake(0, 59.5f, windowWidth, 0.5f);
}

@end
