//
//  FinishOpenAcountViewController.m
//  优顾理财
//
//  Created by Mac on 15/3/19.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPFinishOpenAcountViewController.h"
#import "FPBankStepViewController.h"


@interface FPFinishOpenAcountViewController ()
- (IBAction)finishBtn:(id)sender;

@end

@implementation FPFinishOpenAcountViewController {

  ///返回按钮
  IBOutlet UIButton *backBtn;
  ///开户完成按钮
  IBOutlet UIButton *finishBtn;
  ///开户三步图
  FPBankStepViewController *bankStep;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  self.childView.userInteractionEnabled = NO;

  [backBtn addTarget:self
                action:@selector(backBtnClick)
      forControlEvents:UIControlEventTouchUpInside];
  [backBtn setImage:[UIImage imageNamed:@"返回小箭头.png"]
           forState:UIControlStateNormal];
  [backBtn setImage:[UIImage imageNamed:@"返回小箭头.png"]
           forState:UIControlStateHighlighted];
  backBtn.imageEdgeInsets = UIEdgeInsetsMake(15, 20, 15, 20);
  UIImage *highlightImage =
      [FPYouguUtil createImageWithColor:btnAccordingToTheNormal];
  [backBtn setBackgroundImage:highlightImage
                     forState:UIControlStateHighlighted];

  [finishBtn setBackgroundImage:highlightImage
                       forState:UIControlStateHighlighted];

  ///开户三步图片
  bankStep = [[FPBankStepViewController alloc] initWithNibName:@"FPBankStepViewController" bundle:nil];
  [self.view addSubview:bankStep.view];
  bankStep.view.userInteractionEnabled = NO;
  bankStep.thirdStepBGView.layer.borderColor = [Globle colorFromHexRGB:customFilledColor].CGColor;
  bankStep.thirdStepInterView.backgroundColor = [Globle colorFromHexRGB:customFilledColor];
  bankStep.secondStepBGView.layer.borderColor = [Globle colorFromHexRGB:customFilledColor].CGColor;
  bankStep.secondStepInterView.backgroundColor = [Globle colorFromHexRGB:customFilledColor];
}
/** 调用开户页面 */
+(void)checkOpenAcountStatusWithCallback:(buyOpenCallback)callback{
  
  
  
  
}
- (void)backBtnClick {
//  [self nsnotification];
//  [self removeFromParentViewController];
  [self.navigationController popToRootViewControllerAnimated:YES];
  
}

- (IBAction)finishBtn:(id)sender {
 

  [self nsnotification];
  [self removeFromParentViewController];
}


///按钮出发事件
- (void)nsnotification {
  [SimuControl openAcountWithType:@"1"];
  //    [[NSUserDefaults standardUserDefaults]setInteger:1
  //    forKey:@"My_open_count"];
  
  //发通知使之前的界面都移除(开户流程页)
  [[NSNotificationCenter defaultCenter]
      postNotificationName:@"remove_before_view"
                    object:self
                  userInfo:nil];
  double delayInSeconds = 0.5;
  dispatch_time_t popTime =
      dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
    
    if (buyCallBack) {
      buyCallBack(YES);
    }
    
    
//    //首页申购
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"Go_to_buy_to_buy"
//                                                        object:self
//                                                      userInfo:nil];
  
    ///产品详情页申购
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Go_to_deatil_buy_to_buy"
                                                        object:self
                                                      userInfo:nil];
    ///去我的资产界面
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Go_to_myAsset"
                                                        object:self
                                                      userInfo:nil];
    ///产品详情界面赎回
    [[NSNotificationCenter defaultCenter]
        postNotificationName:@"redeemBtnClick"
                      object:self
                    userInfo:nil];
    
    ///开户完成后跳转修改交易密码
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"go_to_My_RevampTradeView"
     object:self
     userInfo:nil];
    ///开户完成后跳转找回交易密码
    [[NSNotificationCenter defaultCenter]postNotificationName:@"find_trade_pass_word" object:self userInfo:nil];
   
    ///开户完成后跳入银行卡管理界面
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"go_to_bankManage"
     object:self
     userInfo:nil];
    

  });
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
@end
