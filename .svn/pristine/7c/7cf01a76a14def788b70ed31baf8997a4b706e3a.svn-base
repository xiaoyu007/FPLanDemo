//
//  MJRefreshHeaderView.m
//  weibo
//
//  Created by mj on 13-2-26.
//  Copyright (c) 2013年 itcast. All rights reserved.

//  下拉刷新

#define kPullToRefresh @"下拉可以刷新"
#define kReleaseToRefresh @"松开立即刷新"
#define kRefreshing @"努力加载中..."
#define kDefaultKey @"default_MJRefreshHeaderView"

#import "MJRefreshHeaderView.h"

@implementation MJRefreshHeaderView

- (id)init {
  return [self initWithPage:kDefaultKey];
}
- (id)initWithPage:(NSString *)pageName {
  if (self = [super init]) {
    self.pageName = pageName;
    bSingleRow = NO;
    _lastUpdateTimeLabel.text = @"最后更新:--";
  }
  return self;
}

// 构造方法
- (id)initWithScrollView:(UIScrollView *)scrollView {
  self = [super initWithScrollView:scrollView];
  if (self) {
    self.pageName = @"";
  }
  return self;
}
#pragma mark - UIScrollView相关
#pragma mark 重写设置ScrollView
- (void)setScrollView:(UIScrollView *)scrollView {
  [super setScrollView:scrollView];
  // 设置边框
  self.frame =
      CGRectMake(0, -kViewHeight, scrollView.frame.size.width, kViewHeight);
  if (bSingleRow) {
    _statusLabel.center = CGPointMake(_statusLabel.center.x, 33);
  }
}

#pragma mark - 状态相关
#pragma mark 设置最后的更新时间
- (void)setLastUpdateTime:(NSDate *)localLastUpdateTime {
  [[NSUserDefaults standardUserDefaults] setObject:localLastUpdateTime
                                            forKey:self.key];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)key {
  if (!_pageName) {
    return [[FPYouguUtil getUserID] stringByAppendingString:@"空数据"];
  }
  return [[FPYouguUtil getUserID] stringByAppendingString:_pageName];
}

#pragma mark 更新时间字符串
- (void)updateTimeLabel {
  tempDate = [[NSUserDefaults standardUserDefaults] objectForKey:self.key];

  if (tempDate == nil || ![tempDate isKindOfClass:[NSDate class]]) {
    return;
  }
  // 2.格式化日期:假设24000s
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  // 1.获得年月日
  NSCalendar *calendar = [NSCalendar currentCalendar];
  NSDateComponents *cmp1 =
      [calendar components:NSDayCalendarUnit | NSYearCalendarUnit
                  fromDate:tempDate];
  //    NSLog(@"[cmp1 day] = %d",[cmp1 day]);
  NSDateComponents *cmp2 =
      [calendar components:NSDayCalendarUnit | NSYearCalendarUnit
                  fromDate:[NSDate date]];
  //    NSLog(@"[cmp2 day] = %d",[cmp2 day]);

  NSTimeInterval timeInterval = [tempDate timeIntervalSinceNow];
  timeInterval = -timeInterval;
  long temp = 0;
  if (timeInterval < 60) {
    formatter.dateFormat = @"刚刚";
  } else if ((temp = timeInterval / 60) < 60) { // 400
    formatter.dateFormat =
        [NSString stringWithFormat:@"%ld分钟前", temp]; // @"mm分钟前";
  } else if ((temp = temp / 60) < 24 && [cmp1 day] == [cmp2 day]) { // 400/60
    formatter.dateFormat = @"HH:mm";
  } else if ([cmp2 day] - 1 == [cmp1 day]) {
    formatter.dateFormat = @"昨天 HH:mm";
  } else if ([cmp2 day] - 2 == [cmp1 day]) {
    formatter.dateFormat = @"前天 HH:mm";
  } else if ([cmp2 year] == [cmp1 year]) {
    formatter.dateFormat = @"MM月dd日 HH:mm";
  } else {
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
  }
  NSString *time = [formatter stringFromDate:tempDate];
  // 3.显示日期
  _lastUpdateTimeLabel.text = [NSString stringWithFormat:@"最后更新：%@", time];
}
- (void)singleRow {
  if (_statusLabel) {
    bSingleRow = YES;
  }
}

#pragma mark 监听UIScrollView的contentOffset属性
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
  [super observeValueForKeyPath:keyPath
                       ofObject:object
                         change:change
                        context:context];
  if ([@"contentOffset" isEqualToString:keyPath]) {
    if (_scrollView.contentOffset.y < -5) {
      [self updateTimeLabel];
    }
  }
}

#pragma mark 设置状态
- (void)setState:(RefreshState)state {
  if (_state == state)
    return;

  [super setState:state];

  // 保存旧状态
  RefreshState oldState = _state;

  switch (_state = state) {
  case RefreshStatePulling: {
    _statusLabel.text = kReleaseToRefresh;
    [self updateTimeLabel];

    [UIView animateWithDuration:0.2
                     animations:^{
                       _arrowImage.transform =
                           CGAffineTransformMakeRotation(M_PI);
                       UIEdgeInsets inset = _scrollView.contentInset;
                       inset.top = 0;
                       _scrollView.contentInset = inset;
                     }];
    break;
  }

  case RefreshStateNormal: {
    _statusLabel.text = kPullToRefresh;

    // 刷新完毕
    if (oldState == RefreshStateRefreshing) {
      // 保存刷新时间
      self.lastUpdateTime = [NSDate date];
#ifdef NeedAudio
      AudioServicesPlaySystemSound(_endRefreshId);
#endif
    }
    [UIView animateWithDuration:0.2
                     animations:^{
                       _arrowImage.transform = CGAffineTransformIdentity;
                       UIEdgeInsets inset = _scrollView.contentInset;
                       inset.top = 0;
                       _scrollView.contentInset = inset;
                     }];
    break;
  }
  case RefreshStateRefreshing: {
    _statusLabel.text = kRefreshing;

    [UIView animateWithDuration:0.2
                     animations:^{
                       // 1.顶部多出65的滚动范围
                       UIEdgeInsets inset = _scrollView.contentInset;
                       inset.top = kViewHeight;
                       _scrollView.contentInset = inset;
                       // 2.设置滚动位置
                       _scrollView.contentOffset = CGPointMake(0, -kViewHeight);
                     }];
    break;
  }
  }
}

#pragma mark - 在父类中用得上
// 合理的Y值
- (CGFloat)validY {
  return 0;
}

// view的类型
- (int)viewType {
  return RefreshViewTypeHeader;
}
@end