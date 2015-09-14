//
//  RedemViewController.m
//  优顾理财
//
//  Created by jhss on 15-4-7.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPRedemViewController.h"
#import "FPRedeemDelegationVC.h"
#import "FPRadioButton.h"
#import "FPBuyAndRedeemTipVC.h"
#import "UIButton+Block.h"
#import "FundWarningUrl.h"
#import "NetLoadingWaitView.h"

#define NUMBERS @"0123456789.\n"
@interface FPRedemViewController () <UITextFieldDelegate>
@property(nonatomic, strong) UIView *redeemWhiteView;
@property(nonatomic, strong) NSString *tradeField;
@end

@implementation FPRedemViewController {
  NSString *redeemStr;
  ///连续赎回按钮
  FPRadioButton *continuousBtn;
  ///取消赎回按钮
  FPRadioButton *cancRedeemBtn;
  ///赎回时间
  NSString *redeemdtTime;
  ///预计确认时间
  NSString *exackdtTime;
  ///预计赎回到帐日期
  NSString *transferdtTime;
  ///选中的赎回方式
  NSString *chooseStr;
  ///弹出的提示框类
  FPBuyAndRedeemTipVC *tipVc;
  NSString *textFieldString;
  BOOL isHaveDian;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  ///输入框的颜色
  _redeemTextField.delegate = self;
  _redeemTextField.layer.borderWidth = 1;
  _redeemTextField.layer.borderColor = [[Globle colorFromHexRGB:@"f07533"] CGColor];
  _redeemTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
  _redeemTextField.leftView.userInteractionEnabled = NO;
  _redeemTextField.leftViewMode = UITextFieldViewModeAlways;
  _redeemTextField.tag = 11;
  _redeemTextField.clearButtonMode = UITextFieldViewModeAlways;
  _redeemTextField.keyboardType = UIKeyboardTypeDecimalPad;

  if ((long)[_minRedeemStr integerValue] >= 10000) {
    if ([_balanceStr doubleValue] <= [_minRedeemStr doubleValue]) {
      _redeemTextField.placeholder =
          [NSString stringWithFormat:@"请输入赎回份额      最少%f万份", [_balanceStr doubleValue] / 10000.0f];
    } else {
      _redeemTextField.placeholder =
          [NSString stringWithFormat:@"请输入赎回份额      最少%ld万份", (long)[_minRedeemStr integerValue] / 10000];
    }
  } else if ((long)[_minRedeemStr integerValue] / 10000 < 1 && (long)[_minRedeemStr integerValue] >= 1) {
    if ([_balanceStr doubleValue] <= [_minRedeemStr doubleValue]) {
      _redeemTextField.placeholder =
          [NSString stringWithFormat:@"请输入赎回份额      最少%0.2f份", [_balanceStr doubleValue]];
    } else {
      _redeemTextField.placeholder =
          [NSString stringWithFormat:@"请输入赎回份额      最少%ld份", (long)[_minRedeemStr integerValue]];
    }
  } else {
    if ([_balanceStr doubleValue] <= [_minRedeemStr doubleValue]) {
      _redeemTextField.placeholder =
          [NSString stringWithFormat:@"请输入赎回份额      最少%@份", _balanceStr];
    } else {
      _redeemTextField.placeholder =
          [NSString stringWithFormat:@"请输入赎回份额      最少%@份", _minRedeemStr];
    }
  }
  ///按钮按下状态
  UIImage *highlightImage = [FPYouguUtil createImageWithColor:buttonHighLightColor];
  [_redeemButton setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
  _redeemButton.layer.cornerRadius = 18.5;
  _redeemButton.layer.masksToBounds = YES;
  ///产品名称
  _productNameLabel.text = _fundNameStr;
  CGSize nameSize = [_productNameLabel.text sizeWithFont:[UIFont systemFontOfSize:15.0f]
                                       constrainedToSize:CGSizeMake(windowWidth - 95.0f, 100)];
  _productNameLabel.height = nameSize.height + 2.0f;
  ///连续赎回按钮
  continuousBtn = [FPRadioButton buttonWithType:UIButtonTypeCustom];
  continuousBtn.frame = CGRectMake(35, 129, 18, 18);
  [continuousBtn addTarget:self
                    action:@selector(continuousBtn)
          forControlEvents:UIControlEventTouchUpInside];
  continuousBtn.radioBtnSelected = NO;
  chooseStr = @"1";
  [_midBackGroundView addSubview:continuousBtn];
  ///取消赎回按钮
  cancRedeemBtn = [FPRadioButton buttonWithType:UIButtonTypeCustom];
  cancRedeemBtn.frame = CGRectMake(211, 129, 18, 18);
  [cancRedeemBtn addTarget:self
                    action:@selector(cancRedeemBtn)
          forControlEvents:UIControlEventTouchUpInside];
  cancRedeemBtn.radioBtnSelected = YES;
  [_midBackGroundView addSubview:cancRedeemBtn];
  ///限定的份额
  _maxRedeemMoeny.text = [NSString stringWithFormat:@"可赎回份额:%@份", _balanceStr];
}
#pragma mark - 按钮点击事件
///连续赎回按钮
- (void)continuousBtn {
  continuousBtn.radioBtnSelected = NO;
  cancRedeemBtn.radioBtnSelected = YES;
  chooseStr = @"1";
  NSLog(@"连续赎回");
}
///取消赎回按钮
- (void)cancRedeemBtn {
  continuousBtn.radioBtnSelected = YES;
  cancRedeemBtn.radioBtnSelected = NO;
  chooseStr = @"0";
  NSLog(@"取消赎回");
}
///弹出的提示框
- (void)tipViewForBuyView {
  AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
  tipVc = [[FPBuyAndRedeemTipVC alloc] initWithNibName:@"FPBuyAndRedeemTipVC" bundle:nil];
  tipVc.view.frame = app.window.bounds;
  [app.window addSubview:tipVc.view];

  NSString *RedeemStr1 = [NSString stringWithFormat:@"%ld", (long)[_redeemTextField.text integerValue]];
  NSString *RedeemStr2 = _redeemTextField.text;
  NSComparisonResult result = [RedeemStr1 compare:RedeemStr2];
  switch (result) {
  case NSOrderedAscending:
    redeemStr = [NSString stringWithFormat:@"%@份", _redeemTextField.text];
    break;
  case NSOrderedSame:
    redeemStr = [NSString stringWithFormat:@"%@.00份", _redeemTextField.text];
    break;
  default:
    redeemStr = [NSString stringWithFormat:@"%0.2lf份", [_redeemTextField.text doubleValue]];
    break;
  }

  [tipVc showTipWithTitle:@"请输入交易密码"
                withMoney:redeemStr
              withContent:[NSString stringWithFormat:@"赎回到%@", _bankNameAndNumLabel.text]
            withTextField:nil
       withCancelBtnTitle:@"取消"
      withConfirmBtnTitle:@"赎回"
             withCallback:^(NSString *callbackStr) {
               _tradeField = callbackStr;
               NSLog(@"callbackstr = %@", _tradeField);
             }];
  [tipVc.cancelButton addTarget:self
                         action:@selector(cancelButtonClicked)
               forControlEvents:UIControlEventTouchUpInside];
  [tipVc.confirmButton setOnButtonPressedHandler:^{
    [self confirmButtonClicked];
  }];
}
/** 赎回*/
- (void)confirmButtonClicked {
  if (_tradeField == nil || [_tradeField isEqualToString:@""]) {
    YouGu_animation_Did_Start(@"请输入交易密码");
    return;
  }
  if (_tradeField.length < 5 && _tradeField.length > 0) {
    YouGu_animation_Did_Start(@"请输入完整密码");
    return;
  }
  [self sendRequestWithRedem];
}
/** 点击返回按钮*/
- (void)backClickButton {
  [tipVc.view removeFromSuperview];
}
/** 取消*/
- (void)cancelButtonClicked {
  [tipVc.view removeFromSuperview];
}
- (IBAction)redeemButtonClicked:(id)sender {
  //跳转赎回确定页面
  //界面弹出之前需要判断输入的赎回金额是否超出最大的赎回金额，如果超出则弹出提示框，如果在范围内则弹出界面
  if ([_redeemTextField.text isEqualToString:@""]) {
    YouGu_animation_Did_Start(@"请输入赎回份额");
  }else if (0 < [_redeemTextField.text doubleValue] &&[_redeemTextField.text isEqualToString:_balanceStr]){
    //当赎回份额为全部份额，虽然小于min份额，但也可以赎回
    [self tipViewForBuyView];
  }else if (0 < [_redeemTextField.text doubleValue] &&
             [_redeemTextField.text doubleValue] < (long)[_minRedeemStr doubleValue]) {
    YouGu_animation_Did_Start(@"您输入的份额少于最小限制");
  }else if ([_redeemTextField.text doubleValue] > [_balanceStr doubleValue]) {
    YouGu_animation_Did_Start(@"超出本人的持仓份额");
  } else if ([_redeemTextField.text doubleValue] >= (long)[_minRedeemStr doubleValue] &&
             [_redeemTextField.text doubleValue] <= [_balanceStr doubleValue]) {
    [self tipViewForBuyView];
  } else {
    YouGu_animation_Did_Start(@"请输入正确的赎回份额");
  }
}
/*
 userid	    用户编号
 userbankid	所选银行卡ID
 fundid	    基金代码
 subquty	赎回份额redeemTextField.text
 tradecode	交易密码与tradeField.text比较判断
*/
#pragma mark - 网络请求
- (void)sendRequestWithRedem {
  [NetLoadingWaitView startAnimating];
  [[WebServiceManager sharedManager]
      sendRequestWithRedemUserId:YouGu_User_USerid
                     tradecodeId:_tradeField
                     largeflagId:chooseStr
                      uesrBankId:self.redemUserbankid
                          fundId:self.redemFundid
                    AndSubqutyId:_redeemTextField.text
                  withCompletion:^(id response) {
                    [NetLoadingWaitView stopAnimating];
                    if (response && [[response objectForKey:@"status"] isEqualToString:@"0000"]) {
                      //解析
                      [self showRedemWithResponse:response];
                    } else {
                      NSString *message =
                          [NSString stringWithFormat:@"%@", [response objectForKey:@"message"]];
                      if (!message || [message length] == 0 ||
                          [message isEqualToString:@"(null)"]) {
                        message = networkFailed;
                      }
                      if (response && [response[@"status"] isEqualToString:@"0101"]) {
                      } else {
                        YouGu_animation_Did_Start(message);
                      }
                    }
                  }];
}
- (void)showRedemWithResponse:(NSDictionary *)dict {
  YouGu_animation_Did_Start(@"您的持仓已有变动，请重新设置涨跌提醒");
  [self backClickButton];
  FPRedemItem *item = [DicToArray parseRedemWithLists:dict];
  //基金名称
  _productNameLabel.text = item.fundname;
  NSDate *date = [NSDate date];
  NSDateFormatter *dateBuyFormatter = [[NSDateFormatter alloc] init];
  [dateBuyFormatter setDateFormat:@"yyyy/MM/dd   hh:mm:ss"];
  redeemdtTime = [dateBuyFormatter stringFromDate:date]; //赎回时间
  // 时间戳 -》时间
  NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
  // yyyy-MM-dd hh:mm:ss
  [dateFormatter1 setDateFormat:@"yyyy/MM/dd"];
  NSDate *date1 = [[NSDate alloc] initWithTimeIntervalSince1970:[item.transferdt longLongValue]];
  transferdtTime = [dateFormatter1 stringFromDate:date1]; //预计赎回到账时间
  // 时间戳 -》时间
  NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
  // yyyy-MM-dd hh:mm:ss
  [dateFormatter2 setDateFormat:@"yyyy/MM/dd"];
  NSDate *date2 = [[NSDate alloc] initWithTimeIntervalSince1970:[item.exackdt longLongValue]];
  exackdtTime = [dateFormatter2 stringFromDate:date2]; //预计确认时间
  ///跳转委托成功界面
  [self goToRedeemDelegationView];
  [self deleteRemindList];
}
/** 删除对应提醒 */
- (void)deleteRemindList {
  NSDictionary *dict = @{ @"fundid" : _redemFundid, @"tradeacco" : _currentTradeAcco };
  HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
  __weak FPRedemViewController *weakSelf = self;
  callBack.onSuccess = ^(NSObject *obj) {
    FPRedemViewController *strongSelf = weakSelf;
    if (strongSelf) {
      [strongSelf deleteRemindSuccess];
    }
  };
  [FundUserProAndLossRemind deleteUserProAndLossRemindWithId:dict withCallback:callBack];
}
- (void)deleteRemindSuccess {
  //删除铃铛
  if (_currentBlock) {
    _currentBlock(YES);
  }
}
- (void)goToRedeemDelegationView {
  endRedeemStr = _redeemTextField.text;

  __weak FPRedemViewController *weakSelf = self;
  FPRedeemDelegationVC *redDeleVC = [[FPRedeemDelegationVC alloc] initWithCallback:^(BOOL isRedeemSuccess) {
    FPRedemViewController *strongSelf = weakSelf;
    if (strongSelf) {
      double oldValue = 0;
      double newValue = 0;
      if ([endRedeemStr hasSuffix:@"万份"]) {
        oldValue = [_balanceStr doubleValue] * 10000;
        newValue = oldValue - [endRedeemStr doubleValue];
      } else {
        oldValue = [_balanceStr doubleValue];
        newValue = oldValue - [endRedeemStr doubleValue];
      }
      ///限定的份额
      _maxRedeemMoeny.text = [NSString stringWithFormat:@"可赎回份额:%0.2f份", newValue];
    }
  }];
  //银行卡名称及尾号
  redDeleVC.bankAndName = _bankNameAndNumLabel.text;
  //赎回份额
  redDeleVC.redeemNum = _redeemTextField.text;
  //产品名称
  redDeleVC.productName = _productNameLabel.text;
  //赎回时间呢
  redDeleVC.buyTime = redeemdtTime;
  //预计确认时间
  redDeleVC.planTime = exackdtTime;
  //预计赎回到账时间
  redDeleVC.finishPlanTime = transferdtTime;
  redDeleVC.fundIdStr = _redemFundid;
  [AppDelegate pushViewControllerFromRight:redDeleVC];

  _redeemTextField.text = @"";
}
#pragma mark - textFieldDelegate
- (void)animationView {
  [UIView beginAnimations:nil context:nil];                 //设置一个动画
  [UIView setAnimationDuration:0.3];                        //设置持续的时间
  [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut]; //设置动画
  self.redeemWhiteView.frame = CGRectMake(20, 133 + 20, self.view.size.width - 40, 261);
  [UIView commitAnimations]; //提交动画
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [_redeemTextField resignFirstResponder];
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
  self.redeemWhiteView.frame = CGRectMake(20, 100, self.view.size.width - 40, 261);
  [UIView commitAnimations]; //提交动画
}
- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string {
  //屏蔽双点
  if ([string isEqualToString:@"."]) {
    isHaveDian = YES;
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
  if (textField == _redeemTextField) {
    cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if (!basicTest) {
      return NO;
    }
    if (textFieldString.length > 12) {
      textField.text = [textFieldString substringToIndex:12];
      YouGu_animation_Did_Start(@"超出了最大购买金额");
      return NO;
    } else {
      NSLog(@"%@-------", textFieldString);
      return YES;
    }
  }
  return YES;
}
@end
