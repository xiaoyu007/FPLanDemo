//
//  DataArray.m
//  SimuStock
//
//  Created by Mac on 14-10-27.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "DataArray.h"

@implementation DataArray

- (id)init {
  self = [super init];
  if (self) {
    self.array = [[NSMutableArray alloc] init];
    self.dataBinded = NO;
    self.dataComplete = NO;
  }
  return self;
}

- (void)reset {
  [self.array removeAllObjects];
  self.dataBinded = NO;
  self.dataComplete = NO;
}
@end
