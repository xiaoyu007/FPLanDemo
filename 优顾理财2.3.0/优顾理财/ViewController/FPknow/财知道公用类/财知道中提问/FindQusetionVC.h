//
//  FindQusetionVC.h
//  优顾理财
//
//  Created by Mac on 14-4-23.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//
#import "FPBaseViewController.h"
#import "UserHeaderView.h"
#import "UserLoadingView.h"
typedef void (^FQReturnBlock)(BOOL success);
@interface FindQusetionVC : FPBaseViewController <UITextViewDelegate, UIGestureRecognizerDelegate> {
  UIView *textView_View;
  //    输入问题的文本框
  UITextView *textview;
  //    提交按钮
  clickLabel *Summit_btn;
  UserLoadingView *User_loading;
}
@property(nonatomic, strong) UserHeaderView *userheaderView;
@property(nonatomic, strong) UserListItem *item;
@property(nonatomic, strong) UILabel *tipLalbe;
@property(nonatomic, strong) FQReturnBlock returnBlock;
-(id)initWithBlock:(FQReturnBlock) block;
@end
