//
//  BpushModelDeal.h
//  SimuStock
//
//  Created by Mac on 15/4/23.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, YLBpushType) {
  UserBpushAllCount = 0,      //推送总数
  UsercommentCount = 1,       //评论个数
  UsermentionCount = 2,       //@我个数
  UserReplyCount = 3,         //回复个数
  UserSystemMessageCount = 4, //系统消息
  UserFundWarning = 5,       //基金价格预警个数
};

@interface BpushModelDeal : NSObject<UIAlertViewDelegate>
///返回应用内部推送动画的文本内容
+ (void)BPushTextAnimationWithMessgate:(NSDictionary *)userInfo;

///股价预警数据存储coredata数据库
+(void)saveStockWarningData:(NSDictionary *)userInfo;
@end
