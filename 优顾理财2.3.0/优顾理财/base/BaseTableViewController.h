//
//  BaseTableViewController.h
//  SimuStock
//
//  Created by Mac on 15/4/26.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "BaseNoTitleViewController.h"
#import "DataArray.h"
#import "MJRefresh.h"
#import "BaseTableAdapter.h"
#import "Globle.h"
#import "BaseRequester.h"

///传递的回调函数
typedef void (^CallBackAction)();

typedef NS_ENUM(NSUInteger, RefreshType) {
  ///刷新
  RefreshTypeRefresh = 0,

  ///下拉刷新
  RefreshTypeHeaderRefresh = 1,

  ///加载更多
  RefreshTypeLoaderMore = 2,

  ///定时器刷新
  RefreshTypeTimerRefresh = 3,
};

@interface BaseTableViewController
    : BaseNoTitleViewController <MJRefreshBaseViewDelegate> {

@protected

  /** 表格数据绑定适配器 */
  BaseTableAdapter *_tableAdapter;

  /** 是否正在加载更多，用于过滤重复的请求*/
  BOOL isLoadMore;

  /** 暂无更多数据的tablefooter */
  UIView *noDataFootView;
}

/** 数据表格*/
@property(strong, nonatomic) UITableView *tableView;

/** 表格数据，用于数据绑定和小牛判断 */
@property(strong, nonatomic) DataArray *dataArray;

@property(assign, nonatomic) BOOL showTableFooter;

/** 下拉刷新 */
@property(strong, nonatomic) MJRefreshHeaderView *headerView;

/** 上拉加载更多 */
@property(strong, nonatomic) MJRefreshFooterView *footerView;

/** 开始加载，通知父容器*/
@property(copy, nonatomic) CallBackAction beginRefreshCallBack;

/** 结束加载，通知父容器*/
@property(copy, nonatomic) CallBackAction endRefreshCallBack;

/** 数据绑定完毕，通知父容器*/
@property(copy, nonatomic) CallBackAction onDataReadyCallBack;

/** 使用指定的frame大小设置页面的大小 */
- (id)initWithFrame:(CGRect)frame;

/** 请求最新数据，此方法子类必须实现 */
- (void)requestDataListWithRefreshType:(RefreshType)refreshType
                         withDataArray:(DataArray *)existDataList
                          withCallBack:(HttpRequestCallBack *)callback;

/** 判断返回数据是否非法，此方法子类必须实现 */
- (BOOL)isDataValidWithResponseObject:(NSObject<Collectionable> *)latestData
                withRequestParameters:(NSDictionary *)parameters
                      withRefreshType:(RefreshType)refreshType;

/** 获取请求参数 */
- (NSDictionary *)getRequestParamertsWithRefreshType:(RefreshType)refreshType;

/** 返回表格数据适配器，此方法子类必须实现 */
- (BaseTableAdapter *)getBaseTableAdaperWithDataList:(DataArray *)dataList;

/** 是否支持自动加载更多 */
- (BOOL)supportAutoLoadMore;

/** 下拉刷新控件上次刷新时间对应的key */
- (NSString *)headerViewKey;

- (void)refreshButtonPressDown;

- (BOOL)dataBinded;

///刷新或者加载下一页数据
- (void)requestResponseWithRefreshType:(RefreshType)refreshType;

- (void)endRefreshLoading;

- (void)setNoNetWork;

- (void)bindRequestObject:(NSObject<Collectionable> *)latestData
    withRequestParameters:(NSDictionary *)parameters
          withRefreshType:(RefreshType)refreshType;

@end
