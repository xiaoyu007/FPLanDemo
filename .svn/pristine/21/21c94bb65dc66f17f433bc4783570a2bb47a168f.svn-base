//
//  Login_ViewController.h
//  优顾理财
//
//  Created by Mac on 14-8-4.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "topNavView.h"
//正在加载中
#import "UserLoadingView.h"

#import "Login_View.h"

/** 删除自选回调 */
typedef void (^logonSuccessCallback)(BOOL logonSuccess);

@protocol Login_ViewController_delegate <NSObject>
@optional
//代理delegate
- (void)LoginNotificationCenter;
@end

@interface Login_ViewController
    : UIViewController <TopNavViewDelegate, UITextFieldDelegate,
                        UITableViewDataSource, UITableViewDelegate,
                        UIGestureRecognizerDelegate> {
  UIView *content_View;
  TopNavView *topNavView;
  UIScrollView *scrollView_main;

  Login_View *WX_login_View;
  Login_View *QQ_Login_View;
  Login_View *Sina_Login_View;

  UITextField *Username_TextField;
  UITextField *passWord_TextField;

  //   手机号登录
  UIView *View_3;
  //    记录下拉按钮
  UIView *View_5;
  UIButton *User_btn;
  //    分界线
  UIView *View_4;

  //    图标
  UIImageView *news_login_imgV;
  UIImageView *news_pass_imgV;

  UITableView *tableview;
  NSMutableArray *array_main;

  //    正在加载中
  UserLoadingView *User_loading;

  //    或
  UILabel *And_label;
  //    注册新用户
  clickLabel *login_lab;
  //   忘记密码
  clickLabel *pass_word_lab;
  //回调
  logonSuccessCallback currentCallback;
}
@property(nonatomic, strong) id<Login_ViewController_delegate> delegate;
@property(nonatomic, assign) BOOL is_allow_Tourist;
/** 是否隐藏导航栏 */
@property(nonatomic, assign) BOOL isHiddenNavBar;

- (id)initWith_Tourist:(BOOL)is_allow;
/** 调用登录页面 */
+ (void)checkLoginStatusWithCallback:(logonSuccessCallback)callback;
/** 不预判，直接跳登录页面 */
+ (void)loginAgainWithCallback:(logonSuccessCallback)callback;
@end
