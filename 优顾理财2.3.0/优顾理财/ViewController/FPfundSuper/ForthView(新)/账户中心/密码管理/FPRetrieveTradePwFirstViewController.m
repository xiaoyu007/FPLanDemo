//
//  RetrieveTradePwFirstViewController.m
//  优顾理财
//
//  Created by jhss on 15-4-19.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPRetrieveTradePwFirstViewController.h"
#import "FPRetrieveTradePwSecondViewController.h"
#import "UIButton+Block.h"
#import "NetLoadingWaitView.h"
#import "OnLoginRequest.h"

#define NUMBERS @"0123456789\n"
#define timeLength 60
@interface FPRetrieveTradePwFirstViewController ()
- (IBAction)navBtn:(id)sender;


///重新验证
@property(nonatomic, strong) UILabel *authLabel;
///验证码倒计时时间
@property(nonatomic, strong) UILabel *authTimeLabel;
@end

@implementation FPRetrieveTradePwFirstViewController
{
  ///输入验证码框
  IBOutlet UITextField *authTextField;
  ///验证码按钮
  IBOutlet UIButton *authBtn;
  
  UILabel *labAuth;
  UILabel *labTime;
  ///点击下一步按钮
  IBOutlet UIButton *nextBtn;
  IBOutlet UIButton *navBtn;
  ///倒数时间
  int countDown;
  NSTimer *timer;
  
  UILabel *lab;
  UILabel *time;
}
- (void)removeCurrentView {
  [self removeFromParentViewController];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  //接收完成页通知移除当前页面
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(removeCurrentView)
                                               name:@"remove_before_view"
                                             object:nil];
  
  
 
  

  self.childView.userInteractionEnabled = NO;
  authTextField.layer.borderColor = [Globle colorFromHexRGB:textfieldBordColor].CGColor;
  authTextField.layer.borderWidth = 1;
  authTextField.keyboardType = UIKeyboardTypeNumberPad;
  authTextField.clearButtonMode = UITextFieldViewModeAlways;
  authTextField.leftView =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
  authTextField.leftView.userInteractionEnabled = NO;
  authTextField.delegate = self;
  authTextField.leftViewMode = UITextFieldViewModeAlways;


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
  __weak FPRetrieveTradePwFirstViewController *weakSelf = self;
  [nextBtn setOnButtonPressedHandler:^{
    
    FPRetrieveTradePwFirstViewController *strongSelf = weakSelf;
    if (strongSelf) {
      [strongSelf nextBtnClick];
    }
  }];

  
  lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 4,91, 14)];
  lab.text = @"重新验证";
  lab.textColor = [UIColor whiteColor];
  lab.textAlignment = NSTextAlignmentCenter;
  lab.font = [UIFont systemFontOfSize:13];
  [authBtn addSubview:lab];
  
  
  time = [[UILabel alloc]initWithFrame:CGRectMake(0, 21, 91, 12)];
  time.text = [NSString stringWithFormat:@"( %d″)", timeLength];
  time.textColor = [UIColor whiteColor];
  time.textAlignment = NSTextAlignmentCenter;
  time.font = [UIFont systemFontOfSize:12];
  [authBtn addSubview:time];

  //验证码
  requesting = NO;
  [self captchaBtnClickWithNum:0];
  
  __weak FPRetrieveTradePwFirstViewController *weakAuthSelf = self;
  [authBtn setOnButtonPressedHandler:^{
    
    FPRetrieveTradePwFirstViewController *strongSelf = weakAuthSelf;
    if (strongSelf) {
      [strongSelf captchaBtnClickWithNum:0];
    }
  }];
  
  self.authLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 4, 91, 14)];
  self.authLabel.textAlignment = NSTextAlignmentCenter;
  self.authLabel.textColor = [UIColor whiteColor];
  self.authLabel.font = [UIFont systemFontOfSize:13];
  [authBtn addSubview:self.authLabel];

  //计时
  self.authTimeLabel =
      [[UILabel alloc] initWithFrame:CGRectMake(0, 21, 91, 12)];
  self.authTimeLabel.textAlignment = NSTextAlignmentCenter;
  self.authTimeLabel.textColor = [UIColor whiteColor];
  self.authTimeLabel.font = [UIFont systemFontOfSize:12];
  [authBtn addSubview:self.authTimeLabel];
}
- (void)captchaBtnClickWithNum:(NSInteger)num {
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  countDown = timeLength;
  self.authLabel.textColor = [UIColor whiteColor];
  self.authTimeLabel.textColor = [UIColor whiteColor];
  self.authLabel.text = @"重新验证";
  self.authTimeLabel.text = [NSString stringWithFormat:@"( %d″)", timeLength];
  
  //发送请求数据
  [self requestCaptchaWithNum:num];
  

  [authBtn setTitle:@"" forState:UIControlStateNormal];
  [authBtn setBackgroundColor:
               [UIColor colorWithRed:0.67f green:0.67f blue:0.67f alpha:1.00f]];
  timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                           target:self
                                         selector:@selector(timeFireMethod:)
                                         userInfo:nil
                                          repeats:YES];
}
- (void)timeFireMethod:(NSTimer *)theTimer {
  if (countDown == 0) {
    [theTimer invalidate];
    countDown = timeLength;
    [authBtn setTitle:@"重新获取" forState:UIControlStateNormal];
    [authBtn setBackgroundColor:[Globle colorFromHexRGB:@"f07533"]];
    self.authLabel.textColor = [UIColor clearColor];
    self.authTimeLabel.textColor = [UIColor clearColor];
    [authBtn setEnabled:YES];

  } else {
    countDown--;
    lab.hidden = YES;
    time.hidden = YES;
    [authBtn
        setBackgroundColor:
            [UIColor colorWithRed:0.67f green:0.67f blue:0.67f alpha:1.00f]];
    [authBtn setEnabled:NO];
    [authBtn setTitle:@" " forState:UIControlStateNormal];
    self.authLabel.text = @"重新验证";
    if (countDown == 0) {
      return;
    }
    self.authTimeLabel.text = [NSString stringWithFormat:@"( %d″)", countDown];
  }
}
//请求数据
- (void)requestCaptchaWithNum:(NSInteger)num {
  if (requesting) {
    return;
  }
  if (num >= 3) {
    return;
  }
  [NetLoadingWaitView startAnimating];
  requesting = YES;
  HttpRequestCallBack* callBack = [[HttpRequestCallBack alloc] init];
  __weak FPRetrieveTradePwFirstViewController* weakSelf = self;
  callBack.onCheckQuitOrStopProgressBar = ^{
    FPRetrieveTradePwFirstViewController *strongObj = weakSelf;
    if (strongObj) {
      requesting = NO;
      [NetLoadingWaitView stopAnimating];
      return NO;
    } else {
      return YES;
    }
  };
  callBack.onError = ^(BaseRequestObject *obj, NSException *exc){
    if (obj) {
      YouGu_animation_Did_Start(obj.message);
    }else{
      YouGu_animation_Did_Start(networkFailed);
    }
  };
  callBack.onSuccess = ^(NSObject* obj) {
  };
  callBack.onFailed = ^{
    [self requestCaptchaWithNum:(num+1)];
    [BaseRequester defaultFailedHandler]();
  };
  [FindTradePassword findTradePasswordWithPhoneNumber:_phoneNum withCallBack:callBack];
}
#pragma mark-----textFieldDelegate
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [authTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

  [textField resignFirstResponder];
  return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

  NSString *toBeString =
  [textField.text stringByReplacingCharactersInRange:range
                                          withString:string];
  
  NSCharacterSet *cs;
  if (textField == authTextField) {
    cs = [[NSCharacterSet
           characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]
                          componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if (!basicTest) {
      
      return NO;
    }
  }
  if (textField == authTextField) {
    if (toBeString.length > 6) {
      
      textField.text = [toBeString substringToIndex:6];
      return NO;
    }else{
      
      return YES;
    }
    
  }
  
  //其他的类型不需要检测，直接写入
  return YES;
 
}


- (IBAction)navBtn:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
}

-(void)nextBtnClick {
  [authTextField resignFirstResponder];
  
  NSLog(@"进入下一个界面");
  //输入限定条件
  if ([authTextField.text length] == 0) {
    YouGu_animation_Did_Start(@"请输入验证码");
    return;
  } else if (![SimuControl
               validateSixNumberIdentityCard:authTextField
               .text]) {
    YouGu_animation_Did_Start(@"验证码输入有误");
    return;
  }else if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  if (timer) {
    if ([timer respondsToSelector:@selector(isValid)]) {
      //重置
      if ([timer isValid]) {
        [timer invalidate];
        countDown = timeLength;
        [authBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        [authBtn setBackgroundColor:[Globle colorFromHexRGB:@"f07533"]];
        self.authLabel.textColor = [UIColor clearColor];
        self.authTimeLabel.textColor = [UIColor clearColor];
        [authBtn setEnabled:YES];
      }
    }
  }
  [NetLoadingWaitView startAnimating];
  //解析数据
  HttpRequestCallBack* callBack = [[HttpRequestCallBack alloc] init];
  __weak FPRetrieveTradePwFirstViewController* weakSelf = self;
  callBack.onCheckQuitOrStopProgressBar = ^{
    FPRetrieveTradePwFirstViewController *strongSelf = weakSelf;
    if (strongSelf) {
      [NetLoadingWaitView stopAnimating];
      return NO;
    } else {
      return YES;
    }
  };
  callBack.onSuccess = ^(NSObject* obj) {
    FPRetrieveTradePwFirstViewController* strongSelf = weakSelf;
    if (strongSelf) {
      FPRetrieveTradePwSecondViewController *retriveSecond =
      [[FPRetrieveTradePwSecondViewController alloc] init];
      retriveSecond.phoneNum = _phoneNum;
      retriveSecond.authStr = authTextField.text;
      
      [AppDelegate pushViewControllerFromRight:retriveSecond];
    }
  };
  [VerificationNumber Verification_REGISTERPIN:_phoneNum andVerification:authTextField.text andType:@"10" WithcallBack:callBack];
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
