//
//  SetPasswordViewController.m
//  优顾理财
//
//  Created by Mac on 15/3/19.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPSetPasswordViewController.h"
#import "Macro.h"
#import "FPFinishOpenAcountViewController.h"
#import "FPProductAgreementViewController.h"
#import "FPBankStepViewController.h"
#import "NetLoadingWaitView.h"
@interface FPSetPasswordViewController () <UITextFieldDelegate> {
  ///返回按钮
  IBOutlet UIButton *backBtn;

  ///标题(开户)
  IBOutlet UILabel *titleLabel;

  ///下一步按钮
  IBOutlet UIButton *nextStepBtn;
  ///设置交易密码
  IBOutlet UITextField *setTextField;
  ///再输入一次密码
  IBOutlet UITextField *AgainTextField;

  ///开户三步图
  FPBankStepViewController *bankStep;
}
///判断小对勾是否点击
@property(nonatomic, assign) BOOL isColllected;
@end

@implementation FPSetPasswordViewController

//移除当前界面
- (void)removeCurrentView {

  [self removeFromParentViewController];
  //注意：使用完通知后，立即将观察者注销
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  //接收完成页通知移除当前页面
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(removeCurrentView)
                                               name:@"remove_before_view"
                                             object:nil];

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

  self.childView.userInteractionEnabled = NO;
  setTextField.delegate = self;
  AgainTextField.delegate = self;

  setTextField.layer.borderWidth = 1;
  setTextField.layer.borderColor = [[Globle colorFromHexRGB:@"c7c7c7"] CGColor];
  setTextField.secureTextEntry = YES;
  setTextField.keyboardType = UIKeyboardTypeNumberPad;
  setTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
  setTextField.leftView.userInteractionEnabled = NO;
  setTextField.leftViewMode = UITextFieldViewModeAlways;
  setTextField.clearButtonMode = UITextFieldViewModeAlways;

  //再输入一次密码
  AgainTextField.layer.borderWidth = 1;
  AgainTextField.layer.borderColor =
      [[Globle colorFromHexRGB:@"c7c7c7"] CGColor];
  AgainTextField.secureTextEntry = YES;
  AgainTextField.keyboardType = UIKeyboardTypeNumberPad;
  AgainTextField.leftView =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
  AgainTextField.leftView.userInteractionEnabled = NO;
  AgainTextField.leftViewMode = UITextFieldViewModeAlways;
  AgainTextField.clearButtonMode = UITextFieldViewModeAlways;

  titleLabel.textColor =
      (UIColor *)[[Globle colorFromHexRGB:@"F07533"] CGColor];
  //下一步按钮
  [nextStepBtn
      setTitleColor:(UIColor *)[[Globle colorFromHexRGB:@"F07533"] CGColor]
           forState:UIControlStateNormal];
  [nextStepBtn setBackgroundImage:highlightImage
                     forState:UIControlStateHighlighted];

  ///开户三步图片
  bankStep = [[FPBankStepViewController alloc] initWithNibName:@"FPBankStepViewController" bundle:nil];
  [self.view addSubview:bankStep.view];
  bankStep.view.userInteractionEnabled = NO;
  bankStep.secondStepBGView.layer.borderColor = [Globle colorFromHexRGB:customFilledColor].CGColor;
  bankStep.secondStepInterView.backgroundColor = [Globle colorFromHexRGB:customFilledColor];
}


#pragma mark---textFieldDelegate

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

  [setTextField resignFirstResponder];
  [AgainTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return YES;
}
- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string {
  NSString *toBeString =
  [textField.text stringByReplacingCharactersInRange:range
                                          withString:string];
  /** 提示输入数字*/
  NSCharacterSet *cs;
  if (textField == setTextField||textField==AgainTextField) {
    cs = [[NSCharacterSet
           characterSetWithCharactersInString:@"0123456789\n"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]
                          componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if (!basicTest) {
      
      return NO;
    }else
    {
      
      if (toBeString.length > 6) {
        textField.text = [toBeString substringToIndex:6];
        return NO;
      }else{
        
        return YES;
      }
    }
    
  }
  
  return YES;
}

- (void)backBtnClick {
  YGLog(@"返回按钮被点击");
  [self.navigationController popToRootViewControllerAnimated:YES];
}

//下一步按钮
- (IBAction)nextBtnClick:(UIButton *)sender {
  YGLog(@"下一步按钮被点击");
  //    FinishOpenAcountViewController *finishOpenVC =
  //    [[FinishOpenAcountViewController alloc]init];
  //    [AppDelegate pushViewControllerFromRight:finishOpenVC];

  if (setTextField.text.length == 0) {
    YouGu_animation_Did_Start(@"请输入设置密码");
    return;
  }
  if (AgainTextField.text.length == 0) {
    YouGu_animation_Did_Start(@"请再次输入设置密码");
    return;
  }

  if ((![SimuControl validateSixNumberIdentityCard:setTextField.text]) ||
      (![SimuControl validateSixNumberIdentityCard:AgainTextField.text])) {
    YouGu_animation_Did_Start(@"必须为六位数字");
    return;
  } else if ([setTextField.text integerValue] !=
             [AgainTextField.text integerValue]) {

    YouGu_animation_Did_Start(@"两次的密码不一样，请重新输入");
    return;
  } else {
    //发送数据请求
    [self sendSetPassword];
  }
}

//发送数据请求
- (void)sendSetPassword {  
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  [NetLoadingWaitView startAnimating];
  [[WebServiceManager sharedManager]
      sendRequestWithSetPasswordtUserId:YouGu_User_USerid
                         andTradecodeId:setTextField.text
                         withCompletion:^(NSDictionary *dic) {
                           if (dic && [[dic objectForKey:@"status"]
                                          isEqualToString:@"0000"]) {
                             [NetLoadingWaitView stopAnimating];

                            [SimuControl openAcountWithType:@"1"];

                             //相同则保存用户密码，直接进入-----操作完成
                             FPFinishOpenAcountViewController *finishOpenVC =
                                 [[FPFinishOpenAcountViewController alloc] init];
                             [AppDelegate pushViewControllerFromRight:finishOpenVC];

                           } else {
                             
                             [NetLoadingWaitView stopAnimating];
                             NSString *message = [NSString
                                 stringWithFormat:@"%@",
                                                  [dic
                                                      objectForKey:@"message"]];
                             if (!message || [message length] == 0 ||
                                 [message isEqualToString:@"(null)"]) {
                               message = networkFailed;
                             }
                             if (dic &&
                                 [dic[@"status"] isEqualToString:@"0101"]){
                             }else{
                               YouGu_animation_Did_Start(message);
                             }                             return;
                           }

                         }];
}
- (IBAction)protocalBtnClick:(UIButton *)sender {

  YGLog(@"展示优顾理财优购协议");

  FPProductAgreementViewController *productVC =
      [[FPProductAgreementViewController alloc] init];

  [AppDelegate pushViewControllerFromRight:productVC];
}
- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
