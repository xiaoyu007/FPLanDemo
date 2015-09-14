//
//  YGForthViewController.m
//  优顾理财
//
//  Created by Mac on 15/3/15.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPFundShopViewController.h"
#import "FPFundDetailedViewController.h"
#import "FPFinacingShopCell.h"
#import "FPRiskEvaluatingViewController.h"
#import "FPMyOptionalShareManager.h"
#import "FileFundListUtil.h"
#import "DateChangeSimple.h"

const NSInteger pull2RefreshHeaderHeight = 30;
const NSInteger pull2RefreshFooterHeight = 60;

#define shrinkHeadViewHeight 72.0f
#define unfoldHeadViewHeight 175.0f
#define sectionHeight 40.0f
#define rowHeight 80.0f
#define headViewTitleViewGapHeight 7.0f
#define headviewBgGapHeight 18.0f
#define isFirstShowThisPage @"isFirstShowThisPage"

#define defaultGainType 2
#define lowGainType 1
#define middleGainType 2
#define highGainType 3

@interface YGBaseViewController ()

@end

@implementation FPFundShopViewController {
  ///左竖分割线
  UIView *leftVerCuttingLine;
  ///中竖分割线
  UIView *middleVerCuttingLine;
  ///右竖分割线
  UIView *rightVerCuttingLine;
}
- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.view.backgroundColor = [Globle colorFromHexRGB:customBGColor];
    self.isStatus = NO;
    //加载一次自选数据
    [[FPMyOptionalShareManager shareManager] loadMyOptionalData];
    lowFundShopArray = [[NSMutableArray alloc] init];
    midFundShopArray = [[NSMutableArray alloc] init];
    highFundShopArray = [[NSMutableArray alloc] init];
    titleHeight = 0;
    //无网状态图
    self.loading.frame = CGRectMake(
        0.0f, shrinkHeadViewHeight + statusBarHeight, windowWidth,
        windowHeight - shrinkHeadViewHeight - statusBarHeight - 45.0f);
    [self createMainView];
  }
  return self;
}

- (void)viewWillAppear:(BOOL)animated {
  [_headView.shrinkInterBGView.timer setFireDate:[NSDate distantPast]];
  [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
  [_headView.shrinkInterBGView.timer setFireDate:[NSDate distantFuture]];
  [super viewDidDisappear:animated];
}

#pragma mark - view视图
- (void)createHeadView {
  //顶部视图
  _headView = [[[NSBundle mainBundle] loadNibNamed:@"FPFinacingShopHeadView"
                                             owner:self
                                           options:nil] firstObject];
  _headView.width = windowWidth;
  [self.view addSubview:_headView];
  [_headView.riskAssessmentBtn addTarget:self
                                  action:@selector(riskEvaluateButtonClicked)
                        forControlEvents:UIControlEventTouchUpInside];
  //低和高按钮
  [_headView.lowButton addTarget:self
                          action:@selector(leftButtonClicked:)
                forControlEvents:UIControlEventTouchUpInside];
  [_headView.highButton addTarget:self
                           action:@selector(rightButtonClicked:)
                 forControlEvents:UIControlEventTouchUpInside];
  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(riskEvaluateButtonClicked)
             name:@"guidePageRiskBtnClicked"
           object:nil];
  /** 隐藏竖分割线*/
  [self verCuttingLine];
  if (![FPYouguUtil isExistNetwork]) {
    [self.loading animationNoNetWork];
    return;
  }
}
- (UIView *)createTBHeadView {
  //组视图(上->下：两个gap1 + 一个gap2 + 文本高度 + 一个gap2 + 一个gap1)
  UIView *sectionheadView = [[UIView alloc]
      initWithFrame:CGRectMake(0, 0, windowWidth,
                               titleHeight + headViewTitleViewGapHeight * 2.0f +
                                   +headviewBgGapHeight * 3.0f)];
  sectionheadView.backgroundColor = [UIColor clearColor];
  sectionheadView.userInteractionEnabled = YES;
  //表头标题
  if (sectionTitle && [sectionTitle length] > 0) {
    UIView *titleBGView = [[UIView alloc]
        initWithFrame:CGRectMake(20.0f, headviewBgGapHeight * 2.0f,
                                 windowWidth - 40.0f,
                                 headViewTitleViewGapHeight * 2 + titleHeight)];
    titleBGView.backgroundColor = [Globle colorFromHexRGB:@"e4e4e4"];
    [titleBGView.layer setMasksToBounds:YES];
    float radius = (headViewTitleViewGapHeight * 2.0f + titleHeight) / 2.0f;
    [titleBGView.layer setCornerRadius:radius];
    tbTitleLabel = [[UILabel alloc]
        initWithFrame:CGRectMake(35.0f, headviewBgGapHeight * 2.0f +
                                            headViewTitleViewGapHeight,
                                 windowWidth - 70.0f, titleHeight)];
    tbTitleLabel.textAlignment = NSTextAlignmentCenter;
    tbTitleLabel.numberOfLines = 0;
    tbTitleLabel.textColor = [Globle colorFromHexRGB:@"838383"];
    tbTitleLabel.text = sectionTitle;
    tbTitleLabel.font = [UIFont systemFontOfSize:12.0f];
    tbTitleLabel.backgroundColor = [UIColor clearColor];
    [sectionheadView addSubview:titleBGView];
    [sectionheadView addSubview:tbTitleLabel];
  }
  return sectionheadView;
}
- (void)createMainView {
  //内容高度
  float contentHeight = windowHeight - statusBarHeight - tabbarHeight -
                        shrinkHeadViewHeight - BOTTOM_TOOL_BAR_OFFSET_Y;
  finacingScr = [[CycleScrollView alloc]
      initWithFrame:CGRectMake(0, shrinkHeadViewHeight, windowWidth,
                               contentHeight)];
  finacingScr.backgroundColor = [UIColor clearColor];
  finacingScr.scrollView.backgroundColor = [UIColor clearColor];
  [self.childView addSubview:finacingScr];
  [self createHeadView];
  NSMutableArray *tableviewArrays = [NSMutableArray
      arrayWithArray:[self createTableviewsWithContentHeight:contentHeight]];
  FPFundShopViewController *weakSelf = self;
  finacingScr.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex) {
    FPFundShopViewController *strongSelf = weakSelf;
    //只加载当前页，其它页使用老数据
    if (strongSelf && pageIndex == finacingScr.currentPageIndex) {
      [strongSelf showPageIndex:pageIndex];
    }
    return tableviewArrays[pageIndex];
  };
  finacingScr.totalPagesCount = ^NSInteger(void) {
    return 3;
  };
  //当前点击的哪一页
  finacingScr.TapActionBlock = ^(NSInteger pageIndex) {
    NSLog(@"pageIndex = %ld", (long)pageIndex);
  };
  [self refreshScrollowOffsetWithIndex:0];
}
#pragma mark - headview中按钮事件
/** 顶部高低按钮点击 */
- (void)leftButtonClicked:(UIButton *)sender {
  [finacingScr.scrollView setContentOffset:CGPointMake(0, 0)];
}

- (void)rightButtonClicked:(UIButton *)sender {
  [finacingScr.scrollView setContentOffset:CGPointMake(windowWidth * 2, 0)];
}

/** 切换页码 */
- (void)showPageIndex:(NSInteger)pageIndex {
  switch (pageIndex) {
  case 0: {
    [_headView.lowButton setTitle:@"高" forState:UIControlStateNormal];
    [_headView.highButton setTitle:@"中" forState:UIControlStateNormal];
    [_headView changeButtonStatus:lowGainType];
    if (!isLoadingRiskEvaluatList) {
      currentProfitType = lowGainType;
      [self sendRequestWithType:lowGainType];
    }
  } break;
  case 1: {
    [_headView.lowButton setTitle:@"低" forState:UIControlStateNormal];
    [_headView.highButton setTitle:@"高" forState:UIControlStateNormal];
    [_headView changeButtonStatus:middleGainType];
    if (!isLoadingRiskEvaluatList) {
      currentProfitType = middleGainType;
      [self sendRequestWithType:middleGainType];
    }
  } break;
  case 2: {
    [_headView.lowButton setTitle:@"中" forState:UIControlStateNormal];
    [_headView.highButton setTitle:@"低" forState:UIControlStateNormal];
    [_headView changeButtonStatus:highGainType];
    if (!isLoadingRiskEvaluatList) {
      currentProfitType = highGainType;
      [self sendRequestWithType:highGainType];
    }
  } break;
  default:
    break;
  }
}
/** 创建展示的表格数组 */
- (NSMutableArray *)createTableviewsWithContentHeight:(CGFloat)contentHeight {
  NSMutableArray *tableviewArrays = [[NSMutableArray alloc] init];
  //左背景
  UIView *leftView = [[UIView alloc]
      initWithFrame:CGRectMake(0, 0, windowWidth, contentHeight)];
  leftView.backgroundColor = [UIColor clearColor];
  //竖分割线
  leftVerCuttingLine =
      [[UIView alloc] initWithFrame:CGRectMake(windowWidth / 2.0f - 1.0f, 0,
                                               2.0f, contentHeight)];
  leftVerCuttingLine.backgroundColor = [Globle colorFromHexRGB:@"dcdcdc"];
  [leftView addSubview:leftVerCuttingLine];
  leftVerCuttingLine.hidden = YES;
  //低收益表格
  finacingLowTBview = [[PullingRefreshTableView alloc]
        initWithFrame:CGRectMake(0, 0, windowWidth, contentHeight)
      pullingDelegate:self
        andRefresh_id:@"LeftFundList"];
  [finacingLowTBview setHeaderOnly:YES];
  finacingLowTBview.delegate = self;
  finacingLowTBview.dataSource = self;
  finacingLowTBview.backgroundColor = [UIColor clearColor];
  finacingLowTBview.headerView.backgroundColor =
      [Globle colorFromHexRGB:customBGColor];
  finacingLowTBview.separatorStyle = UITableViewCellSeparatorStyleNone;
  [leftView addSubview:finacingLowTBview];
  [finacingLowTBview
      setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
  [tableviewArrays addObject:leftView];
  //中背景
  UIView *middleView = [[UIView alloc]
      initWithFrame:CGRectMake(windowWidth, 0, windowWidth, contentHeight)];
  middleView.backgroundColor = [UIColor clearColor];
  //竖分割线
  middleVerCuttingLine =
      [[UIView alloc] initWithFrame:CGRectMake(windowWidth / 2.0f - 1.0f, 0,
                                               2.0f, contentHeight)];
  middleVerCuttingLine.backgroundColor = [Globle colorFromHexRGB:@"dcdcdc"];
  [middleView addSubview:middleVerCuttingLine];
  middleVerCuttingLine.hidden = YES;
  //中等收益表格
  finacingMiddleTBview = [[PullingRefreshTableView alloc]
        initWithFrame:CGRectMake(0, 0, windowWidth, contentHeight)
      pullingDelegate:self
        andRefresh_id:@"MiddleFundList"];
  [finacingMiddleTBview setHeaderOnly:YES];
  finacingMiddleTBview.delegate = self;
  finacingMiddleTBview.dataSource = self;
  finacingMiddleTBview.backgroundColor = [UIColor clearColor];
  finacingMiddleTBview.headerView.backgroundColor =
      [Globle colorFromHexRGB:customBGColor];
  finacingMiddleTBview.separatorStyle = UITableViewCellSeparatorStyleNone;
  [middleView addSubview:finacingMiddleTBview];
  [finacingMiddleTBview
      setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
  [tableviewArrays addObject:middleView];
  //右背景
  UIView *rightView = [[UIView alloc]
      initWithFrame:CGRectMake(0, 0, windowWidth, contentHeight)];
  rightView.backgroundColor = [UIColor clearColor];
  rightVerCuttingLine =
      [[UIView alloc] initWithFrame:CGRectMake(windowWidth / 2.0f - 1.0f, 0,
                                               2.0f, contentHeight)];
  rightVerCuttingLine.backgroundColor = [Globle colorFromHexRGB:@"dcdcdc"];
  [rightView addSubview:rightVerCuttingLine];
  rightVerCuttingLine.hidden = YES;
  //高收益表格
  finacingHighTBview = [[PullingRefreshTableView alloc]
        initWithFrame:CGRectMake(0, 0, windowWidth, contentHeight)
      pullingDelegate:self
        andRefresh_id:@"RightFundList"];
  [finacingHighTBview setHeaderOnly:YES];
  finacingHighTBview.delegate = self;
  finacingHighTBview.dataSource = self;
  finacingHighTBview.backgroundColor = [UIColor clearColor];
  finacingHighTBview.headerView.backgroundColor =
      [Globle colorFromHexRGB:customBGColor];
  finacingHighTBview.separatorStyle = UITableViewCellSeparatorStyleNone;
  [rightView addSubview:finacingHighTBview];
  [finacingHighTBview
      setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
  [tableviewArrays addObject:rightView];

  [self registerNibCell];

  return tableviewArrays;
}

#pragma mark - 注册NibCell
- (void)registerNibCell {
  UINib *cellNib =
      [UINib nibWithNibName:NSStringFromClass([FPFinacingShopCell class])
                     bundle:nil];
  [finacingLowTBview registerNib:cellNib
          forCellReuseIdentifier:@"FPFinacingShopCell"];
  [finacingMiddleTBview registerNib:cellNib
             forCellReuseIdentifier:@"FPFinacingShopCell"];
  [finacingHighTBview registerNib:cellNib
           forCellReuseIdentifier:@"FPFinacingShopCell"];
}

/** 显示当前收益列表 */
- (NSInteger)showProductLevel {
  NSString *keyStr = [NSString stringWithFormat:@"evalutingType"];
  NSString *selectIndex =
      [[NSUserDefaults standardUserDefaults] objectForKey:keyStr];
  return [selectIndex integerValue];
}
/** 保存收益类型 */
- (void)saveUserProductLevel:(NSInteger)level {
  NSString *keyStr = [NSString stringWithFormat:@"evalutingType"];
  NSUserDefaults *myUser = [NSUserDefaults standardUserDefaults];
  NSString *value = [NSString stringWithFormat:@"%ld", level];
  [myUser setObject:value forKey:keyStr];
  [myUser synchronize];
}
#pragma mark - 用户评级
/** 评测按钮点击 */
- (void)riskEvaluateButtonClicked {
  FPFundShopViewController *weakSelf = self;
  FPRiskEvaluatingViewController *riskVC =
      [[FPRiskEvaluatingViewController alloc]
          initWithCallback:^(FundType level) {
            FPFundShopViewController *strongSelf = weakSelf;
            if (strongSelf) {
              [strongSelf showRiskEvaluatingLevel:level];
            }
          }];
  [AppDelegate pushViewControllerFromRight:riskVC];
}
/** 评测等级 */
- (void)showRiskEvaluatingLevel:(FundType)fundType {
  //头部收回
  [_headView performSelector:@selector(headStretch)
                  withObject:nil
                  afterDelay:0.4f];
  isLoadingRiskEvaluatList = YES;
  switch (fundType) {
  case FundTypeNoneEvaluate: { //未评测
  } break;
  case FundTypeLessThanHundred: //不足100元低收益组合
  case FundTypeYouthLow:
  case FundTypeMiddleAgeLow:
  case FundTypeOldAgeLow: { //低收益
    currentProfitType = FundTypeLow;
    [self refreshScrollowOffsetWithIndex:0];
    [finacingLowTBview setContentOffset:CGPointMake(0, 0)];
    [self saveUserProductLevel:1];
  } break;
  case FundTypeYouthMiddle:
  case FundTypeMiddleAgeMiddle:
  case FundTypeOldAgeMiddle: { //中收益
    currentProfitType = FundTypeMiddle;
    [self refreshScrollowOffsetWithIndex:1];
    [finacingMiddleTBview setContentOffset:CGPointMake(0, 0)];
    [self saveUserProductLevel:2];
  } break;
  case FundTypeYouthHigh:
  case FundTypeMiddleAgeHigh:
  case FundTypeOldAgeHigh: { //高收益
    currentProfitType = FundTypeHigh;
    [self refreshScrollowOffsetWithIndex:2];
    [finacingHighTBview setContentOffset:CGPointMake(0, 0)];
    [self saveUserProductLevel:3];
  } break;
  default:
    break;
  }
  isLoadingRiskEvaluatList = NO;
  [self sendRequestWithType:fundType];
}
- (void)refreshScrollowOffsetWithIndex:(NSInteger)index {
  switch (finacingScr.currentPageIndex) {
  case 0: {
    switch (index) {
    case 0:
      [self showPageIndex:index];
      break;
    case 1: {
      [finacingScr.scrollView setContentOffset:CGPointMake(windowWidth * 2, 0)];
    } break;
    case 2: {
      [finacingScr.scrollView setContentOffset:CGPointMake(0, 0)];
    } break;
    default:
      break;
    }
  } break;
  case 1: {
    switch (index) {
    case 0:
      [finacingScr.scrollView setContentOffset:CGPointMake(0, 0)];
      break;
    case 1: {
      [self showPageIndex:index];
    } break;
    case 2: {
      [finacingScr.scrollView setContentOffset:CGPointMake(windowWidth * 2, 0)];
    } break;
    default:
      break;
    }
  } break;
  case 2: {
    switch (index) {
    case 0:
      [finacingScr.scrollView setContentOffset:CGPointMake(windowWidth * 2, 0)];
      break;
    case 1: {
      [finacingScr.scrollView setContentOffset:CGPointMake(0, 0)];
    } break;
    case 2: {
      [self showPageIndex:index];
    } break;
    default:
      break;
    }
  } break;
  default:
    break;
  }
}
#pragma mark - 网络请求
/** 请求列表数据 */
- (void)sendRequestWithType:(NSInteger)type {
  /** 判断是否有网络*/
  if (![FPYouguUtil isExistNetwork]) {
    [self.loading animationNoNetWork];
    finacingScr.userInteractionEnabled = NO;
    [self verCuttingLine];
    //加载缓存
    FPFundShopList *cache = [FileFundListUtil loadCachedFundListWithType:type];
    if (cache) {
      [self showFundListsWithFundShopList:cache];
    }
    if (lowFundShopArray.count > 0 && type == lowGainType) {
      self.loading.hidden = YES;
      leftVerCuttingLine.hidden = NO;
      finacingScr.userInteractionEnabled = YES;
    } else if (midFundShopArray.count > 0 && type == middleGainType) {
      self.loading.hidden = YES;
      middleVerCuttingLine.hidden = NO;
      finacingScr.userInteractionEnabled = YES;
    } else if (highFundShopArray.count > 0 && type == highGainType) {
      self.loading.hidden = YES;
      rightVerCuttingLine.hidden = NO;
      finacingScr.userInteractionEnabled = YES;
    } else {
      self.loading.hidden = NO;
    }
    [self stopLoadingWithType:type];
    return;
  } else {
    finacingScr.userInteractionEnabled = YES;
  }
  HttpRequestCallBack *callback = [[HttpRequestCallBack alloc] init];
  __weak FPFundShopViewController *weakSelf = self;
  callback.onSuccess = ^(NSObject *obj) {
    FPFundShopViewController *strongSelf = weakSelf;
    if (strongSelf) {
      FPFundShopList *allObject = (FPFundShopList *)obj;
      [strongSelf showFundListsWithFundShopList:allObject];
    }
  };
  callback.onCheckQuitOrStopProgressBar = ^{
    FPFundShopViewController *strongSelf = weakSelf;
    if (strongSelf) {
      [strongSelf stopLoadingWithType:type];
      return NO;
    } else {
      return YES;
    }
  };
  [FPFundShopList getFundListsWithType:type withCallback:callback];
}
- (void)stopLoadingWithType:(NSInteger)type {
  //停止刷新
  switch (type) {
  case FundTypeLow:
    [finacingLowTBview tableViewDidFinishedLoading];
    break;
  case FundTypeMiddle:
    [finacingMiddleTBview tableViewDidFinishedLoading];
    break;
  case FundTypeHigh:
    [finacingHighTBview tableViewDidFinishedLoading];
    break;
  default:
    break;
  }
}
/** 不同产品收益列表 */
- (void)showFundListsWithFundShopList:(FPFundShopList *)fundShopList {
  isLoadSuccess = YES;
  if ([FPYouguUtil isExistNetwork]) {
    //缓存
    [FileFundListUtil saveFundLists:fundShopList withType:currentProfitType];
  }
  //表头内容（评测时出现）
  sectionTitle = fundShopList.desc;
  if (sectionTitle && [sectionTitle length] > 0) {
    //表头文本高度
    titleHeight =
        [sectionTitle sizeWithFont:[UIFont systemFontOfSize:12.0f]
                 constrainedToSize:CGSizeMake(windowWidth - 70.0f, 500)]
            .height;
  }
  switch (currentProfitType) {
  case FundTypeLessThanHundred:
  case FundTypeLow:
  case FundTypeYouthLow:
  case FundTypeMiddleAgeLow:
  case FundTypeOldAgeLow: {
    if ([lowFundShopArray count] > 0) {
      [lowFundShopArray removeAllObjects];
    }
    [lowFundShopArray addObjectsFromArray:fundShopList.fundLists];
    if (lowFundShopArray.count == 0) {
      leftVerCuttingLine.hidden = YES;
      [self.loading notDataStatus];
    } else {
      self.loading.hidden = YES;
      leftVerCuttingLine.hidden = NO;
    }
    //评测提示语
    if ([sectionTitle length] > 0) {
      [finacingLowTBview setTableHeaderView:[self createTBHeadView]];
    } else {
      [finacingLowTBview
          setTableHeaderView:[[UIView alloc]
                                 initWithFrame:CGRectMake(0, 0, windowWidth,
                                                          20.0f)]];
    }
    [finacingLowTBview reloadData];
  } break;
  case FundTypeMiddle:
  case FundTypeYouthMiddle:
  case FundTypeMiddleAgeMiddle:
  case FundTypeOldAgeMiddle: {
    if ([midFundShopArray count] > 0) {
      [midFundShopArray removeAllObjects];
    }
    [midFundShopArray addObjectsFromArray:fundShopList.fundLists];
    if (midFundShopArray.count == 0) {
      middleVerCuttingLine.hidden = YES;
      [self.loading notDataStatus];
    } else {
      self.loading.hidden = YES;
      middleVerCuttingLine.hidden = NO;
    }
    //评测提示语
    if ([sectionTitle length] > 0) {
      [finacingMiddleTBview setTableHeaderView:[self createTBHeadView]];
    } else {
      [finacingMiddleTBview
          setTableHeaderView:[[UIView alloc]
                                 initWithFrame:CGRectMake(0, 0, windowWidth,
                                                          20.0f)]];
    }
    [finacingMiddleTBview reloadData];
  } break;
  case FundTypeHigh:
  case FundTypeYouthHigh:
  case FundTypeMiddleAgeHigh:
  case FundTypeOldAgeHigh: {
    if ([highFundShopArray count] > 0) {
      [highFundShopArray removeAllObjects];
    }
    [highFundShopArray addObjectsFromArray:fundShopList.fundLists];
    if (highFundShopArray.count == 0) {
      rightVerCuttingLine.hidden = YES;
      [self.loading notDataStatus];
    } else {
      self.loading.hidden = YES;
      rightVerCuttingLine.hidden = NO;
    }
    //评测提示语
    if ([sectionTitle length] > 0) {
      [finacingHighTBview setTableHeaderView:[self createTBHeadView]];
    } else {
      [finacingHighTBview
          setTableHeaderView:[[UIView alloc]
                                 initWithFrame:CGRectMake(0, 0, windowWidth,
                                                          20.0f)]];
    }
    [finacingHighTBview reloadData];
  } break;
  default:
    break;
  }
}
/** 分割线隐藏 */
- (void)verCuttingLine {
  if ([lowFundShopArray count] < 1) {
    leftVerCuttingLine.hidden = YES;
  }
  if ([midFundShopArray count] < 1) {
    middleVerCuttingLine.hidden = YES;
  }
  if ([highFundShopArray count] < 1) {
    rightVerCuttingLine.hidden = YES;
  }
}
#pragma mark - 重载表格协议函数
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  if (tableView == finacingLowTBview) {
    return [lowFundShopArray count];
  } else if (tableView == finacingMiddleTBview) {
    return [midFundShopArray count];
  } else
    return [highFundShopArray count];
}

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return rowHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellId = @"FPFinacingShopCell";
  FPFinacingShopCell *cell =
      [tableView dequeueReusableCellWithIdentifier:cellId];
  FPFundShopItem *list;
  if (tableView == finacingLowTBview) {
    list = [lowFundShopArray objectAtIndex:indexPath.row];
  } else if (tableView == finacingMiddleTBview) {
    list = [midFundShopArray objectAtIndex:indexPath.row];
  } else {
    list = [highFundShopArray objectAtIndex:indexPath.row];
  }
  if (indexPath.row % 2) {
    //左侧列表
    [cell showLeftView:NO];
    [cell showRightData:list];
  } else {
    //右侧列表
    [cell showLeftView:YES];
    [cell showLeftData:list];
  }
  return cell;
}
#pragma mark - PullingRefreshTableViewDelegate
- (void)pullingTableViewDidStartRefreshing:
    (PullingRefreshTableView *)tableView {
  [self performSelector:@selector(sendRequest) withObject:nil afterDelay:1.f];
}
/** 延迟加载 */
- (void)sendRequest {
  [self sendRequestWithType:currentProfitType];
}
//刷新结束后，更变，更新刷新时间
- (NSDate *)pullingTableViewRefreshingFinishedDate {
  //停止刷新
  switch (currentProfitType) {
  case FundTypeLow:
    return [self reloadSuccessWithKey:@"LeftFundList"];
    break;
  case FundTypeMiddle:
    return [self reloadSuccessWithKey:@"MiddleFundList"];
    break;
  default:
    return [self reloadSuccessWithKey:@"RightFundList"];
    break;
  }
}
/** 列表重复加载成功，记录当前加载时间 */
- (NSDate *)reloadSuccessWithKey:(NSString *)keyLable {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
  //特指的一片文章的评论
  NSString *key = YouGu_StringWithFormat_double(@"NewsListRefrash_", keyLable);
  NSString *date_time = YouGu_defaults(key);
  NSDate *date = [dateFormatter dateFromString:date_time];

  YouGu_defaults_double(date_time, key);
  if (isLoadSuccess) {
    date = [NSDate date];
    NSString *date_ttime = [dateFormatter stringFromDate:date];
    YouGu_defaults_double(date_ttime, key);
    isLoadSuccess = NO;
  }
  return date;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  //任何情况下，下拉刷新，都是要可以的
  CGPoint offset = scrollView.contentOffset;
  if (offset.y < 0) {
    switch (currentProfitType) {
    case FundTypeLow:
      [finacingLowTBview tableViewDidScroll:scrollView];
      break;
    case FundTypeMiddle:
      [finacingMiddleTBview tableViewDidScroll:scrollView];
      break;
    case FundTypeHigh:
      [finacingHighTBview tableViewDidScroll:scrollView];
    default:
      break;
    }
    return;
  }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate {
  switch (currentProfitType) {
  case FundTypeLow:
    [finacingLowTBview tableViewDidEndDragging:scrollView];
    break;
  case FundTypeMiddle:
    [finacingMiddleTBview tableViewDidEndDragging:scrollView];
    break;
  case FundTypeHigh:
    [finacingHighTBview tableViewDidEndDragging:scrollView];
  default:
    break;
  }
}

#pragma mark - loading 代理方法
- (void)refreshNewInfo {
  if ([FPYouguUtil isExistNetwork]) {
    [self sendRequestWithType:currentProfitType];
  }
}
- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
