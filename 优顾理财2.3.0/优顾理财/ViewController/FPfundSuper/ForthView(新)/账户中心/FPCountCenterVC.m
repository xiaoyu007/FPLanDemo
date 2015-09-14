//
//  CountCenterVC.m
//  优顾理财
//
//  Created by Mac on 15/3/10.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPCountCenterVC.h"
#import "FPBankManageViewController.h"
#import "FPPasswordManageViewController.h"
#import "FPOpenAccountInfo.h"
#import "NetLoadingWaitView.h"
#import "DataArray.h"

@implementation FPCountCenterVC {

  IBOutlet UIButton *navBtn;
  IBOutlet UIButton *managerBankBtn;
  IBOutlet UIButton *managerPasswordBtn;
  ///手机号
  IBOutlet UILabel *iphoneNumlabel;
  ///姓名
  IBOutlet UILabel *nameLabel;
  ///身份证号
  IBOutlet UILabel *IDCardLabel;

  IBOutlet UILabel *bankNum;
  //银行数组
  DataArray *bankArray;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.childView.userInteractionEnabled = NO;
  bankArray = [[DataArray alloc] init];
  [navBtn addTarget:self
                action:@selector(navigationBtn)
      forControlEvents:UIControlEventTouchUpInside];
  [navBtn setImage:[UIImage imageNamed:@"返回小箭头.png"] forState:UIControlStateNormal];
  [navBtn setImage:[UIImage imageNamed:@"返回小箭头.png"] forState:UIControlStateHighlighted];
  navBtn.imageEdgeInsets = UIEdgeInsetsMake(15, 20, 15, 20);
  UIImage *highlightImage = [FPYouguUtil createImageWithColor:btnAccordingToTheNormal];
  [navBtn setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
  ///管理银行卡按下态
  managerBankBtn.imageEdgeInsets = UIEdgeInsetsMake(15, 20, 15, 20);
  [managerBankBtn setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
  ///管理密码按下态
  managerPasswordBtn.imageEdgeInsets = UIEdgeInsetsMake(15, 20, 15, 20);
  [managerPasswordBtn setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
  ///开户完成后跳入银行卡管理界面
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(goToBankManageView)
                                               name:@"go_to_bankManage"
                                             object:nil];
  [self sendRequest];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(refreshSelfView)
                                               name:@"remove_to_before_VC"
                                             object:nil];
}
/** 刷新当前界面 */
- (void)refreshSelfView {
  double delayInSeconds = 0.5;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
    [self sendRequest];
  });
}
/** 发送请求 */
- (void)sendRequest {
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  [NetLoadingWaitView startAnimating];
  [[WebServiceManager sharedManager] sendRequestWithAccountCenterUserId:YouGu_User_USerid
                                                         withCompletion:^(NSDictionary *dic) {
                                                           [NetLoadingWaitView stopAnimating];
                                                           if (dic && [dic[@"status"] isEqualToString:@"0000"]) {
                                                             // 解析
                                                             [self showAcountCenterBankListWithResponse:dic];
                                                           } else {
                                                             NSString *message =
                                                                 dic ? dic[@"message"] : networkFailed;
                                                             if (dic && [dic[@"status"] isEqualToString:@"0101"]) {
                                                             } else {
                                                               YouGu_animation_Did_Start(message);
                                                             }
                                                             return;
                                                           }
                                                         }];
}
- (void)showAcountCenterBankListWithResponse:(NSDictionary *)dict {
  FPCountCenterItem *item = [DicToArray pareseCountCenterList:dict];
  if (bankArray.array.count > 0) {
    [bankArray.array removeAllObjects];
  }
  [bankArray.array addObjectsFromArray:item.bankList];
  bankArray.dataBinded = YES;
  if (item.mobile && [item.mobile length] > 7) {
    NSMutableString *iphoneMut = [[NSMutableString alloc] initWithString:item.mobile];
    [iphoneMut replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    iphoneNumlabel.text = iphoneMut;
  }
  if (item.name && [item.name length] > 1) {
    NSMutableString *nameMut = [[NSMutableString alloc] initWithString:item.name];
    [nameMut replaceCharactersInRange:NSMakeRange(0, 1) withString:@"*"];
    nameLabel.text = nameMut;
  }
  if (item.idno && [item.idno length] > 14) {
    NSMutableString *IDCardMut = [[NSMutableString alloc] initWithString:item.idno];
    [IDCardMut replaceCharactersInRange:NSMakeRange(8, 6) withString:@"******"];
    IDCardLabel.text = IDCardMut;
  }

  bankNum.text = [NSString stringWithFormat:@"%lu张", (unsigned long)bankArray.array.count];
}
//银行卡管理
- (IBAction)manageBtn:(id)sender {
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  [Login_ViewController checkLoginStatusWithCallback:^(BOOL logonSuccess) {
    if (logonSuccess) {
      [[FPOpenAccountInfo shareInstance] openAccountStatusJudgementWithFromPage:IsopenAccountType];
    }
  }];
}
- (void)goToBankManageView {
  if (bankArray.dataBinded && bankArray.array.count < 1) {
    YouGu_animation_Did_Start(@"未请求到银行卡数据，请重试");
    return;
  }
  FPBankManageViewController *bankManageVC = [[FPBankManageViewController alloc] init];
  bankManageVC.mutBankArray = [[NSMutableArray alloc] init];
  [bankManageVC.mutBankArray addObjectsFromArray:bankArray.array];
  [AppDelegate pushViewControllerFromRight:bankManageVC];
}
//密码管理
- (IBAction)changePassword:(id)sender {

  FPPasswordManageViewController *passMVC = [[FPPasswordManageViewController alloc] init];
  [AppDelegate pushViewControllerFromRight:passMVC];
}
//返回上一界面
- (void)navigationBtn {
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
  //注意：使用完通知后，立即将观察者注销
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
