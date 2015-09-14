//
//  MPNotificationWindow.h
//  SimuStock
//
//  Created by Mac on 13-12-11.
//  Copyright (c) 2013年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface MPNotificationWindow : UIWindow

@property(nonatomic, strong) NSMutableArray *notificationQueue;
@property(nonatomic, strong) UIView *currentNotification;

@end
