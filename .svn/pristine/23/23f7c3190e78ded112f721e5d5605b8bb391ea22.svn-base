//
//  BuuyViewController.m
//  优顾理财
//
//  Created by jhss on 15-4-2.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPBuuyViewController.h"
#import "ZKControl.h"
#import "FPPurchaseDelegationVC.h"
#import "FPBankListTableViewCell.h"
#import "FPBuyAndRedeemTipVC.h"
#import "FPFundDetailedViewController.h"
#import "NetLoadingWaitView.h"
#import "UIImageView+WebCache.h"
#import "UIButton+Block.h"

#define NUMBERS @"0123456789.\n"
#define textfieldMaxLength 12

@implementation FPBuuyViewController {
  ///基金背景view
  IBOutlet UIView *midView;

  ///基金购买按钮
  IBOutlet UIButton *buuyBtn;
  ///银行卡按钮
  IBOutlet UIButton *bankBtn;

  ///详情按钮
  IBOutlet UIButton *deatilButton;
  ///弹出提示框类
  FPBuyAndRedeemTipVC *tipVc;
  BOOL isHaveDian;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self refreshXib];
}
#pragma mark - 刷新xib中的控件
- (void)refreshXib {
  //输入框
  _buyTextField.delegate = self;
  _buyTextField.layer.borderWidth = 1;
  _buyTextField.layer.borderColor = [[Globle colorFromHexRGB:@"f07533"] CGColor];
  _buyTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
  _buyTextField.keyboardType = UIKeyboardTypeDecimalPad;
  _buyTextField.leftView.userInteractionEnabled = NO;
  _buyTextField.leftViewMode = UITextFieldViewModeAlways;

  _buyTextField.tag = 11;
  _buyTextField.clearButtonMode = UITextFieldViewModeAlways;
  if ((long)[_buyTextFieldStr integerValue] >= 10000) {
    _buyTextField.placeholder =
        [NSString stringWithFormat:@"请输入购买金额      最少%ld万元", (long)[_buyTextFieldStr integerValue] / 10000];
  } else if ((long)[_buyTextFieldStr integerValue] / 10000 < 1 && (long)[_buyTextFieldStr integerValue] >= 1) {
    _buyTextField.placeholder =
        [NSString stringWithFormat:@"请输入购买金额      最少%ld元", (long)[_buyTextFieldStr integerValue]];
  } else {
    _buyTextField.placeholder =
        [NSString stringWithFormat:@"请输入购买金额      最少%@元", _buyTextFieldStr];
  }
  //基金名称
  _nameLabel.text = _nameLabelStr;
  CGSize nameSize = [_nameLabel.text sizeWithFont:[UIFont systemFontOfSize:15.0f]
                                constrainedToSize:CGSizeMake(windowWidth - 95.0f, 100)];
  _nameLabel.minimumScaleFactor = 12.0f;
  _nameLabel.height = nameSize.height + 2.0f;
  if (_bankNumArray && [_bankNumArray count] > 0) {
    bankItem *item = _bankNumArray[0];
    _bankNameStr = item.bankName;
    _buyUserBankId = item.bankid; //用户绑卡ID
  }
  _btnBankNamelabel.text = _bankNameStr;
  UIImage *highlightImage = [FPYouguUtil createImageWithColor:buttonHighLightColor];
  //银行卡按钮
  [bankBtn addTarget:self
                action:@selector(buttonClicked:)
      forControlEvents:UIControlEventTouchUpInside];
  bankBtn.tag = 2;
  [bankBtn setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
  //显示默认费率
  [self compareOneValueOfFeeWithInput:@"0"];
  //购买按钮
  [buuyBtn addTarget:self
                action:@selector(buttonClicked:)
      forControlEvents:UIControlEventTouchUpInside];
  buuyBtn.tag = 4;
  buuyBtn.layer.cornerRadius = 18.5;
  buuyBtn.layer.masksToBounds = YES;
  [buuyBtn setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
  //详情界面
  [deatilButton addTarget:self
                   action:@selector(buttonClicked:)
         forControlEvents:UIControlEventTouchUpInside];
  [deatilButton setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
  deatilButton.tag = 3;
}
#pragma mark - 费率获取区间
/** 费率区间判断 */
- (void)compareOneValueOfFeeWithInput:(NSString *)inputStr {
  if (feeArr2.count > 0) {
    [feeArr2 removeAllObjects];
  }
  //判断如果没有费率
  if (_mutFeeList.count == 0) {
    _netrateLabel.text = @"0.0%";
    _rateView.hidden = YES;
    _rateLabel.hidden = YES;
  }
  for (feeItem *item in _mutFeeList) {
    if ([item.condition isEqualToString:@""]) {
      [self compareFee:item.fee];
      return;
    }
    feeArr1 = [item.condition componentsSeparatedByString:@"X<"];
    NSString *str2 = @">";
    NSRange range2 = [item.condition rangeOfString:str2];
    if (range2.location != NSNotFound) {
      feeArr2 = [NSMutableArray arrayWithArray:[item.condition componentsSeparatedByString:@">="]];
    }
    if (feeArr1 && [feeArr1 count] > 1) {
      NSString *max = feeArr1[1];
      if ([max hasSuffix:@"万元"]) {
        if ((long)[inputStr doubleValue] < (long)[max doubleValue] * 10000 && (long)[inputStr doubleValue] >= 0) {
          [self compareFee:item.fee];
          return;
        }
      }
    }
    if ([feeArr2 count] > 0) {
      NSString *max2 = feeArr2[1];
      if ([max2 hasSuffix:@"万元"]) {
        _netrateLabel.text = item.fee;
        _rateView.hidden = YES;
        _rateLabel.hidden = YES;
        return;
      }
    }
  }
}
///众禄费率
- (void)compareFee:(NSString *)maxFee {
  if ([_netRatelabelStr isEqualToString:@""]) {
    _netrateLabel.text = maxFee;
    _netrateLabel.hidden = NO;
    _rateView.hidden = YES;
    _rateLabel.hidden = YES;
    return;
  }
  NSComparisonResult result = [maxFee compare:_netRatelabelStr];
  switch (result) {
  case NSOrderedAscending:
    NSLog(@"stt<stt2");
    _netrateLabel.text = maxFee;
    _netrateLabel.hidden = NO;
    _rateView.hidden = YES;
    _rateLabel.hidden = YES;
    break;
  case NSOrderedSame:
    NSLog(@"stt==stt2");
    _netrateLabel.text = maxFee;
    _rateView.hidden = YES;
    _netrateLabel.hidden = NO;
    _rateLabel.hidden = YES;
    break;
  case NSOrderedDescending:
    NSLog(@"stt>stt2");
    _rateLabel.text = maxFee;
    _rateView.hidden = NO;
    _netrateLabel.text = _netRatelabelStr;
    _netrateLabel.hidden = NO;
    break;
  default:
    break;
  }
}
#pragma mark - 按钮点击事件
- (void)buttonClicked:(UIButton *)button {
  //选择银行卡
  if (button.tag == 2) {
    [self bankChildView];
    [_buyTextField resignFirstResponder];
  } else if (button.tag == 3) {
    //进入详情界面，，，，费率
    if (![FPYouguUtil isExistNetwork]) {
      YouGu_animation_Did_Start(networkFailed);
      return;
    }
    //产品详情页
    FPFundDetailedViewController *fundDVC = [[FPFundDetailedViewController alloc] init];
    fundDVC.currentFundId = _buyFundId;
    fundDVC.currentFundName = _nameLabelStr;
    fundDVC.isDeatil = YES;
    [AppDelegate pushViewControllerFromRight:fundDVC];
  } else { //进入购买付费页
    [_buyTextField resignFirstResponder];
    //先进行判断是否低于最少的交易额****
    if ([_buyTextField.text integerValue] >= [_buyTextFieldStr integerValue]) {
      //然后再跳入到购买付费交易密码界面
      [self tipViewForBuyView]; //调取交易密码界面
    } else if ([_buyTextField.text length] == 0) {
      YouGu_animation_Did_Start(@"请输入申购金额");
    } else if (0 < [_buyTextField.text doubleValue] &&
               [_buyTextField.text doubleValue] < [_buyTextFieldStr doubleValue]) {
      YouGu_animation_Did_Start(@"您输入的金额少于最小限制");
    }
  }
}
#pragma mark - 提示框部分
//弹出得输入交易密码提示框
- (void)tipViewForBuyView {
  AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
  tipVc = [[FPBuyAndRedeemTipVC alloc] initWithNibName:@"FPBuyAndRedeemTipVC" bundle:nil];
  moneyStr = [NSString stringWithFormat:@"%.2f元", [_buyTextField.text doubleValue]];
  moneyStr1 = [NSString stringWithFormat:@"%.2f", [_buyTextField.text doubleValue]];

  tipVc.view.frame = app.window.bounds;
  [app.window addSubview:tipVc.view];
  [tipVc showTipWithTitle:@"请输入交易密码"
                withMoney:moneyStr
              withContent:[NSString stringWithFormat:@"使用%@卡,购买%@产品", self.bankNameStr, _nameLabel.text]
            withTextField:nil
       withCancelBtnTitle:@"取消"
      withConfirmBtnTitle:@"确认付款"
             withCallback:^(NSString *callbackStr) {
               _tradeField = callbackStr;
             }];

  [tipVc.cancelButton addTarget:self
                         action:@selector(cancelButtonClicked)
               forControlEvents:UIControlEventTouchUpInside];

  [tipVc.confirmButton setOnButtonPressedHandler:^{
    //点击确认付款按钮
    [self confirmButtonClicked];
  }];
}
//点击返回移除提示框
- (void)backClickButton {
  [tipVc.view removeFromSuperview];
}
/** 确认付款*/
- (void)confirmButtonClicked {
  [[NSNotificationCenter defaultCenter] postNotificationName:@"resignFirstResponder"
                                                      object:self
                                                    userInfo:nil];
  if (_tradeField == nil || [_tradeField isEqualToString:@""]) {
    YouGu_animation_Did_Start(@"请输入交易密码");
    return;
  }
  if (_tradeField.length < 6 && _tradeField.length > 0) {
    YouGu_animation_Did_Start(@"请输入完整的密码");
    return;
  }
  //发送请求数据
  [self sendRequestWithBuy];
}
/** 取消*/
- (void)cancelButtonClicked {
  [[NSNotificationCenter defaultCenter] postNotificationName:@"resignFirstResponder"
                                                      object:self
                                                    userInfo:nil];
  [tipVc.view removeFromSuperview];
}
#pragma mark - 银行列表点击
//选择银行卡，，，，，，子view
- (void)bankChildView {
  AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
  //灰色的背景视图
  self.grayView = [[UIView alloc] initWithFrame:app.window.bounds];
  self.grayView.backgroundColor = [UIColor blackColor];
  self.grayView.alpha = 0.7f;
  self.grayView.tag = 100;
  [app.window addSubview:self.grayView];
  ///添加手势让其点击空白处银行卡列表移除
  UITapGestureRecognizer *tap =
      [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeBankView)];
  [self.grayView addGestureRecognizer:tap];
  //白色银行试图
  self.whiteView =
      [[UIView alloc] initWithFrame:CGRectMake(30, (windowHeight - 300) / 2, windowWidth - 60, 300)];
  self.whiteView.backgroundColor = [UIColor whiteColor];
  self.whiteView.layer.masksToBounds = YES;
  self.whiteView.layer.cornerRadius = 8;
  self.whiteView.tag = 101;
  [app.window addSubview:self.whiteView];
  _tableView =
      [[UITableView alloc] initWithFrame:CGRectMake(0, 43, self.whiteView.size.width, self.whiteView.size.height - 43)
                                   style:UITableViewStylePlain];
  _tableView.delegate = self;
  _tableView.dataSource = self;
  [self.whiteView addSubview:_tableView];
  [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
  UILabel *lab = [UILabel labelWithFrame:CGRectMake(0, 17, self.whiteView.size.width, 17)
                                   title:@"选择银行"
                                    font:17];
  lab.textAlignment = NSTextAlignmentCenter;
  [self.whiteView addSubview:lab];
  //黄色view
  UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 43, self.whiteView.size.width, 1)];
  view2.backgroundColor = [UIColor colorWithRed:0.95f green:0.47f blue:0.18f alpha:1.00f];
  [self.whiteView addSubview:view2];
}
#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return _bankNumArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *indent = @"cell";
  FPBankListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indent];
  if (!cell) {
    cell = [[FPBankListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:indent];
  }
  bankItem *item = _bankNumArray[indexPath.row];
  cell.bankNameLabel.text = item.bankName;
  //网络获取
  [cell.bankImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", IP_HTTP, item.logo]]];
  [cell setSeparatorInset:UIEdgeInsetsMake(0, 65, 0, 0)];
  return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 41;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  _selectedIndex = indexPath.row;
  bankItem *item = _bankNumArray[_selectedIndex];
  self.bankNameStr = item.bankName;
  _buyUserBankId = item.bankid;
  _btnBankNamelabel.text = self.bankNameStr;
  [self removeBankView];
}
//移除银行弹出视图
- (void)removeBankView {
  AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
  UIView *view = (UIView *)[app.window viewWithTag:100];
  UIView *view1 = (UIView *)[app.window viewWithTag:101];
  [view removeFromSuperview];
  [view1 removeFromSuperview];
}
#pragma mark - 请求数据
- (void)sendRequestWithBuy {
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  [NetLoadingWaitView startAnimating];
  [[WebServiceManager sharedManager]
      sendRequestWithBuyUserId:YouGu_User_USerid
                   tradecodeId:_tradeField
                    uesrBankId:_buyUserBankId
                        fundId:_buyFundId
                    AndMoneyId:moneyStr1
                withCompletion:^(id response) {
                  if (response && [[response objectForKey:@"status"] isEqualToString:@"0000"]) {
                    [NetLoadingWaitView stopAnimating];
                    //解析
                    [self showBuyWithResponse:response];
                  } else {
                    [NetLoadingWaitView stopAnimating];
                    NSString *message = [NSString stringWithFormat:@"%@", [response objectForKey:@"message"]];
                    if (!message || [message length] == 0 || [message isEqualToString:@"(null)"]) {
                      message = networkFailed;
                    }
                    if (response &&
                        [response[@"status"] isEqualToString:@"0101"]){
                    }else{
                      YouGu_animation_Did_Start(message);
                    }
                    return;
                  }
                }];
}
//显示请求的数据
- (void)showBuyWithResponse:(NSDictionary *)dict {
  FPBuyItem *buyItem = [DicToArray parseBuyWithLists:dict];
  NSDate *date = [NSDate date];
  NSDateFormatter *dateBuyFormatter = [[NSDateFormatter alloc] init];
  [dateBuyFormatter setDateFormat:@"yyyy/MM/dd   hh:mm:ss"];
  timeLabel = [dateBuyFormatter stringFromDate:date]; //申购时间
  // 时间戳 -》时间
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  // yyyy-MM-dd hh:mm:ss
  [dateFormatter setDateFormat:@"yyyy/MM/dd"];
  NSDate *date1 = [[NSDate alloc] initWithTimeIntervalSince1970:[buyItem.ackdt longLongValue]];
  planTime = [dateFormatter stringFromDate:date1];
  /** 确认付款按钮之后移除子视图*/
  [self cancelButtonClicked];
  ///去委托成功界面
  [self goToDelegation];
}
/** 去委托成功界面*/
- (void)goToDelegation {
  _buyTextField.text = @"";
  FPPurchaseDelegationVC *deleVC = [[FPPurchaseDelegationVC alloc] init];
  deleVC.cardNameAndNumber = _btnBankNamelabel.text;
  deleVC.productName = _nameLabel.text;
  deleVC.moneyStr = moneyStr1;
  deleVC.timeStr = timeLabel;
  deleVC.confirmTimeStr = planTime;
  deleVC.fundIdStr = _buyFundId;
  [AppDelegate pushViewControllerFromRight:deleVC];
}
#pragma mark - textFieldDelegate
- (void)animationView {
  [UIView beginAnimations:nil context:nil];                 //设置一个动画
  [UIView setAnimationDuration:0.3];                        //设置持续的时间
  [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut]; //设置动画
  self.buyWhiteView.frame = CGRectMake(20, 133 + 20, self.view.size.width - 40, 261);
  [UIView commitAnimations]; //提交动画
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [_buyTextField resignFirstResponder];
  [self animationView];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {

  [textField resignFirstResponder];
  [self animationView];
  return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
  [UIView beginAnimations:nil context:nil];                 //设置一个动画
  [UIView setAnimationDuration:0.3];                        //设置持续的时间
  [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut]; //设置动画
  self.buyWhiteView.frame = CGRectMake(20, 100, self.view.size.width - 40, 261);
  [UIView commitAnimations]; //提交动画
}
- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string {
  //屏蔽双点
  if ([string isEqualToString:@"."]) {
    if ([textField.text rangeOfString:@"."].length > 0) {
      return NO;
    }
  }
  textFieldString = [textField.text stringByReplacingCharactersInRange:range withString:string];
  if ([textFieldString rangeOfString:@"."].length > 0) {
    NSArray *numArr = [textFieldString componentsSeparatedByString:@"."];
    NSString *pointRight = numArr[1];
    if ([pointRight length] > 2) {
      return NO;
    }
  }
  /** 提示输入数字*/
  NSCharacterSet *cs;
  if (textField == _buyTextField) {
    cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if (!basicTest) {
      return NO;
    }
    if (textFieldString.length > 12) {
      [self compareOneValueOfFeeWithInput:textFieldString];
      textField.text = [textFieldString substringToIndex:12];
      YouGu_animation_Did_Start(@"超出了最大购买金额");
      return NO;
    } else {
      [self compareOneValueOfFeeWithInput:textFieldString];
      if ([textFieldString length] == 0) {
        //显示默认费率
        [self compareOneValueOfFeeWithInput:@"0"];
      }
      NSLog(@"%@-------", textFieldString);
      return YES;
    }
  }
  return YES;
}
- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
