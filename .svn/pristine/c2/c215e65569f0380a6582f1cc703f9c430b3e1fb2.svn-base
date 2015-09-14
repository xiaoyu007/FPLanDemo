//
//  FPSettingViewController.h
//  优顾理财
//
//  Created by Mac on 15/6/29.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPNoTitleViewController.h"
#import "UserHeaderView.h"
#import "UserInfoViewController.h"
#import "UserPicView.h"
#import "LXActionSheet.h"
typedef NS_ENUM(NSUInteger, PersonCenterType) {
  /** 我的资产 */
  PersonCenterTypeMyAssets = 0,
  /** 账户中心 */
  PersonCenterTypeAccountCenter = 1,
  /** 我的自选 */
  PersonCenterTypeMyOptional = 2,
  /** 工具箱 */
  PersonCenterTypeToolBox = 3,
  /** 我的收藏的文章 */
  PersonCenterTypeMyFav = 4,
  /** 我的钻石 */
  PersonCenterTypeMyDiamond = 6,
  /** 设置 */
  PersonCenterTypeSetting = 5,
};
@interface FPSettingViewController
    : FPNoTitleViewController<UITableViewDataSource,
                              UITableViewDelegate,
                              UserHeaderViewDelegate,
                              UIActionSheetDelegate,
                              Login_ViewController_delegate,
                              LXActionSheetDelegate>

@property(nonatomic, strong) NSMutableArray* mainArray;
////信封推送消息
@property(weak, nonatomic) IBOutlet UIButton* PushBtn;
////登录按钮
@property(weak, nonatomic) IBOutlet UIButton* LoginBtn;
@property (weak, nonatomic) IBOutlet UIView *redPointView;
////UITableView
@property(strong, nonatomic) UITableView* tableView;
///tableviewheader
@property(nonatomic,strong) UIView *ImageView;
@property(nonatomic,strong) UserHeaderView *userHeaderView;
@end
