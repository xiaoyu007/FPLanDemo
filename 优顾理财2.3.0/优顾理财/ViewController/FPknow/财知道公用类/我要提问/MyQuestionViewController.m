//
//  MyQuestionViewController.m
//  优顾理财
//
//  Created by Mac on 14-3-26.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "MyQuestionViewController.h"
#import "UserInfoViewController.h"

@implementation MyQuestionViewController
@synthesize Cai_talk_id;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}
#pragma mark - pv, 选择正确的pvjiem
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [MobClick beginLogPageView:@"Cai_view_Ta_view"];
  [[PV_view_sql sharedManager] PV_DB_DATA:@"Cai_view_Ta_view"];
}
- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [MobClick endLogPageView:@"Cai_view_Ta_view"];
}

- (void)tappedBackGroundView {
  [textview resignFirstResponder];
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
  YGLockButton = NO;
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.topNavView.mainLableString = @"我要提问";
  //给LXActionSheetView添加响应事件
  UITapGestureRecognizer *tapGesture =
      [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedBackGroundView)];
  tapGesture.delegate = self;
  [self.childView addGestureRecognizer:tapGesture];

  textView_View = [[UIView alloc] initWithFrame:CGRectMake(16, 100, 288, 115)];
  [[textView_View layer] setBorderWidth:0.5f];
  [textView_View.layer setBorderColor:[Globle colorFromHexRGB:@"c7c7c7"].CGColor];
  [textView_View.layer setMasksToBounds:YES];
  textView_View.layer.cornerRadius = 2;
  [self.childView addSubview:textView_View];

  textview = [[UITextView alloc] initWithFrame:CGRectMake(3, 0, 283, 110)];
  textview.font = [UIFont systemFontOfSize:14.0f];
  textView_View.backgroundColor = [UIColor clearColor];
  textview.delegate = self;

  [textView_View addSubview:textview];

  label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 270, 14.0f)];
  label.backgroundColor = [UIColor clearColor];
  label.textColor = [Globle colorFromHexRGB:@"d4d9dc"];
  label.textAlignment = NSTextAlignmentLeft;
  label.text = @"说些什么吧...";
  label.font = [UIFont systemFontOfSize:14.0f];
  [textview addSubview:label];

  self.Cai_talk_id = [FPYouguUtil getUserID];

  UserListItem *item = [FileChangelUtil loadUserListItem];
  userheaderView = [[UserHeaderView alloc] initWithFrame:CGRectMake(0,0, 320, 75)];
  [userheaderView setValue:item];
  userheaderView.sourceType = 1;
  [self.childView addSubview:userheaderView];

  //    向TA提问 按钮
  Summit_btn = [[clickLabel alloc] initWithFrame:CGRectMake(windowWidth - 60.0f, 0, 60, navigationHeght)];
  Summit_btn.font = [UIFont systemFontOfSize:18];
  Summit_btn.textAlignment = NSTextAlignmentCenter;
  Summit_btn.text = @"提交";
  Summit_btn.backgroundColor = [UIColor clearColor];
  Summit_btn.textColor = [Globle colorFromHexRGB:customFilledColor];
  [Summit_btn addTarget:self action:@selector(Summit_btn_click)];
  [self.topNavView addSubview:Summit_btn];

  //    我要提问的 @“提交”是，屏蔽界面
  User_loading = [[UserLoadingView alloc] initWithFrame:self.childView.bounds];
  User_loading.hidden = YES;
  User_loading.alter_lable.text = @"正在提交……";
  User_loading.userInteractionEnabled = YES;
  [self.childView addSubview:User_loading];

  textview.textColor = [UIColor blackColor];
  textView_View.backgroundColor = [UIColor whiteColor];
  [[textView_View layer] setBorderColor:[Globle colorFromHexRGB:textfieldBordColor].CGColor];
  textview.backgroundColor = [UIColor clearColor];
  textview.keyboardAppearance = UIKeyboardAppearanceDefault;
}

#pragma mark - 头像点击事件
- (void)USerPicBtnClick {
  UserInfoViewController *userInfoVC = [[UserInfoViewController alloc] init];
  [AppDelegate pushViewControllerFromRight:userInfoVC];
}

#pragma mark - textview   代理
- (void)textViewDidChange:(UITextView *)textView {
  NSUInteger number = [textview.text length];
  if (number > 0) {
    label.hidden = YES;
  } else {
    label.hidden = NO;
  }
}

#pragma mark - 注销消息中心
- (void)dealloc {
  YGLockButton = NO;
  [self.view removeAllSubviews];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Text view  delegate
//字符串是否为空和都是空格
- (BOOL)isStringNil:(NSString *)string {
  if (string == nil) {
    return YES;
  }
  if (string == NULL) {
    return YES;
  }
  if ([string isKindOfClass:[NSNull class]]) {
    return YES;
  }
  if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
    return YES;
  }
  return NO;
}

//提交按钮
- (void)Summit_btn_click {
  // event 日志
  [[event_view_log sharedManager] event_log:@"1000038"];
  [MobClick event:@"1000038"];
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  ///判断空字符串，提交问题
  BOOL is_kong = [self isStringNil:textview.text];
  if (textview && is_kong) {
    YouGu_animation_Did_Start(@"请输入你要提问的内容");
    // NSLog(@"excutte here？？？？？");
    return;
  }
  //处理重复点击问题
  if (YGLockButton == YES) {
    return;
  } else {
    YGLockButton = YES;
  }
  User_loading.hidden = NO;
  [textview resignFirstResponder];
  
  HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
  __weak MyQuestionViewController *weakSelf = self;
  callBack.onCheckQuitOrStopProgressBar = ^{
    MyQuestionViewController *strongObj = weakSelf;
    if (strongObj) {
      YGLockButton = NO;
      User_loading.hidden = YES;
      return NO;
    } else {
      return YES;
    }
  };
  callBack.onSuccess = ^(NSObject *obj) {
    MyQuestionViewController *strongObj = weakSelf;
    if (strongObj) {
      //            提问成功，给一个成功的提示
      textview.text = nil;
      label.hidden = NO;
      //             刷新财知道最新界面
      YouGu_NSNotificationCenter_Sent(@"refrashKnowNewListSend");
      
      YouGu_animation_Did_Start(@"提问成功");
      [self.navigationController popViewControllerAnimated:YES];
    }
  };
  callBack.onError = ^(BaseRequestObject *err, NSException *ex) {
    if (err && [err.status isEqualToString:@"0410"]) {
      //提问成功，审核中
      textview.text = nil;
      label.hidden = NO;
      //刷新财知道最新界面
      YouGu_NSNotificationCenter_Sent(@"refrashKnowNewListSend");
      [self.navigationController popViewControllerAnimated:YES];
    }
    [BaseRequester defaultErrorHandler](err, ex);
  };
  callBack.onFailed = ^{
    [BaseRequester defaultFailedHandler]();
  };
  [KnowPostingRequest KnowPosting:@"" andNickname:[FPYouguUtil getUserNickName] andPic:[FPYouguUtil getHeadpic] andSign:[FPYouguUtil getSignture] andContent:textview.text withCallback:callBack];
}

@end
