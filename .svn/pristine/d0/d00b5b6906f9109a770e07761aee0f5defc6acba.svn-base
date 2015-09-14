//
//  Lineview.m
//  优顾理财
//
//  Created by Mac on 15/7/2.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "Lineview.h"

@implementation Lineview
-(id)initWithCoder:(NSCoder *)aDecoder
{
  self =[super initWithCoder:aDecoder];
  if (self) {
    //分割线
    UIView *line = [[UIView alloc]
                    initWithFrame:CGRectMake(0, 0,self.width, 0.5f)];
    line.backgroundColor = [Globle colorFromHexRGB:@"e6e6e6"];
    [self addSubview:line];
    UIView *lineDown = [[UIView alloc]initWithFrame:CGRectMake(0,0.5,self.width, 0.5f)];
    lineDown.backgroundColor = [Globle colorFromHexRGB:@"fafafa"];
    [self addSubview:lineDown];
  }
  return self;
}

-(id)initWithFrame:(CGRect)frame
{
  self =[super initWithFrame:frame];
  if (self) {
    //分割线
    UIView *line = [[UIView alloc]
                    initWithFrame:CGRectMake(0, 0,self.width, 0.5f)];
    line.backgroundColor = [Globle colorFromHexRGB:@"e6e6e6"];
    [self addSubview:line];
    UIView *lineDown = [[UIView alloc]initWithFrame:CGRectMake(0,0.5,self.width, 0.5f)];
    lineDown.backgroundColor = [Globle colorFromHexRGB:@"fafafa"];
    [self addSubview:lineDown];
  }
  return self;
}
@end
