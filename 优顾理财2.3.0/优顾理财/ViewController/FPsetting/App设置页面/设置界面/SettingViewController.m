//
//  SettingViewController.m
//  优顾理财
//
//  Created by Mac on 14-3-14.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingVCTableViewCell.h"
#import "MySettingTextFont.h"
#import "SettingButton.h"

#import "FPShareSDKUtil.h"

#import "WiFiDownViewController.h"
#import "FeedbackViewController.h"
#import "AboutUsNewsViewController.h"

#import "SQLDataHtmlstring.h"

//用户中心
#import "UserInfoViewController.h"
//修改密码
//登录界面

@implementation SettingViewController
@synthesize app_url;
@synthesize clear_str;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (id)init {
  self = [super init];
  if (self) {
    is_suck = YES;
  }
  return self;
}
#pragma mark - pv, 初始化
- (void)viewWillAppear:(BOOL)animated {
  [Main_tableView reloadData];
  [super viewWillAppear:animated];
  [MobClick beginLogPageView:@"Setting_list_view"];
  [[PV_view_sql sharedManager] PV_DB_DATA:@"Setting_list_view"];
}
- (void)viewWillDisappear:(BOOL)animated {
  [MobClick endLogPageView:@"Setting_list_view"];
  [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  who_num = -1;
  is_clear_data = NO;

  [self.childView setUserInteractionEnabled:YES];
  [self CreatNavBarWithTitle:@"设置"];

  Main_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, windowWidth, self.childView.height - 50)
                                                style:UITableViewStyleGrouped];
  Main_tableView.dataSource = self;
  Main_tableView.delegate = self;
  Main_tableView.backgroundColor = [UIColor clearColor];
  Main_tableView.backgroundView = nil;
  Main_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  Main_tableView.separatorColor = [UIColor clearColor];
  [self.childView addSubview:Main_tableView];

  main_array = [[NSMutableArray alloc] initWithCapacity:0];

  alter_upload_view = [[UIAlertView alloc] initWithTitle:@"确认清除"
                                                 message:@"空"
                                                delegate:self
                                       cancelButtonTitle:@"取消"
                                       otherButtonTitles:@"确定", nil];
  alter_upload_view.tag = 1000;

  alter_upload_view_2 = [[UIAlertView alloc]
          initWithTitle:@"温馨提示"
                message:@"如果你要关闭或开启优顾理财的新消息通知,请在iPhone的\"设置\"-"
                        @"\"通知\"功能中，找到应用程序\"优顾理财\"中更改"
               delegate:self
      cancelButtonTitle:@"确定"
      otherButtonTitles:nil, nil];
  alter_upload_view_2.tag = 2000;

  [self getImageName];
  //刷新设置列表
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(getImageName)
                                               name:@"Setting_old_to_new"
                                             object:nil];
  self.childView.backgroundColor =
      [UIColor colorWithRed:240 / 255.0f green:240 / 255.0f blue:240 / 255.0f alpha:1.0];
  [Main_tableView reloadData];
}
- (void)getImageName {
  NSString *path = [[NSBundle mainBundle] pathForResource:@"Setting_Third.plist" ofType:nil];
  NSMutableArray *array_tt = [NSMutableArray arrayWithContentsOfFile:path];
  for (NSArray *my_array in array_tt) {
    NSMutableArray *first_array = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSDictionary *dic in my_array) {
      NSMutableArray *second_array = [[NSMutableArray alloc] initWithCapacity:0];
      NSString *image_1 = dic[@"image_name"];
      NSString *image_2 = dic[@"night_image_name"];
      NSString *title_name = dic[@"title_name"];
      [second_array addObject:image_1];
      [second_array addObject:image_2];
      [second_array addObject:title_name];

      [first_array addObject:second_array];
    }
    [main_array addObject:first_array];
  }
  [Main_tableView reloadData];
}

#pragma mark - NEWS_Nav_View 自定义导航条  按钮delegate 点击函数
- (void)leftButtonPress {
  [self.view endEditing:NO];
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
  alter_upload_view.delegate = nil;

  alter_upload_view_2.delegate = nil;

  [self.view removeAllSubviews];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - pv, tableView_delegate
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [main_array count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [main_array[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  if (section == 3) {
    return 10;
  }
  return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"CellIdentifier_Setting_VC";
  SettingVCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[SettingVCTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:CellIdentifier];
    //    cell被选择一会的背景效果颜色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
  }

  cell.first_ImageView.image =
      [UIImage imageNamed:[[main_array[indexPath.section] objectAtIndex:indexPath.row] objectAtIndex:0]];
  cell.first_label.text =
      [[main_array[indexPath.section] objectAtIndex:indexPath.row] objectAtIndex:2];
  if ([main_array[indexPath.section] count] == indexPath.row + 1) {
    cell.DI_View.hidden = YES;
  } else {
    cell.DI_View.hidden = NO;
  }
  cell.accessoryView = nil;

  cell.is_Has_been_selected = NO;

  switch (indexPath.section) {
  case 0: {
    switch (indexPath.row) {
    case 0: {
      [cell add_layer_View_code:1];

      UIView *view_btn5 = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 95, 40)];
      view_btn5.userInteractionEnabled = NO;

      UILabel *main_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 55, 40)];
      main_label.backgroundColor = [UIColor clearColor];
      main_label.font = [UIFont systemFontOfSize:16.0f];
      main_label.textAlignment = NSTextAlignmentRight;
      main_label.adjustsFontSizeToFitWidth = YES;
     
      if ([[self Get_down_channlid_array_count] isEqualToString:@"0.0%"]) {
        main_label.text = [SimuControl downDataType];
      }else{
      
        main_label.text = [self Get_down_channlid_array_count];
      }
      
      main_label.textColor = [Globle colorFromHexRGB:@"606060"];
      [view_btn5 addSubview:main_label];

      UIImageView *img_btn5 = [[UIImageView alloc] initWithFrame:CGRectMake(55, 5, 25, 30)];
      img_btn5.image = [UIImage imageNamed:@"更多_白天"];
      [view_btn5 addSubview:img_btn5];

      cell.accessoryView = view_btn5;

    } break;
    case 1: {
      [cell add_layer_View_code:3];
      UILabel *main_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 60)];
      main_label.backgroundColor = [UIColor clearColor];
      main_label.font = [UIFont systemFontOfSize:16.0f];
      main_label.textAlignment = NSTextAlignmentRight;
      main_label.adjustsFontSizeToFitWidth = YES;
      main_label.textColor = [Globle colorFromHexRGB:@"606060"];
      NewsArrayWithALLNewsId * object =[NewsArrayWithALLNewsId sharedManager];
      CGFloat length = object.fileLength;
      self.clear_str =
          [NSString stringWithFormat:@"（缓存大小%.02fM）", length/(1024*1024)];
      if (is_clear_data == YES) {
        self.clear_str = [NSString stringWithFormat:@"（缓存大小%.02fM）", 0.00f];
        [SimuControl downDataWithType:@"0.0%"];
        is_clear_data = NO;
      }
      main_label.text = clear_str;
      cell.accessoryView = main_label;
    } break;
    default:
      break;
    }
  } break;
  case 1: {
    switch (indexPath.row) {
    case 0: {
      [cell add_layer_View_code:1];
      cell.is_Has_been_selected = YES;

      MySettingTextFont *mysettingfont = [[MySettingTextFont alloc] initWithFrame:CGRectMake(0, 0, 170, 60)];
      cell.accessoryView = mysettingfont;

    } break;
    case 1: {
      [cell add_layer_View_code:2];
      //                    cell.is_Has_been_selected=YES;
      SettingButton *btn2 = [[SettingButton alloc] initWithFrame:CGRectMake(0, 17, 46, 26)];
      [btn2 addTarget:self
                    action:@selector(btn2_Click:)
          forControlEvents:UIControlEventTouchUpInside];
      btn2.tag = 20000;
      btn2.selected = [YouGu_defaults(@"WiFi_DownPic") boolValue];
      NSLog(@"sddfsdfa:%d",YouGu_Wifi_Image);
      cell.accessoryView = btn2;

    } break;
    case 2: {
      [cell add_layer_View_code:3];
      //                    cell.is_Has_been_selected=YES;

      UILabel *main_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 60)];
      main_label.backgroundColor = [UIColor clearColor];
      main_label.font = [UIFont systemFontOfSize:16.0f];
      main_label.textAlignment = NSTextAlignmentCenter;
      main_label.textColor = [Globle colorFromHexRGB:@"606060"];
      //是否开启推送
      if ([FPYouguUtil hasNotificationsEnabled]) {
        main_label.text = @"已开启";
      } else {
        main_label.text = @"已关闭";
      }
      cell.accessoryView = main_label;
    } break;
    default:
      break;
    }
  } break;
  case 2: {
    switch (indexPath.row) {
    case 0: {
      [cell add_layer_View_code:1];
      //                    cell.is_Has_been_selected=YES;

      SettingButton *btn3 = [[SettingButton alloc] initWithFrame:CGRectMake(0, 17, 46, 26)];
      [btn3 addTarget:self
                    action:@selector(btn3_Click:)
          forControlEvents:UIControlEventTouchUpInside];
      btn3.tag = 30000;
      btn3.selected = ![self is_Binding:0];
      cell.accessoryView = btn3;

    } break;
    case 1: {
      [cell add_layer_View_code:3];
      //                    cell.is_Has_been_selected=YES;

      SettingButton *btn4 = [[SettingButton alloc] initWithFrame:CGRectMake(0, 17, 46, 26)];
      [btn4 addTarget:self
                    action:@selector(btn4_Click:)
          forControlEvents:UIControlEventTouchUpInside];
      btn4.tag = 40000;
      btn4.selected = ![self is_Binding:1];
      cell.accessoryView = btn4;

    } break;
    default:
      break;
    }
  } break;
  case 3: {
    if (indexPath.row == 0) {
      [cell add_layer_View_code:1];
    } else if (indexPath.row == [main_array[indexPath.section] count] - 1) {
      [cell add_layer_View_code:3];
    } else {
      [cell add_layer_View_code:2];
    }
    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn5.frame = CGRectMake(0, 10, 40, 40);
    CGRect imageFrame = CGRectMake(0, 0, 25, 30);
    UIEdgeInsets imageInset = UIEdgeInsetsMake(5, 0, 5, 15);
    btn5.imageView.frame = imageFrame;
    btn5.imageEdgeInsets = imageInset;
    btn5.userInteractionEnabled = NO;
    [btn5 setImage:[UIImage imageNamed:@"更多_白天"] forState:UIControlStateNormal];
    cell.accessoryView = btn5;
  }
  default:
    break;
  }
  return cell;
}

- (NSString *)Get_down_channlid_array_count {
  
  if (![FPYouguUtil isExistNetwork]) {
    return [SimuControl downDataType];
  }
  
  //   将未下载的，存入已经下载的
  NSMutableArray *Channlid_array2 =
      [NSMutableArray arrayWithContentsOfFile:pathInCacheDirectory(@"Wi_Fi_down_channlid.plist")];

  //    被选中的，所有频道
  NSMutableArray *Channlid_array3 = [NSMutableArray arrayWithContentsOfFile:pathInCacheDirectory(@"Wi_Fi_down_be_selected_channlid.plist")];

  if ([Channlid_array3 count] == 0) {
    return @"0.0%";
  }

  down_count =
      [NSString stringWithFormat:@"%0.1f%%", [Channlid_array2 count] * 100.0 / [Channlid_array3 count]];
  //存入数据
  [SimuControl downDataWithType:down_count];
  return [SimuControl downDataType];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  who_num = -1;
  switch (indexPath.section) {
  case 0: {
    switch (indexPath.row) {
    case 0: {
      WiFiDownViewController *wifiVC = [[WiFiDownViewController alloc] init];
      [AppDelegate pushViewControllerFromRight:wifiVC];

    } break;
    case 1: {
      alter_upload_view.title = @"确认清除";
      alter_upload_view.message = clear_str;
      [alter_upload_view show];
      //            event 日志
      [[event_view_log sharedManager] event_log:@"1000014"];
      [MobClick event:@"1000014"];

      return;
    } break;
    default:
      break;
    }
  } break;
  case 1: {
    switch (indexPath.row) {
    case 1: {
      SettingVCTableViewCell *cell = (SettingVCTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
      UIButton *btn = (UIButton *)[cell viewWithTag:50000];
      [self btn2_Click:btn];
    } break;
    case 2: {
      [alter_upload_view_2 show];
    } break;
    default:
      break;
    }

  } break;
  case 2: {
    switch (indexPath.row) {
    case 0: {
      SettingVCTableViewCell *cell = (SettingVCTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
      UIButton *btn = (UIButton *)[cell viewWithTag:30000];
      [self btn3_Click:btn];
    } break;
    case 1: {
      SettingVCTableViewCell *cell = (SettingVCTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
      UIButton *btn = (UIButton *)[cell viewWithTag:40000];
      [self btn4_Click:btn];
    } break;
    default:
      break;
    }
  } break;
  case 3: {
    switch (indexPath.row) {
    case 0: {
      [Login_ViewController checkLoginStatusWithCallback:^(BOOL logonSuccess) {
        if (logonSuccess) {
          UserInfoViewController *USerinfo = [[UserInfoViewController alloc] init];
          [AppDelegate pushViewControllerFromRight:USerinfo];
        }
      }];
    } break;
    case 1: {
      [Login_ViewController checkLoginStatusWithCallback:^(BOOL logonSuccess) {
        if (logonSuccess) {
          FeedbackViewController *feedback_VC = [[FeedbackViewController alloc] init];
          [AppDelegate pushViewControllerFromRight:feedback_VC];
        }
      }];
    } break;
    case 2: {
      NSString *str =
          [NSString
              stringWithFormat:@"itms-apps://ax.itunes.apple.com/" @"WebObjects/MZStore.woa/wa/" @"viewContentsUserReviews?type=Purple+" @"Software&id=%d", 718149570];
      if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        str = @"https://appsto.re/cn/cFHZQ.i";
      }
      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
      //            event 日志
      [[event_view_log sharedManager] event_log:@"1000018"];
      [MobClick event:@"1000018"];

    } break;
    case 3: {
      AboutUsNewsViewController *baseVC = [[AboutUsNewsViewController alloc] init];
      [AppDelegate pushViewControllerFromRight:baseVC];
    } break;
    default:
      break;
    }
  } break;
  default:
    break;
  }
  [Main_tableView reloadData];
}
#pragma mark - UIalertviewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (alertView != nil && alertView.delegate != nil) {
    //    清除缓存
    if (buttonIndex != alertView.cancelButtonIndex && alertView.tag == 1000) {
      is_clear_data = YES;
      [Main_tableView reloadData];
      //提示语，动画
      YouGu_animation_Did_Start(@"清理完毕");

      NSArray *clearArray = [NSArray array];
      [clearArray writeToFile:pathInCacheDirectory(@"Wi_Fi_down_channlid.plist") atomically:YES];

      //   将未下载的，存入已经下载的
      NSMutableArray *Channlid_array2 = [NSMutableArray arrayWithContentsOfFile:pathInCacheDirectory(@"Wi_Fi_down_be_selected_channlid.plist")];
      [Channlid_array2 writeToFile:pathInCacheDirectory(@"Wi_Fi_down_channlid_UnDown.plist")
                        atomically:YES];

      //        清楚已读，数据库数据
      [FileChangelUtil deleteUserAllWithId];
//      [self remove_filename];
      return;
    }
    if (alertView.tag == 2051 && buttonIndex == alertView.firstOtherButtonIndex) {
      //取消新浪微博账号绑定
      [FPShareSDKUtil cancelAuthWithType:ShareTypeSinaWeibo];
    }
    if (alertView.tag == 2052 && buttonIndex == alertView.firstOtherButtonIndex) {
      //取消腾讯微博账号绑定
      [FPShareSDKUtil cancelAuthWithType:ShareTypeTencentWeibo];
    }
    //    版本更新
    if (buttonIndex != alertView.cancelButtonIndex && alertView.tag == 2000) {
      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:app_url]];
    }
  }
  [Main_tableView reloadData];
}

- (void)willPresentAlertView:(UIAlertView *)alertView {
  if (alertView != nil && alertView.delegate != nil) {
    if (alertView.tag == 2000) {
      for (UIView *view in alertView.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
          UILabel *label = (UILabel *)view;
          if ([label.text isEqualToString:@"更新版本"] == NO) {
            label.textAlignment = NSTextAlignmentLeft;
          }
        }
      }
    }
  }
}

//某个数组里，是否包含某个元素
- (BOOL)Whether_to_include:(NSString *)string andArray:(NSMutableArray *)array {
  string = [NSString stringWithFormat:@"%@", string];
  for (NewsInChannelItem *item in array) {
    if ([string isEqualToString:item.newsID]) {
      return YES;
    }
  }
  return NO;
}

//某个数组里，是否包含某个元素
- (BOOL)Whether_to_include_other:(NSString *)string andArray:(NSArray *)array {
  string = [NSString stringWithFormat:@"%@", string];
  for (NSArray *array_str in array) {
    if ([array_str count] >= 2 && [string isEqualToString:array_str[1]] == YES) {
      return YES;
    }
  }
  return NO;
}

////删除文件夹中多余的文件
//- (void)remove_filename {
//  //清除照片，重新下载@"Collection.xmly"@"com.xmly"
//  YouGu_NSFileManger_removeItemAtPath(@"com.xmly");
//  YouGu_NSFileManager_Path(@"com.xmly");
//  YouGu_NSFileManger_removeItemAtPath(@"Collection.xmly");
//  YouGu_NSFileManager_Path(@"Collection.xmly");
//  YouGu_NSFileManger_removeItemAtPath(@"ALL_images_thing.xmly");
//  YouGu_NSFileManager_Path(@"ALL_images_thing.xmly");
//  [FileChangelUtil deleteUserAllWithId];
//}
- (void)btn2_Click:(UIButton *)sender {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  BOOL isSelected = !sender.selected;
  sender.selected = isSelected;
  [defaults setObject:[@(isSelected) stringValue] forKey:@"WiFi_DownPic"];
}

- (void)btn3_Click:(UIButton *)sender {
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  if (YES == sender.selected) {
    [FPShareSDKUtil authWithType:ShareTypeSinaWeibo
                         options:[FPShareSDKUtil getAuthOptions]
                          result:^(SSAuthState state) {
                            if (state == SSAuthStateSuccess) {
                              sender.selected = NO;
                              [Main_tableView reloadData];
                            } else if (state == SSAuthStateCancel) {
                              sender.selected = YES;
                            }
                          }];
  } else {
    UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:nil
                                                     message:@"是否解绑新浪微博账户？"
                                                    delegate:self
                                           cancelButtonTitle:@"取消"
                                           otherButtonTitles:@"确认", nil];
    alertV.tag = 2051;
    [alertV show];
  }
}

- (void)btn4_Click:(UIButton *)sender {
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  if (YES == sender.selected) {
    [FPShareSDKUtil authWithType:ShareTypeTencentWeibo
                         options:[FPShareSDKUtil getAuthOptions]
                          result:^(SSAuthState state) {
                            if (state == SSAuthStateSuccess) {
                              sender.selected = NO;
                              [Main_tableView reloadData];
                            } else if (state == SSAuthStateCancel) {
                              sender.selected = YES;
                            }
                          }];
  } else {
    UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:nil
                                                     message:@"是否解绑腾讯微博账户？"
                                                    delegate:self
                                           cancelButtonTitle:@"取消"
                                           otherButtonTitles:@"确认", nil];
    alertV.tag = 2052;
    [alertV show];
  }
}
- (BOOL)is_Binding:(int)num {
  BOOL is_bind = NO;
  switch (num) {
  case 0:
    is_bind = [FPShareSDKUtil hasAuthorizedWithType:ShareTypeSinaWeibo]; //新浪微博
    break;
  case 1:
    is_bind = [FPShareSDKUtil hasAuthorizedWithType:ShareTypeTencentWeibo]; //腾讯微博
    break;
  default:
    break;
  }
  return is_bind;
}
@end
