//
//  NewShowLabel.h
//  SimuStock
//
//  Created by moulin wang on 14-7-25.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface NewShowLabel : UILabel

@property(nonatomic) BOOL isLandscape;
@property(nonatomic, strong) NSMutableDictionary *Userinfo;

+ (void)setMessageContent:(NSString *)message;
+ (NewShowLabel *)newShowLabel;

/**显示网络不给力提示 */
+ (void)showNoNetworkTip;

///横竖屏切换
- (void)landscapeStyle:(BOOL)isLandscape;
@end
