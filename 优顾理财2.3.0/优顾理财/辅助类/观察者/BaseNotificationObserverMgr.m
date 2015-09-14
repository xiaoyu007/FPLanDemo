//
//  BaseNotificationObserver.m
//  SimuStock
//
//  Created by Mac on 15/4/26.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "BaseNotificationObserverMgr.h"

@implementation BaseNotificationObserverMgr

-(instancetype)init{
  if (self = [super init]) {
    name2CallbackMap = [@{} mutableCopy];
  }
  return self;
}

-(void)dealloc{
  [name2CallbackMap enumerateKeysAndObjectsUsingBlock:^(NSString* key, id observer, BOOL *stop) {
    [[NSNotificationCenter defaultCenter] removeObserver:observer];
  }];
  [name2CallbackMap removeAllObjects];
}

- (void)addObserverName:(NSString*) observerName
           withObserver:(void (^)(NSNotification *note))block{
  id observer = [[NSNotificationCenter defaultCenter]
                             addObserverForName:observerName
                             object:nil
                             queue:[NSOperationQueue mainQueue]
                             usingBlock:block];
  name2CallbackMap[observerName] = observer;
}

@end
