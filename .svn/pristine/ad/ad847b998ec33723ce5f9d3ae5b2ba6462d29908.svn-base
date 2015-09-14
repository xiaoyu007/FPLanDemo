//
//  BpushModelDeal.m
//  SimuStock
//
//  Created by Mac on 15/4/23.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "TopNewShowPushLabel.h"

@implementation BpushModelDeal
///返回应用内部推送动画的文本内容
+ (void)BPushTextAnimationWithMessgate:(NSDictionary *)userInfo {
  NSNumber *number = userInfo[@"type"];
  if (number == nil)
    return;
  BPushTypeMNCG type = (BPushTypeMNCG)[number integerValue];
  BOOL ispush = [BpushModelDeal PushStatisticsAndStorage:userInfo andType:type];
  if (ispush == NO) {
    return;
  }
  NSString *alert = userInfo[@"aps"][@"alert"];
  NSString *alertMsg = [NSString stringWithFormat:@"%@", alert];
  if (type == BPushExcellentFinancialConsulting || type == BPushOptimalGuXiaobianPost|| type == BPushNodePostedWarning) {
    UIAlertView *alertView = [[UIAlertView alloc]
            initWithTitle:@"通知"
                  message:alertMsg
                 delegate:(AppDelegate *)([UIApplication sharedApplication]
                                              .delegate)
        cancelButtonTitle:@"关闭"
        otherButtonTitles:@"查看", nil];
    alertView.tag = 1000;
    [alertView show];
  } else {
//    if (type == BPushNodePostedWarning) {
//      alertMsg = [@"结贴警报:" stringByAppendingString:alertMsg];
//    }else if (type == BPushAssignSomebody) {
//      alertMsg = [@"向你提问:" stringByAppendingString:alertMsg];
//    } else if (type == BPushCommentPush) {
////      alertMsg = [BpushModelDeal getStockCodeAndName:userInfo];
//      alertMsg = [@"评论:" stringByAppendingString:alertMsg];
//    } else if (type == BPushreplyPush) {
//      alertMsg = [@"回复:" stringByAppendingString:alertMsg];
//    } else
      if (type == BPushShopFundPriceWarning){
      alertMsg = [@"基金预警:" stringByAppendingString:alertMsg];
        [TopNewShowPushLabel setBpushMessageContent:alertMsg
                                      andDictionary:userInfo];
    } }
  return;
}


///系统消息与股票预警推送统计和数据存储
+ (BOOL)PushStatisticsAndStorage:(NSDictionary *)userInfo
                         andType:(BPushTypeMNCG)type {
  if (type == BPushShopFundPriceWarning) {
//    ///在应用里面收到应用推送
//    YLBpushType bpushType = UserFundWarning;
//    [UserBpushInformationNum increaseUnReadCountWithMessageType:bpushType];
    [self saveStockWarningData:userInfo];
    if (![FPYouguUtil isLogined]) {
      return NO;
    }
  } else if (type == BPushTheSystemMessage) { ///系统消息统计、
    YLBpushType bpushType = UserSystemMessageCount;
    ///在应用里面收到应用推送
    [UserBpushInformationNum increaseUnReadCountWithMessageType:bpushType];
  } else if (type == BPushAssignSomebody) { ///被人向你提问（@你）、
    YLBpushType bpushType = UsermentionCount;
    ///在应用里面收到应用推送
    [UserBpushInformationNum increaseUnReadCountWithMessageType:bpushType];
  } else if (type == BPushCommentPush){//评论
    YLBpushType bpushType = UsercommentCount;
    ///在应用里面收到应用推送
    [UserBpushInformationNum increaseUnReadCountWithMessageType:bpushType];
  }else if (type == BPushreplyPush){//回复
    YLBpushType bpushType = UserReplyCount;
    ///在应用里面收到应用推送
    [UserBpushInformationNum increaseUnReadCountWithMessageType:bpushType];
  }
  [[NSNotificationCenter defaultCenter]postNotificationName:@"UnreadPushInfo" object:nil];
  return YES;
}

///股价预警数据存储coredata数据库
+ (void)saveStockWarningData:(NSDictionary *)userInfo {
//  NSString *forword = userInfo[@"forword"];
//  NSURL *url =
//      [NSURL URLWithString:[forword stringByAddingPercentEscapesUsingEncoding:
//                                        NSUTF8StringEncoding]];
//  NSDictionary *dicStockInfo = [url queryComponents];
//  if (userInfo && dicStockInfo.count > 0) {
//    NSString *ruid = [NSString stringWithFormat:@"%@", userInfo[@"ruid"]];
//    ///股价预警信息
//    NSString *msg = userInfo[@"aps"][@"alert"];
//    ///股价发送时间
//    NSString *sendtime = userInfo[@"sendTime"];
//    NSString *stockcode = dicStockInfo[@"stock_code"];
//    NSString *stockname = dicStockInfo[@"stock_name"];
//    NSNumber *FirstType = @([dicStockInfo[@"first_type"] integerValue]);
//
//    ///把股价预警数据存入coredata数据库
//    [[StockWarningController sharedManager] addCoredataWithUid:ruid
//                                                       Withmsg:msg
//                                                  WithsendTime:sendtime
//                                                 WithfirstType:FirstType
//                                                  andStockName:stockname
//                                                  andStockCode:stockcode];
//  }
}
///获取股票预警的股票代码和名称
+ (NSString *)getStockCodeAndName:(NSDictionary *)userInfo {
//  NSString *alert = userInfo[@"aps"][@"alert"];
//  NSString *forword = userInfo[@"forword"];
//  NSURL *url =
//      [NSURL URLWithString:[forword stringByAddingPercentEscapesUsingEncoding:
//                                        NSUTF8StringEncoding]];
//  NSDictionary *dicStockInfo = [url queryComponents];
//  if (userInfo && dicStockInfo.count > 0) {
//    NSString *stockcode = dicStockInfo[@"stock_code"];
//    NSString *stockname = dicStockInfo[@"stock_name"];
//    ///内部推送动画显示，股票名称
//    NSString *stockWarningStr =
//        [NSString stringWithFormat:@"%@(%@)\n", stockname,
//                                   [StockUtil sixStockCode:stockcode]];
//    return [stockWarningStr stringByAppendingString:alert];
//  }
  return nil;
}
@end
