//
//  LabelOfflineDownload.h
//  优顾理财
//
//  Created by Mac on 14-6-20.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAProgressOverlayView.h"
typedef enum {
  otherDownload =0,
  waitDownload = 1,
  finishedDownload = 2,
  UnselectedDownload = 3,
} DownloadNewsStatus;
@protocol LabelOfflineDownload_delegate <NSObject>

- (void)USerPicBtnClick;
- (void)The_download_is_complete;
//下载过程中被中断
- (void)Midway_poisoning_Download;
@end
@interface LabelOfflineDownload : UILabel {
  UIImageView *_Image_Selected;
  UILabel *_img_label;

  UIControl *_actionView;
  UIButton *btn_stop;

  NSMutableArray *down_array;
}
@property(nonatomic) DownloadNewsStatus statue;
/**
 *
 *  用户选择的频道
 *
 */
@property(nonatomic, strong) NSString *userChannleId;
/**
 *
 *  是否停止下载
 *
 */
@property(nonatomic) BOOL isStopping;

/**
 *
 *  动画
 *
 */
@property(nonatomic, strong) DAProgressOverlayView * progressView;

@property(nonatomic, unsafe_unretained)
    id<LabelOfflineDownload_delegate> delegate;
- (void)addTarget:(id)target action:(SEL)action;

#pragma mark - 是否正在下载
- (void)loading_down;
@end
