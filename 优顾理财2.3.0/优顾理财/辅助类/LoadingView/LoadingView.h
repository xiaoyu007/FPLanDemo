//
//  LoadingView.h
//  优顾理财
//
//  Created by Mac on 14-1-3.
//  Copyright (c) 2014年 Ling YU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Loading.h"
@protocol LoadingView_delegate <NSObject>
@optional
///重新刷新数据
- (void)refreshNewInfo;

//无网，趣理财
- (void)InfoManagementBtnClick;

@end

@interface LoadingView : UIView {
  Loading *loading;
}
@property (weak, nonatomic) IBOutlet UIImageView *noNetWorkImageView;
@property(nonatomic, assign) id<LoadingView_delegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *defaultView;
@property (weak, nonatomic) IBOutlet UIView *InfoDefaultView;
@property (weak, nonatomic) IBOutlet UIView *notDataView;
/** 暂无数据label */
@property (weak, nonatomic) IBOutlet UILabel *noDataLabel;
@property (weak, nonatomic) IBOutlet UIButton *noNetWorkBtn;

///动画开始
- (void)animationStart;
//无网络
- (void)animationNoNetWork;
///暂无数据
-(void)notDataStatus;
@end
