//
//  NewsDetailNetWorkObject.m
//  优顾理财
//
//  Created by Mac on 15/7/17.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "NewsDetailNetWorkObject.h"
#import "SQLDataHtmlstring.h"
#import "FPwebViewController.h"
#import "NewsDetailViewController.h"
#import "YGImageDown.h"
#import "MWPhotoBrowser.h"
@interface NewsDetailViewController ()<MWPhotoBrowserDelegate>

@end
@implementation NewsDetailNetWorkObject
////收藏新闻详情页
//+ (void)CollectNewsDetail:(NewsDetailRequest*)newsData
//                andNewsId:(NSString*)newsId {
//  if ([[SQLDataHtmlstring sharedManager] View_user_exists:newsId
//                                              andChannlid:@"1"] == NO) {
//    if (newsData && newsId) {
//      //实名，收藏新闻
//      HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
//      callBack.onSuccess = ^(NSObject *obj) {
//        NewsCollectRequest * collectObject = (NewsCollectRequest *)obj;
//        if (collectObject && collectObject.fid &&
//            newsData.newsTitle) {
//          //        添加收藏
//          [[SQLDataHtmlstring sharedManager]
//           saveUser:newsId
//           andchannlid:@"1"
//           andDescription:newsData.newsTitle
//           andAdd_cancle:@"0"
//           andFid:collectObject.fid
//           andSynchronous:@"0"];
//        }
//      };
//      [NewsCollectRequest getNewsCollectWithNewsId:newsId andNewsTitle:newsData.newsTitle andType:@"1" withCallback:callBack];
//    }
//  } else {
//    NSString* fid = [[SQLDataHtmlstring sharedManager] Search_UserWithfid:newsId
//                                                              andChannlid:@"1"];
//    if (fid && [fid length] > 0) {
//      //         实名 ，取消收藏
//      HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
//      callBack.onSuccess = ^(NSObject *obj) {
//          //        取消收藏
//          [[SQLDataHtmlstring sharedManager] deleteUserWithId:newsId
//                                                  andChannlid:@"1"];
//      };
//      [NewsCollectRequest getNewsCollectWithFid:fid withCallback:callBack];
//    } else {
//      //        取消收藏
//      [[SQLDataHtmlstring sharedManager] deleteUserWithId:newsId
//                                              andChannlid:@"1"];
//    }
//  }
//}

+ (BOOL)webviewStartLoadWithRequest:(NSURLRequest*)request
                   andPhotoPosition:(int)position
                        andDelegate:(NewsDetailViewController*)mainVC {
  NSString* urlString = [[request URL] absoluteString];
  if ([urlString hasPrefix:@"pic:"]) {
    [NewsDetailNetWorkObject downloadPic:[urlString substringFromIndex:4]
                             AndDelegate:mainVC];
    return NO;
  }
  NSArray* urlComps = [urlString componentsSeparatedByString:@"://"];
  if ([urlComps count] &&
      [urlComps[0] isEqualToString:@"objc"]) {
    NSArray* arrFucnameAndParameter = [(NSString*) urlComps[1]
        componentsSeparatedByString:@"/"];
    if ([arrFucnameAndParameter count] == 2) {
      if (arrFucnameAndParameter[0] &&
          arrFucnameAndParameter[1]) {
        NewsDetailViewController* detailVC = [[NewsDetailViewController alloc]
            initWithChannlId:arrFucnameAndParameter[1]
                   andNewsId:arrFucnameAndParameter[0]
                     Andxgsj:@"1"];
        [AppDelegate pushViewControllerFromRight:detailVC];
      }
    }
    return NO;
  }
  //    新闻转码
  if ([urlComps count] &&
      [urlComps[0] isEqualToString:@"http"]) {
    if (![FPYouguUtil isExistNetwork]) {
      YouGu_animation_Did_Start(networkFailed);
      return YES;
    }
    if (position == 233 && [urlComps count] &&
        [urlComps[0] isEqualToString:@"http"]) {
      FPwebViewController* webVC =
          [[FPwebViewController alloc] initWithPathurl:urlString
                                              andTitle:urlString];
      [AppDelegate pushViewControllerFromRight:webVC];
    } else {
      FPwebViewController* webVC =
          [[FPwebViewController alloc] initWithPathurl:urlString];
      [AppDelegate pushViewControllerFromRight:webVC];
    }
    return NO;
  }
  return YES;
}
+ (void)downloadPic:(NSString*)picUrl
        AndDelegate:(NewsDetailViewController*)mainVC {
  picUrl = [picUrl stringByReplacingOccurrencesOfString:@"480.jpg"
                                             withString:@"source.jpg"];
  [[YGImageDown sharedManager]
       add_image:picUrl
      completion:^(UIImage* img) {
        // Browser
        NSMutableArray* photos = [[NSMutableArray alloc] init];
        MWPhoto* photo;
        photo = [MWPhoto photoWithImage:img];
        photo.caption = @"";
        [photos addObject:photo];
        mainVC.photos = [photos copy];
        // Create browser
        MWPhotoBrowser* browser =
            [[MWPhotoBrowser alloc] initWithDelegate:mainVC];
        browser.displayActionButton = YES;
        [AppDelegate pushViewControllerFromRight:browser];
      }];
}
@end
