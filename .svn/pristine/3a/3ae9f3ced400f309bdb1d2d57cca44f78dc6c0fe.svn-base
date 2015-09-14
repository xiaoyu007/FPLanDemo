//
//  FPConnectBankCardVC.m
//  优顾理财
//
//  Created by Mac on 15/7/24.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPConnectBankCardVC.h"
#import "FPPutInIdentifyingCodeViewController.h"
#import "FPAuthorizationViewController.h"

@implementation FPConnectBankCardVC

- (void)viewDidLoad {
  [super viewDidLoad];
  self.childView.clipsToBounds = YES;
  self.topNavView.mainLableString = @"开户";
  [self createNextButton];
  //关联银行卡
  connectBankCardVC =
      [[FPConnectBankCadViewController alloc] initWithNibName:@"FPConnectBankCadViewController"
                                                       bundle:nil];
  connectBankCardVC.phoneTextField.text = _iphoneNumber;
  [self addChildViewController:connectBankCardVC];
  //  connectBankCardVC.view.frame = self.childView.bounds;
  [self.childView addSubview:connectBankCardVC.view];
}
/** 下一步按钮 */
- (void)createNextButton {
  UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
  nextButton.frame = CGRectMake(windowWidth - 80, 0, 80, 50);
  nextButton.backgroundColor = [UIColor clearColor];
  [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
  [nextButton setTitleColor:[Globle colorFromHexRGB:customFilledColor]
                   forState:UIControlStateNormal];
  nextButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
  UIImage *highLightImage = [FPYouguUtil createImageWithColor:buttonHighLightColor];
  [nextButton setBackgroundImage:highLightImage forState:UIControlStateHighlighted];
  [nextButton addTarget:self
                 action:@selector(nextButtonClicked:)
       forControlEvents:UIControlEventTouchUpInside];
  [self.topNavView addSubview:nextButton];
}
- (void)nextButtonClicked:(id)sender {
  //进入下个界面签需要先进行判断
  //，，，，先进行身份证号和手机号的有效性校验，校验成功提交开户并绑卡接口进行验证。验证通过，进入输入验证码页面
  //手机号判断
  //输入限定条件
  //收回键盘
  [connectBankCardVC takeTheKeyboard];
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  if (connectBankCardVC.bankArray.count == 0) {
    YouGu_animation_Did_Start(@"请选择银行卡");
    return;
  }
  //银行卡
  if ([connectBankCardVC.writeCardTextField.text length] == 0) {
    YouGu_animation_Did_Start(@"请输入银行卡号");
    return;
  } else if (![SimuControl citizensInformationAndIdentityCardNumberAndBank:[connectBankCardVC.writeCardTextField.text stringByReplacingOccurrencesOfString:@" "
                                                                                                                                                withString:@""]
                                                              bankIdentity:BankCarNumber]) {

    YouGu_animation_Did_Start(@"请输入正确的银行卡号");
    return;
  }
  if (![SimuControl checkCardNo:[connectBankCardVC.writeCardTextField.text stringByReplacingOccurrencesOfString:@" "
                                                                                                     withString:@""]]) {
    YouGu_animation_Did_Start(@"银行卡无效");
    return;
  }
  //姓名
  if ([connectBankCardVC.nameTextField.text length] == 0) {
    YouGu_animation_Did_Start(@"请输入姓名");
    return;
  }
  if ([connectBankCardVC.nameTextField.text length] < 2) {
    YouGu_animation_Did_Start(@"请输入正确的姓名");
    NSLog(@"%ld", [connectBankCardVC.nameTextField.text length]);
    return;
  } else if (![SimuControl citizensInformationAndIdentityCardNumberAndBank:connectBankCardVC.nameTextField.text
                                                              bankIdentity:CivicsName]) {
    YouGu_animation_Did_Start(@"请输入正确的姓名");
    return;
  }
  //身份证
  if ([connectBankCardVC.IDCardTextField.text length] == 0) {
    YouGu_animation_Did_Start(@"请输入身份证号");
    return;
  } else if (![SimuControl citizensInformationAndIdentityCardNumberAndBank:connectBankCardVC.IDCardTextField.text
                                                              bankIdentity:IDCardNumber]) {
    YouGu_animation_Did_Start(@"请输入正确的身份证号");
    return;
  }
  if (![SimuControl checkIdentityNumber:connectBankCardVC.IDCardTextField.text]) {
    YouGu_animation_Did_Start(@"身份证无效");
    return;
  }
  //手机号
  if ([connectBankCardVC.phoneTextField.text length] == 0) {
    YouGu_animation_Did_Start(@"请输入手机号");
    return;
  } else if (![SimuControl lengalPhoneNumber:connectBankCardVC.phoneTextField.text]) {
    YouGu_animation_Did_Start(@"请输入正确的手机号");
    return;
  }
  //协议同意与否
  if (connectBankCardVC.isColllected == NO) {
    YouGu_animation_Did_Start(@"请同意优顾协议");
    return;
  }
  [MBProgressHUD showMessage:@"正在加载中..."];
  [[WebServiceManager sharedManager]
      sendRequestWithOpenAcountFirstStepUserId:YouGu_User_USerid
                                      mobileId:connectBankCardVC.phoneTextField.text
                                      banknoId:connectBankCardVC.bankNumber
                                    bankaccoId:[connectBankCardVC.writeCardTextField.text stringByReplacingOccurrencesOfString:@" "
                                                                                                                    withString:@""]
                                        idnoId:connectBankCardVC.IDCardTextField.text
                                     AndNameId:connectBankCardVC.nameTextField.text
                                withCompletion:^(NSDictionary *dic) {
                                  if (dic &&
                                      [[dic objectForKey:@"status"] isEqualToString:@"0000"]) {
                                    [MBProgressHUD hideHUD];
                                    //解析
                                    [self showConnectBankWithResponse:dic];
                                  } else if (dic && [[dic objectForKey:@"status"] isEqualToString:@"1113"]) {
                                    [MBProgressHUD hideHUD];
                                    YouGu_animation_Did_Start(@"身份证号已经被绑定");
                                    return;
                                  } else if (dic && [[dic objectForKey:@"status"] isEqualToString:@"100020"]) {
                                    [MBProgressHUD hideHUD];
                                    YouGu_animation_Did_Start(@"请输入银行预留手机号");

                                    return;
                                  } else if ([[dic objectForKey:@"status"]
                                                 isEqualToString:@"200101"]) {
                                    //用户已在众禄开户则直接跳转到授权页面
                                    FPAuthorizationViewController *authVC =
                                        [[FPAuthorizationViewController alloc] init];
                                    [AppDelegate pushViewControllerFromRight:authVC];
                                  } else {
                                    NSString *message = [NSString stringWithFormat:@"%@", [dic objectForKey:@"message"]];

                                    if (!message || [message length] == 0 || [message isEqualToString:@"(null)"]) {
                                      message = networkFailed;
                                    }
                                    if (dic && [dic[@"status"] isEqualToString:@"0101"]) {
                                    } else {
                                      YouGu_animation_Did_Start(message);
                                    }
                                  }
                                  [MBProgressHUD hideHUD];
                                }];
}
//* 显示请求数据
- (void)showConnectBankWithResponse:(NSDictionary *)dict {
  FPConnectBankItem *connectBItem = [DicToArray parseConnectBankLists:dict];
  //未在众禄开户,,绑定成功后跳入到验证码页面
  FPPutInIdentifyingCodeViewController *putIFCVC = [[FPPutInIdentifyingCodeViewController alloc] init];
  putIFCVC.authPhoneTextField = connectBankCardVC.phoneTextField.text; //验证手机号码
  putIFCVC.bankCardId = connectBItem.userbankid;                       //银行卡的ID
  putIFCVC.openNumber = connectBItem.serialno;                         //开户流水号
  [AppDelegate pushViewControllerFromRight:putIFCVC];
}
- (void)refreshMainPageView {
}
- (void)leftButtonPress {
  [[NSNotificationCenter defaultCenter] postNotificationName:@"remove_open_view"
                                                      object:self
                                                    userInfo:nil];
  [super leftButtonPress];
}
@end
