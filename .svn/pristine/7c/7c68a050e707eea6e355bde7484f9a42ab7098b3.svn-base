//
//  FPUserCenterViewController.h
//  优顾理财
//
//  Created by Mac on 15/8/27.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPNoTitleViewController.h"
#import "UserCenterHeadVC.h"

@interface FPUserCenterViewController : FPNoTitleViewController <UITableViewDataSource,UITableViewDelegate>
{
  /** 目录 */
  NSArray *catalogArray;
  /** 表头 */
  UserCenterHeadVC *headVC;
}
/** 用户头像 */
@property (weak, nonatomic) IBOutlet UIImageView *userHeadImageView;
/** 用户昵称 */
@property (weak, nonatomic) IBOutlet UILabel *userNickNameLabel;
/** 用户信息按钮 */
@property (weak, nonatomic) IBOutlet UIButton *userInfoButton;
/** 刷新按钮 */
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;

/** 目录表格 */
@property (weak, nonatomic) IBOutlet UITableView *catalogTableview;
/** 头像按钮点击 */
- (IBAction)headImageButtonClicked:(id)sender;
/** 用户信息点击 */
- (IBAction)userInfoButtonClicked:(id)sender;
/** 刷新按钮点击 */
- (IBAction)refreshButtonClicked:(id)sender;

@end
