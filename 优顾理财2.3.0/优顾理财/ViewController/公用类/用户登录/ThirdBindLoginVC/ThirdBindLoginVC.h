//
//  ThirdBindLoginVC.h
//  优顾理财
//
//  Created by Mac on 14-8-5.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "topNavView.h"
#import "PicUserHeader.h"
#import "UserLoadingView.h"
#import "ExpressTextField.h"
@interface ThirdBindLoginVC
    : UIViewController <TopNavViewDelegate, UITextFieldDelegate,
                        UIGestureRecognizerDelegate> {
  UIView *content_View;
  TopNavView *topNavView;

  UIScrollView *scrollView_main;

  //    //    用户头像
  PicUserHeader *USER_Pic_image;
  ExpressTextField *main_nick_textfield;

  UIView *View_11;
  UIImageView *imageView_1;
  //完成
  UIButton *finishButton;

  clickLabel *Summit_btn;

  UserLoadingView *User_loading;
}
@property(nonatomic, strong) NSString *nick_label_text;
@property(nonatomic, strong) NSString *user_pic_url;
@property(nonatomic, strong) NSString *bar_text;
@property(nonatomic, strong) NSString *openid_str;
@property(nonatomic, strong) NSString *token_str;

- (id)initWithName:(NSString *)name
            andPic:(NSString *)user_pic
       andBar_text:(NSString *)text
         andOpenID:(NSString *)openid
          andToken:(NSString *)token;
@end
