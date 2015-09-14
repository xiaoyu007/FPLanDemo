//
//  RetrieveTradePwViewController.m
//  优顾理财
//
//  Created by jhss on 15-4-19.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPRetrieveTradePwViewController.h"
#import "FPRetrieveTradePwFirstViewController.h"
#import "UIButton+Block.h"
#import "NetLoadingWaitView.h"

@interface FPRetrieveTradePwViewController () <UITextFieldDelegate>
- (IBAction)navBtn:(id)sender;

@end

@implementation FPRetrieveTradePwViewController {

  IBOutlet UIButton *navBtn;
  IBOutlet UITextField *nameTextField;
  IBOutlet UITextField *IDCardTextField;
  IBOutlet UIButton *nextBtn;

  NSString *phoneNumber;
}
- (void)removeCurrentView {

  [self removeFromParentViewController];
}
- (void)viewDidLoad {
  [super viewDidLoad];
  self.childView.userInteractionEnabled = NO;

  //接收完成页通知移除当前页面
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(removeCurrentView)
                                               name:@"remove_before_view"
                                             object:nil];

  nameTextField.layer.borderColor = [Globle colorFromHexRGB:textfieldBordColor].CGColor;
  nameTextField.layer.borderWidth = 1;
  nameTextField.text = self.nameStr;
  nameTextField.clearButtonMode = UITextFieldViewModeAlways;
  nameTextField.leftView =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
  nameTextField.leftView.userInteractionEnabled = NO;
  nameTextField.delegate = self;
  nameTextField.leftViewMode = UITextFieldViewModeAlways;


  IDCardTextField.layer.borderWidth = 1;
  IDCardTextField.layer.borderColor =
      [Globle colorFromHexRGB:textfieldBordColor].CGColor;
  IDCardTextField.text = self.IDStr;
  IDCardTextField.clearButtonMode = UITextFieldViewModeAlways;
  IDCardTextField.leftView =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
  IDCardTextField.leftView.userInteractionEnabled = NO;
  IDCardTextField.delegate = self;
  IDCardTextField.leftViewMode = UITextFieldViewModeAlways;


  [navBtn setImage:[UIImage imageNamed:@"返回小箭头.png"]
          forState:UIControlStateNormal];
  [navBtn setImage:[UIImage imageNamed:@"返回小箭头.png"]
          forState:UIControlStateHighlighted];
  navBtn.imageEdgeInsets = UIEdgeInsetsMake(15, 20, 15, 20);
  UIImage *highlightImage =
      [FPYouguUtil createImageWithColor:btnAccordingToTheNormal];
  [navBtn setBackgroundImage:highlightImage forState:UIControlStateHighlighted];

  [nextBtn setBackgroundColor:[Globle colorFromHexRGB:@"f07533"]];
  [nextBtn setBackgroundImage:highlightImage
                     forState:UIControlStateHighlighted];
  requesting = NO;
  __weak FPRetrieveTradePwViewController *weakSelf = self;
  [nextBtn setOnButtonPressedHandler:^{
    
    FPRetrieveTradePwViewController *strongSelf = weakSelf;
    if (strongSelf) {
      [strongSelf nextBtnClick];
    }
  }];
}
#pragma mark-----textFieldDelegate
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

  [nameTextField resignFirstResponder];
  [IDCardTextField resignFirstResponder];
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
  
  
    if (textField == IDCardTextField) {
    NSString *str = [toBeString uppercaseString];
      toBeString = str ;
    if (toBeString.length > 18) {
      textField.text = [toBeString substringToIndex:18];
      return NO;
    }else{
      textField.text = toBeString;
      return NO;
    }
  }
  return YES;
  
}
- (IBAction)navBtn:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
}
-(void)nextBtnClick{
  [nameTextField resignFirstResponder];
  [IDCardTextField resignFirstResponder];
  //姓名
  if ([nameTextField.text length] == 0) {
    YouGu_animation_Did_Start(@"请输入姓名");
    return;

  } else if (![SimuControl citizensInformationAndIdentityCardNumberAndBank:
                               nameTextField.text bankIdentity:CivicsName]) {
    YouGu_animation_Did_Start(@"请输入正确的姓名");
    return;
  }
  //身份证
  if ([IDCardTextField.text length] == 0) {
    YouGu_animation_Did_Start(@"请输入身份证号");
    return;
  } else if (![SimuControl
                 citizensInformationAndIdentityCardNumberAndBank:
                     IDCardTextField.text bankIdentity:IDCardNumber]) {
    YouGu_animation_Did_Start(@"请输入正确的身份证号");
    return;
  }
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  if (requesting) {
    return;
  }
  ///发送数据请求
  [self sendRequestWithVerifyIdentity:@"1111" AndIdno:@"2222"];
}
- (void)sendRequestWithVerifyIdentity:(NSString *)userName
                              AndIdno:(NSString *)idno {
  
  [NetLoadingWaitView startAnimating];
  requesting = YES;
  [[WebServiceManager sharedManager]
      sendRequestWithusernameId:nameTextField.text
                      AndidnoId:IDCardTextField.text
                 withCompletion:^(NSDictionary *dic) {
                   [NetLoadingWaitView stopAnimating];
                   requesting = NO;
                   
                   if (dic &&
                       [dic[@"status"] isEqualToString:@"0000"]) {
                     //解析
                     [self showRetrieveListWithResponse:dic];
                     //需要做判断是否输入的信息正确
                     FPRetrieveTradePwFirstViewController *retriveTradeFVC =
                         [[FPRetrieveTradePwFirstViewController alloc] init];
                     retriveTradeFVC.phoneNum = phoneNumber;

                     [AppDelegate pushViewControllerFromRight:retriveTradeFVC];
                   } else {
                     NSString *message = [NSString
                         stringWithFormat:@"%@", dic[@"message"]];
                     if (!message || [message length] == 0 ||
                         [message isEqualToString:@"(null)"]) {
                       message = networkFailed;
                     }
                     YouGu_animation_Did_Start(message);
                   }

                 }];
}
- (void)showRetrieveListWithResponse:(NSDictionary *)dic {
  FPRetrieveItem *item = [DicToArray parseRetrieveList:dic];
  phoneNumber = item.phone;
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
