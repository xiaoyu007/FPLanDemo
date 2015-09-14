//
//  NewsListViewController.h
//  优顾理财
//
//  Created by Mac on 15/6/30.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPNoTitleBaseTableViewController.h"
#import "EScrollerView.h"
#import "RTLabel.h"
@interface NewsListViewController
    : FPNoTitleBaseTableViewController<EScrollerViewDelegate> ///新闻频道id
@property(nonatomic, strong) NSString *Channlid;
///频道名称
@property(nonatomic, strong) NSString *Name;
/// tableHeader
@property(nonatomic, strong) NSMutableArray *headerArray;
@property(nonatomic, strong) EScrollerView * tableHeader;
@property(nonatomic) BOOL isOfflineRead;

- (id)initWithFrame:(CGRect)frame
      withChannelID:(NSString *)channelId
    withChannelName:(NSString *)name;
- (void)refreshButtonPressDown;
-(void)addScrollTableViewHeader;
@end
