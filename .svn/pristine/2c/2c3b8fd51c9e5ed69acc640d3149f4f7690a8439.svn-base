//
//  NewsDetailViewController1.h
//  优顾理财
//
//  Created by Mac on 15/8/26.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPTableViewController.h"
#import "PicUserHeader.h"

/** 赞信息回传 */
typedef void (^PraiseStatusCallback)(BOOL isPraise);

/**
 *  咨询二级页面
 */
@interface NewsDetailViewController
    : FPTableViewController <PicUserHeaderDelegate> {
  /** 频道id */
  NSString *channlId;
  /** 新闻id */
  NSString *newsId;
  NSInteger selectedIndex;
}
///修改时间
@property(nonatomic, strong) NSString *xgsjTime;
@property(nonatomic, strong) NSArray *photos;

///赞数
@property(nonatomic, strong) NSString *praiseNum;
@property(nonatomic) BOOL isOfflineRead;
///是否跳转
@property(nonatomic) BOOL isPush;
/** 赞数据 */
@property(nonatomic, copy) PraiseStatusCallback praiseCallback;

/** 收藏新闻的对象 */
@property(nonatomic, strong) MyCollectItem *newsCollectItem;
#pragma mark - 初始化
- (id)initWithChannlId:(NSString *)localChannlid
             andNewsId:(NSString *)localNewsid
               Andxgsj:(NSString *)time;

@end
