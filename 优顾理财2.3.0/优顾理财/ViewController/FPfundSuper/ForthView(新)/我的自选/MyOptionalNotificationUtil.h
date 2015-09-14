//
//  MyOptionalNotificationUtil.h
//  优顾理财
//
//  Created by Mac on 15/8/14.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "BaseNotificationObserverMgr.h"
/** 自选状态信息变更 */
static NSString *const NT_MyOptionalFundChange = @"NT_MyOptionalChange";
/** 自选状态变更通知回调管理器 */
typedef void (^MyOptionalFundChange)();
/** 用户信息变更通知回调管理器 */
@interface MyOptionalNotificationUtil : BaseNotificationObserverMgr
/** 自选状态管理 */
@property(copy, nonatomic) MyOptionalFundChange myOptionalFundchange;

@end
