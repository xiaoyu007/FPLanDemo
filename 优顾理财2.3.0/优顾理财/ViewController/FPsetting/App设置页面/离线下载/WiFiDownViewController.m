//
//  Wi-Fi_Down_ViewController.m
//  优顾理财
//
//  Created by Mac on 14-5-19.1
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "WiFiDownViewController.h"

@implementation WiFiDownViewController
@synthesize wi_fi_string;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}
#pragma mark - pv, 选择正确的pvjiem
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [MobClick beginLogPageView:@"Offline_Download_view"];
  [[PV_view_sql sharedManager] PV_DB_DATA:@"Offline_Download_view"];
}
- (void)viewWillDisappear:(BOOL)animated {
  //    在将要消失的时候，保存数据   这是已经下载完成的数据
  [_finishedDownloadArray writeToFile:pathInCacheDirectory(@"Wi_Fi_down_channlid.plist")
                           atomically:YES];

  [btn_array writeToFile:pathInCacheDirectory(@"Wi_Fi_down_channlid_UnDown.plist") atomically:YES];

  //    被选中的，所有频道
  [id_channlid_array writeToFile:pathInCacheDirectory(@"Wi_Fi_down_be_selected_channlid.plist")
                      atomically:YES];

  //    调用，消息中心，让main_viewController 继续下载
  [[NSNotificationCenter defaultCenter] postNotificationName:@"unCompleteChannleDownLoad"
                                                      object:nil];

  [super viewWillDisappear:animated];
  [MobClick endLogPageView:@"Offline_Download_view"];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.topNavView.mainLableString = @"离线下载";
  
  
  self.view.backgroundColor = [UIColor whiteColor];
  _waitDownloadArray = [[NSMutableArray alloc] init];
  //  所有频道
  _allChannelArray = [[NSMutableArray alloc] init];
  _finishedDownloadArray = [[NSMutableArray alloc] init];
  is_complete = NO;

  btn_array = [[NSMutableArray alloc] initWithCapacity:0];
  //  被选中的，id 数组
  id_channlid_array = [[NSMutableArray alloc] initWithCapacity:0];
  is_doing = NO;

  alter_upload_view = [[UIAlertView alloc] initWithTitle:@"通知"
                                                 message:@"您现在网络方式为:3G或GPRS," @"是否继续进入离线下载!!!"
                                                delegate:self
                                       cancelButtonTitle:@"离开"
                                       otherButtonTitles:@"继续下载", nil];
  alter_upload_view.tag = 3000;
  alter_upload_view_2 = [[UIAlertView alloc] initWithTitle:@"通知"
                                                   message:@"您现在网络方式为:无网络," @"不能进入离线下载!!!"
                                                  delegate:self
                                         cancelButtonTitle:@"离开"
                                         otherButtonTitles:nil, nil];
  alter_upload_view_2.tag = 2000;
  alter_upload_view_3 = [[UIAlertView alloc] initWithTitle:@"通知"
                                                   message:@"您现在网络方式为:3G或GPRS," @"是否继续进入离线下载!!!"
                                                  delegate:self
                                         cancelButtonTitle:@"离开"
                                         otherButtonTitles:@"继续下载", nil];
  alter_upload_view_3.tag = 1000;
  [self Get_header_View];
}

//监听到网络状态改变
- (void)reachabilityChanged:(NSNotification *)note {
  Reachability *curReach = [note object];
  NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
  [self updateInterfaceWithReachability:curReach];
}

//处理连接改变后的情况
- (void)updateInterfaceWithReachability:(Reachability *)curReach {
  //对连接改变做出响应的处理动作。
  NetworkStatus status = [curReach currentReachabilityStatus];
  if (status == ReachableViaWWAN) {
    if ([wi_fi_string isEqualToString:@"3G/2G"] == NO) {
      //            原先不是3G/2G,给提示
      [alter_upload_view show];
    }
    self.wi_fi_string = @"3G/2G";
    printf("\n3g/2G\n");
  } else if (status == ReachableViaWiFi) {
    self.wi_fi_string = @"wifi";
    printf("\nwifi\n");
  } else {
    self.wi_fi_string = @"无网络";
    printf("\n无网络\n");
  }
}

#pragma mark - 初始化，UI控件
///******************************************************************************
// 函数名称 : -(void)Get_header_View
// 函数描述 :初始化，UI控件
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************
#pragma mark - 初始化，UI控件

- (void)Get_header_View {
  label_1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 200, 30)];
  label_1.backgroundColor = [UIColor clearColor];
  label_1.font = [UIFont systemFontOfSize:16.0f];
  label_1.textAlignment = NSTextAlignmentLeft;
  label_1.text = @"WIFI时自动离线下载";
  [self.childView addSubview:label_1];

  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  btn_WiFi_or_GRPS = [[SettingButton alloc] initWithFrame:CGRectMake(275, 10, 46, 26)];
  [btn_WiFi_or_GRPS addTarget:self
                       action:@selector(btn1_Click:)
             forControlEvents:UIControlEventTouchUpInside];
  btn_WiFi_or_GRPS.selected = [[defaults objectForKey:@"Wi-Fi_or_GRPS"] intValue];
  [self.childView addSubview:btn_WiFi_or_GRPS];

  view_1 = [[UIView alloc] initWithFrame:CGRectMake(16, 50, 288, 1)];
  view_1.backgroundColor = [UIColor grayColor];
  [self.childView addSubview:view_1];

  label_2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 200, 30)];
  label_2.backgroundColor = [UIColor clearColor];
  label_2.font = [UIFont systemFontOfSize:16.0f];
  label_2.textAlignment = NSTextAlignmentLeft;
  label_2.text = @"选择要离线下载的内容";
  [self.childView addSubview:label_2];

  num = 0;

  label_3 = [[UILabel alloc] initWithFrame:CGRectMake(200, 60, 70, 30)];
  label_3.backgroundColor = [UIColor clearColor];
  label_3.font = [UIFont systemFontOfSize:12.0f];
  label_3.textAlignment = NSTextAlignmentRight;
  label_3.text = @"已选0/12";
  [self.childView addSubview:label_3];

  btn2 = [[SettingButton alloc] initWithFrame:CGRectMake(275, 60, 46, 26)];
  [btn2 addTarget:self action:@selector(btn2_Click:) forControlEvents:UIControlEventTouchUpInside];
  btn2.selected = YES;
  [self.childView addSubview:btn2];

  NewsChannelList *allObject = [FileChangelUtil loadAllNewsChannelList];
  if (allObject.channels.count > 0) {
    [self.allChannelArray addObjectsFromArray:allObject.channels];
    zong_num = allObject.channels.count;
    label_3.text = [NSString stringWithFormat:@"已选%d/%ld", num, (long)zong_num];
  }

  //    添加 已经下载完成的频道
  NSMutableArray *Channlid_array =
      [NSMutableArray arrayWithContentsOfFile:pathInCacheDirectory(@"Wi_Fi_down_channlid.plist")];
  if (Channlid_array.count > 0) {
    //        已下载的频道
    [self.finishedDownloadArray addObjectsFromArray:Channlid_array];
  }
  //    添加，未下载成功的频道
  NSMutableArray *Channlid_array2 = [NSMutableArray arrayWithContentsOfFile:pathInCacheDirectory(@"Wi_Fi_down_channlid_UnDown.plist")];
  if (Channlid_array2.count > 0) {
    [btn_array addObjectsFromArray:Channlid_array2];
  }
  //    被选中的所有频道
  NSMutableArray *Channlid_array3 = [NSMutableArray arrayWithContentsOfFile:pathInCacheDirectory(@"Wi_Fi_down_be_selected_channlid.plist")];
  if (id_channlid_array.count > 0) {
    [id_channlid_array addObjectsFromArray:Channlid_array3];
  }

  num = (int)[id_channlid_array count];
  [self To_determine_whether_all];

  //    创建所有的频道
  [self get_channlid];

  [self Night_to_Day];
}

//判断是否全选
- (void)To_determine_whether_all {
  label_3.text = [NSString stringWithFormat:@"已选%d/%ld", num, (long)zong_num];
  if (num == zong_num) {
    btn2.selected = NO;
  } else {
    btn2.selected = YES;
  }
}

#pragma mark - 创建，所有频道
///******************************************************************************
// 函数名称 : -(void)get_channlid
// 函数描述 :创建，所有频道
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************
#pragma mark - 创建，所有频道
- (void)get_channlid {
  for (int i = 0; i < self.allChannelArray.count; i++) {
    NewsChannelItem *onlyObject = self.allChannelArray[i];
    //  所有频道   (最底层，作下载新闻和点击用)
    LabelOfflineDownload *offline_download =
        [[LabelOfflineDownload alloc] initWithFrame:CGRectMake(20 + i % 4 * 69, 100 + i / 4 * 59, 70, 60)];
    offline_download.backgroundColor = [UIColor clearColor];
    [[offline_download layer] setBorderWidth:1.0];
    offline_download.tag = 2000 + i;
    offline_download.delegate = self;
    offline_download.textAlignment = NSTextAlignmentCenter;
    offline_download.text = onlyObject.name;
    offline_download.userChannleId = onlyObject.channleID;
    [offline_download addTarget:self action:@selector(btn_click:)];
    [self.childView addSubview:offline_download];

    offline_download.backgroundColor = [UIColor clearColor];
    [[offline_download layer] setBorderColor:[UIColor grayColor].CGColor];
    offline_download.textColor = [UIColor blackColor];
  }
  num = (int)[id_channlid_array count];
  [self To_determine_whether_all];

  NSString *network = CheckNetWork();
  if ([network isEqualToString:@"3G或GPRS"] == YES) {
    self.wi_fi_string = @"3G/2G";
    [alter_upload_view show];
  } else if ([network isEqualToString:@"wifi"] == YES) {
    self.wi_fi_string = @"wifi";
    for (int i = 0; i < self.allChannelArray.count; i++) {
      LabelOfflineDownload *A_offline_download = (LabelOfflineDownload *)[self.childView viewWithTag:i + 2000];
      [self Download_and_no_download:A_offline_download];
    }
    [self One_by_one_to_download];
  } else {
    self.wi_fi_string = @"无网络";

    [alter_upload_view_2 show];
  }
  num = (int)[id_channlid_array count];
  [self To_determine_whether_all];

  //开启网络状况的监听
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(reachabilityChanged:)
                                               name:kReachabilityChangedNotification
                                             object:nil];

  hostReach = [Reachability reachabilityWithHostName:@"www.youguu.com"]; //可以以多种形式初始化
  [hostReach startNotifier]; //开始监听,会启动一个run loop
}

#pragma mark - UIalertviewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (buttonIndex == alertView.cancelButtonIndex && alertView.tag == 2000) {
    [self stop_After_download];
    [self.waitDownloadArray removeAllObjects];
    [self.navigationController popViewControllerAnimated:YES];
    return;
  }

  //    网络检测
  if (buttonIndex == alertView.cancelButtonIndex && alertView.tag == 3000) {
    [self stop_After_download];
    [self.waitDownloadArray removeAllObjects];
    [self.navigationController popViewControllerAnimated:YES];
    return;
  }

  //    清除缓存
  if (alertView.tag == 1000) {
    if (buttonIndex != alertView.cancelButtonIndex) {
      for (int i = 0; i < self.allChannelArray.count; i++) {
        LabelOfflineDownload *A_offline_download = (LabelOfflineDownload *)[self.childView viewWithTag:i + 2000];
        A_offline_download.isStopping = NO;
        [self Download_and_no_download:A_offline_download];
      }
      [self One_by_one_to_download];
    } else {
      [self stop_After_download];
      [self.waitDownloadArray removeAllObjects];
      [self.navigationController popViewControllerAnimated:YES];
      return;
    }
  }
}

// delegate
- (void)USerPicBtnClick {
  [self One_by_one_to_download];
}

//某个数组里，是否包含某个元素
- (BOOL)Whether_to_include:(NSString *)string andArray:(NSMutableArray *)array {
  for (NSString *str in array) {
    if ([string isEqualToString:str] == YES) {
      return YES;
    }
  }
  return NO;
}

//选择已经下载完成的，和，没有下载的，
- (void)Download_and_no_download:(LabelOfflineDownload *)offline_download {
  if (btn_WiFi_or_GRPS.selected == NO) {
    if ([self Whether_to_include:offline_download.userChannleId andArray:btn_array] == YES) {
      [self.finishedDownloadArray removeObject:offline_download.userChannleId];
      if ([self Whether_to_include:offline_download.userChannleId andArray:id_channlid_array] == NO) {
        [id_channlid_array addObject:offline_download.userChannleId];
      }
      offline_download.statue = waitDownload;
      offline_download.isStopping = NO;
      //            [offline_download loading_down];
      NSString *offline_tag = [NSString stringWithFormat:@"%ld", (long)offline_download.tag];
      [self add_Filter_array_redundancy:offline_tag];
    } else if ([self Whether_to_include:offline_download.userChannleId
                               andArray:self.finishedDownloadArray] == YES) {
      if ([self Whether_to_include:offline_download.userChannleId andArray:id_channlid_array] == NO) {
        [id_channlid_array addObject:offline_download.userChannleId];
      }
      offline_download.statue = finishedDownload;
    } else {
      [id_channlid_array removeObject:offline_download.userChannleId];
      offline_download.statue = otherDownload;
    }
  } else {
    if ([self Whether_to_include:offline_download.userChannleId andArray:id_channlid_array] == YES) {
      offline_download.statue = UnselectedDownload;
    } else {
      offline_download.statue = otherDownload;
    }
  }
}

//下载过程中被中断
- (void)Midway_poisoning_Download {
  [self One_by_one_to_download];
}

//下载完成回调
- (void)The_download_is_complete {
  if ([self.waitDownloadArray count] > 0) {
    LabelOfflineDownload *A_offline_download =
        (LabelOfflineDownload *)[self.childView viewWithTag:[self.waitDownloadArray[0] intValue]];
    [self.waitDownloadArray removeObjectAtIndex:0];

    [btn_array removeObject:A_offline_download.userChannleId];
    if ([self Whether_to_include:A_offline_download.userChannleId
                        andArray:self.finishedDownloadArray] == NO) {
      [self.finishedDownloadArray addObject:A_offline_download.userChannleId];
    }
    if ([self Whether_to_include:A_offline_download.userChannleId andArray:id_channlid_array] == NO) {
      [id_channlid_array addObject:A_offline_download.userChannleId];
    }
  }

  [self One_by_one_to_download];
}

//让等待下载的频道，一个个下载
- (void)One_by_one_to_download {
  if ([self.waitDownloadArray count] > 0) {
    is_complete = YES;
    LabelOfflineDownload *A_offline_download =
        (LabelOfflineDownload *)[self.childView viewWithTag:[self.waitDownloadArray[0] intValue]];
    [A_offline_download loading_down];
  } else {
    is_complete = NO;
  }
}

- (void)stop_After_download {
  if ([self.waitDownloadArray count] > 0) {
    LabelOfflineDownload *A_offline_download =
        (LabelOfflineDownload *)[self.childView viewWithTag:[self.waitDownloadArray[0] intValue]];
    A_offline_download.isStopping = YES;
  }
}

#pragma mark - 最底层 点击，进入，被选状态，准备下载
///******************************************************************************
// 函数名称 :-(void)btn_click:(UIButton *)sender
// 函数描述 :最底层 点击，进入，被选状态，准备下载
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************
#pragma mark -  最底层 点击，进入，被选状态，准备下载
- (void)btn_click:(UIButton *)sender {
  if (sender.tag >= 2000) {
    LabelOfflineDownload *A_offline_download = (LabelOfflineDownload *)[self.childView viewWithTag:sender.tag];

    if (A_offline_download.statue != otherDownload) {
      A_offline_download.statue = otherDownload;
      A_offline_download.progressView.hidden = YES;
      A_offline_download.isStopping = YES;
      [btn_array removeObject:A_offline_download.userChannleId];
      [self.finishedDownloadArray removeObject:A_offline_download.userChannleId];
      [id_channlid_array removeObject:A_offline_download.userChannleId];
      NSString *offline_tag = [NSString stringWithFormat:@"%ld", (long)A_offline_download.tag];
      [self.waitDownloadArray removeObject:offline_tag];
    } else {
      [btn_array addObject:A_offline_download.userChannleId];
      [self.finishedDownloadArray removeObject:A_offline_download.userChannleId];
      if ([self Whether_to_include:A_offline_download.userChannleId
                          andArray:id_channlid_array] == NO) {
        [id_channlid_array addObject:A_offline_download.userChannleId];
      }

      if (btn_WiFi_or_GRPS.selected == YES) {
        A_offline_download.statue = UnselectedDownload;
      } else {
        A_offline_download.statue = waitDownload;
        A_offline_download.isStopping = NO;
        //               [A_offline_download loading_down];
        NSString *offline_tag = [NSString stringWithFormat:@"%ld", (long)A_offline_download.tag];
        [self add_Filter_array_redundancy:offline_tag];
        //如果下载完成，就从新开始下载
        if (is_complete == NO) {
          [self One_by_one_to_download];
        }
      }
    }
  }

  num = (int)[id_channlid_array count];
  [self To_determine_whether_all];
}

- (void)btn1_Click:(UIButton *)sender {
  sender.selected = !sender.selected;

  if (sender.selected == NO) {
    for (int i = 0; i < self.allChannelArray.count; i++) {
      LabelOfflineDownload *A_offline_download = (LabelOfflineDownload *)[self.childView viewWithTag:i + 2000];

      [self Download_and_no_download:A_offline_download];
    }
    if (is_complete == NO) {
      [self One_by_one_to_download];
    }
  } else {
    [self.waitDownloadArray removeAllObjects];
    for (int i = 0; i < self.allChannelArray.count; i++) {
      LabelOfflineDownload *A_offline_download = (LabelOfflineDownload *)[self.childView viewWithTag:i + 2000];
      A_offline_download.isStopping = YES;

      if ([self Whether_to_include:A_offline_download.userChannleId
                          andArray:id_channlid_array] == YES) {
        A_offline_download.statue = UnselectedDownload;
        A_offline_download.isStopping = YES;
      } else {
        A_offline_download.statue = otherDownload;
      }
    }
  }
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setObject:[NSString stringWithFormat:@"%d", sender.selected] forKey:@"Wi-Fi_or_GRPS"];
}

#pragma mark - 全选，按钮
///******************************************************************************
// 函数名称 :-(void)btn2_Click:(UIButton *)sender
// 函数描述 :全选，按钮
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :// no为亮，yes为暗，未选中
// ******************************************************************************
#pragma mark -  全选，按钮
- (void)btn2_Click:(UIButton *)sender {
  sender.selected = !sender.selected;
  if (sender.selected == NO) {
    if (btn_WiFi_or_GRPS.selected == NO) {
      for (int i = 0; i < self.allChannelArray.count; i++) {
        LabelOfflineDownload *A_offline_download = (LabelOfflineDownload *)[self.childView viewWithTag:i + 2000];

        if ([self Whether_to_include:A_offline_download.userChannleId
                            andArray:self.finishedDownloadArray] == YES) {
          A_offline_download.statue = finishedDownload;
        } else {
          A_offline_download.statue = waitDownload;
          if ([self Whether_to_include:A_offline_download.userChannleId
                              andArray:id_channlid_array] == NO) {
            [id_channlid_array addObject:A_offline_download.userChannleId];
            if ([self Whether_to_include:A_offline_download.userChannleId andArray:btn_array] == NO) {
              [btn_array addObject:A_offline_download.userChannleId];
            }
          }

          if ([self Whether_to_include:A_offline_download.userChannleId andArray:btn_array] == YES) {
            A_offline_download.isStopping = NO;
            NSString *offline_tag = [NSString stringWithFormat:@"%ld", (long)A_offline_download.tag];
            [self add_Filter_array_redundancy:offline_tag];
            if (is_complete == NO) {
              [self One_by_one_to_download];
            }
          }
        }
      }
    } else {
      [self.waitDownloadArray removeAllObjects];
      for (int i = 0; i < self.allChannelArray.count; i++) {
        LabelOfflineDownload *A_offline_download = (LabelOfflineDownload *)[self.childView viewWithTag:i + 2000];
        A_offline_download.statue = UnselectedDownload;

        if ([self Whether_to_include:A_offline_download.userChannleId andArray:btn_array] == NO) {
          [btn_array addObject:A_offline_download.userChannleId];
        }
        if ([self Whether_to_include:A_offline_download.userChannleId
                            andArray:id_channlid_array] == NO) {
          [id_channlid_array addObject:A_offline_download.userChannleId];
        }
      }
    }

  } else {
    [self.waitDownloadArray removeAllObjects];
    [btn_array removeAllObjects];
    [self.finishedDownloadArray removeAllObjects];
    [id_channlid_array removeAllObjects];
    for (int i = 0; i < self.allChannelArray.count; i++) {
      LabelOfflineDownload *A_offline_download = (LabelOfflineDownload *)[self.childView viewWithTag:i + 2000];
      A_offline_download.isStopping = YES;
      A_offline_download.statue = otherDownload;
      A_offline_download.progressView.hidden = YES;
    }
  }
  num = (int)[id_channlid_array count];
  [self To_determine_whether_all];
}

//过滤，wait_for_download，重复成员
- (void)add_Filter_array_redundancy:(NSString *)str {
  if ([self Whether_to_include:str andArray:self.waitDownloadArray] == YES) {
    return;
  } else {
    [self.waitDownloadArray addObject:str];
  }
}

/**
 *
 *  //消息中心
 *
 **/
#pragma mark - 消息中心，回调，夜间、白天和无图、有图

//夜间模式和白天模式
- (void)Night_to_Day {
  //        正文——主视图
  self.view.backgroundColor = [Globle colorFromHexRGB:@"f1f1f1"];
  view_1.backgroundColor = [Globle colorFromHexRGB:@"d1d1d1"];
  label_1.textColor = [Globle colorFromHexRGB:@"000000"];
  label_2.textColor = [Globle colorFromHexRGB:@"000000"];
  label_3.textColor = [Globle colorFromHexRGB:@"000000"];
}

#pragma mark - NEWS_Nav_View 自定义导航条  按钮delegate 点击函数
- (void)leftButtonPress {
  [self stop_After_download];
  [self.waitDownloadArray removeAllObjects];
  [self.navigationController popViewControllerAnimated:YES];
}

@end
