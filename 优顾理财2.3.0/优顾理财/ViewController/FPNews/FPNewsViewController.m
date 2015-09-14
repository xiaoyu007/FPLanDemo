//
//  FPNewsViewController.m
//  优顾理财
//
//  Created by Mac on 15/6/29.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//
#import "FPNewsViewController.h"
#import "OrderViewController.h"
#import "NewsListViewController.h"

#define instructionBtnWith 40

@implementation FPNewsViewController
/** 单击导航栏“说明”按钮响应函数 */
- (void)clickOnInstructionBtn:(UIButton *)clickedBtn {
  NewsChannelItem *item = myChannelList.channels[pageIndex];
  NSString *selectedChangel = item.channleID;
  OrderViewController *orderVC = [[OrderViewController alloc] init];
  __weak FPNewsViewController *strongSelf = self;
  orderVC.block = ^() {
    if (strongSelf) {
      NewsChannelList *mylist = [FileChangelUtil loadMyNewsChannelList];
      if (mylist.channels.count > 0) {
        [myChannelList.channels removeAllObjects];
        [myChannelList.channels addObjectsFromArray:mylist.channels];
      }
      ///选择当前频道
      [self getChangleID:selectedChangel];
      [self createMainView];
    }
  };
  [FPYouguUtil isPushAnimtion:NO];
  [AppDelegate pushViewControllerFromRight:orderVC];
  return;
}

///判断当前选择的频道
- (NSInteger)getChangleID:(NSString *)changleid {
  pageIndex = 0;
  [myChannelList.channels enumerateObjectsUsingBlock:^(NewsChannelItem *obj, NSUInteger idx, BOOL *stop) {
    if ([obj.channleID isEqualToString:changleid]) {
      pageIndex = (int)idx;

      *stop = YES;
    }
  }];
  return pageIndex;
}

#pragma mark ——— 子控件懒加载 ———
/** 懒加载顶部右侧“说明”按钮 */
- (UIButton *)instructionBtn {
  if (_instructionBtn == nil) {
    _instructionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  }
  return _instructionBtn;
}
/** 设置顶部右侧“说明”按钮 */
- (void)setupInstructionBtn {
  self.instructionBtn.frame =
      CGRectMake(self.childView.width - instructionBtnWith, 0, instructionBtnWith, 45);
  self.instructionBtn.backgroundColor = [UIColor whiteColor];
  [self.instructionBtn setImage:[UIImage imageNamed:@"侧边栏-白天"] forState:UIControlStateNormal];
  UIImage *highLightImage = [FPYouguUtil createImageWithColor:buttonHighLightColor];
  [self.instructionBtn setImage:[UIImage imageNamed:@"侧边栏-白天"]
                       forState:UIControlStateHighlighted];
  [self.instructionBtn setBackgroundImage:highLightImage forState:UIControlStateHighlighted];
  [self.instructionBtn addTarget:self
                          action:@selector(clickOnInstructionBtn:)
                forControlEvents:UIControlEventTouchUpInside];
  [self.childView addSubview:self.instructionBtn];
}

//点击标签回调
- (void)changeToIndex:(NSInteger)index {
  if (index > 0) {
  } else
    index = 0;
  CGFloat screenWidth = self.childView.bounds.size.width;
  [_scrollView setContentOffset:CGPointMake(screenWidth * index, 0) animated:NO];
  NewsChannelItem *channel = myChannelList.channels[index];
  NewsListViewController *vc = channelVCs[channel.channleID];
  if (!vc.dataArray.dataBinded) {
    [vc refreshButtonPressDown];
  }
  pageIndex = index;
  selectedChannel = channel;
}

- (void)creatView {
  NewsChannelList *mylist = [FileChangelUtil loadMyNewsChannelList];
  if (mylist.channels.count > 0) {
    [myChannelList.channels addObjectsFromArray:mylist.channels];
  } else {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"AllChannelNews.plist" ofType:nil];
    NSMutableArray *mylist = [NSMutableArray arrayWithContentsOfFile:path][0];
    for (int i = 0; i < mylist.count; i++) {
      NSDictionary *dic = mylist[i];
      NSString *changId = dic[@"ChangID"];
      NSString *Name = dic[@"Name"];
      NewsChannelItem *item = [[NewsChannelItem alloc] init];
      item.channleID = changId;
      item.name = Name;
      if (i == 0) {
        item.isEditable = NO;
        item.isVisible = NO;
      } else {
        item.isEditable = YES;
        item.isVisible = YES;
      }
      [myChannelList.channels addObject:item];
    }
    [FileChangelUtil saveMyNewsChannelList:myChannelList];
  }
  /// ui布局
  pageIndex = 0;
  [self createMainView];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.isStatus = NO;
  self.loading.hidden = YES;
  ///导航条右上角，频道选择
  [self setupInstructionBtn];
  [self createInitView];
}
- (void)createInitView {
  //  self.loading.hidden = NO;
  channelVCs = [[NSMutableDictionary alloc] init];
  myChannelList = [[NewsChannelList alloc] init];
  myChannelList.channels = [[NSMutableArray alloc] init];
  newsMyChannelList = [[NewsChannelList alloc] init];
  newsMyChannelList.channels = [[NSMutableArray alloc] init];
  moreChannelList = [[NewsChannelList alloc] init];
  moreChannelList.channels = [[NSMutableArray alloc] init];
  [FPYouguUtil performBlockOnMainThread:^{
    [self creatView];
  } withDelaySeconds:0.01];
}
//创建滚动视图
- (void)createScrollView {
  CGFloat width = self.childView.bounds.size.width;
  CGFloat height = CGRectGetHeight(self.childView.bounds) - 45.0f;

  if (!_scrollView) {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 45.0f, width, height)];
    _scrollView.contentSize = CGSizeMake(width * myChannelList.channels.count, height);
    _scrollView.backgroundColor = [UIColor grayColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.decelerationRate = 1.0f;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = YES;
    _scrollView.bounces = NO;
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    _scrollView.backgroundColor = [UIColor clearColor];
    [self.childView addSubview:_scrollView];
  } else {
    [_scrollView removeAllSubviews];
    _scrollView.contentOffset = CGPointMake(0, 0);
    _scrollView.contentSize = CGSizeMake(self.childView.width, height);
  }
}
//设置标示线 在滚动是代理方法里
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (scrollView == _scrollView) {
    ///偏移量
    CGFloat tool_left = scrollView.contentOffset.x / _scrollView.width * topToolbarView.maxlineView.width;
    topToolbarView.maxlineView.left = tool_left;
  }
}
#pragma mark scrollView代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  CGPoint offset = scrollView.contentOffset;
  if (offsetX.x != offset.x && scrollView == _scrollView && offset.x >= 0 &&
      offset.x <= _scrollView.width * (myChannelList.channels.count - 1)) {
    NSInteger index = offset.x / _scrollView.width;
    [topToolbarView changTapToIndex:index];
    pageIndex = index;
    [self refreshButtonPressDown];
    offsetX = offset;
  }
}
#pragma mark
#pragma mark------------------界面---------------
- (void)createMainView {
  if (!topToolbarView) {
    topToolbarView =
        [[TopToolBarUIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.childView.bounds.size.width - instructionBtnWith, 45)
                                            DataArray:myChannelList.channels
                                  withInitButtonIndex:0];
    topToolbarView.Tooldelegate = self;
    [self.childView addSubview:topToolbarView];
    UIView *line_bottomLineView =
        [[UIView alloc] initWithFrame:CGRectMake(0, topToolbarView.bottom - 1, self.childView.width, 1)];
    line_bottomLineView.backgroundColor = [Globle colorFromHexRGB:Color_WFOrange_btnDown];
    [self.childView addSubview:line_bottomLineView];
  } else {
    topToolbarView.ttlv_corSelIndex = pageIndex;
    [topToolbarView removeAllSubviews];
    [topToolbarView creatCtrlor:myChannelList.channels];
  }
  [self createScrollView];
  [self updateViewControllers];
  //  [FPYouguUtil performBlockOnGlobalThread:^{
  //    [self updateViewControllers];
  //  } withDelaySeconds:0.1];
}
/** 更新当前页面，例如：当用户编辑要现实的栏目时，可以调用此方法
 * 1. 从父VC中移除；
 * 2. 重用或新建子vc，添加至父vc中；
 * 3. 重置当前选中的栏目，如果仍然存在，显示此栏目，否则显示第一个栏目
 */
- (void)updateViewControllers {
  CGFloat width = self.scrollView.width;
  //  __block NSInteger newSelectIndex = 0;
  NSMutableDictionary *oldChannelVCs = [channelVCs mutableCopy];
  [channelVCs removeAllObjects];
  [_scrollView removeAllSubviews];

  [myChannelList.channels enumerateObjectsUsingBlock:^(NewsChannelItem *obj, NSUInteger idx, BOOL *stop) {
    //数据
    CGRect frame = CGRectMake(width * idx, 0, width, CGRectGetHeight(_scrollView.bounds));

    NewsListViewController *vc = oldChannelVCs[obj.channleID];
    if (vc == nil) {
      vc = [[NewsListViewController alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)
                                           withChannelID:obj.channleID
                                         withChannelName:obj.name];
    }
    vc.view.frame = frame;
    channelVCs[obj.channleID] = vc;
    [self addChildViewController:vc];
    [_scrollView addSubview:vc.view];
  }];
  _scrollView.contentSize = CGSizeMake(width * channelVCs.count, _scrollView.height);
  _scrollView.contentOffset = CGPointMake(width * pageIndex, 0);

  //切换至新选中的栏目
  if (pageIndex >= 0) {
    CGFloat screenWidth = self.childView.bounds.size.width;
    [_scrollView setContentOffset:CGPointMake(screenWidth * pageIndex, 0) animated:NO];
    NewsChannelItem *channel = myChannelList.channels[pageIndex];
    selectedChannel = channel;
    if (pageIndex == 0) {
      [FPYouguUtil performBlockOnMainThread:^{
        NewsListViewController *vc = channelVCs[channel.channleID];
        [vc refreshButtonPressDown];
      } withDelaySeconds:0.1];
    }
  }
}
#pragma mark-----------------------end-----------------------
- (void)refreshButtonPressDown {
  NewsChannelItem *channel = myChannelList.channels[pageIndex];
  NewsListViewController *vc = channelVCs[channel.channleID];
//  [vc addScrollTableViewHeader];
  if (vc.dataArray.array.count > 0) {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"isAutoRefresh"
                                                        object:channel.channleID
                                                      userInfo:nil];
  } else {
    [vc refreshButtonPressDown];
  }
}
@end
