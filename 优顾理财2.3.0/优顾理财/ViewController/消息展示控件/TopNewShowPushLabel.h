//
//  NewShowLabel.h
//  SimuStock
//
//  Created by moulin wang on 14-7-25.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface TopNewShowPushLabel : UILabel


@property(nonatomic, strong) NSMutableDictionary *Userinfo;

+ (TopNewShowPushLabel *)topNewShowPushLabel;
///推送在应用启动时，的提示动画
+ (void)setBpushMessageContent:(NSString *)message
                 andDictionary:(NSDictionary *)dic;
@end
