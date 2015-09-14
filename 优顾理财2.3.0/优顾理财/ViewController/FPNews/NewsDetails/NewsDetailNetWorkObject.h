//
//  NewsDetailNetWorkObject.h
//  优顾理财
//
//  Created by Mac on 15/7/17.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsDetailRequest.h"
@class NewsDetailViewController;
@interface NewsDetailNetWorkObject : NSObject
////收藏新闻详情页
//+(void)CollectNewsDetail:(NewsDetailRequest*)newsData
//               andNewsId:(NSString*)newsId;
+(BOOL)webviewStartLoadWithRequest:(NSURLRequest*)request andPhotoPosition:(int)position andDelegate:(NewsDetailViewController *) mainVC;
@end
