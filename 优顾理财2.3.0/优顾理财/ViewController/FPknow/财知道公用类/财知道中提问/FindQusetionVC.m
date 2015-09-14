//
//  FindQusetionVC.m
//  优顾理财
//
//  Created by Mac on 14-4-23.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "FindQusetionVC.h"
#import "UserInfoViewController.h"

@implementation FindQusetionVC
-(id)initWithBlock:(FQReturnBlock) block
{
  self=[super init];
  if (self) {
    self.returnBlock = block;
  }
  return self;
}
- (void)viewDidAppear:(BOOL)animated {
  [self setExclusiveTouchForButtons:self.view];
  [super viewDidAppear:animated];
}
//?????????????????
- (void)setExclusiveTouchForButtons:(UIView *)myView {
  for (UIView *v in [myView subviews]) {
    if ([v isKindOfClass:[UIButton class]])
      [((UIButton *)v)setExclusiveTouch:YES];
    else if ([v isKindOfClass:[UIView class]]) {
      [self setExclusiveTouchForButtons:v];
    }
  }
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
  self.topNavView.mainLableString = @"向TA提问";
  // Do any additional setup after loading the view.
  textView_View = [[UIView alloc] initWithFrame:CGRectMake(16, 100, 288, 115)];
  [[textView_View layer] setBorderWidth:1.0f];
  textView_View.layer.cornerRadius = 5;
  [self.childView addSubview:textView_View];

  textview = [[UITextView alloc] initWithFrame:CGRectMake(3, 0, 283, 110)];
  textview.font = [UIFont systemFontOfSize:17];
  textView_View.backgroundColor = [UIColor clearColor];
  textview.delegate = self;
  [textView_View addSubview:textview];

  _tipLalbe = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 270, 30)];
  _tipLalbe.backgroundColor = [UIColor clearColor];
  _tipLalbe.textColor = [UIColor grayColor];
  if (self.item) {
    _tipLalbe.text = [NSString stringWithFormat:@"@%@", self.item.nickName];
  }
  _tipLalbe.textAlignment = NSTextAlignmentLeft;
  _tipLalbe.font = [UIFont systemFontOfSize:18];
  [textview addSubview:_tipLalbe];

  _userheaderView = [[UserHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 75)];
  [_userheaderView setValue:self.item];
  [self.childView addSubview:_userheaderView];

  //    向TA提问 按钮
  Summit_btn = [[clickLabel alloc] initWithFrame:CGRectMake(240, 10, 70, 30)];
  Summit_btn.font = [UIFont systemFontOfSize:18];
  Summit_btn.textAlignment = NSTextAlignmentCenter;
  Summit_btn.text = @"提交";
  Summit_btn.backgroundColor = [UIColor clearColor];
  Summit_btn.textColor = [Globle colorFromHexRGB:customFilledColor];
  Summit_btn.highlightedColor = [UIColor grayColor];
  [Summit_btn addTarget:self action:@selector(submitBtnClick:)];
  [self.topNavView addSubview:Summit_btn];

  //    我要提问的 @“提交”是，屏蔽界面
  User_loading = [[UserLoadingView alloc] initWithFrame:self.view.bounds];
  User_loading.hidden = YES;
  User_loading.alter_lable.text = @"正在提交……";
  User_loading.userInteractionEnabled = YES;
  [self.view addSubview:User_loading];

  //    背景颜色
  [self Night_to_Day];
}
- (void)setItem:(UserListItem *)item {
  if (item) {
    _item = item;
    if (_userheaderView) {
      [_userheaderView setValue:item];
    }
    _tipLalbe.text = [NSString stringWithFormat:@"@%@", item.nickName];
  }
}

#pragma mark - textview   代理
- (void)textViewDidChange:(UITextView *)textView {
  NSUInteger number = [textview.text length];
  if (number > 0) {
    _tipLalbe.hidden = YES;
  } else {
    _tipLalbe.hidden = NO;
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
  if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
    return YES;
  }
  return NO;
}

//提交按钮
- (void)submitBtnClick:(UIButton *)sender {
  if (self.item) {
    // event 日志
    [[event_view_log sharedManager] event_log:@"1000038"];
    [MobClick event:@"1000038"];

    if (![FPYouguUtil isExistNetwork]) {
      YouGu_animation_Did_Start(networkFailed);
      return;
    }
    BOOL isNil = [self isBlankString:textview.text];
    if (textview && isNil) {
      //提示语，动画
      YouGu_animation_Did_Start(@"请输入您要提问的内容");
      return;
    }
    [textview resignFirstResponder];
    User_loading.hidden = NO;
    if (YGLockButton == YES) {
      return;
    } else {
      YGLockButton = YES;
    }
    HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
    __weak FindQusetionVC *weakSelf = self;
    callBack.onCheckQuitOrStopProgressBar = ^{
      FindQusetionVC *strongSelf = weakSelf;
      if (strongSelf) {
        YGLockButton = NO;
        User_loading.hidden = YES;
        return NO;
      } else {
        return YES;
      }
    };
    callBack.onSuccess = ^(NSObject *obj) {
      FindQusetionVC *strongSelf = weakSelf;
      if (strongSelf) {
        if (self.returnBlock) {
          self.returnBlock(YES);
        }
        //提示语，动画
        YouGu_animation_Did_Start(@"提问成功");
        [AppDelegate popViewController:YES];
      }
    };
    callBack.onError = ^(BaseRequestObject *err, NSException *ex) {
      if ([err.status isEqualToString:@"0410"]) {
        //            提问成功，审核中
        [AppDelegate popViewController:YES];
      }
      [BaseRequester defaultErrorHandler](err, ex);
    };
    [AskQuestionToThem getAskQuestionToThemWithContent:textview.text
                                           andSlaveRid:self.item.userId
                                          andSlaveName:self.item.nickName
                                          withCallback:callBack];
  }
}

- (void)Night_to_Day {
  self.childView.backgroundColor =
      [UIColor colorWithRed:240 / 255.0f green:240 / 255.0f blue:240 / 255.0f alpha:1.0];
  textview.textColor = [UIColor blackColor];
  textView_View.backgroundColor = [UIColor whiteColor];
  [[textView_View layer] setBorderColor:[Globle colorFromHexRGB:@"c1c1c1"].CGColor];
  textview.backgroundColor = [UIColor clearColor];
  textview.keyboardAppearance = UIKeyboardAppearanceDefault;
}
@end
