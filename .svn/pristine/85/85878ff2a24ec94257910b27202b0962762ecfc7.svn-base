//
//  Wi-Fi_Down_ViewController.h
//  优顾理财
//
//  Created by Mac on 14-5-19.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "FPBaseViewController.h"
#import "DAProgressOverlayView.h"
#import "SettingButton.h"
#import "LabelOfflineDownload.h"
#import "Reachability.h"
@interface WiFiDownViewController
    : FPBaseViewController <LabelOfflineDownload_delegate,
                            UIAlertViewDelegate> {
@private
  Reachability *hostReach;
  /**  选择的网络类型*/
  NSString *wi_fi_string;

  NSMutableArray *btn_array;

  BOOL is_doing;
  /**  已选中频道和总频道数*/
  UILabel *label_3;
  /** 计算已选中的频道个数*/
  int num;
  /**   频道的数量*/
  NSInteger zong_num;
  //    被选中的，id，数组
  NSMutableArray *id_channlid_array;

  //    是否下载完成
  BOOL is_complete;
  /**  全选得对勾按钮*/
  SettingButton *btn2;

  /** wifi时离线下载下面的横线view*/
  UIView *view_1;
  /**  wifi时自动离线下载后面的对勾按钮*/
  SettingButton *btn_WiFi_or_GRPS;
  /**  WIFI时自动离线下载*/
  UILabel *label_1;
  /**  选择要离线下载的内容*/
  UILabel *label_2;
   /**  提示3G/2G网络*/
  UIAlertView *alter_upload_view;
  /**  提示wifi网络提示*/
  UIAlertView *alter_upload_view_2;
  /**  提示无网络提示*/
  UIAlertView *alter_upload_view_3;
}
///等待下载的频道
@property(nonatomic,strong) NSMutableArray * waitDownloadArray;
///所有的频道
@property(nonatomic,strong) NSMutableArray * allChannelArray;
///已经下载完成的频道
@property(nonatomic,strong) NSMutableArray * finishedDownloadArray;

///网络类型
@property(nonatomic, retain) NSString *wi_fi_string;
@end
