//
//  CancelDetermineViewController.m
//  优顾理财
//
//  Created by jhss on 15-4-8.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPCancelDetermineViewController.h"
#import "NetLoadingWaitView.h"
#import "UIButton+Block.h"
#define NUMBERS @"0123456789\n"

@interface FPCancelDetermineViewController () <UITextFieldDelegate>

@end

@implementation FPCancelDetermineViewController {
  ///导航按钮
  IBOutlet UIButton *navigBtn;
  ///交易密码
  IBOutlet UITextField *dealTextField;
  ///确认按钮
  IBOutlet UIButton *affirmBtn;
  ///滚动背景
  IBOutlet UIScrollView *scrollView;
  ///动画
  CAShapeLayer *arcLayer;
  UIView *roundView;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  self.childView.userInteractionEnabled = NO;
  [self updateView];
  [self updatePageData];
//  [self createCancelShieldLay];
  
}
/** 调整界面UI */
- (void)updateView{
  //交易密码
  dealTextField.delegate = self;
  dealTextField.layer.borderWidth = 1;
  dealTextField.layer.borderColor =
  [[Globle colorFromHexRGB:@"f07533"] CGColor];
  dealTextField.leftView =
  [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
  dealTextField.leftView.userInteractionEnabled = NO;
  dealTextField.leftViewMode = UITextFieldViewModeAlways;
  dealTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
  [dealTextField setSecureTextEntry:YES];
  dealTextField.keyboardType = UIKeyboardTypeNumberPad;
  //返回按钮
  [navigBtn addTarget:self
               action:@selector(navigBtnClick:)
     forControlEvents:UIControlEventTouchUpInside];
  navigBtn.tag = 11;
  [navigBtn setImage:[UIImage imageNamed:@"返回小箭头.png"]
            forState:UIControlStateNormal];
  [navigBtn setImage:[UIImage imageNamed:@"返回小箭头.png"]
            forState:UIControlStateHighlighted];
  navigBtn.imageEdgeInsets = UIEdgeInsetsMake(15, 20, 15, 20);
  UIImage *highlightImage =
  [FPYouguUtil createImageWithColor:btnAccordingToTheNormal];
  [navigBtn setBackgroundImage:highlightImage
                      forState:UIControlStateHighlighted];
  //确认按钮
  affirmBtn.backgroundColor = [Globle colorFromHexRGB:@"f07533"];
  affirmBtn.layer.cornerRadius = 18.5;
  affirmBtn.layer.masksToBounds = YES;
  [affirmBtn setBackgroundImage:highlightImage
                       forState:UIControlStateHighlighted];
  
  FPCancelDetermineViewController *weakSelf = self;
  [affirmBtn setOnButtonPressedHandler:^{
    FPCancelDetermineViewController *strongSelf = weakSelf;
    if (strongSelf) {
      //点击确认撤单按钮
      [strongSelf confirmBtn];
    }
  }];
  scrollView.userInteractionEnabled = YES;
  scrollView.frame = CGRectMake(0,70, windowWidth, windowHeight-60.0f);
  scrollView.contentSize = CGSizeMake(windowWidth, 500.0f);
  
  ///键盘收回
  UITapGestureRecognizer *tap =
  [[UITapGestureRecognizer alloc] initWithTarget:self
                                          action:@selector(animationTextField)];
  [scrollView addGestureRecognizer:tap];
}

-(void)confirmBtn{

  [self animationTextField];
  if ([dealTextField.text length]==0) {
    
    YouGu_animation_Did_Start(@"请输入交易密码");
    return;
  }
  if([dealTextField.text length]<6&&[dealTextField.text length]>0){
    
    YouGu_animation_Did_Start(@"请输入完整的密码");
    return;
  }
  //点击确认按钮请求数据
  [self sendRequestWithAffirmAndCancel];
  
}
/** 撤单确认请求成功 */
- (void)updatePageData{
  //委托时间
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"yyyy年MM月dd日  HH点mm分"];
  NSDate *date =
  [[NSDate alloc] initWithTimeIntervalSince1970:[_item.time longLongValue]/1000];
  self.deleTime.text = [dateFormatter stringFromDate:date];
  //交易类型
  self.dealTypeLabel.text = self.tradeType;
  //基金名称
  self.fundNameLabel.text = _item.fundname;
  CGSize nameSize = [self.fundNameLabel.text sizeWithFont:[UIFont systemFontOfSize:15.0f] constrainedToSize:CGSizeMake(windowWidth - 95.0f, 100)];
  self.fundNameLabel.height = nameSize.height + 2.0f;
  //产品代码
  self.productWord.text = _item.fundid;
  //交易账户
  self.payAccount.text =_item.bankName;
  //申请金额
  self.applyMoney.text = [NSString
                          stringWithFormat:@"%@",_item.subamt];
  //付款状态
//  self.payStatelabel.text =[TradeStatusInfo getTradeStatusFromId:_item.payStatus];
  if (_item.payStatus.length>0) {
     self.payStatelabel.text = _item.payStatus;
  }else{
  
    self.payStatelabel.text = @"--";
  }
 
}
#pragma mark - 数据加载
///返回点击事件
- (void)navigBtnClick:(UIButton *)btn {
  [dealTextField resignFirstResponder];
  [self animationTextField];

    [self.navigationController popViewControllerAnimated:YES];

}
//请求数据
- (void)sendRequestWithAffirmAndCancel {
  [NetLoadingWaitView startAnimating];
    [[WebServiceManager sharedManager]
      sendRequestWithAffirmUserId:YouGu_User_USerid
                   tradeAccountId:self.tradeacco
                serialnoAccountId:self.serialno
            andTradecodeAccountId:dealTextField.text
                   withCompletion:^(id response) {
                     if (response && [[response objectForKey:@"status"]
                                         isEqualToString:@"0000"]) {
                       [NetLoadingWaitView stopAnimating];
                      
//                       shieldView.hidden = NO;
//                       roundView.hidden = NO;
                       ///加载动画
                       [self createCancelShieldLay];
                       
                       YouGu_animation_Did_Start(@"您的撤单申请已受理");
                       [NSTimer
                                scheduledTimerWithTimeInterval:2.0
                                target:self
                                selector:@selector(backView)
                                userInfo:nil
                                repeats:NO];
                     } else {
                       [NetLoadingWaitView stopAnimating];
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
                       }
                     }
                   }];
}
#pragma mark - 定时器操作
///创建遮蔽层
- (void)createCancelShieldLay{
  
  
  shieldView = [[UIView alloc]initWithFrame:self.view.bounds];
  shieldView.backgroundColor = [UIColor blackColor];
  shieldView.alpha = 0.5;
//  shieldView.hidden = YES;
  [self.view addSubview:shieldView];
  //调用所画得图形
  [self intiUIOfView];
  
  roundView = [[UIView alloc]
                       initWithFrame:CGRectMake(
                                                windowWidth / 2-19,
                                                windowHeight / 2-29 , 38,
                                                38)];
  roundView.backgroundColor =
  [UIColor blackColor];
  
  roundView.layer.cornerRadius = 20;
  roundView.layer.masksToBounds = YES;
  roundView.alpha = 0.5;
//  roundView.hidden = YES;
  [self.view addSubview:roundView];


}
///定义所需要画的图形
- (void)intiUIOfView {
  UIBezierPath *path = [UIBezierPath bezierPath];
  CGRect rect = [UIScreen mainScreen].applicationFrame;
//  [path addArcWithCenter:CGPointMake(rect.size.width / 2,
//                                     rect.size.height / 2 - 50)
//                  radius:20
//              startAngle:0
//                endAngle:2 * M_PI
//               clockwise:NO];
  [path addArcWithCenter:CGPointMake(rect.size.width / 2,
                                     rect.size.height / 2)
                  radius:20
              startAngle:0
                endAngle:2 * M_PI
               clockwise:NO];
  arcLayer = [CAShapeLayer layer];
  arcLayer.path = path.CGPath; // 46,169,230
  arcLayer.fillColor = [Globle colorFromHexRGB:@"f6f6f6"].CGColor;
  arcLayer.strokeColor = [Globle colorFromHexRGB:@"f07533"].CGColor;
//  arcLayer.strokeColor = CFBridgingRetain([UIColor orangeColor]);
  
  arcLayer.lineWidth = 3;
  arcLayer.frame = self.view.frame;
  [shieldView.layer addSublayer:arcLayer];
  [self drawLineAnimation:arcLayer];
}
- (void)backView {
  shieldView.hidden = YES;
  /**  刷新委托撤单数据*/
  [[NSNotificationCenter defaultCenter]
   postNotificationName:@"refeshCheckData"
   object:self
   userInfo:nil];
  [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark--textFieldDelegate
- (void)animationTextField {
  [dealTextField resignFirstResponder];
  [UIView beginAnimations:nil context:nil]; //设置一个动画
  [UIView setAnimationDuration:0.3];        //设置持续的时间
  [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut]; //设置动画
  scrollView.frame =
      CGRectMake(0, 70, self.view.size.width,scrollView.size.height);
  [UIView commitAnimations]; //提交动画
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [dealTextField resignFirstResponder];
  [self animationTextField];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
  dealTextField = textField;
  [UIView beginAnimations:nil context:nil]; //设置一个动画
  [UIView setAnimationDuration:0.3];        //设置持续的时间
  [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut]; //设置动画
  scrollView.frame =
      CGRectMake(0, -150, scrollView.size.width, scrollView.size.height);
  [UIView commitAnimations]; //提交动画
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  [self animationTextField];
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
  if (textField == dealTextField) {
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

//定义动画过程
- (void)drawLineAnimation:(CALayer *)layer {
  CABasicAnimation *bas = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
  bas.duration = 1;
  bas.delegate = self;
  bas.fromValue = @0;
  bas.toValue = @1;
  [layer addAnimation:bas forKey:@"key"];
}

@end
