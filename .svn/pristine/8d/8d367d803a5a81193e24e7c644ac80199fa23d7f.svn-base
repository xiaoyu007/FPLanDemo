
//
//  UserInfoViewController.h
//  优顾理财
//
//  Created by Mac on 14-7-30.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "FPBaseViewController.h"
#import "UserPicView.h"
#import "UserSystemPic.h"
//正在加载中
#import "UserLoadingView.h"
@interface UserInfoViewController
    : FPBaseViewController <UITableViewDataSource, UITableViewDelegate, UserPicView_Delegate,
                            UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate> {
  UITableView *main_tableView;
  NSMutableArray *main_array;

  NSInteger Userpic_num;
  clickLabel *Summit_btn;

  //    正在加载中
  UserLoadingView *User_loading;
  //    末位提示语
  UILabel *foot_label;

  //绑定第三方帐号
  NSMutableArray *bind_main_array;
  //
}
@property(nonatomic, strong) UIImageView *User_pic;

@end
