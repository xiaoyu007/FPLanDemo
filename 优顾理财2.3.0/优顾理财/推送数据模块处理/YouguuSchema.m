//
//  YouguuSchema.m
//  优顾理财
//
//  Created by Mac on 15/7/27.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "YouguuSchema.h"
#import "NSURL+QueryComponent.h"
#import "NewsDetailViewController.h"
#import "KnowDetailViewController.h"
#import "FPMyAssetViewController.h"
@implementation YouguuSchema
+ (void)forwardPageFromNoticfication:(NSDictionary *)userInfo {
  if (userInfo == nil)
    return;
  BPushTypeMNCG type = (BPushTypeMNCG)[userInfo[@"type"] intValue];
  if (type == BPushExcellentFinancialConsulting) {
    ///新闻推送
    NewsDetailViewController * newsDetailVC =[[NewsDetailViewController alloc]initWithChannlId:[FPYouguUtil ishave_blank:userInfo[@"cid"]] andNewsId:[FPYouguUtil ishave_blank:userInfo[@"iid"]] Andxgsj:[FPYouguUtil ishave_blank:userInfo[@"utime"]]];
    [AppDelegate pushViewControllerFromRight:newsDetailVC];
  } if (type == BPushOptimalGuXiaobianPost||type == BPushCommentPush || type == BPushAssignSomebody||type == BPushNodePostedWarning || type == BPushreplyPush) {
    ////小编推贴
    NSString * fwd = userInfo[@"fwd"];
    NSString * talkId = [fwd stringByReplacingOccurrencesOfString:@"tid="
                                                       withString:@""];
    KnowDetailViewController * knowDetailVC =[[KnowDetailViewController alloc]initWithTalkId:talkId];
    [AppDelegate pushViewControllerFromRight:knowDetailVC];
  }
  else{//type == BPushCommentPush || type == BPushAssignSomebody||type == BPushNodePostedWarning
    NSString *forword = userInfo[@"forword"];
    if (forword) {
      NSURL *url =
      [NSURL URLWithString:[forword stringByAddingPercentEscapesUsingEncoding:
                            NSUTF8StringEncoding]];
      if (url) {
        [YouguuSchema handleYouguuUrl:url];
      }
    }
  }
}

/** 处理优顾协议的跳转 */
+ (void)handleYouguuUrl:(NSURL *)url {
  //非youguu协议的url，不处理，直接返回
  if (![@"youguu" isEqualToString:[url scheme]]) {
    return;
  }
  NSLog(@"scheme: %@", [url scheme]);
  NSLog(@"host: %@", [url host]);
  NSLog(@"fragment: %@", [url queryComponents]);
  NSString *host = [url host];
  NSDictionary *dic = [url queryComponents];
  if ([@"jhss_finance" isEqualToString:host]) { //基金价格预警
    ///
    if ([@"/my_assert" isEqualToString:url.relativePath]) {
      FPMyAssetViewController * myAssetVC =[[FPMyAssetViewController alloc]init];
      [AppDelegate pushViewControllerFromRight:myAssetVC];
    }
  }
  NSLog(@"还没有处理的推送的forword，%@",dic);
}

@end
