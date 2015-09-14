//
//  FeedbackWriteViewController.m
//  优顾理财
//
//  Created by Mac on 14-3-27.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "FeedbackWriteViewController.h"


@implementation FeedbackWriteViewController
@synthesize text_qq;
@synthesize delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}
#pragma mark - pv, 选择正确的pvjiem
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [MobClick beginLogPageView:@"Feedback_input_view"];
  [[PV_view_sql sharedManager] PV_DB_DATA:@"Feedback_input_view"];
}
- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [MobClick endLogPageView:@"Feedback_input_view"];
}
#pragma mark - NEWS_Nav_View 自定义导航条  按钮delegate 点击函数
- (void)leftButtonPress {
  [self.view endEditing:NO];
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
  YGLockButton = NO;
}

- (void)viewDidLoad {
  YGLockButton = NO;
  [super viewDidLoad];
  // Do any additional setup after loading the view.

  // self.navigationController.navigationBarHidden=YES;

  [self CreatNavBarWithTitle:@"我要反馈"];

  header_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 320, 30)];
  header_label.backgroundColor = [UIColor clearColor];
  header_label.font = [UIFont systemFontOfSize:10.0f];
  header_label.textAlignment = NSTextAlignmentCenter;
  header_label.text =
      [NSString stringWithFormat:@"设备:%@  系统:%@  客户端版本:%@",
                                 Iphone_model(), Iphone_OS(), youguu_Version];
  header_label.numberOfLines = 1;
  [self.childView addSubview:header_label];

  //    反馈信息框
  text_feedback = [[UITextView alloc] init];
  text_feedback.frame = CGRectMake(10, 80, 300, 100);
  text_feedback.delegate = self;
  [[text_feedback layer] setBorderWidth:1];
  text_feedback.layer.cornerRadius = 5;
  text_feedback.tag = 1000;
  text_feedback.font = [UIFont systemFontOfSize:15];
  [self.childView addSubview:text_feedback];

  //    灰色提示文字
  text_label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 260, 30)];
  text_label.textAlignment = NSTextAlignmentLeft;
  text_label.numberOfLines = 2;
  text_label.textColor = [UIColor colorWithRed:164 / 255.0f
                                         green:164 / 255.0f
                                          blue:164 / 255.0f
                                         alpha:1.0];
  text_label.backgroundColor = [UIColor clearColor];
  text_label.font = [UIFont systemFontOfSize:13];
  text_label.text = @"留" @"下"
                           @"您宝贵的意见，我们将及时的回复和解决";
  [text_feedback addSubview:text_label];

  //    qq,信箱，手机号
  text_qq = [[UITextView alloc] init];
  //    text_qq.keyboardType=UIKeyboardTypeNumberPad;
  text_qq.frame = CGRectMake(10, 185, 300, 34);
  //    text_qq.delegate=self;
  [[text_qq layer] setBorderWidth:1];
  text_qq.layer.cornerRadius = 5;
  text_qq.delegate = self;
  text_qq.tag = 2000;
  //    text_qq.placeholder=@"  选填：QQ、邮箱或手机等其他联系方式";
  text_qq.keyboardType = UIKeyboardTypeASCIICapable;
  text_qq.font = [UIFont systemFontOfSize:15];
  [self.childView addSubview:text_qq];

  //    灰色提示文字
  text_qq_text = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 260, 30)];
  text_qq_text.textAlignment = NSTextAlignmentLeft;
  text_qq_text.numberOfLines = 2;
  text_qq_text.textColor = [UIColor colorWithRed:164 / 255.0f
                                           green:164 / 255.0f
                                            blue:164 / 255.0f
                                           alpha:1.0];
  text_qq_text.backgroundColor = [UIColor clearColor];
  text_qq_text.font = [UIFont systemFontOfSize:13];
  text_qq_text.text = @"选填：QQ、邮箱或手机等其他联系方式";
  [text_qq addSubview:text_qq_text];

  //    发送意见反馈 按钮
  Summit_btn = [[clickLabel alloc] initWithFrame:CGRectMake(240, 10, 70, 30)];
  Summit_btn.font = [UIFont systemFontOfSize:18];
  Summit_btn.textAlignment = NSTextAlignmentCenter;
  Summit_btn.text = @"提交";
  Summit_btn.backgroundColor = [UIColor clearColor];
  Summit_btn.textColor = [Globle colorFromHexRGB:customFilledColor];
  Summit_btn.highlightedColor = [UIColor grayColor];
  [Summit_btn addTarget:self action:@selector(Summit_btn_click:)];
  [self.childView addSubview:Summit_btn];

  [self Night_to_Day];
}

- (void)Summit_btn_click:(UIButton *)sender {
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }

  if (YES == [self isBlankString:text_feedback.text]) {
    //提示语，动画
    YouGu_animation_Did_Start(@"请输入您宝贵的意见");
    return;
  }

  if (YGLockButton == YES) {
    return;
  } else {
    YGLockButton = YES;
  }

  [[WebServiceManager sharedManager]
      Feedback_Feedtext:text_feedback.text
             andContact:text_qq.text
             completion:^(NSDictionary *dic) {
               YGLockButton = NO;
               if (dic &&
                   [dic[@"status"] isEqualToString:@"0000"]) {

                 //  保存反馈意见
                 NSUserDefaults *defaults =
                     [NSUserDefaults standardUserDefaults];
                 [defaults setObject:text_feedback.text
                              forKey:@"Feedback_text_data"];

                 //提示语，动画
                 YouGu_animation_Did_Start(@"意见反馈提交成功");

                 // 发送反馈意见成功以后，收回写反馈意见
                 if ([delegate
                         respondsToSelector:@selector(refrash_tableview)]) {
                   [delegate refrash_tableview];
                 }
                 [self.navigationController popViewControllerAnimated:YES];
               } else {
                 NSString *message = dic[@"message"];
                 if (!message || [message length] == 0 ||
                     [message isEqualToString:@"(null)"]) {
                   message = networkFailed;
                 }
                 if (dic &&
                     [dic[@"status"] isEqualToString:@"0101"]){
                 }else{
                   YouGu_animation_Did_Start(message);
                 }
               }

             }];
}

- (void)Night_to_Day {
    self.view.backgroundColor = [Globle colorFromHexRGB:@"f1f1f1"];
    header_label.textColor = [UIColor colorWithRed:20 / 255.0f
                                             green:20 / 255.0f
                                              blue:20 / 255.0f
                                             alpha:1.0];

    text_feedback.backgroundColor = [UIColor colorWithRed:246 / 255.0f
                                                    green:246 / 255.0f
                                                     blue:246 / 255.0f
                                                    alpha:1.0f];
    [[text_feedback layer] setBorderColor:[UIColor colorWithRed:213 / 255.0f
                                                          green:213 / 255.0f
                                                           blue:213 / 255.0f
                                                          alpha:1.0f].CGColor];
    text_feedback.textColor = [UIColor blackColor];

    text_qq.backgroundColor = [UIColor colorWithRed:246 / 255.0f
                                              green:246 / 255.0f
                                               blue:246 / 255.0f
                                              alpha:1.0f];
    [[text_qq layer] setBorderColor:[UIColor colorWithRed:213 / 255.0f
                                                    green:213 / 255.0f
                                                     blue:213 / 255.0f
                                                    alpha:1.0f].CGColor];
    text_qq.textColor = [UIColor blackColor];
    text_feedback.keyboardAppearance = UIKeyboardAppearanceDefault;
    text_qq.keyboardAppearance = UIKeyboardAppearanceDefault;
}

#pragma mark - Text view  delegate
//字符串是否为空和都是空格
- (BOOL)isBlankString:(NSString *)string {
  if (string == nil) {
    return YES;
  }
  if (string == NULL) {
    return YES;
  }
  if ([string isKindOfClass:[NSNull class]]) {
    return YES;
  }
  if ([[string stringByTrimmingCharactersInSet:
                   [NSCharacterSet whitespaceAndNewlineCharacterSet]] length] ==
      0) {
    return YES;
  }
  return NO;
}


//代理delegate
- (void)textViewDidChange:(UITextView *)textView {
  NSInteger number = [textView.text length];
  if (textView.tag == 1000) {
    if (number > 0) {
      text_label.hidden = YES;

    } else {
      text_label.hidden = NO;
    }
  }
  if (textView.tag == 2000) {
    if (number > 0) {
      text_qq_text.hidden = YES;

    } else {
      text_qq_text.hidden = NO;
    }
  }
}
- (BOOL)textView:(UITextView *)textView
    shouldChangeTextInRange:(NSRange)range
            replacementText:(NSString *)text {
  if (textView.tag == 2000) {
    if ([text isEqualToString:@"\n"]) {
      return NO;
    }
  }

  return YES;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
