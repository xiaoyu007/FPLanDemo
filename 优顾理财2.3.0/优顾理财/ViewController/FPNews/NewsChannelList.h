//
//  NewsChannelList.h
//  SimuStock
//
//  Created by Mac on 15/5/24.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "BaseRequestObject.h"
#import "JsonFormatRequester.h"
@class HttpRequestCallBack;

/** 赞信息回传 */
typedef void (^PraiseStatusCallback)(BOOL isPraise);

/** 临时保存新闻id */
@interface NewsArrayWithId : JsonRequestObject
@end

/** 单个频道信息 */
@interface NewsChannelItem : JsonRequestObject

/** 频道Id */
@property(nonatomic, strong) NSString *channleID;

/** 频道名称 */
@property(nonatomic, strong) NSString *name;

/** 是否可编辑 */
@property(nonatomic, assign) BOOL isEditable;

/** 是否可见 */
@property(nonatomic, assign) BOOL isVisible;
@end

/** 频道列表 */
@interface NewsChannelList : JsonRequestObject <Collectionable>

/** 频道列表 */
@property(nonatomic, strong) NSMutableArray *channels;

/** 获取频道列表 */
+ (void)getNetworkRequestsAllChannelwithCallback:
    (HttpRequestCallBack *)callback;
@end

/** 单个频道信息 */
@interface NewsInChannelItem : JsonRequestObject

/** 新闻id */
@property(nonatomic, strong) NSString *newsID;
/** 频道 */
@property(nonatomic, strong) NSString *newsChannlid;
/** 赞数据回调 */
//@property(nonatomic, copy) PraiseStatusCallback praiseCallback;
/** 新闻发布时间 */
@property(nonatomic, strong) NSString *publishTime;

/** 新闻标题 bt*/
@property(nonatomic, strong) NSString *title;
/** 新闻赞数 */
@property(nonatomic, strong) NSString *praise;
/** 新闻//文章类型，1.普通新闻  2.技术转码新闻 */
@property(nonatomic, strong) NSString *source;
/** 新闻wzlx 类型 */
@property(nonatomic, strong) NSString *wzlx;
/** 新闻简介 */
@property(nonatomic, strong) NSString *newsIntroduction;
/** 新闻topicid，专题，微热点 */
@property(nonatomic, strong) NSString *topicid;
/** 新闻来源 */
@property(nonatomic, strong) NSString *ly;
/** 新闻有没有图片 */
@property(nonatomic, strong) NSString *lx;
/** 新闻修改时间 */
@property(nonatomic, strong) NSString *xgsj;
/** 新闻 */
@property(nonatomic, strong) NSString *url;
/** 新闻News_sourceUrl */
@property(nonatomic, strong) NSString *newsSourceUrl;
/** 广告id */
@property(nonatomic, strong) NSString *aid;
/** 图片 */
@property(nonatomic, strong) NSString *picImage;
/**是否被赞过了*/
@property(nonatomic, assign) BOOL isPraise;
/**  是否已读 */
@property(nonatomic, assign) BOOL is_or_read;
@end

/** 频道列表 */
@interface NewsListInChannel : JsonRequestObject

/** 频道推广headerview */
@property(nonatomic, strong) NSMutableArray *headerList;
/** 频道列表 */
@property(nonatomic, strong) NSMutableArray *newsList;

/** 获取频道的新闻列表 */
+ (void)requestNewsListWithChannlid:(NSString *)channlid
                           andStart:(NSInteger)startnum
                       withCallback:(HttpRequestCallBack *)callback;

@end

/** 新闻点赞接口 */
@interface NewsItemPraise : JsonRequestObject
+ (void)requestNewsItemWithNewsId:(NSString *)newsId
                      AndChannlid:(NSString *)channlid
                     withCallback:(HttpRequestCallBack *)callback;
@end

@interface OnlyNewsRotItem : JsonRequestObject

@end

@interface NewsRotList : JsonRequestObject <Collectionable>
/** 名称 */
@property(nonatomic, strong) NSString *name;
/** 频道列表 */
@property(nonatomic, strong) NSMutableArray *newsList;
+ (void)requestNewsRotItemWithtopicId:(NSString *)topicid
                             andStart:(int)startnum
                          andPagesize:(NSString *)page
                         withCallback:(HttpRequestCallBack *)callback;
+ (void)requestNewsRotItemWithDic:(NSDictionary *)dic
                     withCallback:(HttpRequestCallBack *)callback;
@end