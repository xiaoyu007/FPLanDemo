//
//  OptionalManageViewController.m
//  优顾理财
//
//  Created by Mac on 15-4-21.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPOptionalManageViewController.h"
#import "FPOptionalManageCell.h"
#import "FPMyOptionalItem.h"
#import "FPOptionalManageHeadView.h"
#import "FPMyOptionalShareManager.h"
#import "UIButton+Block.h"

typedef NS_ENUM(NSUInteger, OptionalFundType) {
  /** 其它基金类型 */
  OptionalFundTypeOtherFund,
  /** 货币基金 */
  OptionalFundTypeMoneyFund = 4,
  /** 理财型基金 */
  OptionalFundTypeFinancialFund = 5,
};

#define optionalCellHeight 45.0f
#define sectionHeight 60.0f
#define sectionNum 3

@implementation FPOptionalManageViewController

- (id)initWithCallBack:(onReturnObject)callBack {
  self = [super init];
  if (self) {
    currentCallback = callBack;
  }
  return self;
}
- (void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
}
- (void)viewDidLoad {
  [super viewDidLoad];
  [self CreatNavBarWithTitle:@"我的自选"];
  myOptionalArray = [[NSMutableArray alloc] init];
  moneyFundArray = [[NSMutableArray alloc] init];
  financialFundArray = [[NSMutableArray alloc] init];
  otherArray = [[NSMutableArray alloc] init];
  fundTypeArray = [[NSMutableArray alloc] init];
  selectedFundArray = [[NSMutableArray alloc] init];
  [self createMainView];
  [self showOptionalLists:_optionalManageArray];
}

- (void)createMainView {
  //自选管理按钮
  UIButton *manageButton = [UIButton buttonWithType:UIButtonTypeCustom];
  manageButton.frame = CGRectMake(windowWidth - 60.0f, 0, 60.0f, 50.0f);
  manageButton.backgroundColor = [UIColor clearColor];
  [manageButton setTitle:@"删除" forState:UIControlStateNormal];
  [manageButton setTitleColor:[Globle colorFromHexRGB:customFilledColor]
                     forState:UIControlStateNormal];
  [manageButton addTarget:self
                   action:@selector(deleteButtonClick:)
         forControlEvents:UIControlEventTouchUpInside];
  UIImage *highlightImage =
      [FPYouguUtil createImageWithColor:btnAccordingToTheNormal];
  [manageButton setBackgroundImage:highlightImage
                          forState:UIControlStateHighlighted];
  [self.childView addSubview:manageButton];
  //表格
  optionalManageTableview = [[UITableView alloc]
      initWithFrame:CGRectMake(0, navigationHeght, windowWidth,
                               windowHeight - navigationHeght -
                                   statusBarHeight)];
  optionalManageTableview.delegate = self;
  optionalManageTableview.dataSource = self;
  optionalManageTableview.backgroundColor =
      [Globle colorFromHexRGB:customBGColor];
  [self.childView addSubview:optionalManageTableview];
  optionalManageTableview.separatorStyle =
      UITableViewCellSeparatorStyleSingleLine;
  optionalManageTableview.separatorColor =
      [Globle colorFromHexRGB:lightCuttingLine];
  //去除多余的分割线
  [optionalManageTableview
      setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
  [self registerNibCell];
}

- (void)registerNibCell {
  UINib *cellNib =
      [UINib nibWithNibName:NSStringFromClass([FPOptionalManageCell class])
                     bundle:nil];
  [optionalManageTableview registerNib:cellNib
                forCellReuseIdentifier:@"FPOptionalManageCell"];
}

- (void)deleteButtonClick:(id)sender {
  //没选择点击没反应
  if ([selectedFundArray count] < 1) {
    YouGu_animation_Did_Start(@"请选择要删除的基金");
    return;
  }
  UIAlertView *alertView =
      [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                 message:@"确认要删除吗？"
                                delegate:self
                       cancelButtonTitle:@"取消"
                       otherButtonTitles:@"确定", nil];
  [alertView show];
}
- (void)alertView:(UIAlertView *)alertView
    clickedButtonAtIndex:(NSInteger)buttonIndex {
  //确定
  if (buttonIndex == 1) {
    __block FPOptionalManageViewController *weakSelf = self;
    [[WebServiceManager sharedManager]
        deleteFundListWithFundId:selectedFundArray
                      withUserId:YouGu_User_USerid
                  withCompletion:^(id response) {
                    if (response && [[response objectForKey:@"status"]
                                        isEqualToString:@"0000"]) {
                      FPOptionalManageViewController *strongSelf = weakSelf;
                      if (strongSelf) {
                        [strongSelf mySelectionDeleteSuccess:selectedFundArray];
                      }
                    } else {
                      NSString *message = [NSString
                          stringWithFormat:@"%@",
                                           [response objectForKey:@"message"]];
                      if (!message || [message length] == 0 ||
                          [message isEqualToString:@"(null)"]) {
                        message = networkFailed;
                      }
                      if (response &&
                          [response[@"status"] isEqualToString:@"0101"]){
                      }else{
                        YouGu_animation_Did_Start(message);
                      }                    }
                  }];
  }
}
/** 删除成功 */
- (void)mySelectionDeleteSuccess:(NSArray *)selectedArray {
  //重新过滤次
  for (NSString *tempStr in selectedFundArray) {
    for (int st = 0; st < [_optionalManageArray count]; st++) {
      FPMyOptionalItem *item = _optionalManageArray[st];
      if ([tempStr isEqualToString:item.fundId]) {
        [_optionalManageArray removeObject:item];
        //本地缓存中清除掉
        [[FPMyOptionalShareManager shareManager]
            deleteMyOptionalListWithID:item.fundId];
        break;
      }
    }
  }
  [selectedFundArray removeAllObjects];
  [self showOptionalLists:_optionalManageArray];
  currentCallback(YES);
  if ([myOptionalArray count] < 1) {
    [AppDelegate popViewController:YES];
  }
}

/** 传递数据 */
- (void)showOptionalLists:(NSMutableArray *)array {
  if ([myOptionalArray count] > 0) {
    [myOptionalArray removeAllObjects];
    [otherArray removeAllObjects];
    [moneyFundArray removeAllObjects];
    [financialFundArray removeAllObjects];
  }
  [myOptionalArray addObjectsFromArray:array];
  //列表
  for (FPMyOptionalItem *item in myOptionalArray) {
    switch ([item.invsttype integerValue]) {
    case OptionalFundTypeMoneyFund: {
      if ([item.isSelected integerValue]) {
        [moneyFundArray addObject:item];
      }
    } break;
    case OptionalFundTypeFinancialFund: {
      if ([item.isSelected integerValue]) {
        [financialFundArray addObject:item];
      }
    } break;
    default:
      if ([item.isSelected integerValue]) {
        [otherArray addObject:item];
      }
      break;
    }
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
  [optionalManageTableview reloadData];
}
#pragma mark - tableview协议函数
/** 自定义分割线长度 */
- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  if ([optionalManageTableview
          respondsToSelector:@selector(setSeparatorInset:)]) {
    [optionalManageTableview
        setSeparatorInset:UIEdgeInsetsMake(0, 0.0f, 0, 0.0f)];
  }

  if ([optionalManageTableview
          respondsToSelector:@selector(setLayoutMargins:)]) {
    [optionalManageTableview
        setLayoutMargins:UIEdgeInsetsMake(0, 0.0f, 0, 0.0f)];
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
- (CGFloat)tableView:(UITableView *)tableView
    heightForHeaderInSection:(NSInteger)section {
  return sectionHeight;
}
- (UIView *)tableView:(UITableView *)tableView
    viewForHeaderInSection:(NSInteger)section {
  FPOptionalManageHeadView *headView =
      [[[NSBundle mainBundle] loadNibNamed:@"FPOptionalManageHeadView"
                                     owner:self
                                   options:nil] firstObject];
  if (section == 0 && existOtherFund) {
    headView.lastestWorthLabel.text = @"最新净值";
    headView.priceRateLabel.text = @"涨跌幅";
    headView.sectionTitleLabel.text = @"普通基金";
  } else {
    headView.sectionTitleLabel.text = fundTypeArray[section];
    headView.lastestWorthLabel.text = @"万分收益";
    headView.priceRateLabel.text = @"7日年化";
  }
  return headView;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  if (existOtherFund && section == 0) {
    return [otherArray count];
  } else if (existMoneyFund && section < 2) {
    return [moneyFundArray count];
  } else {
    return [financialFundArray count];
  }
}

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
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
  static NSString *cellID = @"FPOptionalManageCell";
  FPOptionalManageCell *cell = (FPOptionalManageCell *)
      [tableView dequeueReusableCellWithIdentifier:cellID];
  FPMyOptionalItem *item;
  if (existOtherFund && indexPath.section == 0) {
    item = otherArray[indexPath.row];
    cell.cellBgButton.tag = 10000 + indexPath.row;
  } else if (existMoneyFund && indexPath.section < 2) {
    item = moneyFundArray[indexPath.row];
    cell.cellBgButton.tag = 20000 + indexPath.row;
  } else {
    item = financialFundArray[indexPath.row];
    cell.cellBgButton.tag = 30000 + indexPath.row;
  }
  cell.fundNameLabel.height = item.fundNameHeight;
  cell.fundNameLabel.attributedText = item.attr;

  __weak FPOptionalManageViewController *weakSelf = self;
  ButtonPressed buttonPressed = ^{
    FPOptionalManageViewController *strongSelf = weakSelf;
    if (strongSelf) {
      [strongSelf cellBgButtonClickedWithTag:cell.cellBgButton.tag];
    }
  };
  [cell.cellBgButton setOnButtonPressedHandler:buttonPressed];
  cell.radioImageView.hidden = [item.isSelected integerValue];
  //最新净值
  if (existOtherFund && indexPath.row == 0) {
    cell.newestProfitLabel.text =
        [NSString stringWithFormat:@"%.4f", [item.cumvalue floatValue]];
  } else {
    //万收
    cell.newestProfitLabel.text =
        [NSString stringWithFormat:@"%.4f", [item.cumvalue floatValue]];
  }
  //涨跌幅
  item.netValueRate =
      [NSString stringWithFormat:@"%0.2f%%", [item.netValueRate floatValue]];
  cell.priceRateLabel.text = item.netValueRate;
  if ([item.netValueRate floatValue] > 0) {
    cell.priceRateLabel.textColor = [Globle colorFromHexRGB:DataUpColor];
  } else if ([item.netValueRate floatValue] == 0) {
    cell.priceRateLabel.textColor = [Globle colorFromHexRGB:DataZeroColor];
  } else {
    cell.priceRateLabel.textColor = [Globle colorFromHexRGB:DataDownColor];
  }
  return cell;
}
/** 单选按钮点击 */
- (void)cellBgButtonClickedWithTag:(NSInteger)tag {
  FPMyOptionalItem *item;
  switch (tag / 10000) {
  case sectionNum - 2: {
    if (existOtherFund) {
      item = otherArray[tag - 10000];
    } else if (existMoneyFund) {
      item = moneyFundArray[tag - 20000];
    } else {
      item = financialFundArray[tag - 30000];
    }
  } break;
  case sectionNum - 1: {
    if (existMoneyFund) {
      item = moneyFundArray[tag - 20000];
    } else {
      item = financialFundArray[tag - 30000];
    }
  } break;
  case sectionNum: {
    item = financialFundArray[tag - 30000];
  } break;
  default:
    break;
  }
  if (item == nil) {
    return;
  }
  BOOL isExisted = YES;
  for (NSString *subString in selectedFundArray) {
    if ([subString isEqualToString:item.fundId]) {
      isExisted = NO;
    }
  }
  if (isExisted) {
    [selectedFundArray addObject:item.fundId];
    item.isSelected = @"1";
  } else {
    [selectedFundArray removeObject:item.fundId];
    item.isSelected = @"0";
  }
}
@end
