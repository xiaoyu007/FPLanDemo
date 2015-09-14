//
//  NewsDetailTitleTableViewController.h
//  优顾理财
//
//  Created by Yuemeng on 15/9/11.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "BaseTitleViewController.h"
#import "BaseTableViewController.h"
#import "PicUserHeader.h"
#import "CommentBox.h"
#import "NewsDetailBottomView.h"
#import "NewsHeaderView.h"


typedef void (^PraiseStatusCallback)(BOOL isPraise);
typedef void(^getTitleBlock)(NSString *);
/**
 *      资讯二级详情页面
 */

@interface NewsDetailTableAdapter : BaseTableAdapter <UIAlertViewDelegate,PicUserHeaderDelegate> {
  NSInteger _selectedIndex;
  BOOL _reviewExist;
  NewsHeaderView *sectionView1;
  NewsHeaderView *sectionView2;
}
@property(nonatomic, strong) NSMutableArray *relatedArray;

@end

@interface NewsDetailTableViewController
    : BaseTableViewController <NewsDetailBottomViewDelegate, CommentBoxDelegate,
                               PicUserHeaderDelegate, UIWebViewDelegate>
@property(nonatomic, copy) NSString *newsId;
@property(nonatomic, copy) NSString *channlId;
@property(nonatomic, copy) NSString *xgsjTime;
@property(nonatomic, strong) NSMutableArray *relatedArray;
@property(nonatomic, strong) CommentBox *commentBox;
@property(nonatomic, copy) NSString *becommentName;
@property(nonatomic, copy) NSString *becommentId;
@property(nonatomic, strong) NewsDetailBottomView *newsBottomView;
@property(nonatomic, strong) MyCollectItem *newsCollectItem;
@property(nonatomic, strong) UIWebView *webView;
@property(nonatomic, strong) clickLabel *clickLabel;
@property(nonatomic) NSInteger num;
@property(nonatomic) BOOL reviewExist;
@property(nonatomic) BOOL isPush;
@property(nonatomic, copy) NSString *commentNum;
@property(nonatomic, copy) PraiseStatusCallback praiseCallback;
@property(nonatomic, strong) NewsDetailRequest *headerTableViewData;
@property(nonatomic) BOOL isOfflineRead;
@property(nonatomic, copy) NSString *praiseNum;
@property(nonatomic,copy)getTitleBlock getTitleBlock;

@end

@interface NewsDetailTitleTableViewController : BaseTitleViewController {
  NewsDetailTableViewController *_tableVC;
}

@property(nonatomic, copy) NSString *newsId;
@property(nonatomic, copy) NSString *channlId;
@property(nonatomic, copy) NSString *xgsjTime;
@property(nonatomic) BOOL isOfflineRead;
@property(nonatomic, copy) NSString *praiseNum;
@property(nonatomic, copy) PraiseStatusCallback praiseCallback;


- (id)initWithChannlId:(NSString *)localChannlid
             andNewsId:(NSString *)localNewsid
               Andxgsj:(NSString *)time;
@end
