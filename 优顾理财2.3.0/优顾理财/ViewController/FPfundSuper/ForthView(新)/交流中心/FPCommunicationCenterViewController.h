//
//  CommunicationCenterViewController.h
//  优顾理财
//
//  Created by Mac on 15/3/20.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPBaseViewController.h"
typedef NS_ENUM(NSUInteger, CommunCenterPageType) {
  /** 我的提问 */
  CommunCenterPageTypeMyQuestion = 0,
  /** 我的回答 */
  CommunCenterPageTypeMyAnswer,
  /** 我的消息 */
  CommunCenterPageTypeMyInfo,
  /** 我的评论 */
  CommunCenterPageTypeMyComment,
  /** @我的 */
  CommunCenterPageTypeAtMe,
};
/** 交流中心 */
@interface FPCommunicationCenterViewController
    : FPBaseViewController <UITableViewDelegate, UITableViewDataSource> {
  /** 交流中心tableview */
  UITableView *commuTableview;
  /** 每栏显示内容 */
  NSArray *dataArray;
  /** 加载image数组 */
  NSArray *imageArray;
  /** icon背景色数组 */
  NSArray *bgColorArray;
}
@end
