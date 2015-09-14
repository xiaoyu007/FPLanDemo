//
//  FPSettingViewController.m
//  优顾理财
//
//  Created by Mac on 15/6/29.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPSettingViewController.h"
//登入
#import "FPOpenAccountInfo.h"
#import "FPMyOptionalFundVController.h"
#import "FPCountCenterVC.h"
#import "Tools_ViewController.h"
#import "MyCollectionViewController.h"
#import "SettingViewController.h"
#import "Lineview.h"
#import "GuideMapView.h"
#import "BaiDuPush.h"
#import "UserBpushInformationNum.h"
#import "FPCommunicationCenterViewController.h"
#import "FPCommunicationCenterTableViewCell.h"

@implementation FPSettingViewController

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    //登陆成功，退出当前界面
    [[NSNotificationCenter defaultCenter]
        addObserver:self
           selector:@selector(LoginNotificationCenter)
               name:@"LoginNotificationCenter"
             object:nil];
    //清除个人信息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(logoutAccount)
                                                 name:@"logoutAccount"
                                               object:nil];
    ///开户完成后进入我的账户中心界面,,,,
    [[NSNotificationCenter defaultCenter]
        addObserver:self
           selector:@selector(goToPersonCenter)
               name:@"Go_to_PersonCenter"
             object:nil];

    ///开户完成后进入我的资产界面,,,,
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(goToMyAssetView)
                                                 name:@"Go_to_myAsset"
                                               object:nil];
    ///是否有未读的推送消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(UnreadPushInfo)
                                                 name:@"UnreadPushInfo"
                                               object:nil];
  }
  return self;
}
- (void)UnreadPushInfo {
  UserBpushInformationNum *savedCount =
      [UserBpushInformationNum getUnReadObject];
  if ([savedCount getCount:UserBpushAllCount] > 0) {
    _redPointView.hidden = NO;
  } else {
    _redPointView.hidden = YES;
  }
}
- (void)awakeFromNib {
  [super awakeFromNib];
  _redPointView.layer.cornerRadius = _redPointView.width / 2.0;
  _redPointView.hidden = YES;
}
#pragma mark - 登陆回调
- (void)LoginNotificationCenter {
  if ([YouGu_User_sessionid intValue] > 0 && [YouGu_User_USerid intValue] > 0) {
    [self.LoginBtn setTitle:@"注销" forState:UIControlStateNormal];
    //    self.PushBtn.hidden = NO;
  } else {
    [self.LoginBtn setTitle:@"登录" forState:UIControlStateNormal];
    //    self.PushBtn.hidden = YES;
  }
  UserListItem *item = [FileChangelUtil loadUserListItem];
  [_userHeaderView setValue:item];
  //登录成功以后，获取收藏列表
  [NewsWithDidCollect sharedManager];
}

/** 创建表格 */
- (void)createTableview {
  [self createTableviewHeaderView];
  _tableView = [[UITableView alloc]
      initWithFrame:CGRectMake(0,navigationHeght, windowWidth,
                               self.childView.height - navigationHeght)];
  _tableView.dataSource = self;
  _tableView.delegate = self;
  _tableView.backgroundColor = [UIColor clearColor];
  _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  _tableView.separatorColor = [Globle colorFromHexRGB:@"efefef"];
  _tableView.tableHeaderView = _ImageView;
  [self.childView addSubview:self.tableView];
  [self registerNibCell];
  //只加载一次
  if (YouGu_defaults(@"YouGu_GuideMap") == nil) {
    YouGu_defaults_double(@"1", @"YouGu_GuideMap");
    GuideMapView *guideMapView =
        [[GuideMapView alloc] initWithFrame:self.view.bounds];
    [self.childView addSubview:guideMapView];
  }
}

#pragma mark - 注册NibCell
- (void)registerNibCell {
  UINib *cellNib =
      [UINib nibWithNibName:NSStringFromClass([FPCommunicationCenterTableViewCell class])
                     bundle:nil];
  [self.tableView registerNib:cellNib
       forCellReuseIdentifier:@"FPCommunicationCenterTableViewCell"];
}

#pragma mark - 用户消息中心
- (IBAction)PushBtnClick:(UIButton *)sender {
  [Login_ViewController checkLoginStatusWithCallback:^(BOOL logonSuccess) {
    if (logonSuccess) {
      FPCommunicationCenterViewController *vc =
          [[FPCommunicationCenterViewController alloc] init];
      [AppDelegate pushViewControllerFromRight:vc];
    }
  }];
}
- (IBAction)LoginBtnClick:(id)sender {
  if ([YouGu_User_USerid intValue] > 0) {
    LXActionSheet *actionSheet = [[LXActionSheet alloc]
                 initWithTitle:@"退出后不会删除任何历史数据,"
                 @"下次登录依然可以使用本账号"
                      delegate:self
             cancelButtonTitle:@"取消"
        destructiveButtonTitle:@"退出登录"
             otherButtonTitles:nil];
    [actionSheet showInView:APP_AppDelegate.window];
  } else {
    Login_ViewController *loginVC = [[Login_ViewController alloc] init];
    [AppDelegate pushViewControllerFromRight:loginVC];
  }
}

- (void)createTableviewHeaderView {
  _ImageView = [[UIView alloc]
      initWithFrame:CGRectMake(0, navigationHeght, windowWidth, 75.0f)];
  _ImageView.backgroundColor = [UIColor clearColor];
  _ImageView.userInteractionEnabled = YES;
  [self.childView addSubview:_ImageView];

  UserListItem *item = [FileChangelUtil loadUserListItem];
  _userHeaderView = [[UserHeaderView alloc]
      initWithFrame:CGRectMake(0, 0, windowWidth, 75.0f)];
  _userHeaderView.isClick = YES;
  _userHeaderView.delegate = self;
  [_userHeaderView setValue:item];
  _userHeaderView.sourceType = 1;
  [_ImageView addSubview:_userHeaderView];

  //分割线
  Lineview *lineview = [[Lineview alloc]
      initWithFrame:CGRectMake(16.0f, _ImageView.frame.size.height - 1.0f,
                               self.childView.width - 32.0f, 1.0f)];
  [_ImageView addSubview:lineview];
}
#pragma mark - 头像点击事件
- (void)USerPicBtnClick {
  [Login_ViewController checkLoginStatusWithCallback:^(BOOL logonSuccess) {
    if (logonSuccess) {
      UserInfoViewController *USer_Mod = [[UserInfoViewController alloc] init];
      [AppDelegate pushViewControllerFromRight:USer_Mod];
    }
  }];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  self.loading.hidden = YES;
  _redPointView.layer.cornerRadius = _redPointView.width / 2.0;
  [self UnreadPushInfo];
  self.isStatus = NO;
  //读取界面内容
  NSString *path =
  [[NSBundle mainBundle] pathForResource:@"MainSetting.plist" ofType:nil];
  self.mainArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  [self.childView addSubview:self.PushBtn];
  [self.childView addSubview:self.LoginBtn];
  [self createTableview];
  [self LoginNotificationCenter];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [self.mainArray count];
}
- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
  return [self.mainArray[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 64.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString* CellIdentifier = @"FPCommunicationCenterTableViewCell";
  
  FPCommunicationCenterTableViewCell* cell =
  [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  cell.iconBGImageView.image = [FPYouguUtil
                                createImageWithColor:
                                [Globle colorFromHexRGB:[[self.mainArray[indexPath.section]
                                                          objectAtIndex:indexPath.row]
                                                         objectAtIndex:1]]];
  cell.iconImageView.image = [UIImage imageNamed:[[self.mainArray[indexPath.section]
                                                     objectAtIndex:indexPath.row] objectAtIndex:0]];
  cell.nameLabel.text = [[self.mainArray[indexPath.section] objectAtIndex:indexPath.row]
                         objectAtIndex:4];
  cell.nameLabel.text =
      [[self.mainArray[indexPath.section] objectAtIndex:indexPath.row]
          objectAtIndex:4];
  return cell;
}

/** 选中 */
- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [UIView animateWithDuration:0.3f
                   animations:^{
                     [tableView deselectRowAtIndexPath:indexPath animated:YES];
                   }];
  switch (indexPath.row) {
  case PersonCenterTypeMyAssets: {
    NSLog(@"我的资产");
        [Login_ViewController checkLoginStatusWithCallback:^(BOOL logonSuccess) {
      if (logonSuccess) {
        /**  我的资产数据请求*/
        [[FPOpenAccountInfo shareInstance] myAssetViewController];
      }
    }];
  } break;
  case PersonCenterTypeAccountCenter: {
    NSLog(@"账户中心");
   
    [Login_ViewController checkLoginStatusWithCallback:^(BOOL logonSuccess) {
      if (logonSuccess) {
        ///账户中心
        FPCountCenterVC *countVC = [[FPCountCenterVC alloc] init];
        [AppDelegate pushViewControllerFromRight:countVC];
      }
    }];
    
    
  } break;
  case PersonCenterTypeMyOptional: {
    if ([SimuControl OnLoginType] == 1) {
      FPMyOptionalFundVController *myVC =
          [[FPMyOptionalFundVController alloc] init];
      [AppDelegate pushViewControllerFromRight:myVC];
    } else {
      [Login_ViewController checkLoginStatusWithCallback:^(BOOL logonSuccess) {
        if (logonSuccess) {
          FPMyOptionalFundVController *myVC =
              [[FPMyOptionalFundVController alloc] init];
          [AppDelegate pushViewControllerFromRight:myVC];
        }
      }];
    }
    NSLog(@"我的自选");
  } break;
  case PersonCenterTypeToolBox: {
    Tools_ViewController *tools_VC = [[Tools_ViewController alloc] init];
    [AppDelegate pushViewControllerFromRight:tools_VC];
  } break;
  case PersonCenterTypeMyFav: {
    /** 先判断是否登陆*/
    if ([SimuControl OnLoginType] == 1) {
      MyCollectionViewController *Collection_VC =
          [[MyCollectionViewController alloc] init];
      [AppDelegate pushViewControllerFromRight:Collection_VC];
    } else {
      [Login_ViewController checkLoginStatusWithCallback:^(BOOL logonSuccess) {
        if (logonSuccess) {
          MyCollectionViewController *Collection_VC =
              [[MyCollectionViewController alloc] init];
          [AppDelegate pushViewControllerFromRight:Collection_VC];
        }
      }];
    }
  }
  case PersonCenterTypeMyDiamond: {
    NSLog(@"我的钻石");
  } break;
  case PersonCenterTypeSetting: {
    SettingViewController *setting_VC = [[SettingViewController alloc] init];
    [AppDelegate pushViewControllerFromRight:setting_VC];
  } break;
  default:
    break;
  }
}
///我的资产界面
- (void)goToMyAssetView {
  [[FPOpenAccountInfo shareInstance] myAssetViewController];
}
///账户中心
- (void)goToPersonCenter {
  ///账户中心
  FPCountCenterVC *countVC = [[FPCountCenterVC alloc] init];
  [AppDelegate pushViewControllerFromRight:countVC];
}

#pragma mark - LXActionSheetDelegate
- (void)didClickOnButtonIndex:(NSInteger *)buttonIndex {
  //    NSLog(@"%d",(int)buttonIndex);
}
/** 需要在其它界面退出登录 */
- (void)logoutAccount {
  [self logonOutYouguu];
}
- (void)didClickOnDestructiveButton {
  //取消百度，推送绑定
  HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
  callBack.onSuccess = ^(NSObject *obj) {
    NSLog(@"解除绑定成功：%@", ((BaiDuPush *)obj).message);
  };
  callBack.onError = ^(BaseRequestObject *err, NSException *ex) {
    NSLog(@"解除绑定错误：%@", err.message);
  };
  callBack.onFailed = ^{
    NSLog(@"解除绑定失败：");
  };
  [BaiDuPush pushDelBindUserWithCallback:callBack];
  [self logonOutYouguu];
}
- (void)logonOutYouguu {
  [FPYouguUtil clearOutLogin];
  UserListItem *item = [FileChangelUtil loadUserListItem];
  [_userHeaderView setValue:item];
  [self.tableView reloadData];
  [self.LoginBtn setTitle:@"登录" forState:UIControlStateNormal];
}
- (void)didClickOnCancelButton {
}

- (void)dealloc {
  [self.view removeAllSubviews];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
