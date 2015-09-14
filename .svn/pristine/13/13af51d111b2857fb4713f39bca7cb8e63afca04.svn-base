//
//  BaseNotificationObserver.h
//  SimuStock
//
//  Created by Mac on 15/4/26.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 通知类型的观察者的管理器基类 */
@interface BaseNotificationObserverMgr : NSObject {
  ///字典：通知(key) --> 观察者(value)
  NSMutableDictionary *name2CallbackMap;
}

/** 添加观察者 */
- (void)addObserverName:(NSString *)observerName
           withObserver:(void (^)(NSNotification *note))block;

@end
