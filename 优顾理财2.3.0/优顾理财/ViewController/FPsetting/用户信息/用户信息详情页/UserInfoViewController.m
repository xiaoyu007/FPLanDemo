//
//  UserInfoViewController.m
//  优顾理财
//
//  Created by Mac on 14-7-30.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoTableViewCell.h"
//图片下载
#import "YGImageDown.h"
//修改界面
#import "RepairInfoViewController.h"
#import "RepairSignViewController.h"
//帐户绑定
#import "BindMobilePhoneViewController.h"

#import "FPShareSDKUtil.h"
#import "OnLoginRequest.h"
#import "OnLoginRequestItem.h"
#import "UIImageView+WebCache.h"

@implementation UserInfoViewController
@synthesize User_pic;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}
#pragma mark - pv, 初始化
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [main_tableView reloadData];
  [MobClick beginLogPageView:@"The_user_center_list_view"];
  [[PV_view_sql sharedManager] PV_DB_DATA:@"The_user_center_list_view"];
}
- (void)viewWillDisappear:(BOOL)animated {
  [MobClick endLogPageView:@"The_user_center_list_view"];
  [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.topNavView.mainLableString = @"用户中心";
//  [self.User_pic setImageWithURL:[NSURL URLWithString:[FPYouguUtil getHeadpic]] placeholderImage:[UIImage imageNamed:@"头像无网络.png"]];
  User_pic = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"头像无网络.png"]];
  [[YGImageDown sharedManager] add_image:[FPYouguUtil getHeadpic]
                              completion:^(UIImage *img) {
                                if (img) {
                                  self.User_pic.image = img;
                                }
                              }];

  bind_main_array = [[NSMutableArray alloc] initWithCapacity:0];
  main_array = [[NSMutableArray alloc] initWithCapacity:0];
  NSArray *array1 = @[ @"头像", @"昵称", @"用户名", @"个性签名" ];
  NSArray *array2 = @[ @"手机号", @"QQ", @"新浪微博", @"微信" ];
  main_array = [@[ array1, array2 ] mutableCopy];

  main_tableView =
      [[UITableView alloc] initWithFrame:self.childView.bounds style:UITableViewStylePlain];
  main_tableView.delegate = self;
  main_tableView.dataSource = self;
  main_tableView.backgroundColor = [UIColor clearColor];
  main_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  [self.childView addSubview:main_tableView];

  //    末位提示语
  foot_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
  foot_label.text = @"绑定帐户," @"可" @"使" @"用" @"手机、QQ、微信或者微博登" @"录";
  foot_label.font = [UIFont systemFontOfSize:13];
  foot_label.backgroundColor = [UIColor clearColor];
  foot_label.textAlignment = NSTextAlignmentCenter;
  main_tableView.tableFooterView = foot_label;

  //    上传头像是，屏蔽界面
  User_loading = [[UserLoadingView alloc] initWithFrame:self.view.bounds];
  User_loading.hidden = YES;
  User_loading.alter_lable.text = @"正在保存";
  User_loading.userInteractionEnabled = YES;
  [self.view addSubview:User_loading];

  [self Get_user_xinxi];
  foot_label.textColor = [Globle colorFromHexRGB:@"000000"];

  //设置通知中心
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(System_pic_user)
                                               name:@"System_pic_user"
                                             object:nil];

  //手机绑定，成功后的刷新 @"bind_moblie_phone_viewController_refrash"
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(bind_moblie_phone_viewController_refrash:)
                                               name:@"bind_moblie_phone_viewController_refrash"
                                             object:nil];
}
- (void)bind_moblie_phone_viewController_refrash:(NSNotification *)notification {
  UserBindThirdItem *thirdItem = [notification object];

  if (thirdItem) {
    [bind_main_array addObject:thirdItem];

    [main_tableView reloadData];
  }
}

- (void)Get_user_xinxi {
  if (![FPYouguUtil isExistNetwork]) {
    [self.loading animationNoNetWork];
    return;
  }
  HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
  __weak UserInfoViewController *weakSelf = self;
  callBack.onCheckQuitOrStopProgressBar = ^{
    UserInfoViewController *strongObj = weakSelf;
    if (strongObj) {
      self.loading.hidden = YES;
      return NO;
    } else {
      return YES;
    }
  };
  callBack.onSuccess = ^(NSObject *obj) {
    UserInfoViewController *strongSelf = weakSelf;
    if (strongSelf) {
      UserBaseInfoItem *item = (UserBaseInfoItem *)obj;
      [bind_main_array addObjectsFromArray:item.array];
//      [self.User_pic setImageWithURL:[NSURL URLWithString:[FPYouguUtil getHeadpic]] placeholderImage:[UIImage imageNamed:@"头像无网络"]];
      [[YGImageDown sharedManager] add_image:[FPYouguUtil getHeadpic]
                                  completion:^(UIImage *img) {
                                    if (img) {
                                      self.User_pic.image = img;
                                    }
                                  }];
      //刷新用户信息
      [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginNotificationCenter"
                                                          object:nil];
      [main_tableView reloadData];
    }
  };
  [UserBaseInfoItem ShowMyLnfoWithcallBack:callBack];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - NEWS_Nav_View 自定义导航条  按钮delegate 点击函数
- (void)leftButtonPress {
  [self.view endEditing:NO];
  [self.navigationController popViewControllerAnimated:YES];
}
// Customize the number of sections in the table view.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0 && indexPath.row == 3) {
    return 80;
  }
  return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [main_array[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [main_array count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 25.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  if (section == 0) {
    UIView *myView = [[UIView alloc] init];
    myView.backgroundColor = [Globle colorFromHexRGB:@"f2f3f3"];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 4.0f, 90, 14.0f)];
    titleLabel.textColor = [Globle colorFromHexRGB:@"84929e"];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"基本资料";
    titleLabel.font = [UIFont systemFontOfSize:14.0f];

    [myView addSubview:titleLabel];
    return myView;
  } else if (section == 1) {
    UIView *myView = [[UIView alloc] init];
    myView.backgroundColor = [Globle colorFromHexRGB:@"f2f3f3"];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 4, 90, 14.0f)];
    titleLabel.textColor = [Globle colorFromHexRGB:@"84929e"];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"帐号绑定";
    titleLabel.font = [UIFont systemFontOfSize:14.0f];

    [myView addSubview:titleLabel];
    return myView;
  }
  return nil;
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"UserInfoTableViewCell";

  UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UserInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:CellIdentifier];
  }
  // cell被选择一会的背景效果颜色
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  // Configure the cell.
  cell.Title_label.text = [main_array[indexPath.section] objectAtIndex:indexPath.row];

  NSString *thirdname = [self Search_bind_array:(int)indexPath.row];
  if ([thirdname length] > 0) {
    [cell To_determine_whether_the:indexPath.row
                        andSection:indexPath.section
                          andImage:self.User_pic.image
                      andhave_type:YES
                      andthirdname:thirdname
                    withArrowImage:[self isRegister:indexPath.row]];
  } else {
    [cell To_determine_whether_the:indexPath.row
                        andSection:indexPath.section
                          andImage:self.User_pic.image
                      andhave_type:NO
                      andthirdname:@""
                    withArrowImage:[self isRegister:indexPath.row]];
  }
//  [cell.PIC_image.picImage setImageWithURL:[NSURL URLWithString:[FPYouguUtil getHeadpic]] placeholderImage:[UIImage imageNamed:@"头像无网络.png"]];
  cell.PIC_image.picImage.image = self.User_pic.image;
  if (indexPath.section == 0 && indexPath.row == 2) {
    cell.is_pressed_state = NO;
  } else {
    cell.is_pressed_state = YES;
  }
  return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    switch (indexPath.row) {
    case 0: {
      NSArray *array_images = nil;
      // 判断是否支持相机
      if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        array_images = @[ @"系统头像", @"调用图库", @"手机拍照", @"取消" ];
      } else {
        array_images = @[ @"从相册选择", @"系统头像", @"取消" ];
      }
      UserPicView *userPicView =
          [[UserPicView alloc] initWithFrame:self.view.bounds andImages:array_images];
      userPicView.delegate = self;
      [self.view addSubview:userPicView];
    } break;
    case 1: {
      RepairInfoViewController *repairVC = [[RepairInfoViewController alloc] init];
      [AppDelegate pushViewControllerFromRight:repairVC];
    } break;
    case 3: {
      RepairSignViewController *repairSignVC = [[RepairSignViewController alloc] init];
      [AppDelegate pushViewControllerFromRight:repairSignVC];
    } break;
    default: { User_loading.hidden = YES; } break;
    }
  } else if (indexPath.section == 1) {
    if (!([YouGu_User_USerid intValue] > 0)) {
      //提示语，动画
      YouGu_animation_Did_Start(@"您还没登录不可以绑定");
      return;
    }
    int Personal_type = [self IS_Exist_Bind_Name:(int)indexPath.row];

    switch (indexPath.row) {
    case 0: {
      if (Personal_type > 0) {
        if (Personal_type == 4) {
          //提示语，动画
          YouGu_animation_Did_Start(@"手" @"机" @"号" @"注册用户不能解绑手机号");
          return;
        } else {
          UIAlertView *alter_upload_view = [[UIAlertView alloc] initWithTitle:@"确认解绑"
                                                                      message:@"解绑手机后," @"将不能用手机号登录，同时不" @"能找回密码,确定要解绑吗"
                                                                     delegate:self
                                                            cancelButtonTitle:@"取消"
                                                            otherButtonTitles:@"确定", nil];
          alter_upload_view.tag = 1000 + indexPath.row;
          [alter_upload_view show];
        }
      } else {
        BindMobilePhoneViewController *bindMobilePhoneVC = [[BindMobilePhoneViewController alloc] init];
        [AppDelegate pushViewControllerFromRight:bindMobilePhoneVC];
      }
    } break;
    case 1: {
      if (Personal_type > 0) {
        if (Personal_type == 2) {
          //提示语，动画
          YouGu_animation_Did_Start(@"QQ号注册的用户不能解绑QQ号");
          return;
        } else {
          UIAlertView *alter_upload_view = [[UIAlertView alloc]
                  initWithTitle:@"确认解绑"
                        message:@"解绑后,将无法使用QQ帐户登录," @"确定要解绑吗？"
                       delegate:self
              cancelButtonTitle:@"取消"
              otherButtonTitles:@"确定", nil];
          alter_upload_view.tag = 1000 + indexPath.row;
          [alter_upload_view show];
        }
      } else {
        [self WX_QQ_Sina_Login:@"QQ帐户" andType:@"5" andShare_Type:ShareTypeQQSpace];
      }
    } break;
    case 2: {
      if (Personal_type > 0) {
        if (Personal_type == 3) {
          //提示语，动画
          YouGu_animation_Did_Start(@"新" @"浪" @"号" @"注册用户不能解绑新浪号");
          return;
        } else {
          UIAlertView *alter_upload_view =
              [[UIAlertView alloc] initWithTitle:@"确认解绑"
                                         message:@"解绑后,将无法使用新浪帐户登录," @"确定要解绑吗？"
                                        delegate:self
                               cancelButtonTitle:@"取消"
                               otherButtonTitles:@"确定", nil];
          alter_upload_view.tag = 1000 + indexPath.row;
          [alter_upload_view show];
        }
      } else {
        [self WX_QQ_Sina_Login:@"新浪微博" andType:@"6" andShare_Type:ShareTypeSinaWeibo];
      }
    } break;
    case 3: {
      if (Personal_type > 0) {
        if (Personal_type == 7) {
          //提示语，动画
          YouGu_animation_Did_Start(@"微" @"信" @"号" @"注册用户不能解绑微信号");
          return;
        } else {
          UIAlertView *alter_upload_view =
              [[UIAlertView alloc] initWithTitle:@"确认解绑"
                                         message:@"解绑后,将无法使用微信帐户登录," @"确定要解绑吗？"
                                        delegate:self
                               cancelButtonTitle:@"取消"
                               otherButtonTitles:@"确定", nil];
          alter_upload_view.tag = 1000 + indexPath.row;
          [alter_upload_view show];
        }
      } else {
        [self WX_QQ_Sina_Login:@"微信帐户" andType:@"8" andShare_Type:ShareTypeWeixiSession];
      }
    } break;
    default:
      break;
    }
  }
  [tableView reloadData];
}
//判断，是否，有绑定的帐号
- (int)IS_Exist_Bind_Name:(int)row {
  for (UserBindThirdItem *thirdItem in bind_main_array) {
    switch (row) {
    case 0: {
      if (thirdItem.BindType == 1 || thirdItem.BindType == 4) {
        return thirdItem.BindType;
      }
    } break;
    case 1: {
      if (thirdItem.BindType == 2 || thirdItem.BindType == 5) {
        return thirdItem.BindType;
      }
    } break;
    case 2: {
      if (thirdItem.BindType == 3 || thirdItem.BindType == 6) {
        return thirdItem.BindType;
      }
    } break;
    case 3: {
      if (thirdItem.BindType == 7 || thirdItem.BindType == 8) {
        return thirdItem.BindType;
      }
    } break;
    default:
      break;
    }
  }
  return 0;
}
/**
 *  是否是注册的三方或手机用户
 *
 *  @param row 行数
 *
 *  @return 注册 yes 绑定 no
 */
- (BOOL)isRegister:(NSInteger)row {
  for (UserBindThirdItem *thirdItem in bind_main_array) {
    switch (row) {
      case 0: {
        if (thirdItem.BindType == 4) {
          return YES;
        }else{
          return NO;
        }
      } break;
      case 1: {
        if (thirdItem.BindType == 2) {
          return YES;
        }else{
          return NO;
        }
      } break;
      case 2: {
        if (thirdItem.BindType == 3) {
          return YES;
        }else{
          return NO;
        }
      } break;
      case 3: {
        if (thirdItem.BindType == 7) {
          return YES;
        }else{
          return NO;
        }
      } break;
      default:
        break;
    }
  }
  return NO;
}
//判断，是否，有绑定的帐号
- (NSString *)Search_bind_array:(int)row {
  for (UserBindThirdItem *thirdItem in bind_main_array) {
    switch (row) {
    case 0: {
      if (thirdItem.BindType == 1 || thirdItem.BindType == 4) {
        return thirdItem.BindThridName;
      }
    } break;
    case 1: {
      if (thirdItem.BindType == 2 || thirdItem.BindType == 5) {
        return thirdItem.BindThridName;
      }
    } break;
    case 2: {
      if (thirdItem.BindType == 3 || thirdItem.BindType == 6) {
        return thirdItem.BindThridName;
      }
    } break;
    case 3: {
      if (thirdItem.BindType == 7 || thirdItem.BindType == 8) {
        return thirdItem.BindThridName;
      }
    } break;
    default:
      break;
    }
  }
  return nil;
}
#pragma mark - 第三方登录
- (void)WX_QQ_Sina_Login:(NSString *)source
                 andType:(NSString *)type
           andShare_Type:(ShareType)sharetype {
  if ([FPYouguUtil isExistNetwork]) {
    User_loading.hidden = NO;
    [ShareSDK cancelAuthWithType:sharetype];
    [FPShareSDKUtil getUserInfoWithType:sharetype
                            authOptions:[FPShareSDKUtil getAuthOptions]
                                 result:^(BOOL result, id<ISSPlatformUser> userInfo) {
                                   if (result && userInfo) {
                                     NSString *token = [[userInfo credential] token];
                                     [self theThirdResigerWitOopenid:[userInfo uid]
                                                            andToken:token
                                                             andType:type
                                                         andNickname:[userInfo nickname]];
                                   }
                                   User_loading.hidden = YES;
                                 }];
  }
}
//判断是否，已经注册过了，（第三方方式，）
- (void)theThirdResigerWitOopenid:(NSString *)openid
                         andToken:(NSString *)token
                          andType:(NSString *)type
                      andNickname:(NSString *)nickname {
  User_loading.hidden = NO;
  HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
  __weak UserInfoViewController *weakSelf = self;
  callBack.onCheckQuitOrStopProgressBar = ^{
    UserInfoViewController *strongObj = weakSelf;
    if (strongObj) {
      User_loading.hidden = YES;
      return NO;
    } else {
      return YES;
    }
  };
  callBack.onSuccess = ^(NSObject *obj) {
    UserInfoViewController *strongSelf = weakSelf;
    if (strongSelf) {
      JsonRequestObject *result = (JsonRequestObject *)obj;
      if ([result isOK]) {
        if ([type intValue] == 5) {
          YouGu_animation_Did_Start(@"QQ帐户绑定成功");
        } else if ([type intValue] == 6) {
          YouGu_animation_Did_Start(@"新浪微博绑定成功");
        } else if ([type intValue] == 8) {
          YouGu_animation_Did_Start(@"微信帐户绑定成功");
        }
        UserBindThirdItem *thirdItem = [[UserBindThirdItem alloc] init];
        thirdItem.BindType = [type intValue];
        thirdItem.BindOpenid = openid;
        thirdItem.BindThridName = nickname;
        [bind_main_array addObject:thirdItem];

        [main_tableView reloadData];
      } else { //异常处理：0001: 您已经绑定相关账号
        [NewShowLabel setMessageContent:result.message];
      }
    }
  };
  [BindAuthentication getBindAuthentication:openid
                                   andToken:token
                           andThirdnickname:nickname
                                    andtype:type
                               WithcallBack:callBack];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (buttonIndex == alertView.cancelButtonIndex) {
    return;
  } else {
    int array_num = [self Yougu_bind_photo_sina_QQ_WeiXi_num:(int)alertView.tag - 1000];
    if (array_num >= 0) {
      UserBindThirdItem *thirdItem = bind_main_array[array_num];
      NSString *openid = thirdItem.BindOpenid;
      //        点击，“取消”按钮
      User_loading.hidden = NO;
      HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
      __weak UserInfoViewController *weakSelf = self;
      callBack.onCheckQuitOrStopProgressBar = ^{
        UserInfoViewController *strongObj = weakSelf;
        if (strongObj) {
          User_loading.hidden = YES;
          return NO;
        } else {
          return YES;
        }
      };
      callBack.onSuccess = ^(NSObject *obj) {
        UserInfoViewController *strongSelf = weakSelf;
        if (strongSelf) {
          [bind_main_array removeObjectAtIndex:array_num];
          [main_tableView reloadData];
        }
      };
      [UnbindMobilePhone getUnbindMobilePhoneWithPhoneNum:openid WithcallBack:callBack];
    }
  }
}

//判断是第几个
- (int)Yougu_bind_photo_sina_QQ_WeiXi_num:(int)tag {
  for (int i = 0; i < [bind_main_array count]; i++) {
    UserBindThirdItem *thirdItem = bind_main_array[i];
    switch (tag) {
    case 0: {
      if (thirdItem.BindType == 1 || thirdItem.BindType == 4) {
        return i;
      }
    } break;
    case 1: {
      if (thirdItem.BindType == 2 || thirdItem.BindType == 5) {
        return i;
      }
    } break;
    case 2: {
      if (thirdItem.BindType == 3 || thirdItem.BindType == 6) {
        return i;
      }
    } break;
    case 3: {
      if (thirdItem.BindType == 7 || thirdItem.BindType == 8) {
        return i;
      }
    } break;
    default:
      break;
    }
  }
  return -1;
}

#pragma mark - action sheet delegte
- (void)button_clickedButtonAtIndex:(NSInteger)buttonIndex {
  NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
  // 判断是否支持相机
  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    switch (buttonIndex) {
    case 0: //系统图像
    {
      [self System_User_pic_ViewController];
      return;
    }
    case 1: //相册
    {
      //隐藏状态拦
      [[UIApplication sharedApplication] setStatusBarHidden:NO];
      [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
      sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    } break;
    case 2: //相机
    {
      //隐藏状态拦
      [[UIApplication sharedApplication] setStatusBarHidden:NO];
      sourceType = UIImagePickerControllerSourceTypeCamera;
    } break;
    case 3: //取消
      return;
    }
  } else {
    if (buttonIndex == 0) {
      sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    } else if (buttonIndex == 1) {
      [self System_User_pic_ViewController];
      return;
    }else{
      //取消
      return;
    }
  }
  // 跳转到相机或相册页面
  UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
  imagePickerController.delegate = self;
  imagePickerController.allowsEditing = YES;
  imagePickerController.sourceType = sourceType;
  [self.navigationController presentViewController:imagePickerController
                                          animated:YES
                                        completion:^{
                                        }];
}
//系统用户头像
- (void)System_User_pic_ViewController {
  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
  UserSystemPic *System_pic = [[UserSystemPic alloc] init];
  [self presentViewController:System_pic
                     animated:YES
                   completion:^{
                   }];
}
#pragma mark - image picker delegte
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [[UIApplication sharedApplication] setStatusBarHidden:NO];
  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

  [picker dismissViewControllerAnimated:NO
                             completion:^{
                               [[UIApplication sharedApplication] setStatusBarHidden:NO];
                               [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
                             }];
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
  [[UIApplication sharedApplication] setStatusBarHidden:NO];
  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
  [picker dismissViewControllerAnimated:YES
                             completion:^{
                             }];
  [MobClick event:@"1000044"];
  //    event 日志
  [[event_view_log sharedManager] event_log:@"1000044"];
  UIImage *image = info[UIImagePickerControllerEditedImage];
  self.User_pic.image = image;
  //    使用 相册或相机 上传图片
  NSData *imageData = UIImageJPEGRepresentation(self.User_pic.image, 0.2);
  [self ModificationUserHeadpic:imageData andSysPic:@""];
}

////修改用户头像
- (void)ModificationUserHeadpic:(NSData *)picData andSysPic:(NSString *)syspic {
  User_loading.hidden = NO;
  HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
  __weak UserInfoViewController *weakSelf = self;
  callBack.onCheckQuitOrStopProgressBar = ^{
    UserInfoViewController *strongObj = weakSelf;
    if (strongObj) {
      User_loading.hidden = YES;
      return NO;
    } else {
      return YES;
    }
  };
  callBack.onSuccess = ^(NSObject *obj) {
    UserInfoViewController *strongSelf = weakSelf;
    if (strongSelf) {
       ///将上传成功的图片保存在本地 imageUrl
      ModificationUserInfo * userInfo = (ModificationUserInfo *)obj;
      if (userInfo.imageUrl && userInfo.imageUrl.length>0) {
        [[YGImageDown sharedManager]savePhotoToNativeWithImage:picData andPicName:userInfo.imageUrl];
      }
      
      //刷新用户信息
      [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginNotificationCenter"
                                                          object:nil];
      //提示语，动画
      YouGu_animation_Did_Start(@"修改成功");
      [main_tableView reloadData];
    }
  };
  [ModificationUserInfo getModificationUserInfoWithData:picData
                                              andSysPic:syspic
                                            andNickname:[FPYouguUtil getUserNickName]
                                            andSignture:[FPYouguUtil getSignture]
                                           WithcallBack:callBack];
}

#pragma mark - 系统头像选择，回调的消息中心 delegate
//系统头像选择，回调的消息中心
- (void)System_pic_user {
  [MobClick event:@"1000044"];
  [[event_view_log sharedManager] event_log:@"1000044"];
  //    默认头像类型为 2:修改用户头像默认头像url
  NSString *pic_url = YouGu_defaults(@"USER_url_pic");
//  [self.User_pic setImageWithURL:[NSURL URLWithString:pic_url] placeholderImage:[UIImage imageNamed:@"头像无网络"]];
  [[YGImageDown sharedManager] add_image:pic_url
                              completion:^(UIImage *img) {
                                self.User_pic.image = [UIImage imageNamed:@"头像无网络"];
                                if (img) {
                                  self.User_pic.image = img;
                                }
                              }];
  [self ModificationUserHeadpic:[NSData data] andSysPic:pic_url];
}
@end
