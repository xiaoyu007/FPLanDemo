//
//  PullingRefreshTableView.h
//  PullingTableView
//
//  Created by danal on 3/6/12.If you want use it,please leave my name here
//  Copyright (c) 2012 danal Luo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
  kPRStateNormal = 0,
  kPRStatePulling = 1,
  kPRStateLoading = 2,
  kPRStateHitTheEnd = 3
} PRState;

@interface PullLoadingView : UIView {
  UILabel *_stateLabel;
  UILabel *_dateLabel;
  UIImageView *_arrowView;
  UIActivityIndicatorView *_activityView;
  //    上啦刷新
  UIActivityIndicatorView *activityView;
  UILabel *_state_my_lable;

  CALayer *_arrow;
  BOOL _loading;
  //    我新添加的
  NSString *My_refresh_id;
}
@property(nonatomic, getter=isLoading) BOOL loading;
@property(nonatomic, getter=isAtTop) BOOL atTop;
@property(nonatomic) PRState state;

//- (id)initWithFrame:(CGRect)frame atTop:(BOOL)top;
//我新修改过的
- (id)initWithFrame:(CGRect)frame
              atTop:(BOOL)top
      andRefresh_ID:(NSString *)Refresh_ID;
- (void)updateRefreshDate:(NSDate *)date;

@end

@protocol PullingRefreshTableViewDelegate;

@interface PullingRefreshTableView : UITableView <UIScrollViewDelegate> {
  PullLoadingView *_headerView;
  PullLoadingView *_footerView;
  UILabel *_msgLabel;
  BOOL _loading;
  BOOL _isFooterInAction;
  NSInteger _bottomRow;
}
/** 刷新头 */
@property(nonatomic, strong) PullLoadingView *headerView;
@property(assign, nonatomic)
    id<PullingRefreshTableViewDelegate> pullingDelegate;
@property(nonatomic) BOOL autoScrollToNextPage;
@property(nonatomic) BOOL reachedTheEnd;
@property(nonatomic, getter=isHeaderOnly) BOOL headerOnly;
//    我新添加的
@property(nonatomic, strong) NSString *myRefresh_id;
/** 外不需要控制停止 */
@property(nonatomic, strong) PullLoadingView *footerView;

//- (id)initWithFrame:(CGRect)frame
// pullingDelegate:(id<PullingRefreshTableViewDelegate>)aPullingDelegate;
//我新添加的
- (id)initWithFrame:(CGRect)frame
    pullingDelegate:(id<PullingRefreshTableViewDelegate>)aPullingDelegate
      andRefresh_id:(NSString *)Refresh_id;

- (void)tableViewDidScroll:(UIScrollView *)scrollView;

//我新添加的，用途是:在tableview的数据为空时，隐藏，上啦刷新的，图片和文字
- (void)My_add_hidden_view;
//我新添加的，用途是:在tableview的数据为空时，隐藏，上啦刷新的，图片和文字
- (void)My_add_hidden_header_view;
//我新添加的，对应，上面的隐藏的，底视图
- (void)My_add_cancel_hidden_view;

- (void)tableViewDidEndDragging:(UIScrollView *)scrollView;

- (void)tableViewDidFinishedLoading;

- (void)tableViewDidFinishedLoadingWithMessage:(NSString *)msg;

- (void)launchRefreshing;

- (void)flashMessage:(NSString *)msg;
@end

@protocol PullingRefreshTableViewDelegate <NSObject>

@required
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView;
@optional
// Implement this method if headerOnly is false
- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView;
// Implement the follows to set date you want,Or Ignore them to use current date
- (NSDate *)pullingTableViewRefreshingFinishedDate;
- (NSDate *)pullingTableViewLoadingFinishedDate;
@end