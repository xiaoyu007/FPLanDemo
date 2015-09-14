//
//  FPNoTitleBaseTableViewController.h
//  优顾理财
//
//  Created by Mac on 15/8/13.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPNoTitleViewController.h"
#import "PullingRefreshTableView.h"
#import "DataArray.h"

@interface FPNoTitleBaseTableViewController
    : FPNoTitleViewController <UITableViewDataSource, UITableViewDelegate,
                               UIScrollViewDelegate,
                               PullingRefreshTableViewDelegate>

@property(nonatomic, strong) PullingRefreshTableView *tableView;
///当前是第几组数据
@property(nonatomic, assign) NSInteger refrashIndex;
/** 初始请求 */
@property(nonatomic, assign) NSInteger startIndex;
/// tableview，相关数据
@property(nonatomic, strong) DataArray *dataArray;
/**是否网络请求成功 */
@property(nonatomic, assign) BOOL isSuccess;
///刷新
@property(nonatomic, strong) NSString *RefreshLable;

- (id)initWithRefreshLable:(NSString *)labletext;
- (id)initWithFrame:(CGRect)frame AndRefreshLable:(NSString *)labletext;
-(void)creatBaseTableView;
#pragma mark - 数据上啦，下拉 加载
- (HttpRequestCallBack *)getHttpCallBack;
///上啦刷新请求更多数据
- (void)requestData;
/**
 *  失败
 *
 *  @return
 */
-(void)returnFail;
/**
 *  错误
 *
 *  @return
 */
-(void)returnError:(BaseRequestObject *)err;
///成功回调
- (void)returnBlock:(NSObject *)obj;
///数据解析
- (void)jsonToDic:(NSArray *)array;

- (void)setNoNetWork;

@end
