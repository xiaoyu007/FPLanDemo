//
//  FPNewsPushUtil.m
//  优顾理财
//
//  Created by Mac on 15/7/7.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPNewsPushUtil.h"
#import "HotTopicViewController.h"
//#import "SpecialTopicViewController.h"
#import "SpecialTopicTitleTableViewController.h"
#import "FPwebViewController.h"
#import "NewsDetailViewController.h"
#import "NewsDetailTitleTableViewController.h"

@implementation FPNewsPushUtil

+ (void)PushToOtherViewController:(NewsInChannelItem *)item
                    isOfflineRead:(BOOL)isOfflineRead
                andPraiseCallBack:(PraiseStatusCallback)callBack{
  switch ([item.wzlx intValue]) {
    case 1: {  //微热点
      HotTopicViewController* Special_VC =
          [[HotTopicViewController alloc] initWithTopicid:item.topicid];
      Special_VC.channlId = item.newsChannlid;
      [AppDelegate pushViewControllerFromRight:Special_VC];
    } break;
    case 2: {  ///专题
      SpecialTopicTitleTableViewController* specialVC =
          [[SpecialTopicTitleTableViewController alloc]initWithTopicid:item.topicid];
      specialVC.channlid = item.newsChannlid;
      [AppDelegate pushViewControllerFromRight:specialVC];
    } break;
    case 3: {
      FPwebViewController * webVC =[[FPwebViewController alloc]initWithPathurl:item.newsSourceUrl andTitle:item.title];
      [AppDelegate pushViewControllerFromRight:webVC];
    } break;
    case 0: {
      //   进入新闻正文页
      NewsDetailTitleTableViewController * newsDetailVC = [[NewsDetailTitleTableViewController alloc]initWithChannlId:item.newsChannlid andNewsId:item.newsID Andxgsj:item.xgsj];
      
      newsDetailVC.isOfflineRead = isOfflineRead;
      newsDetailVC.praiseNum = item.praise;
      /** 赞数据回传 */
      newsDetailVC.praiseCallback = ^(BOOL isPraise){
        if (isPraise) {
          callBack(YES);
        }
      };
      [AppDelegate pushViewControllerFromRight:newsDetailVC];
    } break;
    default:
      break;
  }
}

@end
