//
//  OffDownloadObject.m
//  优顾理财
//
//  Created by Mac on 15/7/28.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "OffDownloadObject.h"
#import "SQLDataHtmlstring.h"

@implementation OffDownloadObject
#pragma mark - 每次启动应用，都去下载，被选中的评论，前20条数据
//离线下载
+ (void)offDownload {
  //    默认离线下载 焦点，趣理财
  [OffDownloadObject defaults_Focus_Setting];
  //    在wifi情况下， 且文件图片大小超过100m的，
  [OffDownloadObject replace_Folder_images];
}

+ (void)defaults_Focus_Setting {
  if (YouGu_defaults(@"first_Wi_FI_be_selected") == nil) {
    NSMutableArray *end_array = [@[ @"1", @"25" ] mutableCopy];

    [end_array writeToFile:pathInCacheDirectory(@"Wi_Fi_down_channlid_UnDown.plist")
                atomically:YES];

    [end_array writeToFile:pathInCacheDirectory(@"Wi_Fi_down_be_selected_channlid.plist")
                atomically:YES];

    YouGu_defaults_double(@YES, @"first_Wi_FI_be_selected");
  }
}
//将collection 收藏数据转移到com  下面去
+ (BOOL)Transfer_of_data:(NSString *)news_id {
  //==Json数据
  NSData *resultdata =
      [NSData dataWithContentsOfFile:pathInCacheDirectory(YouGu_StringWithFormat_Third(@"com.xmly/", news_id, @".json"))];

  return
      [resultdata writeToFile:pathInCacheDirectory(YouGu_StringWithFormat_Third(@"Collection.xmly/", news_id, @".json"))
                   atomically:YES];
}
//是否需要销毁图片文件夹，重建，
+ (void)replace_Folder_images {
  float page_length =
      [OffDownloadObject folderSizeAtPath:pathInCacheDirectory(@"ALL_images_thing.xmly")];
  //    是否是Wi-Fi网络
  if (YouGu_WiFi_CheckNetWork == YES && page_length > 100.0f) {
    //        清除照片，重新下载
    YouGu_NSFileManger_removeItemAtPath(@"ALL_images_thing.xmly");
    YouGu_NSFileManager_Path(@"ALL_images_thing.xmly");
  }
}
#pragma mark - 遍历文件夹获得文件夹大小，返回多少M
//遍历文件夹获得文件夹大小，返回多少M
+ (float)folderSizeAtPath:(NSString *)folderPath {
  if (!YouGu_fileExistsAtPath(folderPath))
    return 0;
  NSEnumerator *childFilesEnumerator = [[YouGu_NSFileManager subpathsAtPath:folderPath] objectEnumerator];
  NSString *fileName;
  long long folderSize = 0;
  while ((fileName = [childFilesEnumerator nextObject]) != nil) {
    NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
    folderSize += [OffDownloadObject fileSizeAtPath:fileAbsolutePath];
  }
  return folderSize / (1024.0 * 1024.0);
}
#pragma mark - 单个文件的大小
//单个文件的大小
+ (long long)fileSizeAtPath:(NSString *)filePath {
  if (YouGu_fileExistsAtPath(filePath)) {
    return [[YouGu_NSFileManager attributesOfItemAtPath:filePath error:nil] fileSize];
  }
  return 0;
}

+ (void)unCompleteChannleDownLoad {
  NSMutableArray *Channlid_array = [NSMutableArray arrayWithContentsOfFile:pathInCacheDirectory(@"Wi_Fi_down_be_selected_channlid.plist")];
  //    没有要下载的频道，或，wifi下下载被取消了
  if ([Channlid_array count] == 0 || [YouGu_defaults(@"Wi-Fi_or_GRPS") intValue] == 1) {
    //       任何情况下，都下载，趣理财，前20的下载
    [OffDownloadObject down_today_data:@"25"];
    return;
  } else {
    //        默认下载  趣理财
    if ([OffDownloadObject The_existence_of_an_element:@"25" and_array:Channlid_array] == NO) {
      [OffDownloadObject down_today_data:@"25"];
    }

    for (NSString *channlid_id in Channlid_array) {
      if (![FPYouguUtil isExistNetwork]) {
        YouGu_animation_Did_Start(networkFailed);
        break;
      }
      [OffDownloadObject Sorted_array:channlid_id];
      [OffDownloadObject down_today_data:channlid_id];
    }
  }
}
//整理，下载完成的，未完成的
+ (void)Sorted_array:(NSString *)string {
  NSMutableArray *Channlid_array2 = [NSMutableArray arrayWithContentsOfFile:pathInCacheDirectory(@"Wi_Fi_down_channlid_UnDown.plist")];
  if ([OffDownloadObject The_existence_of_an_element:string and_array:Channlid_array2] == NO) {
    [Channlid_array2 removeObject:string];
    [Channlid_array2 writeToFile:pathInCacheDirectory(@"Wi_Fi_down_channlid_UnDown.plist")
                      atomically:YES];
  }

  NSMutableArray *Channlid_array3 =
      [NSMutableArray arrayWithContentsOfFile:pathInCacheDirectory(@"Wi_Fi_down_channlid.plist")];
  if ([OffDownloadObject The_existence_of_an_element:string and_array:Channlid_array3] == NO) {
    [Channlid_array3 addObject:string];
    [Channlid_array3 writeToFile:pathInCacheDirectory(@"Wi_Fi_down_channlid.plist") atomically:YES];
  }

  NSMutableArray *Channlid_array4 = [NSMutableArray arrayWithContentsOfFile:pathInCacheDirectory(@"Wi_Fi_down_be_selected_channlid.plist")];
  if ([OffDownloadObject The_existence_of_an_element:string and_array:Channlid_array4] == NO) {
    [Channlid_array4 addObject:string];
    [Channlid_array4 writeToFile:pathInCacheDirectory(@"Wi_Fi_down_be_selected_channlid.plist")
                      atomically:YES];
  }
}

//数组中是否存在这个元素
+ (BOOL)The_existence_of_an_element:(NSString *)string and_array:(NSMutableArray *)M_array {
  for (NSString *str in M_array) {
    if ([string isEqualToString:str] == YES) {
      return YES;
    }
  }
  return NO;
}

+ (void)down_today_data:(NSString *)channlid {
  HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
  callBack.onSuccess = ^(NSObject *obj) {
    NewsListInChannel *listObject = (NewsListInChannel *)obj;
    [FileChangelUtil saveNewsTeamListData:listObject andChanleId:channlid];
    [listObject.newsList enumerateObjectsUsingBlock:^(NewsInChannelItem *objItem, NSUInteger idx, BOOL *stop) {
      if (objItem.newsID.length > 0 && [objItem.wzlx intValue] == 0) {
        if (idx == listObject.newsList.count - 1) {
          [OffDownloadObject down_News_context:channlid andNews_id:objItem.newsID andSaveObject:YES];
          return;
        }
        [OffDownloadObject down_News_context:channlid andNews_id:objItem.newsID andSaveObject:NO];
      }
    }];
    [listObject.headerList enumerateObjectsUsingBlock:^(NewsInChannelItem *objItem, NSUInteger idx, BOOL *stop) {
      if (objItem.newsID.length > 0 && [objItem.wzlx intValue] == 0) {
        if (idx == listObject.newsList.count - 1) {
          [OffDownloadObject down_News_context:channlid andNews_id:objItem.newsID andSaveObject:YES];
          return;
        }
        [OffDownloadObject down_News_context:channlid andNews_id:objItem.newsID andSaveObject:NO];
      }
    }];
  };
  callBack.onError = ^(BaseRequestObject *err, NSException *ex) {
  };
  callBack.onFailed = ^{
  };
  [NewsListInChannel requestNewsListWithChannlid:channlid andStart:0 withCallback:callBack];
}

//下载文章正文
+ (void)down_News_context:(NSString *)channlid
               andNews_id:(NSString *)newsid
            andSaveObject:(BOOL)save {
  //缓存是否有这篇文章
  NewsDetailRequest *item = [FileChangelUtil loadNewsDetailInfo:newsid];
  if (!item) {
    HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
    callBack.onSuccess = ^(NSObject *obj) {
      NewsDetailRequest *object = (NewsDetailRequest *)obj;
      ///保存新闻
      [FileChangelUtil saveNewsDetailInfo:object andNewId:newsid andSaveObject:save];
    };
    callBack.onError = ^(BaseRequestObject *err, NSException *ex) {
    };
    callBack.onFailed = ^{
    };
    [NewsDetailRequest getNewsDetailWithChannlid:channlid AndNewsid:newsid withCallback:callBack];
  }
}

@end
