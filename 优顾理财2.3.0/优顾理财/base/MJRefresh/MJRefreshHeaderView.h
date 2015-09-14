//
//  MJRefreshHeaderView.h
//  weibo
//
//  Created by mj on 13-2-26.
//  Copyright (c) 2013年 itcast. All rights reserved.
//  下拉刷新

#import "MJRefreshBaseView.h"

// 类
@interface MJRefreshHeaderView : MJRefreshBaseView {
  BOOL bSingleRow;
  NSDate *tempDate;
}
@property(copy, nonatomic) NSString *pageName;
// 最后的更新时间
@property(nonatomic, strong) NSDate *lastUpdateTime;
- (void)singleRow;
- (id)initWithPage:(NSString *)pageName;
- (void)updateTimeLabel;
#pragma mark 设置状态
- (void)setState:(RefreshState)state;
@end