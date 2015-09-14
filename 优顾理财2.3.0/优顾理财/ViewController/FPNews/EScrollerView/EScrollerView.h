//
//  EScrollerView.h
//  icoiniPad
//
//  Created by Ethan on 12-11-24.
//
//

#import <UIKit/UIKit.h>

#import "CustomPageDada.h"

@protocol EScrollerViewDelegate <NSObject>
@optional
/** 广告接收点击 */
- (void)EScrollerViewDidClicked:(NSUInteger)index;
@end
/** 广告视图 */
@interface EScrollerView : UIView <UIScrollViewDelegate> {
  /** 当前页面 */
  int currentPageIndex;
}
@property(nonatomic, strong) UIView* noteView;
@property(nonatomic, assign) id<EScrollerViewDelegate> delegate;
/** 广告图 */
@property(nonatomic, strong) UIScrollView *scrollView;
/** 导航栏索引 */
@property(nonatomic, strong) UIPageControl *pageControl;
/** 文本显示 */
@property(nonatomic, strong) UILabel *noteTitle;
///夜间模式，加屏幕
@property(nonatomic, strong) UIView *pin_view;
/** 头部数据 */
@property(nonatomic, strong) NSMutableArray *header_array;
/** 更新头视图 */
- (void)change_images:(NSMutableArray *)array;
@end
