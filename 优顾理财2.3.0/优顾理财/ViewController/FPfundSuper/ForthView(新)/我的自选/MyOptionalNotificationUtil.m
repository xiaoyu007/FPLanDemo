//
//  MyOptionalNotificationUtil.m
//  优顾理财
//
//  Created by Mac on 15/8/14.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "MyOptionalNotificationUtil.h"

@implementation MyOptionalNotificationUtil

- (instancetype)init{
  if (self = [super init]) {
    [self addObserver];
  }
  return self;
}
/** 创建观察者 */
- (void)addObserver{
  __weak MyOptionalNotificationUtil *weakSelf = self;
  [self addObserverName:NT_MyOptionalFundChange withObserver:^(NSNotification *note) {
    if (weakSelf.myOptionalFundchange) {
      weakSelf.myOptionalFundchange();
    }
  }];
}

@end
