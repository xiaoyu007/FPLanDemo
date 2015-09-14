//
//  NewsDetailRequest.m
//  优顾理财
//
//  Created by Mac on 15/7/14.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "DateChangeSimple.h"
@implementation NewsDetailRequest
- (void)jsonToObject:(NSDictionary *)dic {
  [super jsonToObject:dic];
  NSArray *array = dic[@"result"];
  NSDictionary *aryDic = array[0];

  self.newsTitle = aryDic[@"cbt"];
  self.newsIntroduction = aryDic[@"jj"];
  self.Photo_position = [aryDic[@"lx"] intValue];
  self.newsSource = aryDic[@"ly"];
  self.newsPlnum = [aryDic[@"plnum"] intValue];
  self.creatTime = [[DateChangeSimple sharedManager]
      get_time_date:[FPYouguUtil ishave_blank:aryDic[@"sj"]]];
  self.webUrl = aryDic[@"weburl"];
  self.xgsjTime = [FPYouguUtil ishave_blank:aryDic[@"xgsj"]];
  self.originalUrl = aryDic[@"yw"];
  self.praiseNum = [aryDic[@"zn"] intValue];
  self.newsContent = aryDic[@"zw"];
  self.logoPic = aryDic[@"logo"];

  NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
  NSString *filePath =
      [resourcePath stringByAppendingPathComponent:@"Day.html"];
  NSString *string =
      [[NSString alloc] initWithContentsOfFile:filePath
                                      encoding:NSUTF8StringEncoding
                                         error:nil];
  if (self.logoPic.length > 0) {
    BOOL hasExistPic = [FPYouguUtil
        ishasExistPic:[NSString stringWithFormat:@"%@.png", self.logoPic]];
    if (hasExistPic) {
      self.logoPic = [NSString
          stringWithFormat:@"<div><img class='log_img' src='%@.png'></div>",
                           self.logoPic];
    } else {
      self.logoPic = [NSString
          stringWithFormat:@"<div><a " @"href='http://img.youguu.com/company/"
                           @"%@.png' /><img class='log_img' "
                           @"src='http://img.youguu.com/company/"
                           @"%@.png'>< /a></div>",
                           self.logoPic, self.logoPic];
    }
  } else {
    self.logoPic = @"";
  }
  string = [string stringByReplacingOccurrencesOfString:@"${web_view_logo}"
                                             withString:self.logoPic];
  string = [string stringByReplacingOccurrencesOfString:@"${img_opacity}"
                                             withString:@"1"];
  string = [string stringByReplacingOccurrencesOfString:@"${backgroundcolor}"
                                             withString:customBGColor];
  string = [string stringByReplacingOccurrencesOfString:@"${h1_text_color};"
                                             withString:@"#000000"];
  //  string = [string
  //  stringByReplacingOccurrencesOfString:@"${body_text_fontsize}"
  //                                             withString:YouGu_Font_text_Model];
  //根据关键字替换
  string = [string stringByReplacingOccurrencesOfString:@"${title}"
                                             withString:self.newsTitle];
  string = [string stringByReplacingOccurrencesOfString:@"${Source}"
                                             withString:self.newsSource];
  string = [string stringByReplacingOccurrencesOfString:@"${time}"
                                             withString:self.creatTime];
  string = [string stringByReplacingOccurrencesOfString:@"${content}"
                                             withString:self.newsContent];
  NSArray *picArray = aryDic[@"tp"];
  __block NSString *htmlStr = string;
  [picArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx,
                                         BOOL *stop) {
    NSString *picUrl =
        [NSString stringWithFormat:@"%@%@", IP_HTTP, obj[@"url"]];
    NSString *pickey = [FPYouguUtil ishave_blank:obj[@"key"]];
    if (!YouGu_Wifi_Image) {
      htmlStr =
          [string stringByReplacingOccurrencesOfString:pickey withString:@""];
    } else {
      NSString *have_image_html = [NSString
          stringWithFormat:
              @"<a href='pic:%@'/><img class='bb' src='%@' id='imgid'/></a>",
              picUrl, picUrl];
      htmlStr = [htmlStr stringByReplacingOccurrencesOfString:pickey
                                                   withString:have_image_html];
    }
  }];
  //     4、 web 的html，字符串
  self.webViewHtml = htmlStr;
}
///新闻详情文章
+ (void)getNewsDetailWithChannlid:(NSString *)channlid
                        AndNewsid:(NSString *)newsid
                     withCallback:(HttpRequestCallBack *)callback {
  NSString *path = [NSString
      stringWithFormat:
          @"%@/youguu/newsrest/info/readNews/%@/%@/%@/%@/%@/%@/%@/%@",
          IP_HTTP_DATA, ak_version, YouGu_User_sessionid, YouGu_User_USerid,
          Iphone_Size(), channlid, newsid, @"1", @"1"];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[NewsDetailRequest class]
             withHttpRequestCallBack:callback];
}
@end

@implementation NewsReviewRequest

- (void)jsonToObject:(NSDictionary *)dic {
  [super jsonToObject:dic];
}

///资讯详情页评论和回复
+ (void)getRequestWithReply:(NSString *)channlid
                  andNewsId:(NSString *)newsid
                 andContent:(NSString *)content
                andBeUserid:(NSString *)beuid
               withCallback:(HttpRequestCallBack *)callback {
  NSString *path =
      [NSString stringWithFormat:@"%@/youguu/newsrest/info/newReplay/%@/%@/%@",
                                 IP_HTTP_DATA, channlid, newsid, beuid];

  NSDictionary *dic = @{ @"content" : content, @"bid" : beuid };
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"POST"
               withRequestParameters:dic
              withRequestObjectClass:[NewsReviewRequest class]
             withHttpRequestCallBack:callback];
}
@end
@implementation NewsOnlyCommentObject

- (void)jsonToObject:(NSDictionary *)dic {
  [super jsonToObject:dic];
  NSString *content = YouGu_ishave_blank(dic[@"content"]);
  if ([content hasPrefix:@"##"]) {
    NSArray *urlComps = [content componentsSeparatedByString:@"##"];
    if ([urlComps count] >= 3) {
      content = [content substringFromIndex:2];
      content = [content substringFromIndex:[urlComps[1] length] + 2];
      content = [NSString stringWithFormat:@"<font color=#14a5f0>%@</font>%@",
                                           urlComps[1], content];
    }
  }
  self.content = content;
  self.userListItem = [[UserListItem alloc] init];
  self.userListItem.nickName = YouGu_ishave_blank(dic[@"uname"]);
  self.userListItem.userId = YouGu_ishave_blank(dic[@"uid"]);
  self.userListItem.headPic = YouGu_ishave_blank(dic[@"photo"]);
  self.userListItem.vipType = YouGu_ishave_blank(dic[@"vtype"]);
  self.userListItem.CertifySignature =
      YouGu_ishave_blank(dic[@"certifySignature"]);

  self.creattime = [[DateChangeSimple sharedManager]
      get_time_date:YouGu_ishave_blank(dic[@"createtime"])];
  self.commentId = YouGu_ishave_blank(dic[@"id"]);
  self.praiseNum = YouGu_ishave_blank(dic[@"praise"]);
  self.stampNum = YouGu_ishave_blank(dic[@"stamp"]);
  self.commentType = [dic[@"type"] intValue];
}

@end

@implementation NewsCommentListRequest

- (NSArray *)getArray {
  return _commentList;
}

- (void)jsonToObject:(NSDictionary *)dic {
  [super jsonToObject:dic];
  self.commentList = [[NSMutableArray alloc] init];
  NSArray *array = dic[@"result"];

  [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx,
                                      BOOL *stop) {
    NewsOnlyCommentObject *onlyObject = [[NewsOnlyCommentObject alloc] init];
    [onlyObject jsonToObject:obj];
    [self.commentList addObject:onlyObject];
  }];
}

+ (void)getRequestWithCommentList:(NSString *)channlid
                        AndNewsId:(NSString *)newsid
                      AndStartNum:(NSString *)start
                     withCallback:(HttpRequestCallBack *)callback {
  NSString *path = [NSString
      stringWithFormat:
          @"%@/youguu/newsrest/info/newReplaylist/%@/%@/%@/%@/%@/%@/%@",
          IP_HTTP_DATA, ak_version, YouGu_User_sessionid, YouGu_User_USerid,
          channlid, newsid, start, @"20"];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[NewsCommentListRequest class]
             withHttpRequestCallBack:callback];
}

+ (void)getRequestWithDic:(NSDictionary *)dic
             withCallback:(HttpRequestCallBack *)callback {
  NSString *path =
      [NSString stringWithFormat:@"%@/youguu/newsrest/info/newReplaylist/%@/%@/"
                                 @"%@/{channlid}/{newsid}/{start}/%@",
                                 IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                                 YouGu_User_USerid, @"20"];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:dic
              withRequestObjectClass:[NewsCommentListRequest class]
             withHttpRequestCallBack:callback];
}

@end

@implementation NewsonlyRelatedObject

- (void)jsonToObject:(NSDictionary *)dic {
  [super jsonToObject:dic];
  self.newsId = [dic[@"infoId"] stringValue];
  self.channlid = [dic[@"channelId"] stringValue];
  self.title = dic[@"title"];
}

@end
///新闻相关文章
@implementation NewsRelatedArticlesRequest
- (void)jsonToObject:(NSDictionary *)dic {
  [super jsonToObject:dic];
  self.listArray = [[NSMutableArray alloc] init];
  NSArray *array = dic[@"result"];
  [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx,
                                      BOOL *stop) {
    NewsonlyRelatedObject *onlyObject = [[NewsonlyRelatedObject alloc] init];
    [onlyObject jsonToObject:obj];
    [self.listArray addObject:onlyObject];
  }];
}

+ (void)getRelatedArticlesWithNewsid:(NSString *)newsid
                        withCallback:(HttpRequestCallBack *)callback {
  NSString *path = [NSString
      stringWithFormat:@"%@/youguu/newsrest/info/relateInfos/%@/%@/%@/%@",
                       IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                       YouGu_User_USerid, newsid];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[NewsRelatedArticlesRequest class]
             withHttpRequestCallBack:callback];
}

@end

///获得赞数和评论数
@implementation NewspraiseNumAndCommentNumRequest

- (void)jsonToObject:(NSDictionary *)dic {
  [super jsonToObject:dic];
  NSArray *array = dic[@"result"];
  NSDictionary *arrayDic = array[0];
  self.praiseNum = [@([arrayDic[@"zn"] intValue]) stringValue];
  self.commentNum = [@([arrayDic[@"plnum"] intValue]) stringValue];
}

+ (void)getPraiseNumAndCommentNumWithChannlid:(NSString *)channlid
                                    AndNewsId:(NSString *)newsid
                                 withCallback:(HttpRequestCallBack *)callback {
  NSString *path = [NSString
      stringWithFormat:@"%@/youguu/newsrest/info/infonum/%@/%@/%@/%@/%@/%@",
                       IP_HTTP_DATA, ak_version, YouGu_User_sessionid,
                       YouGu_User_USerid, Iphone_Size(), channlid, newsid];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[NewspraiseNumAndCommentNumRequest class]
             withHttpRequestCallBack:callback];
}
@end

///评论点赞
@implementation NewsCommentpraiseRequest

- (void)jsonToObject:(NSDictionary *)dic {
  [super jsonToObject:dic];
}

+ (void)getNewsCommentPraiseRequest:(NSString *)channlid
                          AndNewsid:(NSString *)newsid
                         andReplyid:(NSString *)replyid
                       withCallback:(HttpRequestCallBack *)callback {
  NSString *path = [NSString
      stringWithFormat:
          @"%@/youguu/newsrest/info/commentReply/%@/%@/%@/%@/%@/%@/%@",
          IP_HTTP_DATA, ak_version, YouGu_User_sessionid, YouGu_User_USerid,
          channlid, newsid, replyid, @"1"];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[NewsCommentListRequest class]
             withHttpRequestCallBack:callback];
}
@end

@implementation NewsCollectRequest
- (void)jsonToObject:(NSDictionary *)dic {
  [super jsonToObject:dic];
  self.fid = YouGu_ishave_blank(dic[@"fid"]);
}
///添加收藏
+ (void)getNewsCollectWithNewsId:(NSString *)newsId
                    andNewsTitle:(NSString *)title
                         andType:(NSString *)type
                    withCallback:(HttpRequestCallBack *)callback {
  title = [CommonFunc base64StringFromText:title];
  NSString *path = [NSString
      stringWithFormat:
          @"%@/youguu/newsrest/info/addFavorite?id=%@&type=%@&title=%@",
          IP_HTTP_DATA, newsId, type, title];
  path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[NewsCollectRequest class]
             withHttpRequestCallBack:callback];
}
///取消收藏
+ (void)getNewsCollectWithFid:(NSString *)fid
                 withCallback:(HttpRequestCallBack *)callback {
  NSString *path = [NSString
      stringWithFormat:@"%@/youguu/newsrest/info/deleteFavorite?fid=%@",
                       IP_HTTP_DATA, fid];
  JsonFormatRequester *request = [[JsonFormatRequester alloc] init];
  [request asynExecuteWithRequestUrl:path
                   WithRequestMethod:@"GET"
               withRequestParameters:nil
              withRequestObjectClass:[NewsCollectRequest class]
             withHttpRequestCallBack:callback];
}

@end
