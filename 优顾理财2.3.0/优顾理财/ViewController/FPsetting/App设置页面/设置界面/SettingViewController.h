//
//  SettingViewController.h
//  优顾理财
//
//  Created by Mac on 14-3-14.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
//提示动画
#import "AnimationLabelAlterView.h"

typedef NS_ENUM(NSUInteger, SettingPageType) {
  /** wifi下载 */
  SettingPageTypeWifiDownload,
  /** 清除缓存 */
  SettingPageTypeClearCache,
  /** 字体设置 */
  SettingPageTypeTextFont,
  /** 夜间模式 */
  SettingPageTypeNightMode,
  /** 无图模式 */
  SettingPageTypeNoImageMode,
  /** 推送开关 */
  SettingPageTypePushSwitch,
  /** 新浪微博 */
  SettingPageTypeSinaWeibo,
  /** 腾讯微博 */
  SettingPageTypeTencentWeibo,
  /** 用户中心 */
  SettingPageTypePersonCenter,
  /** 修改密码 */
  SettingPageTypeChangePassword,
  /** 反馈 */
  SettingPageTypeFeedback,
  /** 版本更新 */
  SettingPageTypeVersionUpdate,
  /** 评分 */
  SettingPageTypeGraded,
  /** 关于我们 */
  SettingPageTypeAboutUs,
};

@interface SettingViewController
    : YGBaseViewController <UITableViewDelegate, UITableViewDataSource,
                            UIAlertViewDelegate> {

  UITableView *Main_tableView;

  NSMutableArray *main_array;

  BOOL is_suck;
  //   新版本的连接
  NSString *app_url;

  BOOL is_clear_data;
  NSString *clear_str;

  BOOL is_done;

  UIAlertView *alter_upload_view;
  UIAlertView *alter_upload_view_2;
  //下载数
  NSString *down_count;

  //    登录页面，回调
  int who_num;
}
@property(nonatomic, retain) NSString *app_url;
@property(nonatomic, retain) NSString *clear_str;
@end
