//
//  FPNewsViewController.h
//  优顾理财
//
//  Created by Mac on 15/6/29.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPNoTitleViewController.h"
#import "TopToolBarUIScrollView.h"
#import "NewsChannelList.h"

@interface FPNewsViewController
    : FPNoTitleViewController <UIScrollViewDelegate,
                               TopToolBarUIScrollViewDelegate> {
  ///当前页面索引
  NSInteger pageIndex;
  ///当前选中的栏目
  NewsChannelItem *selectedChannel;

  //创建上方导航栏
  TopToolBarUIScrollView *topToolbarView;

  NSMutableDictionary *channelVCs;

  NewsChannelList *myChannelList;
  NewsChannelList *newsMyChannelList;
  NewsChannelList *moreChannelList;

  CGRect *rectframe;
  /// 滑动偏移量
  CGPoint offsetX;
}
/** 顶部右侧“说明”按钮 */
@property(strong, nonatomic) UIButton *instructionBtn;
@property(nonatomic, strong) UIScrollView *scrollView;
@end
