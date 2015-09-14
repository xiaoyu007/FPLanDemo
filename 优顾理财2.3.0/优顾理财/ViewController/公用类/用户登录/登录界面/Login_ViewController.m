//
//  Login_ViewController.m
//  优顾理财
//
//  Created by Mac on 14-8-4.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "NewUserRegistVC.h"
#import "ForgetPasswordVC.h"
#import "Login_TableViewCell.h"
#import "ThirdBindLoginVC.h"
#import "FPShareSDKUtil.h"
#import "OnLoginRequest.h"

#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"

//日志
///数据绑定
#import "UserDataSaveToDefault.h"
#import "OnLoginRequestItem.h"

@implementation Login_ViewController
@synthesize delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}
+ (void)checkLoginStatusWithCallback:(logonSuccessCallback)callback {
  //登陆
  if ([SimuControl OnLoginType] == 1) {
    if (callback) {
      callback(YES);
    }
  } else {
    [FPYouguUtil performBlockOnMainThread:^{
      [AppDelegate pushViewControllerFromRight:[[Login_ViewController alloc] initWithCallBack:callback]];
    } withDelaySeconds:0.1];
  }
}
/** 无导航栏 */
+ (void)loginAgainWithCallback:(logonSuccessCallback)callback {
  Login_ViewController *loginVC = [[Login_ViewController alloc] initWithCallBack:callback];
  //无导航栏
  loginVC.isHiddenNavBar = NO;
  //登陆
  [AppDelegate pushViewControllerFromRight:loginVC];
}
- (id)initWithCallBack:(logonSuccessCallback)callBack {
  self = [super init];
  if (self) {
    currentCallback = callBack;
  }
  return self;
}

- (id)initWith_Tourist:(BOOL)is_allow {
  self = [super init];
  if (self) {
    self.is_allow_Tourist = is_allow;
  }
  return self;
}

#pragma mark - pv, 选择正确的pvjiem
- (void)viewWillAppear:(BOOL)animated {
  if (![WXApi isWXAppInstalled]) {
    WX_login_View.shadow_View.hidden = NO;
  }
  if (![TencentOAuth iphoneQQInstalled]) {
    QQ_Login_View.shadow_View.hidden = NO;
  }
  [super viewWillAppear:NO];
  [MobClick beginLogPageView:@"User_Login_Main_view"];
  [[PV_view_sql sharedManager] PV_DB_DATA:@"User_Login_Main_view"];
}
- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:NO];
  [MobClick endLogPageView:@"User_Login_Main_view"];
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

  topNavView = [[TopNavView alloc] initWithFrame:CGRectMake(0, 0, windowWidth, 50)];
  topNavView.mainLableString = @"登录";
  [topNavView setMainLableString:@"登录"];
  topNavView.delegate = self;
  [content_View addSubview:topNavView];
  if (_isHiddenNavBar) {
    topNavView.hidden = YES;
  }
  scrollView_main =
      [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, windowWidth, content_View.height - 50)];
  scrollView_main.showsVerticalScrollIndicator = NO;
  scrollView_main.contentSize = CGSizeMake(0, content_View.height);
  [content_View addSubview:scrollView_main];

  UITapGestureRecognizer *tap_scroll =
      [[UITapGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(tap_gesturerecongnizer:)];
  tap_scroll.delegate = self;
  [self.view addGestureRecognizer:tap_scroll];

  //微信登录
  WX_login_View =
      [[Login_View alloc] initWithFrame:CGRectMake(20, 20, 90, 90) withImage:@"微信图标.png"];
  WX_login_View.userInteractionEnabled = YES;
  WX_login_View.title_label.text = @"微信帐号";
  [WX_login_View.btn_Main addTarget:self
                             action:@selector(WX_click_label_click:)
                   forControlEvents:UIControlEventTouchUpInside];
  [scrollView_main addSubview:WX_login_View];

  if (![WXApi isWXAppInstalled]) {
    WX_login_View.shadow_View.hidden = NO;
  }

  // QQ
  QQ_Login_View =
      [[Login_View alloc] initWithFrame:CGRectMake(115, 20, 90, 90) withImage:@"腾讯标"];
  QQ_Login_View.userInteractionEnabled = YES;
  QQ_Login_View.title_label.text = @"QQ帐号";
  [QQ_Login_View.btn_Main addTarget:self
                             action:@selector(qq_click_label_click:)
                   forControlEvents:UIControlEventTouchUpInside];
  [scrollView_main addSubview:QQ_Login_View];

  if (![TencentOAuth iphoneQQInstalled]) {
    QQ_Login_View.shadow_View.hidden = NO;
  }

  //新浪weibo
  Sina_Login_View =
      [[Login_View alloc] initWithFrame:CGRectMake(210, 20, 90, 90) withImage:@"微博.png"];
  Sina_Login_View.userInteractionEnabled = YES;
  Sina_Login_View.title_label.text = @"微博帐号";
  [Sina_Login_View.btn_Main addTarget:self
                               action:@selector(sina_click_label_click:)
                     forControlEvents:UIControlEventTouchUpInside];
  [scrollView_main addSubview:Sina_Login_View];

  //    或
  And_label = [[UILabel alloc] initWithFrame:CGRectMake(20, 130, 280, 30)];
  And_label.textAlignment = NSTextAlignmentCenter;
  And_label.font = [UIFont systemFontOfSize:14.0f];
  And_label.text = @"—————-—— 或 ————————";
  And_label.hidden = NO;
  And_label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin |
                               UIViewAutoresizingFlexibleRightMargin;
  And_label.backgroundColor = [UIColor clearColor];
  [scrollView_main addSubview:And_label];

  //   手机号登录
  View_3 = [[UIView alloc] initWithFrame:CGRectMake(20, 180, windowWidth - 40.0f, 81)];
  [[View_3 layer] setBorderWidth:0.5f];
  View_3.layer.cornerRadius = 5;
  View_3.backgroundColor = [UIColor whiteColor];
  [scrollView_main addSubview:View_3];

  Username_TextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, 230, 40)];
  [Username_TextField setBorderStyle:UITextBorderStyleNone]; //外框类型
  Username_TextField.placeholder = @"手机号/用户名";   //默认显示的字
  Username_TextField.font = [UIFont systemFontOfSize:14.0f];
  Username_TextField.autocorrectionType = UITextAutocorrectionTypeNo;
  Username_TextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
  Username_TextField.returnKeyType = UIReturnKeyDone;
  Username_TextField.keyboardType = UIKeyboardTypeDefault;
  Username_TextField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
  Username_TextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
  Username_TextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

  Username_TextField.tag = 2000;
  Username_TextField.delegate = self;
  [View_3 addSubview:Username_TextField];

  User_btn = [UIButton buttonWithType:UIButtonTypeCustom];
  User_btn.frame = CGRectMake(windowWidth - 85.0f, 0, 40, 40);
  User_btn.imageEdgeInsets = UIEdgeInsetsMake(4.5f, 4.5f, 4.5f, 4.5f);
  [User_btn setImage:[UIImage imageNamed:@"下拉列表"] forState:UIControlStateNormal];
  [User_btn addTarget:self
                action:@selector(User_btn_Click:)
      forControlEvents:UIControlEventTouchUpInside];
  [View_3 addSubview:User_btn];

  //    分界线
  View_4 = [[UIView alloc] initWithFrame:CGRectMake(0, 40, windowWidth- 40, 0.5f)];
  [View_3 addSubview:View_4];

  passWord_TextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 41, windowWidth - 60.0f, 40)];
  [passWord_TextField setBorderStyle:UITextBorderStyleNone]; //外框类型
  passWord_TextField.placeholder = @"请输入密码";       //默认显示的字
  passWord_TextField.font = [UIFont systemFontOfSize:14.0f];
  passWord_TextField.autocorrectionType = UITextAutocorrectionTypeNo;
  passWord_TextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
  passWord_TextField.returnKeyType = UIReturnKeyDone;
  passWord_TextField.keyboardType = UIKeyboardTypeASCIICapable;
  passWord_TextField.secureTextEntry = YES;
  passWord_TextField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
  passWord_TextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
  passWord_TextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

  passWord_TextField.tag = 3000;
  passWord_TextField.delegate = self;
  [View_3 addSubview:passWord_TextField];

  //    注册新用户
  login_lab = [[clickLabel alloc] initWithFrame:CGRectMake(20, windowWidth - 40.0f, 110, 20)];
  login_lab.font = [UIFont systemFontOfSize:15.0f];
  login_lab.textAlignment = NSTextAlignmentCenter;
  login_lab.text = @"   注册新用户";
  login_lab.backgroundColor = [UIColor clearColor];
  login_lab.textColor = [Globle colorFromHexRGB:@"676767"];
  login_lab.highlightedColor = buttonHighLightColor;
  [login_lab addTarget:self action:@selector(login_click:)];
  [scrollView_main addSubview:login_lab];

  news_login_imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
  [login_lab addSubview:news_login_imgV];

  //   忘记密码
  pass_word_lab = [[clickLabel alloc] initWithFrame:CGRectMake(windowWidth - 110.0f, 280, 90, 20)];
  pass_word_lab.font = [UIFont systemFontOfSize:15.0f];
  pass_word_lab.textAlignment = NSTextAlignmentCenter;
  pass_word_lab.text = @"    忘记密码";
  pass_word_lab.backgroundColor = [UIColor clearColor];
  pass_word_lab.textColor = [Globle colorFromHexRGB:@"676767"];
  pass_word_lab.highlightedColor = buttonHighLightColor;
  [pass_word_lab addTarget:self action:@selector(pass_word_click:)];
  [scrollView_main addSubview:pass_word_lab];

  news_pass_imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
  [pass_word_lab addSubview:news_pass_imgV];

  //登录
  UIButton *finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
  finishButton.frame = CGRectMake(20, windowWidth, windowWidth - 40.0f, 34);
  finishButton.alpha = 0.8;
  finishButton.tag = 20000;
  finishButton.layer.cornerRadius = 5;
  finishButton.backgroundColor = [Globle colorFromHexRGB:@"f65f5b"];
  ;
  [finishButton setTitle:@"登录" forState:UIControlStateNormal];
  UIImage *highlightImage = [FPYouguUtil createImageWithColor:buttonHighLightColor];

  [finishButton setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
  [finishButton addTarget:self
                   action:@selector(finish:)
         forControlEvents:UIControlEventTouchUpInside];
  [scrollView_main addSubview:finishButton];

  if (self.is_allow_Tourist == YES) {
    //以游客身份直接发言
    UIButton *finishButton_2 = [UIButton buttonWithType:UIButtonTypeCustom];
    finishButton_2.frame = CGRectMake(20, 380, windowWidth - 40.0f, 34);
    finishButton_2.alpha = 0.8;
    finishButton_2.layer.cornerRadius = 5;
    finishButton_2.backgroundColor = [UIColor whiteColor];
    [finishButton_2 setTitle:@"以游客身份直接发言" forState:UIControlStateNormal];
    UIImage *highlightImage = [FPYouguUtil createImageWithColor:buttonHighLightColor];
    [finishButton_2 setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    [finishButton_2 setTitleColor:[Globle colorFromHexRGB:@"c50100"] forState:UIControlStateNormal];
    [finishButton_2 addTarget:self
                       action:@selector(finishButton_2_click:)
             forControlEvents:UIControlEventTouchUpInside];
    [scrollView_main addSubview:finishButton_2];
  }

  array_main =
      [[NSMutableArray alloc] initWithContentsOfFile:pathInCacheDirectory(@"Login_nickname.plist")];
  //判断是否显示下拉小三角,并且改变用户名输入框的frame
  if ([array_main count] > 0) {
    User_btn.hidden = NO;
    Username_TextField.frame = CGRectMake(10, 0, windowWidth - 90.0f, 40);
  }else{
  User_btn.hidden = YES;
  Username_TextField.frame = CGRectMake(10, 0, windowWidth - 60.0f, 40);
  }

  tableview = [[UITableView alloc] initWithFrame:CGRectMake(21, 220, windowWidth - 42.0f, 120)];
  tableview.dataSource = self;
  tableview.delegate = self;
  tableview.hidden = YES;
  tableview.layer.cornerRadius = 2;
  [[tableview layer] setBorderWidth:0.5f];
  tableview.backgroundColor = [UIColor whiteColor];
  tableview.userInteractionEnabled = YES;
  tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
  [scrollView_main addSubview:tableview];

  //    上传头像是，屏蔽界面
  User_loading = [[UserLoadingView alloc] initWithFrame:content_View.bounds];
  User_loading.hidden = YES;
  User_loading.alter_lable.text = @"正在登录...";
  User_loading.userInteractionEnabled = YES;
  [content_View addSubview:User_loading];

  [self Night_to_Day];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  [UIView animateWithDuration:0.3f
                   animations:^{
                     scrollView_main.contentOffset = CGPointMake(0, 100);
                   }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  if (textField.tag == 2000) {
    [passWord_TextField becomeFirstResponder];
    return YES;
  }

  if (textField.tag == 3000) {
    UIButton *btn = (UIButton *)[scrollView_main viewWithTag:20000];

    [self finish:btn];

    [textField resignFirstResponder];
    [UIView animateWithDuration:0.3f
                     animations:^{
                       scrollView_main.contentOffset = CGPointMake(0, 0);
                     }];
  }
  return YES;
}

- (void)finishButton_2_click:(id)sender {
  YouGu_defaults_double(@"1", @"visitor_User");
  [self.navigationController popViewControllerAnimated:YES];
}
- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)finish:(UIButton *)sender {
  NSString *nickname = [FPYouguUtil ishave_blank:Username_TextField.text];
  NSString *password = [FPYouguUtil ishave_blank:passWord_TextField.text];
  if (nickname.length > 0 && password.length > 0) {
    if (![FPYouguUtil isExistNetwork]) {
      YouGu_animation_Did_Start(networkFailed);
      return;
    }
    User_loading.hidden = NO;
    sender.userInteractionEnabled = NO;
    HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
    __weak Login_ViewController *weakSelf = self;
    callBack.onCheckQuitOrStopProgressBar = ^{
      Login_ViewController *strongSelf = weakSelf;
      if (strongSelf) {
        User_loading.hidden = YES;
        sender.userInteractionEnabled = YES;
        return NO;
      } else {
        return YES;
      }
    };
    callBack.onSuccess = ^(NSObject *obj) {
      Login_ViewController *strongSelf = weakSelf;
      if (strongSelf) {
        OnLoginRequestItem *item = (OnLoginRequestItem *)obj;
        //已经绑定过了，直接登陆(并保存用户数据）
        [FileChangelUtil saveUserListItem:item.userListItem];
        
        
        NSArray *array=[UserDataSaveToDefault getArrayLogiWithNickname:nickname];;
        [array_main removeAllObjects];
        [array_main addObjectsFromArray:array];
        ///登录成功
        [FPYouguUtil OnLoginSuccess];
        [AppDelegate popViewController:NO];
        ///未绑定成功回调block

        [FPYouguUtil performBlockOnMainThread:^{
          if (currentCallback) {
            currentCallback(YES);
          }
        } withDelaySeconds:0.1];
      }
    };
    [OnLoginRequestItem getOnLoginWithNickName:nickname andpassword:password withCallback:callBack];
  } else {
    if ([Username_TextField.text length] == 0) {
      //提示语，动画
      YouGu_animation_Did_Start(@"请输入帐号");
      return;
    };
    if ([passWord_TextField.text length] == 0) {
      //提示语，动画
      YouGu_animation_Did_Start(@"请输入密码");
    }
  }
}
//判断手机是否绑定     绑定：去关联银行卡页    未绑定：去开户首页
- (void)bindMobile {
  HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
  __weak Login_ViewController *weakSelf = self;
  callBack.onCheckQuitOrStopProgressBar = ^{
    Login_ViewController *strongObj = weakSelf;
    if (strongObj) {
      return NO;
    } else {
      return YES;
    }
  };
  callBack.onSuccess = ^(NSObject *obj) {
    Login_ViewController *strongSelf = weakSelf;
    if (strongSelf) {
      [SimuControl bingMobileWithType:1];
    }
  };
  callBack.onError = ^(BaseRequestObject *err, NSException *ex) {
  };
  callBack.onFailed = ^{
  };
  [PhoneVerification sendPhoneVerificationWithUserId:[FPYouguUtil getUserID] WithcallBack:callBack];
}
#pragma mark - NEWS_Nav_View 自定义导航条  按钮delegate 点击函数
- (void)leftButtonPress {
  ///未绑定成功回调block
  [FPYouguUtil performBlockOnMainThread:^{
    if (currentCallback) {
      currentCallback(NO);
    }
  } withDelaySeconds:0.1];
  [self.view endEditing:NO];
  [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch {
  if (tableview.hidden == NO) {
    if ([touch.view isKindOfClass:[UIScrollView class]] == YES ||
        [touch.view isKindOfClass:[UITextField class]] == YES) {
      tableview.hidden = YES;
      User_btn.transform = CGAffineTransformMakeRotation(360 * M_PI / 180.0);
      return YES;
    }
  }

  if (![touch.view isKindOfClass:[UIScrollView class]]) {
    return NO;
  }
  return YES;
}

#pragma mark - 财知道首页，数据请求

#pragma mark - 第三方登录

- (void)WX_QQ_Sina_Login:(NSString *)source
                 andType:(NSString *)type
           andShare_Type:(ShareType)sharetype {
  if ([FPYouguUtil isExistNetwork]) {
    User_loading.hidden = NO;
    [ShareSDK cancelAuthWithType:sharetype];
    [FPShareSDKUtil getUserInfoWithType:sharetype
                            authOptions:[FPShareSDKUtil getAuthOptions]
                                 result:^(BOOL result, id<ISSPlatformUser> userInfo) {
                                   if (result) {
                                     NSString *token = [[userInfo credential] token];
                                     [self the_third_resiger_openid:[userInfo uid]
                                                          and_token:token
                                                           and_type:type
                                                       and_nickname:[userInfo nickname]
                                                        and_pic_url:[userInfo profileImage]];
                                   }
                                   User_loading.hidden = YES;
                                 }];
  }
}

- (void)WX_click_label_click:(id)sender {
  [self WX_QQ_Sina_Login:@"微信" andType:@"7" andShare_Type:ShareTypeWeixiSession];
}

- (void)qq_click_label_click:(id)sender {
  [self WX_QQ_Sina_Login:@"QQ空间" andType:@"2" andShare_Type:ShareTypeQQSpace];
}

- (void)sina_click_label_click:(id)sender {
  [self WX_QQ_Sina_Login:@"新浪微博" andType:@"3" andShare_Type:ShareTypeSinaWeibo];
}

//判断是否，已经注册过了，（第三方方式，）
- (void)the_third_resiger_openid:(NSString *)openid
                       and_token:(NSString *)token
                        and_type:(NSString *)type
                    and_nickname:(NSString *)nickname
                     and_pic_url:(NSString *)user_pic {
  User_loading.hidden = NO;
  //    判断是否注册过了，这个第三方帐号
  HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
  __weak Login_ViewController *weakSelf = self;
  callBack.onCheckQuitOrStopProgressBar = ^{
    Login_ViewController *strongSelf = weakSelf;
    if (strongSelf) {
      User_loading.hidden = YES;
      return NO;
    } else {
      return YES;
    }
  };
  callBack.onSuccess = ^(NSObject *obj) {
    Login_ViewController *strongSelf = weakSelf;
    if (strongSelf) {
      ///登录成功
      [FPYouguUtil OnLoginSuccess];
      [FPYouguUtil performBlockOnMainThread:^{
        if (currentCallback) {
          currentCallback(YES);
        }
      } withDelaySeconds:0.1];
      [AppDelegate popViewController:NO];
    }
  };
  callBack.onError = ^(BaseRequestObject *obj, NSException *exc) {
    Login_ViewController *strongSelf = weakSelf;
    if (strongSelf) {
      if (obj.status && [obj.status isEqualToString:@"1010"]) {
        [strongSelf third_bind_VC:nickname
                          andIcon:user_pic
                          andText:type
                        andOpenid:openid
                         andToken:token];
      } else {
        [BaseRequester defaultErrorHandler](obj, exc);
      }
    }
  };
  [JudgeThirdItem getJudgeThirdItem:openid andType:type andToken:token withCallback:callBack];
}

//第三方登陆授权成功
- (void)third_bind_VC:(NSString *)nickname
              andIcon:(NSString *)user_pic
              andText:(NSString *)text
            andOpenid:(NSString *)openid
             andToken:(NSString *)token {
  ThirdBindLoginVC *thirdVC = [[ThirdBindLoginVC alloc] initWithName:nickname
                                                              andPic:user_pic
                                                         andBar_text:text
                                                           andOpenID:openid
                                                            andToken:token];
  [AppDelegate pushViewControllerFromRight:thirdVC];
}

- (void)login_click:(id)sender {
  NewUserRegistVC *newsUserRegistVC = [[NewUserRegistVC alloc] init];
  [AppDelegate pushViewControllerFromRight:newsUserRegistVC];
}

- (void)pass_word_click:(id)sender {
  ForgetPasswordVC *forgetPwdVC = [[ForgetPasswordVC alloc] init];
  [AppDelegate pushViewControllerFromRight:forgetPwdVC];
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  // Return the number of rows in the section.
  return [array_main count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"Login_VC_Cell";
  Login_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[Login_TableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier];
    //    cell被选择一会的背景效果颜色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
  }
  cell.label.text = array_main[indexPath.row];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  Username_TextField.text = array_main[indexPath.row];
  tableview.hidden = YES;
  User_btn.transform = CGAffineTransformMakeRotation(360 * M_PI / 180.0);
}

- (void)tap_gesturerecongnizer:(UITapGestureRecognizer *)sender {
  [UIView animateWithDuration:0.3f
                   animations:^{
                     scrollView_main.contentOffset = CGPointMake(0, 0);
                   }];
  [Username_TextField resignFirstResponder];
  [passWord_TextField resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [UIView animateWithDuration:0.3f
                   animations:^{
                     scrollView_main.contentOffset = CGPointMake(0, 0);
                   }];
  [Username_TextField resignFirstResponder];
  [passWord_TextField resignFirstResponder];
}

- (void)User_btn_Click:(UIButton *)button {
  //隐藏键盘
  [Username_TextField resignFirstResponder];
  [passWord_TextField resignFirstResponder];

  tableview.height = array_main.count * 40;
  if (tableview.hidden == YES) {
    button.transform = CGAffineTransformMakeRotation(180 * M_PI / 180.0);
    tableview.hidden = NO;
  } else {
    button.transform = CGAffineTransformMakeRotation(360 * M_PI / 180.0);
    tableview.hidden = YES;
  }
}

/**
 *
 *  //消息中心
 *
 **/
#pragma mark - 消息中心，回调，夜间、白天和无图、有图

//夜间模式和白天模式
- (void)Night_to_Day {
  self.view.backgroundColor = [Globle colorFromHexRGB:customBGColor];
  WX_login_View.top_imageView.image = [UIImage imageNamed:@"微信图标." @"pn" @"g"];
  QQ_Login_View.top_imageView.image = [UIImage imageNamed:@"腾讯标"];
  Sina_Login_View.top_imageView.image = [UIImage imageNamed:@"微博"];

  WX_login_View.title_label.textColor = [Globle colorFromHexRGB:@"ffffff"];
  QQ_Login_View.title_label.textColor = [Globle colorFromHexRGB:@"ffffff"];
  Sina_Login_View.title_label.textColor = [Globle colorFromHexRGB:@"ffffff"];

  WX_login_View.btn_Main.backgroundColor = [Globle colorFromHexRGB:@"01a800"];

  QQ_Login_View.btn_Main.backgroundColor = [Globle colorFromHexRGB:@"35b3e6"];

  Sina_Login_View.btn_Main.backgroundColor = [Globle colorFromHexRGB:@"f5b83e"];

  news_login_imgV.image = [UIImage imageNamed:@"注册的标"];
  news_pass_imgV.image = [UIImage imageNamed:@"忘记密码"];

  [[tableview layer] setBorderColor:[Globle colorFromHexRGB:@"d8d8d8"].CGColor];
  View_4.backgroundColor = [Globle colorFromHexRGB:textfieldBordColor];

  View_3.backgroundColor = [Globle colorFromHexRGB:customBGColor];
  [[View_3 layer] setBorderColor:[Globle colorFromHexRGB:textfieldBordColor].CGColor];
  Username_TextField.textColor = [Globle colorFromHexRGB:textfieldContentColor];
  Username_TextField.keyboardAppearance = UIKeyboardAppearanceDefault;

  passWord_TextField.textColor = [Globle colorFromHexRGB:textfieldContentColor];
  passWord_TextField.keyboardAppearance = UIKeyboardAppearanceDefault;

  And_label.textColor = [Globle colorFromHexRGB:textNameColor];
  login_lab.textColor = [Globle colorFromHexRGB:textNameColor];
  pass_word_lab.textColor = [Globle colorFromHexRGB:textNameColor];

  tableview.backgroundColor = [Globle colorFromHexRGB:customBGColor];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little
 preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
