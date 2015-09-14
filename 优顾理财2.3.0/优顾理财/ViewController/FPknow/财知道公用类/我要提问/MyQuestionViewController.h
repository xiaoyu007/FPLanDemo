//
//  MyQuestionViewController.h
//  优顾理财
//
//  Created by Mac on 14-3-26.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "FPBaseViewController.h"
#import "UserHeaderView.h"
#import "UserLoadingView.h"

@interface MyQuestionViewController
    : FPBaseViewController <UITextViewDelegate, UserHeaderViewDelegate, UIGestureRecognizerDelegate> {

  UserHeaderView *userheaderView;
  UIView *textView_View;
  //    输入问题的文本框
  UITextView *textview;
  //   具体内容 默认提示
  UILabel *label;
  //    提交按钮
  clickLabel *Summit_btn;
  UserLoadingView *User_loading;
}
@property(nonatomic, retain) NSString *Cai_talk_id;
@end
