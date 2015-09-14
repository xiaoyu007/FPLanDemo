//
//  ThirdBindLoginVC.m
//  优顾理财
//
//  Created by Mac on 14-8-5.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "ThirdBindLoginVC.h"

#import "OnLoginRequestItem.h"

@implementation ThirdBindLoginVC
@synthesize user_pic_url, nick_label_text, bar_text, openid_str, token_str;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (id)initWithName:(NSString *)name
            andPic:(NSString *)user_pic
       andBar_text:(NSString *)text
         andOpenID:(NSString *)openid
          andToken:(NSString *)token {
  self = [super init];
  if (self) {
    // Custom initialization
    self.nick_label_text = name;
    self.user_pic_url = user_pic;
    self.bar_text = text;
    self.openid_str = openid;
    self.token_str = token;
  }
  return self;
}

#pragma mark - pv, 选择正确的pvjiem
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [MobClick beginLogPageView:@"The_Third_registration_view"];
  [[PV_view_sql sharedManager] PV_DB_DATA:@"The_Third_registration_view"];
}
- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [MobClick endLogPageView:@"The_Third_registration_view"];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  [self finish:finishButton];
  return YES;
}

- (void)tappedBackGroundView {
  [main_nick_textfield resignFirstResponder];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch {
  UIView *view = [touch view];

  if ([view isKindOfClass:[UIControl class]]) {
    return NO;
  }
  return YES;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  content_View = [[UIView alloc] initWithFrame:self.view.bounds];
  [self.view addSubview:content_View];

  if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
    UIView *ios_7_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowWidth, 20)];
    ios_7_view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:ios_7_view];

    content_View.frame = CGRectMake(0, 20, windowWidth, self.view.frame.size.height - 20);
  }

  scrollView_main = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, windowWidth, content_View.height - 50)];
  scrollView_main.contentSize = CGSizeMake(0, content_View.height);
  [content_View addSubview:scrollView_main];
  scrollView_main.showsVerticalScrollIndicator = NO;
  //给LXActionSheetView添加响应事件
  UITapGestureRecognizer *tapGesture =
      [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedBackGroundView)];
  tapGesture.delegate = self;
  [content_View addGestureRecognizer:tapGesture];

  topNavView = [[TopNavView alloc] initWithFrame:CGRectMake(0, 0, windowWidth, 50)];
  NSString *top_View;
  if ([self.bar_text intValue] == 7) {
    top_View = @"微信帐号授权成功";
  } else if ([self.bar_text intValue] == 2) {
    top_View = @"QQ帐号授权成功";
  } else {
    top_View = @"新浪微博授权成功";
  }
  topNavView.mainLableString = top_View;
  [topNavView setMainLableString:top_View];
  topNavView.delegate = self;
  [content_View addSubview:topNavView];

  //    //    用户头像
  USER_Pic_image = [[PicUserHeader alloc] initWithFrame:CGRectMake((windowWidth - 100)/2.0f, 40, 100, 100)];
  USER_Pic_image.picImage.image = [UIImage imageNamed:@"头像.png"];
  [USER_Pic_image down_pic:self.user_pic_url];
  [scrollView_main addSubview:USER_Pic_image];

  View_11 = [[UIView alloc] initWithFrame:CGRectMake(20, 170, windowWidth - 40.0f, 35)];
  View_11.layer.cornerRadius = 3.0f;
  View_11.layer.borderWidth = 0.5f;
  View_11.backgroundColor = [UIColor whiteColor];
  View_11.layer.borderColor = [Globle colorFromHexRGB:textfieldBordColor].CGColor;
  [scrollView_main addSubview:View_11];

  imageView_1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"普通注册-夜间"]];
  imageView_1.frame = CGRectMake(0, 0, 35, 35);
  [View_11 addSubview:imageView_1];

  main_nick_textfield = [[ExpressTextField alloc] initWithFrame:CGRectMake(35, 0, windowWidth - 80.0f, 35)];
  main_nick_textfield.backgroundColor = [UIColor clearColor];
  main_nick_textfield.font = [UIFont systemFontOfSize:16.0f];
  main_nick_textfield.textAlignment = NSTextAlignmentLeft;
  main_nick_textfield.text = self.nick_label_text;
  main_nick_textfield.textColor = [UIColor blackColor];
  [main_nick_textfield setSpaceAtStart];
  [View_11 addSubview:main_nick_textfield];

  //完成
  finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
  finishButton.frame = CGRectMake(20, 220, windowWidth - 40.0f, 34);
  finishButton.alpha = 0.8;
  finishButton.layer.cornerRadius = 5;
  finishButton.backgroundColor = [Globle colorFromHexRGB:@"f65f5b"];
  ;
  [finishButton setTitle:@"完成" forState:UIControlStateNormal];
  UIImage *highlightImage = [FPYouguUtil createImageWithColor:buttonHighLightColor];
  [finishButton setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
  [finishButton addTarget:self
                   action:@selector(finish:)
         forControlEvents:UIControlEventTouchUpInside];
  [scrollView_main addSubview:finishButton];

  //上传头像是，屏蔽界面
  User_loading = [[UserLoadingView alloc] initWithFrame:content_View.bounds];
  User_loading.hidden = YES;
  User_loading.alter_lable.text = @"正在保存";
  User_loading.userInteractionEnabled = YES;
  [content_View addSubview:User_loading];

  self.view.backgroundColor = [Globle colorFromHexRGB:customBGColor];

  main_nick_textfield.backgroundColor = [Globle colorFromHexRGB:customBGColor];
  [[main_nick_textfield layer] setBorderColor:[Globle colorFromHexRGB:textfieldBordColor].CGColor];
  main_nick_textfield.textColor = [Globle colorFromHexRGB:textfieldContentColor];
  main_nick_textfield.keyboardAppearance = UIKeyboardAppearanceDefault;
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - NEWS_Nav_View 自定义导航条  按钮delegate 点击函数
- (void)leftButtonPress {
  [self.view endEditing:NO];
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)finish:(UIButton *)sender {
  [main_nick_textfield resignFirstResponder];
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  User_loading.hidden = NO;
  sender.userInteractionEnabled = NO;
  HttpRequestCallBack *callback = [[HttpRequestCallBack alloc] init];
  __weak ThirdBindLoginVC *weakSelf = self;
  callback.onCheckQuitOrStopProgressBar = ^{
    ThirdBindLoginVC *strongSelf = weakSelf;
    if (strongSelf) {
      User_loading.hidden = YES;
      sender.userInteractionEnabled = YES;
      return NO;
    } else {
      return YES;
    }
  };
  callback.onSuccess = ^(NSObject *obj) {
    ThirdBindLoginVC *strongSelf = weakSelf;
    if (strongSelf) {
      ///登录成功
      [FPYouguUtil OnLoginSuccess];
      [AppDelegate popToRootViewController:NO];
    }
  };
  [AutoBindRegistItem getAutoBindRegistItemWith:self.openid_str
                               andThirdnickname:self.nick_label_text
                                    AndNickname:main_nick_textfield.text
                                         andPic:self.user_pic_url
                                        andtype:self.bar_text
                                   withCallback:callback];
}
@end
