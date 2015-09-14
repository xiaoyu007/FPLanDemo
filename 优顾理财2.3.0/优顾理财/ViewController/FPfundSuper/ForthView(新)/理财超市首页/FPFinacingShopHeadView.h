//
//  FinacingShopHeadView.h
//  优顾理财
//
//  Created by Mac on 15-3-31.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaterWaveView.h"

/** 基金头视图 */
@interface FPFinacingShopHeadView : UIView <UIGestureRecognizerDelegate, UITextFieldDelegate> {
  /** 动态图图片数组 */
  NSMutableArray *imageArray;
  /** 5大按钮数组 */
  NSArray *btnTitleArray;
  /** 产品所处位置 */
  NSInteger tempBtnIndex;
  /** 低收益列表 */
  NSMutableArray *lowGainArray;
  /** 中收益列表 */
  NSMutableArray *middleGainArray;
  /** 高收益列表 */
  NSMutableArray *highGainArray;
  /** 定时器 */
  NSTimer *firstPageTimer;
  __block CGRect leftFrame;
  __block CGRect rightFrame;
  int step;
  int allStep;
  /** 移动上限 */
  CGPoint moveMinCenter;
  /** 移动下限 */
  CGPoint moveMaxCenter;
  /** 平移开始位置 */
  CGPoint startPoint;
  /** 平移结束位置 */
  CGPoint endPoint;
  /** 当前位置 */
  CGPoint currentPoint;
  /** 获取当前透明度 */
  float currentAlpha;
  /** 低中高收益button数组 */
  NSArray *buttonArr;
  /** 展示收益等级label数组 */
  NSArray *showArr;
  /** 原始弧度 */
  CGAffineTransform originRotation;
}
/** 父类视图 */
@property(nonatomic, strong) UIView *parentView;

@property (weak, nonatomic) IBOutlet UIView *shrinkBgView;
@property (weak, nonatomic) IBOutlet UIView *unfoldBgView;


#pragma mark - 展开是ui
/** 理财超市头视图背景 */
@property(weak, nonatomic) IBOutlet UIImageView *fShopBGImageView;
/** 理财icon背景圆 */
@property(weak, nonatomic) IBOutlet UIView *fShopRoundView;
/** 理财icon */
@property(weak, nonatomic) IBOutlet UIImageView *fShopIconImageView;
/** 风险评测按钮 */
@property(weak, nonatomic) IBOutlet UIButton *riskAssessmentBtn;
@property(weak, nonatomic) IBOutlet UILabel *riskAssessmentLabel;

/** 我的资产按钮 */
@property(weak, nonatomic) IBOutlet UIButton *myAssetsBtn;
@property(weak, nonatomic) IBOutlet UILabel *myAssetsLabel;

/** 中等收益产品按钮 */
@property(weak, nonatomic) IBOutlet UIButton *accountCenterBtn;
@property(weak, nonatomic) IBOutlet UILabel *accountCenterLabel;

/** 我的自选按钮 */
@property(weak, nonatomic) IBOutlet UIButton *myOptionBtn;
@property(weak, nonatomic) IBOutlet UILabel *myOptionLabel;

/** 搜索按钮 */
@property(weak, nonatomic) IBOutlet UIButton *searchBtn;
@property(weak, nonatomic) IBOutlet UILabel *searchLabel;

/** 伸展按钮背景view */
@property(weak, nonatomic) IBOutlet UIView *stretchBgView;
/** 伸展按钮 */
@property(weak, nonatomic) IBOutlet UIButton *stretchButton;
/** 伸缩箭头 */
@property(weak, nonatomic) IBOutlet UIImageView *stretchImageView;

#pragma mark - 收缩时ui
/** 低切换按钮 */
@property(weak, nonatomic) IBOutlet UIButton *lowButton;
/** 高切换按钮 */
@property(weak, nonatomic) IBOutlet UIButton *highButton;
/** 左箭头 */
@property(weak, nonatomic) IBOutlet UIImageView *leftArrowImageView;
/** 右箭头 */
@property(weak, nonatomic) IBOutlet UIImageView *rightArrowImageView;
/** 内收缩背景view */
@property(weak, nonatomic) IBOutlet WaterWaveView *shrinkInterBGView;

/** 收缩背景view */
@property(weak, nonatomic) IBOutlet UIView *shrinkBGView;
/** 动态图 */
@property(weak, nonatomic) IBOutlet UIImageView *shrinkBGImageView;
/** 中收益label */
@property(weak, nonatomic) IBOutlet UILabel *midProductNameLabel;
/** 低收益label */
@property(weak, nonatomic) IBOutlet UILabel *lowProductNameLabel;
/** 高收益label */
@property(weak, nonatomic) IBOutlet UILabel *highProductNameLabel;
/** 搜索框相应按钮 */
@property(weak, nonatomic) IBOutlet UIButton *searchTextClickBtn;
/** 父view */
@property(strong, nonatomic) UIView *superView;
/** 伸展按钮 */
- (void)stretchHeadView:(UIButton *)sender;
/** 评测，搜索按钮延时收回 */
- (void)headStretch;
/** 我的资产 */
- (IBAction)showMyAssetsPage:(UIButton *)sender;
/** 账户中心 */
- (IBAction)showAccountCenterPage:(UIButton *)sender;
/** 我的自选 */
- (IBAction)showMyOptionPage:(UIButton *)sender;
/** 搜索 */
- (IBAction)showSearchPage:(id)sender;

/** 产品类型切换 */
- (void)changeButtonStatus:(NSInteger)currentStatus;

@end
