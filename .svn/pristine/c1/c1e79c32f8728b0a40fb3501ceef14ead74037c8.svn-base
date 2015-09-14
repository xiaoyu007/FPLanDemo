//
//  YGForthViewController.m
//  优顾理财
//
//  Created by Mac on 15/3/15.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FundDetailedViewController.h"
#import "CommunicationCenterViewController.h"
#import "FinacingShopCell.h"
#import "RiskEvaluatingViewController.h"
#import "SearchFundViewController.h"
#import "Interest management_ViewController.h"
#import "MyOptionalShareManager.h"
#import "MyOptionalFundVController.h"
#import "OpenAccountInfo.h"
#import "date_simple.h"

const NSInteger pull2RefreshHeaderHeight = 30;
const NSInteger pull2RefreshFooterHeight = 60;

#define shrinkHeadViewHeight 72.0f
#define unfoldHeadViewHeight 175.0f
#define sectionHeight 40.0f
#define rowHeight 80.0f
#define headViewDownGapHeight 15.0f
#define headviewBGViewGapHeight 14.0f
#define isFirstShowThisPage @"isFirstShowThisPage"

#define defaultGainType 2
#define lowGainType 1
#define middleGainType 2
#define highGainType 3

@interface YGBaseViewController () <UITableViewDelegate, UITableViewDataSource,
                                    UITextFieldDelegate>

@end

@implementation FundShopViewController {
  Youguu_Loading_View *loadingView;
  ///左竖分割线
  UIView *leftVerCuttingLine;
  ///中竖分割线
  UIView *middleVerCuttingLine;
  ///右竖分割线
  UIView *rightVerCuttingLine;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  //加载一次自选数据
  [[MyOptionalShareManager shareManager] loadMyOptionalData];
  lowFundShopArray = [[NSMutableArray alloc] init];
  midFundShopArray = [[NSMutableArray alloc] init];
  highFundShopArray = [[NSMutableArray alloc] init];
  titleHeight = 0;
  [self createMainView];
  //无网状态图
  loadingView = [[Youguu_Loading_View alloc]
      initWithFrame:self.childView.bounds];
  loadingView.delegate = self;
  loadingView.userInteractionEnabled = YES;
  [self.childView addSubview:loadingView];
  loadingView.hidden = YES;
}
#pragma mark view视图
- (void)createHeadView{
  //顶部视图
  _headView = [[[NSBundle mainBundle] loadNibNamed:@"FinacingShopHeadView"
                                             owner:self
                                           options:nil] firstObject];
  [self.childView addSubview:_headView];
  
  [_headView.riskAssessmentBtn addTarget:self
                                  action:@selector(riskEvaluateButtonClicked)
                        forControlEvents:UIControlEventTouchUpInside];
  [_headView.myAssetsBtn addTarget:self
                            action:@selector(headviewMyAssetsClicked:)
                  forControlEvents:UIControlEventTouchUpInside];
  [_headView.accountCenterBtn addTarget:self
                            action:@selector(headviewAccountCenterButtonClicked:)
                  forControlEvents:UIControlEventTouchUpInside];
  [_headView.myOptionBtn addTarget:self
                             action:@selector(headviewMyOptionBtnClicked:)
                   forControlEvents:UIControlEventTouchUpInside];
  //低和高按钮
  [_headView.lowButton addTarget:self
                          action:@selector(leftButtonClicked:)
                forControlEvents:UIControlEventTouchUpInside];
  [_headView.highButton addTarget:self
                           action:@selector(rightButtonClicked:)
                 forControlEvents:UIControlEventTouchUpInside];
  [_headView.searchTextClickBtn addTarget:self
                                   action:@selector(clickSearchText:)
                         forControlEvents:UIControlEventTouchUpInside];
  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(riskEvaluateButtonClicked) name:@"guidePageRiskBtnClicked" object:nil];
  [self createSearchView];
  /** 隐藏竖分割线*/
  [self verCuttingLine];
  if (YouGu_Not_NetWork == YES) {
    [loadingView btn_click];
  }
}
- (UIView *)createTBHeadView{
  //组视图
  UIView *sectionheadView = [[UIView alloc]
                             initWithFrame:CGRectMake(0, 0, windowWidth,  titleHeight
                                                      +
                                                      headViewDownGapHeight +
                                                      headviewBGViewGapHeight + 20.0f)];
  sectionheadView.backgroundColor = [UIColor clearColor];
  sectionheadView.userInteractionEnabled = YES;
  //表头标题
  if (sectionTitle && [sectionTitle length] > 0) {
    UIView *titleBGView = [[UIView alloc]
                           initWithFrame:CGRectMake(20.0f,headviewBGViewGapHeight + headViewDownGapHeight + 7.0f, windowWidth - 40.0f,
                                                    headviewBGViewGapHeight + titleHeight)];
    titleBGView.backgroundColor = [Globle colorFromHexRGB:@"e4e4e4"];
    [titleBGView.layer setMasksToBounds:YES];
    [titleBGView.layer
     setCornerRadius:(headviewBGViewGapHeight + titleHeight) / 2.0f];
    tbTitleLabel = [[UILabel alloc]
                    initWithFrame:CGRectMake(35.0f, 14.0f + headviewBGViewGapHeight + headViewDownGapHeight,
                                             windowWidth - 70.0f, titleHeight)];
    tbTitleLabel.textAlignment = NSTextAlignmentLeft;
    tbTitleLabel.numberOfLines = 0;
    tbTitleLabel.textColor = [Globle colorFromHexRGB:@"838383"];
    tbTitleLabel.text = sectionTitle;
    tbTitleLabel.font = [UIFont systemFontOfSize:11.0f];
    tbTitleLabel.backgroundColor = [UIColor clearColor];
    [sectionheadView addSubview:titleBGView];
    [sectionheadView addSubview:tbTitleLabel];
  }
  return sectionheadView;
}
- (void)createMainView {
  //内容高度
  float contentHeight =
  self.childView.height - tabbarHeight - shrinkHeadViewHeight;
  finacingScr = [[CycleScrollView alloc]
                 initWithFrame:CGRectMake(0, shrinkHeadViewHeight, windowWidth,
                                          contentHeight)];
  finacingScr.backgroundColor = [UIColor whiteColor];
  [self.childView addSubview:finacingScr];
  [self createHeadView];
  
  NSMutableArray *tableviewArrays = [NSMutableArray arrayWithArray:[self createTableviewsWithContentHeight:contentHeight]];
  FundShopViewController *weakSelf = self;
  finacingScr.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
    FundShopViewController *strongSelf = weakSelf;
    //只加载当前页，其它页使用老数据
    if (strongSelf&&pageIndex == finacingScr.currentPageIndex) {
      [strongSelf showPageIndex:pageIndex];
    }
    return tableviewArrays[pageIndex];
  };
  finacingScr.totalPagesCount = ^NSInteger(void){
    return 3;
  };
  //当前点击的哪一页
  finacingScr.TapActionBlock = ^(NSInteger pageIndex){
    NSLog(@"pageIndex = %ld", pageIndex);
  };
  NSInteger index = [self showProductLevel];
  //只区分了左右移动，具体index不确定
  if (index > 0) {
    [self refreshScrollowContentOffSetWithIndex:index - 1];
  }else{
    //左移
    [finacingScr.scrollView setContentOffset:CGPointMake(windowWidth * 2, 0)];
  }
}
- (void)refreshScrollowContentOffSetWithIndex:(NSInteger)index{
  if (index == 1) {
    //左移
    [finacingScr.scrollView setContentOffset:CGPointMake(windowWidth * 2, 0)];
  }else if (index == 2){
    //右移
    [finacingScr.scrollView setContentOffset:CGPointMake(0, 0)];
  }else{
    [self showPageIndex:index];
  }
}
/** 切换页码 */
- (void)showPageIndex:(NSInteger)pageIndex{
  switch (pageIndex) {
    case 0:
    {
      [_headView.lowButton setTitle:@"高" forState:UIControlStateNormal];
      [_headView.highButton setTitle:@"中" forState:UIControlStateNormal];
      [_headView changeButtonStatus:lowGainType];
      if (!isLoadingRiskEvaluatList) {
        [self sendRequestWithType:lowGainType];
        currentProfitType = lowGainType;
      }
    }
      break;
    case 1:
    {
      [_headView.lowButton setTitle:@"低" forState:UIControlStateNormal];
      [_headView.highButton setTitle:@"高" forState:UIControlStateNormal];
      [_headView changeButtonStatus:middleGainType];
      if (!isLoadingRiskEvaluatList) {
        [self sendRequestWithType:middleGainType];
        currentProfitType = middleGainType;
      }
    }
      break;
    case 2:
    {
      [_headView.lowButton setTitle:@"中" forState:UIControlStateNormal];
      [_headView.highButton setTitle:@"低" forState:UIControlStateNormal];
      [_headView changeButtonStatus:highGainType];
      if (!isLoadingRiskEvaluatList) {
        [self sendRequestWithType:highGainType];
        currentProfitType = highGainType;
      }
    }
      break;
    default:
      break;
  }
}
/** 创建展示的表格数组 */
- (NSMutableArray *)createTableviewsWithContentHeight:(CGFloat)contentHeight{
  NSMutableArray *tableviewArrays = [[NSMutableArray alloc]init];
  //左背景
  UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, windowWidth, contentHeight)];
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
                       initWithFrame:CGRectMake(0, 0, windowWidth, contentHeight) pullingDelegate:self andRefresh_id:@"LeftFundList"];
  [finacingLowTBview setHeaderOnly:YES];
  finacingLowTBview.delegate = self;
  finacingLowTBview.dataSource = self;
  finacingLowTBview.backgroundColor = [UIColor clearColor];
  finacingLowTBview.headerView.backgroundColor = [Globle colorFromHexRGB:customBGColor];
  finacingLowTBview.separatorStyle = UITableViewCellSeparatorStyleNone;
  [leftView addSubview:finacingLowTBview];
  [finacingLowTBview setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
  [tableviewArrays addObject:leftView];
  //中背景
  UIView *middleView = [[UIView alloc]initWithFrame:CGRectMake(windowWidth, 0, windowWidth, contentHeight)];
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
                          initWithFrame:CGRectMake(0, 0, windowWidth, contentHeight) pullingDelegate:self andRefresh_id:@"MiddleFundList"];
  [finacingMiddleTBview setHeaderOnly:YES];
  finacingMiddleTBview.delegate = self;
  finacingMiddleTBview.dataSource = self;
  finacingMiddleTBview.backgroundColor = [UIColor clearColor];
  finacingMiddleTBview.headerView.backgroundColor = [Globle colorFromHexRGB:customBGColor];
  finacingMiddleTBview.separatorStyle = UITableViewCellSeparatorStyleNone;
  [middleView addSubview:finacingMiddleTBview];
  [finacingMiddleTBview setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
  [tableviewArrays addObject:middleView];
  //右背景
  UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, windowWidth, contentHeight)];
  rightView.backgroundColor = [UIColor clearColor];
  rightVerCuttingLine =
  [[UIView alloc] initWithFrame:CGRectMake(windowWidth / 2.0f - 1.0f, 0,
                                           2.0f, contentHeight)];
  rightVerCuttingLine.backgroundColor = [Globle colorFromHexRGB:@"dcdcdc"];
  [rightView addSubview:rightVerCuttingLine];
  rightVerCuttingLine.hidden = YES;
  //高收益表格
  finacingHighTBview = [[PullingRefreshTableView alloc]
                        initWithFrame:CGRectMake(0, 0, windowWidth, contentHeight) pullingDelegate:self andRefresh_id:@"RightFundList"];
  [finacingHighTBview setHeaderOnly:YES];
  finacingHighTBview.delegate = self;
  finacingHighTBview.dataSource = self;
  finacingHighTBview.backgroundColor = [UIColor clearColor];
  finacingHighTBview.headerView.backgroundColor = [Globle colorFromHexRGB:customBGColor];
  finacingHighTBview.separatorStyle = UITableViewCellSeparatorStyleNone;
  [rightView addSubview:finacingHighTBview];
  [finacingHighTBview setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
  [tableviewArrays addObject:rightView];
  return tableviewArrays;
}
/** 显示当前收益列表 */
- (NSInteger)showProductLevel{
  NSInteger selectIndex = [[NSUserDefaults standardUserDefaults]integerForKey:@"evalutingType"];
  return selectIndex;
}
/** 创建搜索控件 */
- (void)createSearchView {
  //搜索控件
  UIView *grayView =
  [[UIView alloc] initWithFrame:CGRectMake(2.0f, 5.0f, 102.0f, 24.0f)];
  grayView.backgroundColor = [Globle colorFromHexRGB:@"e7e7e2"];
  grayView.userInteractionEnabled = NO;
  [grayView.layer setMasksToBounds:YES];
  [grayView.layer setCornerRadius:12.0f];
  grayView.alpha = 0.85f;
  [_headView.searchTextClickBtn addSubview:grayView];
  searchTextfield =
  [[UITextField alloc] initWithFrame:CGRectMake(10.0f, 2.0f, 60.0f, 20.0f)];
  searchTextfield.placeholder = @"产品查询";
  searchTextfield.delegate = self;
  searchTextfield.userInteractionEnabled = NO;
  searchTextfield.returnKeyType = UIReturnKeySearch;
  searchTextfield.textAlignment = NSTextAlignmentLeft;
  searchTextfield.textColor = [Globle colorFromHexRGB:@"a8a8a8"];
  searchTextfield.font = [UIFont systemFontOfSize:12.0f];
  searchTextfield.backgroundColor = [UIColor clearColor];
  [grayView addSubview:searchTextfield];
  UIImageView *searchImageView =
  [[UIImageView alloc] initWithFrame:CGRectMake(75.0f, 4.0f, 16.0f, 16.0f)];
  searchImageView.image = [UIImage imageNamed:@"搜索图标"];
  [grayView addSubview:searchImageView];
}
/** 评测按钮点击 */
- (void)riskEvaluateButtonClicked {
  FundShopViewController *weakSelf = self;
  RiskEvaluatingViewController *riskVC =
  [[RiskEvaluatingViewController alloc] initWithCallback:^(FundType level) {
    FundShopViewController *strongSelf = weakSelf;
    if (strongSelf) {
      [strongSelf showRiskEvaluatingLevel:level];
    }
  }];
  [APP_AppDelegate PushYGsetViewController:riskVC];
}
/** 评测等级 */
- (void)showRiskEvaluatingLevel:(FundType)fundType {
  isLoadingRiskEvaluatList = YES;
  NSUserDefaults *myUser = [NSUserDefaults standardUserDefaults];
  switch (fundType) {
    case FundTypeNoneEvaluate: { //未评测
    } break;
    case FundTypeLessThanHundred: //不足100元低收益组合
    case FundTypeYouthLow:
    case FundTypeMiddleAgeLow:
    case FundTypeOldAgeLow: { //低收益
      currentProfitType = FundTypeLow;
      [self refreshScrollowOffsetWithIndex:0];
      [myUser setInteger:1 forKey:@"evalutingType"];
      [myUser synchronize];
    } break;
    case FundTypeYouthMiddle:
    case FundTypeMiddleAgeMiddle:
    case FundTypeOldAgeMiddle: { //中收益
      currentProfitType = FundTypeMiddle;
      [self refreshScrollowOffsetWithIndex:1];
      [myUser setInteger:2 forKey:@"evalutingType"];
      [myUser synchronize];
    } break;
    case FundTypeYouthHigh:
    case FundTypeMiddleAgeHigh:
    case FundTypeOldAgeHigh: { //高收益
      currentProfitType = FundTypeHigh;
      [self refreshScrollowOffsetWithIndex:2];
      [myUser setInteger:3 forKey:@"evalutingType"];
      [myUser synchronize];
    } break;
    default:
      break;
  }
  isLoadingRiskEvaluatList = NO;
  [self sendRequestWithType:fundType];
}
- (void)refreshScrollowOffsetWithIndex:(NSInteger)index{
  switch (finacingScr.currentPageIndex) {
    case 0:
    {
      switch (index) {
        case 0:
          [self showPageIndex:index];
          break;
        case 1:
        {
          [finacingScr.scrollView setContentOffset:CGPointMake(windowWidth * 2, 0)];
        }
          break;
        case 2:
        {
          [finacingScr.scrollView setContentOffset:CGPointMake(0, 0)];
        }
          break;
        default:
          break;
      }
    }
      break;
    case 1:
    {
      switch (index) {
        case 0:
          [finacingScr.scrollView setContentOffset:CGPointMake(0, 0)];
          break;
        case 1:
        {
          [self showPageIndex:index];
        }
          break;
        case 2:
        {
          [finacingScr.scrollView setContentOffset:CGPointMake(windowWidth * 2, 0)];
        }
          break;
        default:
          break;
      }
    }
      break;
    case 2:
    {
      switch (index) {
        case 0:
          [finacingScr.scrollView setContentOffset:CGPointMake(windowWidth * 2, 0)];
          break;
        case 1:
        {
          [finacingScr.scrollView setContentOffset:CGPointMake(0, 0)];
        }
          break;
        case 2:
        {
          [self showPageIndex:index];
        }
          break;
        default:
          break;
      }
    }
      break;
    default:
      break;
  }
}
/**  分割线隐藏*/
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
/**  分割线不隐藏*/
- (void)isVerCuttingLine {
  leftVerCuttingLine.hidden = NO;
  rightVerCuttingLine.hidden = NO;
  middleVerCuttingLine.hidden = NO;
}
#pragma mark 网络请求
/** 请求列表数据 */
- (void)sendRequestWithType:(NSInteger)type {
  //读缓存
  switch (type) {
    case lowGainType:
    {
      //解析
      [self showFundListsWithType:type withData:[NSDictionary dictionaryWithContentsOfFile:[PlistOperation getPlistPath:@"lowFundShopingList"]]];
    }
      break;
    case middleGainType:
    {
      //解析
      [self showFundListsWithType:type withData:[NSDictionary dictionaryWithContentsOfFile:[PlistOperation getPlistPath:@"middleFundShopingList"]]];
    }
      break;
    case highGainType:
    {
      //解析
      [self showFundListsWithType:type withData:[NSDictionary dictionaryWithContentsOfFile:[PlistOperation getPlistPath:@"highFundShopingList"]]];
    }
      break;
    default:
      break;
  }
  //记录当前收益类型
  /** 判断是否有网络*/
  if (YouGu_Not_NetWork == YES) {
    [loadingView btn_click];
    loadingView.hidden = NO;
    [self verCuttingLine];

    if (lowFundShopArray.count > 0 && type == lowGainType) {
      loadingView.hidden = YES;
      [self isVerCuttingLine];
      return;
    } else if (midFundShopArray.count > 0 && type == middleGainType) {

      loadingView.hidden = YES;
      [self isVerCuttingLine];
      return;
    } else if (highFundShopArray.count > 0 && type == highGainType) {

      loadingView.hidden = YES;
      [self isVerCuttingLine];
      return;
    }
    return;
  }
  [[WebServiceManager sharedManager]
      loadFundListsWithType:type
             withCompletion:^(id response) {
               if (response && [[response objectForKey:@"status"]
                                   isEqualToString:@"0000"]) {
                 isLoadSuccess = YES;
                 //解析
                 [self showFundListsWithType:type withData:response];
               } else {
                 NSString *message = [NSString
                     stringWithFormat:@"%@",
                                      [response objectForKey:@"message"]];
                 if (!message || [message length] == 0 ||
                     [message isEqualToString:@"(null)"]) {
                   message = networkFailed;
                 }
                 [loadingView btn_click];
                 [self verCuttingLine];
                 YouGu_animation_Did_Start(message);
               }
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
             }];
}
/** 不同产品收益列表 */
- (void)showFundListsWithType:(FundType)type withData:(NSDictionary *)dict {
  //表头内容（评测时出现）
  sectionTitle = [dict objectForKey:@"desc"];
  if (sectionTitle && [sectionTitle length] > 0) {
    //表头文本高度
    titleHeight =
        [sectionTitle sizeWithFont:[UIFont systemFontOfSize:12.0f]
                 constrainedToSize:CGSizeMake(windowWidth - 70.0f, 500)]
            .height;
  }
  switch (type) {
  case FundTypeLessThanHundred:
  case FundTypeLow:
  case FundTypeYouthLow:
  case FundTypeMiddleAgeLow:
  case FundTypeOldAgeLow:
    {
    if ([lowFundShopArray count] > 0) {
      [lowFundShopArray removeAllObjects];
    }
    [lowFundShopArray
        addObjectsFromArray:[DicToArray parseFundShoppingList:dict withFundType:CustomFundTypeLowPro]];
    if (lowFundShopArray.count == 0) {
      leftVerCuttingLine.hidden = YES;
      [loadingView btn_click];
    }else{
      loadingView.hidden = YES;
      leftVerCuttingLine.hidden = NO;
    }
    //评测提示语
    if ([sectionTitle length] > 0) {
      [finacingLowTBview setTableHeaderView:[self createTBHeadView]];
    }else{
      [finacingLowTBview setTableHeaderView:[[UIView alloc]initWithFrame:CGRectMake(0, 0, windowWidth, 20.0f )]];

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
    [midFundShopArray
        addObjectsFromArray:[DicToArray parseFundShoppingList:dict withFundType:CustomFundTypeMiddlePro]];
    if (midFundShopArray.count == 0) {
      middleVerCuttingLine.hidden = YES;
      [loadingView btn_click];
    }else{
      loadingView.hidden = YES;
      middleVerCuttingLine.hidden = NO;
    }
    //评测提示语
    if ([sectionTitle length] > 0) {
      [finacingMiddleTBview setTableHeaderView:[self createTBHeadView]];
    }else{
      [finacingMiddleTBview setTableHeaderView:[[UIView alloc]initWithFrame:CGRectMake(0, 0, windowWidth, 20.0f)]];
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
    [highFundShopArray
        addObjectsFromArray:[DicToArray parseFundShoppingList:dict withFundType:CustomFundTypeHighPro]];
    if (highFundShopArray.count == 0) {
      rightVerCuttingLine.hidden = YES;
      [loadingView btn_click];
    }else{
      loadingView.hidden = YES;
      rightVerCuttingLine.hidden = NO;
    }
    //评测提示语
    if ([sectionTitle length] > 0) {
      [finacingHighTBview setTableHeaderView:[self createTBHeadView]];
    }else{
      [finacingHighTBview setTableHeaderView:[[UIView alloc]initWithFrame:CGRectMake(0, 0, windowWidth, 20.0f)]];
    }
    [finacingHighTBview reloadData];
  } break;
  default:
    break;
  }
}
#pragma mark - headview中按钮事件
/** 表头我的资产button */
- (void)headviewMyAssetsClicked:(UIButton *)sender {
  [Login_ViewController checkLoginStatusWithCallback:^(BOOL logonSuccess) {
    if ([CheckNetWork() isEqualToString:@"无网络"]) {
      YouGu_animation_Did_Start(@"无网络请稍后再试");
      return;
    }
    [[OpenAccountInfo shareInstance]openAccountStatusJudgementWithFromPage:OpenAccountSwitchTypeMyAssets];
  }];
}
/** 表头账户中心button */
- (void)headviewAccountCenterButtonClicked:(UIButton *)sender {
  [Login_ViewController checkLoginStatusWithCallback:^(BOOL logonSuccess) {
    if ([CheckNetWork() isEqualToString:@"无网络"]) {
      YouGu_animation_Did_Start(@"无网络请稍后再试");
      return;
    }
    ///账户中心数据请求
    [[OpenAccountInfo shareInstance]sendAcountCenter:@"0"];
    
  }];
}
/** 表头我的自选button */
- (void)headviewMyOptionBtnClicked:(UIButton *)sender {
  if ([SimuControl OnLoginType] == 1) {
    MyOptionalFundVController *myVC =
    [[MyOptionalFundVController alloc] init];
    [APP_AppDelegate PushYGsetViewController:myVC];
  } else {
    [Login_ViewController checkLoginStatusWithCallback:^(BOOL logonSuccess) {
      MyOptionalFundVController *myVC =
      [[MyOptionalFundVController alloc] init];
      [APP_AppDelegate PushYGsetViewController:myVC];
    }];
  }
}
/** 顶部高低按钮点击 */
- (void)leftButtonClicked:(UIButton *)sender {
  [finacingScr.scrollView setContentOffset:CGPointMake(0, 0)];
}
- (void)rightButtonClicked:(UIButton *)sender {
  [finacingScr.scrollView setContentOffset:CGPointMake(windowWidth * 2, 0)];
}
#pragma mark -重载表格协议函数
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
  static NSString *cellId = @"FinacingShopCell";
  FinacingShopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
  if (!cell) {
    cell = [[[NSBundle mainBundle] loadNibNamed:cellId
                                          owner:self
                                        options:nil] firstObject];
  }
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  FundShopList *list;
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
#pragma mark 搜索
/** 点击搜索栏 */
- (void)clickSearchText:(id)sender {
  SearchFundViewController *sVC = [[SearchFundViewController alloc] init];
  [APP_AppDelegate PushYGsetViewController:sVC];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  if (textField == searchTextfield) {
    [textField resignFirstResponder];
    return YES;
  } else {
    return NO;
  }
}
#pragma mark - 点击手势
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
- (NSDate *)reloadSuccessWithKey:(NSString *)key{
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  key = [NSString stringWithFormat:@"_refresh_time_date_%@", key];
  //    特指的一片文章的评论
  NSString *date_time =
  [defaults objectForKey:key];
  NSDate *date = [[date_simple sharedManager]dateStringSwitchToDate:date_time];
  if (isLoadSuccess) {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    date = [NSDate date];
    NSString *date_ttime = [dateFormatter stringFromDate:date];
    [defaults setObject:date_ttime forKey:key];
    [defaults synchronize];
    isLoadSuccess = NO;
  }
  return date;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  //    任何情况下，下拉刷新，都是要可以的
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
- (void)loadData_Cai {
  if (YouGu_Not_NetWork == NO) {
    [self sendRequestWithType:defaultGainType];
    currentProfitType = defaultGainType;
  }
}
- (void)Interest_management {
  YGMainViewController *main_vc =
  (YGMainViewController
   *)(((AppDelegate *)[[UIApplication sharedApplication] delegate])
      .main_viewController);
  Interest_management_ViewController *ii_Vc =
  [[Interest_management_ViewController alloc] init];
  [main_vc.navigationController pushViewController:ii_Vc animated:YES];
}
- (void)dealloc{
  [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
