//
//  MyOptionalFundVController.m
//  优顾理财
//
//  Created by Mac on 15-4-19.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPMyOptionalFundVController.h"
#import "FPMyOptionalFundCell.h"
#import "FPMyOptionalItem.h"
#import "FPOptionalSectionHeadView.h"
#import "FPOptionalManageViewController.h"
#import "FPFundDetailedViewController.h"
#import "FPSearchFundViewController.h"
#import "PlistOperation.h"

#define optionalCellHeight 45.0f
#define sectionHeight 60.0f
#define sectionNum 3

@implementation FPMyOptionalFundVController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self CreatNavBarWithTitle:@"我的自选"];

  ///注册观察者，，观察是否有添加的自选基金，，，，时时的更新
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(refreshButtonClicked:)
                                               name:@"refishCustomizeList"
                                             object:nil];

  ////产品详情界面是否有取消自选的基金，，，进行刷新数据
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(refreshButtonClicked:)
                                               name:@"refishCustomizeListData"
                                             object:nil];

  myOptionalArray = [[NSMutableArray alloc] init];
  moneyFundArray = [[NSMutableArray alloc] init];
  financialFundArray = [[NSMutableArray alloc] init];
  otherArray = [[NSMutableArray alloc] init];
  fundTypeArray = [[NSMutableArray alloc] init];
  [self createMainView];
  [self createNoOptionalProductView];
  [self sendRequestOfoptionalFundQueryWithUserId:YouGu_User_USerid];
}
#pragma mark - mainview
- (void)createMainView {
  //自选管理按钮
  manageButton = [UIButton buttonWithType:UIButtonTypeCustom];
  manageButton.frame = CGRectMake(windowWidth - 100.0f, 0, 50.0f, 50.0f);
  [manageButton setImage:[UIImage imageNamed:@"自选管理小图标"] forState:UIControlStateNormal];
  [manageButton addTarget:self
                   action:@selector(manageButtonClick:)
         forControlEvents:UIControlEventTouchUpInside];
  manageButton.imageEdgeInsets = UIEdgeInsetsMake(16.0f, 15.0f, 16.0f, 15.0f);
  UIImage *highlightImage = [FPYouguUtil createImageWithColor:btnAccordingToTheNormal];
  [manageButton setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
  [manageButton setImage:[UIImage imageNamed:@"自选管理小图标"] forState:UIControlStateHighlighted];
  [self.childView addSubview:manageButton];
  //刷新按钮
  refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
  refreshButton.frame = CGRectMake(windowWidth - 50.0f, 0, 50.0f, 50.0f);
  [refreshButton setImage:[UIImage imageNamed:@"刷新小图标"] forState:UIControlStateNormal];
  [refreshButton setImage:[UIImage imageNamed:@"刷新小图标"] forState:UIControlStateHighlighted];
  refreshButton.imageEdgeInsets = UIEdgeInsetsMake(16.0f, 15.0f, 16.0f, 15.0f);
  [refreshButton addTarget:self
                    action:@selector(refreshButtonClicked:)
          forControlEvents:UIControlEventTouchUpInside];
  [refreshButton setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
  [self.childView addSubview:refreshButton];
  //刷新菊花
  [self createIndicator];
  //表格
  myOptionalTableview =
      [[UITableView alloc] initWithFrame:CGRectMake(0, navigationHeght, windowWidth, windowHeight - navigationHeght - statusBarHeight)];
  myOptionalTableview.delegate = self;
  myOptionalTableview.dataSource = self;
  myOptionalTableview.backgroundColor = [Globle colorFromHexRGB:customBGColor];
  [self.childView addSubview:myOptionalTableview];
  myOptionalTableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
  myOptionalTableview.separatorColor = [Globle colorFromHexRGB:lightCuttingLine];
  //去除多余的分割线
  [myOptionalTableview setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
  [myOptionalTableview setTableFooterView:[self createAddOptionalFundView]];
  myOptionalTableview.tableFooterView.hidden = YES;
  [self registerNibCell];
}

#pragma mark - 注册NibCell
- (void)registerNibCell {
  UINib *cellNib =
      [UINib nibWithNibName:NSStringFromClass([FPMyOptionalFundCell class]) bundle:nil];
  [myOptionalTableview registerNib:cellNib forCellReuseIdentifier:@"FPMyOptionalFundCell"];
}

/** 菊花控件 */
- (void)createIndicator {
  indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
  indicator.center = refreshButton.center;
  indicator.hidden = YES;
  [self.childView addSubview:indicator];
}

- (UIView *)createAddOptionalFundView {
  UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowWidth, 90.0f)];
  footView.backgroundColor = [UIColor clearColor];
  footView.userInteractionEnabled = YES;
  UIView *cuttingLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowWidth, 0.5f)];
  cuttingLine.backgroundColor = [Globle colorFromHexRGB:lightCuttingLine];
  [footView addSubview:cuttingLine];

  UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
  addButton.frame = CGRectMake(60.0f, 31.0f, windowWidth - 60 * 2, 36.0f);
  addButton.backgroundColor = [Globle colorFromHexRGB:customFilledColor];
  [addButton.layer setMasksToBounds:YES];
  [addButton.layer setCornerRadius:18.0f];
  [addButton addTarget:self
                action:@selector(manualAddOptionalProduct)
      forControlEvents:UIControlEventTouchUpInside];
  [addButton setTitle:@"        手动添加" forState:UIControlStateNormal];
  [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
  UIImage *highLightImage = [FPYouguUtil createImageWithColor:btnAccordingToTheNormal];
  [addButton setBackgroundImage:highLightImage forState:UIControlStateHighlighted];
  addButton.titleLabel.font = [UIFont systemFontOfSize:17.0f];
  [footView addSubview:addButton];

  UIImageView *addImageView =
      [[UIImageView alloc] initWithFrame:CGRectMake((windowWidth - 120.0f) / 2.0f - 40.0f, 9.0f, 17.0f, 17.0f)];
  addImageView.userInteractionEnabled = NO;
  addImageView.image = [UIImage imageNamed:@"添加小加号"];
  [addButton addSubview:addImageView];
  return footView;
}
- (void)createNoOptionalProductView {
  noDataView =
      [[UIView alloc] initWithFrame:CGRectMake(0, navigationHeght, windowWidth, windowHeight - navigationHeght)];
  noDataView.hidden = YES;
  noDataView.backgroundColor = [UIColor whiteColor];
  [self.childView addSubview:noDataView];

  //无产品label
  UILabel *noDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 95.0f, windowWidth - 40.0f, 17.0f)];
  noDataLabel.font = [UIFont systemFontOfSize:17.0f];
  noDataLabel.backgroundColor = [UIColor clearColor];
  noDataLabel.textAlignment = NSTextAlignmentCenter;
  noDataLabel.textColor = [Globle colorFromHexRGB:@"84929e"];
  noDataLabel.text = @"目前尚无自选产品";
  [noDataView addSubview:noDataLabel];
  //“点击添加”按钮
  UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
  addButton.frame = CGRectMake(60.0f, 176.0f, windowWidth - 120.0f, 36.0f);
  [addButton.layer setMasksToBounds:YES];
  [addButton.layer setCornerRadius:18.0f];
  addButton.backgroundColor = [Globle colorFromHexRGB:customFilledColor];
  [addButton addTarget:self
                action:@selector(manualAddOptionalProduct)
      forControlEvents:UIControlEventTouchUpInside];
  [addButton setTitle:@"        点击添加" forState:UIControlStateNormal];
  [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
  UIImage *highLightImage = [FPYouguUtil createImageWithColor:buttonHighLightColor];
  [addButton setBackgroundImage:highLightImage forState:UIControlStateHighlighted];
  addButton.titleLabel.font = [UIFont systemFontOfSize:17.0f];
  [noDataView addSubview:addButton];

  UIImageView *addImageView =
      [[UIImageView alloc] initWithFrame:CGRectMake((windowWidth - 120.0f) / 2.0f - 40.0f, 9.0f, 17.0f, 17.0f)];
  addImageView.image = [UIImage imageNamed:@"添加小加号"];
  [addButton addSubview:addImageView];
}
/** 手动添加自选 */
- (void)manualAddOptionalProduct {
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  FPSearchFundViewController *sVC = [[FPSearchFundViewController alloc] init];
  [AppDelegate pushViewControllerFromRight:sVC];
}

/** 切换到管理界面 */
- (void)manageButtonClick:(id)sender {
  __block FPMyOptionalFundVController *weakSelf = self;
  FPOptionalManageViewController *optionalMVC =
      [[FPOptionalManageViewController alloc] initWithCallBack:^(BOOL listChanged) {
        if (listChanged) {
          FPMyOptionalFundVController *strongSelf = weakSelf;
          if (strongSelf) {
            //重新刷新
            [strongSelf sendRequestOfoptionalFundQueryWithUserId:YouGu_User_USerid];
          }
        }
      }];
  optionalMVC.optionalManageArray = myOptionalArray;
  [AppDelegate pushViewControllerFromRight:optionalMVC];
}
/** 切换到刷新界面 */
- (void)refreshButtonClicked:(id)sender {
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  [self sendRequestOfoptionalFundQueryWithUserId:YouGu_User_USerid];
}
- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)readFromCache {
  //读缓存
  NSString *plistName = [NSString stringWithFormat:@"myOptionalLists_%@", YouGu_User_USerid];
  [self showOptionalListsWithResponse:[NSDictionary dictionaryWithContentsOfFile:[PlistOperation getPlistPath:plistName]]];
}
#pragma mark - 加载数据
- (void)sendRequestOfoptionalFundQueryWithUserId:(NSString *)userId {
  indicator.hidden = NO;
  [indicator startAnimating];
  [self readFromCache];
  refreshButton.hidden = YES;
  [[WebServiceManager sharedManager]
      loadOptionalListsWithUserId:userId
                   withCompletion:^(id dic) {
                     indicator.hidden = YES;
                     refreshButton.hidden = NO;
                     [indicator stopAnimating];
                     if (dic && [[dic objectForKey:@"status"] isEqualToString:@"0000"]) {
                       //解析
                       [self showOptionalListsWithResponse:dic];
                     } else {
                       NSString *message = dic ? dic[@"message"] : networkFailed;
                       if (dic && [[dic objectForKey:@"status"] isEqualToString:@"0101"]) {

                       } else {
                         YouGu_animation_Did_Start(message);
                       }
                       if ([myOptionalArray count] < 1) {
                         manageButton.hidden = YES;
                       }
                     }
                   }];
}
- (void)showOptionalListsWithResponse:(NSDictionary *)dict {
  if ([myOptionalArray count] > 0) {
    [myOptionalArray removeAllObjects];
  }
  [otherArray removeAllObjects];
  [moneyFundArray removeAllObjects];
  [financialFundArray removeAllObjects];
  //列表
  [myOptionalArray addObjectsFromArray:[DicToArray parseOptionalListWithDict:dict]];
  [self arrayDivideSmallArray];
}
/** 数组分为普通、理财、货币等类型 */
- (void)arrayDivideSmallArray {
  for (FPMyOptionalItem *item in myOptionalArray) {
    //添加基金名称参数
    NSString *fundNameIdStr = [NSString stringWithFormat:@"%@  %@", item.fundName, item.fundId];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:fundNameIdStr];
    //名称范围
    NSRange nameRange = [fundNameIdStr rangeOfString:item.fundName];
    NSRange idRange = [fundNameIdStr rangeOfString:item.fundId];
    [attr addAttribute:NSForegroundColorAttributeName
                 value:(id)[Globle colorFromHexRGB:textNameColor]
                 range:nameRange];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0f] range:nameRange];

    [attr addAttribute:NSForegroundColorAttributeName
                 value:(id)[Globle colorFromHexRGB:textfieldContentColor]
                 range:idRange];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11.0f] range:idRange];
    item.fundNameHeight = (attr.size.width / 106.0f + 1.0f) * 15.0f + 25.0f;
    item.attr = attr;
    //代码范围
    switch ([item.invsttype integerValue]) {
    case OptionalFundTypeMoneyFund: {
      [moneyFundArray addObject:item];
    } break;
    case OptionalFundTypeFinancialFund: {
      [financialFundArray addObject:item];
    } break;
    default:
      [otherArray addObject:item];
      break;
    }
  }
  if ([myOptionalArray count] == 0) {
    manageButton.hidden = YES;
    noDataView.hidden = NO;
    myOptionalTableview.tableFooterView.hidden = YES;
  } else {
    manageButton.hidden = NO;
    noDataView.hidden = YES;
    myOptionalTableview.tableFooterView.hidden = NO;
  }
  if ([fundTypeArray count] > 0) {
    [fundTypeArray removeAllObjects];
  }
  /** 其它基金 */
  if ([otherArray count] > 0) {
    existOtherFund = 1;
    [fundTypeArray addObject:@"普通基金"];
  } else {
    existOtherFund = 0;
  }
  /** 货币基金 */
  if ([moneyFundArray count] > 0) {
    [fundTypeArray addObject:@"货币基金"];
    existMoneyFund = 1;
  } else {
    existMoneyFund = 0;
  }
  /** 理财基金 */
  if ([financialFundArray count] > 0) {
    [fundTypeArray addObject:@"理财基金"];
    existFinancialFund = 1;
  } else {
    existFinancialFund = 0;
  }
  [myOptionalTableview reloadData];
}
#pragma mark - tableview协议函数
/** 自定义分割线长度 */
- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  if ([myOptionalTableview respondsToSelector:@selector(setSeparatorInset:)]) {
    [myOptionalTableview setSeparatorInset:UIEdgeInsetsMake(0, 0.0f, 0, 0.0f)];
  }

  if ([myOptionalTableview respondsToSelector:@selector(setLayoutMargins:)]) {
    [myOptionalTableview setLayoutMargins:UIEdgeInsetsMake(0, 0.0f, 0, 0.0f)];
  }
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
  if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {

    [cell setSeparatorInset:UIEdgeInsetsMake(0, 0.0f, 0, 0.0f)];
  }
  if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
    [cell setLayoutMargins:UIEdgeInsetsMake(0, 0.0f, 0, 0.0f)];
  }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return existFinancialFund + existMoneyFund + existOtherFund;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return sectionHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  FPOptionalSectionHeadView *headView =
      [[[NSBundle mainBundle] loadNibNamed:@"FPOptionalSectionHeadView"
                                     owner:self
                                   options:nil] firstObject];
  if (section == 0 && existOtherFund) {
    headView.netValueLabel.text = @"最新净值";
    headView.priceRateLabel.text = @"涨跌幅";
    headView.sectionTitleLabel.text = @"普通基金";
  } else {
    headView.sectionTitleLabel.text = fundTypeArray[section];
    headView.netValueLabel.text = @"万分收益";
    headView.priceRateLabel.text = @"7日年化";
  }
  return headView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (existOtherFund && section == 0) {
    return [otherArray count];
  } else if (existMoneyFund && section < 2) {
    return [moneyFundArray count];
  } else {
    return [financialFundArray count];
  }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  FPMyOptionalItem *item;
  if (existOtherFund && indexPath.section == 0) {
    item = otherArray[indexPath.row];
  } else if (existMoneyFund && indexPath.section < 2) {
    item = moneyFundArray[indexPath.row];
  } else {
    item = financialFundArray[indexPath.row];
  }
  return item.fundNameHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellID = @"FPMyOptionalFundCell";
  FPMyOptionalFundCell *cell = (FPMyOptionalFundCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
  FPMyOptionalItem *item;
  if (existOtherFund && indexPath.section == 0) {
    item = otherArray[indexPath.row];
  } else if (existMoneyFund && indexPath.section < 2) {
    item = moneyFundArray[indexPath.row];
  } else {
    item = financialFundArray[indexPath.row];
  }
  cell.fundNameLabel.height = item.fundNameHeight;
  cell.fundNameLabel.attributedText = item.attr;
  //最新净值
  if (existOtherFund && indexPath.row == 0) {
    cell.NewNetworthLabel.text = [NSString stringWithFormat:@"%.4f", [item.cumvalue floatValue]];
  } else {
    //万收
    cell.NewNetworthLabel.text = [NSString stringWithFormat:@"%.4f", [item.cumvalue floatValue]];
  }
  //涨跌幅
  NSString *priceStr = [NSString stringWithFormat:@"%0.2f%%", [item.netValueRate floatValue]];
  cell.PriceRattingLabel.text = priceStr;

  if ([priceStr floatValue] > 0) {
    cell.PriceRattingLabel.textColor = [Globle colorFromHexRGB:@"e84545"];
  } else if ([priceStr floatValue] == 0) {
    cell.PriceRattingLabel.textColor = [Globle colorFromHexRGB:@"5b5f62"];
  } else {
    cell.PriceRattingLabel.textColor = [Globle colorFromHexRGB:@"50b241"];
  }
  //近30日收益
  item.monthRate = [NSString stringWithFormat:@"%0.2f%%", [item.monthRate floatValue]];
  cell.oneMonthProfitLabel.text = item.monthRate;
  if ([item.monthRate floatValue] > 0) {
    cell.oneMonthProfitLabel.textColor = [Globle colorFromHexRGB:@"e84545"];
  } else if ([item.monthRate floatValue] == 0) {
    cell.oneMonthProfitLabel.textColor = [Globle colorFromHexRGB:@"5b5f62"];
  } else {
    cell.oneMonthProfitLabel.textColor = [Globle colorFromHexRGB:@"50b241"];
  }
  return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [UIView animateWithDuration:0.3f
                   animations:^{
                     [tableView deselectRowAtIndexPath:indexPath animated:YES];
                   }];
  FPMyOptionalItem *item;
  if (existOtherFund && indexPath.section == 0) {
    item = otherArray[indexPath.row];
  } else if (existMoneyFund && indexPath.section < 2) {
    item = moneyFundArray[indexPath.row];
  } else {
    item = financialFundArray[indexPath.row];
  }
  FPFundDetailedViewController *fundDetailVC = [[FPFundDetailedViewController alloc] init];
  fundDetailVC.currentFundId = item.fundId;
  fundDetailVC.currentFundName = item.fundName;
  fundDetailVC.invsttypeStr = item.invsttype;
  [AppDelegate pushViewControllerFromRight:fundDetailVC];
}
@end
