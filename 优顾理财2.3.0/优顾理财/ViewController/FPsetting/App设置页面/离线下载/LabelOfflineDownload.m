//
//  LabelOfflineDownload.m
//  优顾理财
//
//  Created by Mac on 14-6-20.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "LabelOfflineDownload.h"
#import "WifiOffDownload.h"
@implementation LabelOfflineDownload
- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self setup];
  }
  return self;
}

- (id)init {
  if (self = [super init]) {
    [self setup];
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super initWithCoder:aDecoder]) {
  }
  return self;
}

- (void)setup {
  down_array = [[NSMutableArray alloc] initWithCapacity:0];

  _isStopping = NO;
  //    离线下载动画
  _progressView = [[DAProgressOverlayView alloc] initWithFrame:CGRectMake(0, 0, 70, 60)];
  _progressView.userInteractionEnabled = NO;
  _progressView.hidden = YES;
  [self addSubview:_progressView];
  [self Night_to_Day];

  btn_stop = [UIButton buttonWithType:UIButtonTypeCustom];
  btn_stop.frame = CGRectMake(0, 0, self.width, self.height);
  btn_stop.hidden = YES;
  btn_stop.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.8];
  [btn_stop setImage:[UIImage imageNamed:@"wi_fi暂停按钮"] forState:UIControlStateNormal];
  [btn_stop addTarget:self
                action:@selector(stop_to_play:)
      forControlEvents:UIControlEventTouchUpInside];
  UIEdgeInsets edgeinset = UIEdgeInsetsMake(10, 15, 10, 15);
  btn_stop.imageEdgeInsets = edgeinset;
  [self addSubview:btn_stop];

  _Image_Selected =
      [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width * 3 / 7, self.height / 2)];
  _Image_Selected.userInteractionEnabled = NO;
  [self addSubview:_Image_Selected];

  _img_label =
      [[UILabel alloc] initWithFrame:CGRectMake(1, 5, _Image_Selected.width * 2 / 3, _Image_Selected.height / 3)];
  _img_label.backgroundColor = [UIColor clearColor];
  _img_label.userInteractionEnabled = NO;
  _img_label.font = [UIFont systemFontOfSize:6];
  _img_label.textColor = [UIColor whiteColor];
  _img_label.textAlignment = NSTextAlignmentLeft;
  [_Image_Selected addSubview:_img_label];

  [self setUserInteractionEnabled:TRUE];
  _actionView = [[UIControl alloc] initWithFrame:self.bounds];
  [_actionView setBackgroundColor:[UIColor clearColor]];
  [_actionView addTarget:self
                  action:@selector(appendHighlightedColor)
        forControlEvents:UIControlEventTouchDown];
  [_actionView addTarget:self
                  action:@selector(removeHighlightedColor)
        forControlEvents:UIControlEventTouchCancel | UIControlEventTouchUpInside | UIControlEventTouchDragOutside | UIControlEventTouchUpOutside];
  [self addSubview:_actionView];
  [self sendSubviewToBack:_actionView];
}

- (void)addTarget:(id)target action:(SEL)action {
  _actionView.tag = self.tag;
  [_actionView addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)appendHighlightedColor {
}

- (void)removeHighlightedColor {
}

- (void)setStatue:(DownloadNewsStatus)statue {
  _statue = statue;
  if (statue == waitDownload) {
    _Image_Selected.image = [UIImage imageNamed:@"下载条-夜间"];
  } else if (statue == finishedDownload) {
    _img_label.text = @"100%";
    _Image_Selected.image = [UIImage imageNamed:@"下载进度条-" @"下载完成"];
  } else if (statue == UnselectedDownload) {
    _img_label.text = nil;
    _Image_Selected.image = [UIImage imageNamed:@"没有勾选"];
  } else {
    _img_label.text = nil;
    _Image_Selected.image = nil;
  }
}

#pragma mark - 是否正在下载
- (void)loading_down {
  self.statue = waitDownload;
  self.progressView.hidden = NO;
  self.isStopping = NO;
  _img_label.text = @"0%";
  [down_array removeAllObjects];

  if (![FPYouguUtil isExistNetwork]) {
    [self stop_setting];
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  [self down_animation];
}

//异步下载
- (void)down_animation {
  [self.progressView displayOperationWillTriggerAnimation];
  double delayInSeconds = self.progressView.stateChangeAnimationDuration;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
    if (self.isStopping == YES) {
      if ([self.delegate respondsToSelector:@selector(Midway_poisoning_Download)] == YES) {
        [self.delegate Midway_poisoning_Download];
      }
      self.progressView.hidden = YES;
      return;
    }
    [self down_today_data:self.userChannleId];
  });
}

#pragma mark - 离线下载
///******************************************************************************
// 函数名称 :-(void)down_today_data:(NSString *)channlid_id andbutton:(UIButton
// *)sender
// 函数描述 :离线下载
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************
#pragma mark -  离线下载
- (void)down_today_data:(NSString *)channlid {
  __weak LabelOfflineDownload *weakObj = self;
  HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
  callBack.onCheckQuitOrStopProgressBar = ^{
    LabelOfflineDownload *strongObj = weakObj;
    if (strongObj) {
      if (self.isStopping == YES) {
        if ([self.delegate respondsToSelector:@selector(Midway_poisoning_Download)] == YES) {
          [self.delegate Midway_poisoning_Download];
        }
        self.progressView.hidden = YES;
      }
      return NO;
    } else {
      return YES;
    }
  };
  callBack.onSuccess = ^(NSObject *obj) {
    WifiOffDownload *object = (WifiOffDownload *)obj;
    for (NewsInChannelItem *item in object.array) {

      if (item && item.newsID.length > 0) {
        if ([item.wzlx intValue] == 0) {
          NewsWithItem *newsItem = [[NewsWithItem alloc] initWithNewsId:item.newsID andType:1];
          BOOL isExist = [[NewsArrayWithALLNewsId sharedManager] isReadNewsWithID:newsItem];
          if (!isExist) {
            [self downLoadNewsContextWithID:item.newsID AndChannlID:channlid];
          } else {
            self.progressView.progress = self.progressView.progress + 0.05;
            [self updateProgress];
          }
        } else {
          self.progressView.progress = self.progressView.progress + 0.05;
          [self updateProgress];
        }
      }
    }
  };
  callBack.onError = ^(BaseRequestObject *err, NSException *ex) {
    [self stop_setting];
  };
  callBack.onFailed = ^{
    [self stop_setting];
  };
  [WifiOffDownload getWifiOffDownloadWithChannlid:channlid andStartnum:0 withCallback:callBack];
}

//下载文章正文
- (void)downLoadNewsContextWithID:(NSString *)newsID AndChannlID:(NSString *)channlID {
  __weak LabelOfflineDownload *weakObj = self;
  HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
  callBack.onCheckQuitOrStopProgressBar = ^{
    LabelOfflineDownload *strongObj = weakObj;
    if (strongObj) {
      if (self.isStopping == YES) {
        if ([self.delegate respondsToSelector:@selector(Midway_poisoning_Download)] == YES) {
          [self.delegate Midway_poisoning_Download];
        }
        self.progressView.hidden = YES;
      }
      self.progressView.progress = self.progressView.progress + 0.05;
      [self updateProgress];
      return NO;
    } else {
      return YES;
    }
  };
  callBack.onSuccess = ^(NSObject *obj) {
    NewsDetailRequest *object = (NewsDetailRequest *)obj;
    ///保存新闻
    [FileChangelUtil saveNewsDetailInfo:object andNewId:newsID];
  };
  [NewsDetailRequest getNewsDetailWithChannlid:channlID AndNewsid:newsID withCallback:callBack];
}

//暂停，设置
- (void)stop_setting {
  btn_stop.hidden = NO;

  [self.progressView displayOperationDidFinishAnimation];
  double delayInSeconds = self.progressView.stateChangeAnimationDuration;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
    self.progressView.progress = 0.0f;
    self.progressView.hidden = YES;

  });
}

//暂停时，再点击
- (void)stop_to_play:(UIButton *)sender {
  btn_stop.hidden = YES;

  if ([self.delegate respondsToSelector:@selector(USerPicBtnClick)]) {
    [self.delegate USerPicBtnClick];
  }
}

#pragma mark - 一个动画，结束以后
///******************************************************************************
// 函数名称 :- (void)updateProgress
// 函数描述 :一个动画，结束以后
// 输入参数 : 无
// 输出参数 : N/A
// 返回参数 : (void)
// 备注信息 :
// ******************************************************************************
#pragma mark -  一个动画，结束以后
- (void)updateProgress {
  if (self.isStopping == YES) {
    if ([self.delegate respondsToSelector:@selector(Midway_poisoning_Download)] == YES) {
      [self.delegate Midway_poisoning_Download];
    }
    self.progressView.hidden = YES;
    return;
  }

  _img_label.text = [NSString stringWithFormat:@"%0.0f%%", self.progressView.progress * 100];
  if (self.progressView.progress >= 1.0f) {
    //        _progressView.progress = 0.;
    if ([self.delegate respondsToSelector:@selector(The_download_is_complete)] == YES) {
      [self.delegate The_download_is_complete];
    }

    self.statue = finishedDownload;

    btn_stop.hidden = YES;
    [self.progressView displayOperationDidFinishAnimation];
    double delayInSeconds = self.progressView.stateChangeAnimationDuration;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
      self.progressView.progress = 0.;
      self.progressView.hidden = YES;
    });
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
  self.progressView.overlayColor = [UIColor colorWithRed:0. green:0. blue:0. alpha:0.5];
}
@end
