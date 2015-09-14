//
//  FinacingShopHeadView.m
//  优顾理财
//
//  Created by Mac on 15-3-31.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPFinacingShopHeadView.h"
#import "UIButton+CustomButton.h"

#import "FPSearchFundViewController.h"
#import "FPCommunicationCenterViewController.h"
#import "FPOpenAccountInfo.h"
#import "FPMyOptionalFundVController.h"
#import "UIButton+Block.h"
#import "FPCountCenterVC.h"

#define shrinkHeight 90.0f
#define unfoldHeight 250.0f

#define shrinkBtnBGViewOrignY 70.0f
#define unfoldBtnBGViewOrignY 232.0f

#define unfoldViewHeight 268.0f
#define moveMaxValue 40.0f
/** 低收益 */
#define lowGainsStatus 1
/** 中等收益 */
#define midGainsStatus 2
/** 高收益 */
#define highGainsStatus 3
/** 产品标题label移动距离 */
#define animationLeft 1
#define animationRight 2
#define productLabelTranlateWidth 170.0f

@implementation FPFinacingShopHeadView {

  /**  记录按钮的点击状态*/
  BOOL isSelected;
}
/** xib加载完成时刷新控件 */
- (void)awakeFromNib {
  [self createUnchangeView];
  [self createUnfoldView];
  [self createShrinkView];
  [self createWaveAnimation];
  [self createSearchView];
  if (![[NSUserDefaults standardUserDefaults] boolForKey:@"FirstIntoFundPage"]) {
    [self createNotification];
  }
  isSelected = NO;
}
/** 检测self位置 */
- (void)setCenter:(CGPoint)center {
  [super setCenter:center];
  if (self.frame.origin.y < -163.0f) {
    return;
  }
  currentAlpha = ABS((ABS(self.frame.origin.y) - 163.0f) / 163.0f);
  _stretchButton.transform =
      CGAffineTransformRotate(originRotation, (-self.frame.origin.y - 163.0f) / 163.0f * M_PI);
  _shrinkBgView.hidden = NO;
  _shrinkInterBGView.hidden = NO;
  _shrinkBgView.alpha = 1.0f - currentAlpha;
  _shrinkInterBGView.alpha = 1.0f - currentAlpha;
  _unfoldBgView.hidden = NO;
  _unfoldBgView.alpha = currentAlpha;
}
/** 创建搜索控件 */
- (void)createSearchView {
  //搜索控件
  UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(2.0f, 5.0f, 102.0f, 24.0f)];
  grayView.backgroundColor = [Globle colorFromHexRGB:@"e7e7e2"];
  grayView.userInteractionEnabled = NO;
  [grayView.layer setMasksToBounds:YES];
  [grayView.layer setCornerRadius:12.0f];
  grayView.alpha = 0.85f;
  [_searchTextClickBtn addSubview:grayView];
  UITextField *searchTextfield = [[UITextField alloc] initWithFrame:CGRectMake(10.0f, 2.0f, 60.0f, 20.0f)];
  searchTextfield.placeholder = @"产品查询";
  searchTextfield.delegate = self;
  searchTextfield.userInteractionEnabled = NO;
  searchTextfield.returnKeyType = UIReturnKeySearch;
  searchTextfield.textAlignment = NSTextAlignmentLeft;
  searchTextfield.textColor = [Globle colorFromHexRGB:@"a8a8a8"];
  searchTextfield.font = [UIFont systemFontOfSize:12.0f];
  searchTextfield.backgroundColor = [UIColor clearColor];
  [grayView addSubview:searchTextfield];
  UIImageView *searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(75.0f, 4.0f, 16.0f, 16.0f)];
  searchImageView.image = [UIImage imageNamed:@"搜索图标"];
  [grayView addSubview:searchImageView];
}
/** 创建不变模块 */
- (void)createUnchangeView {
  //背景图
  UIImage *bgImage = [UIImage imageNamed:@"下拉背景"];
  bgImage = [bgImage resizableImageWithCapInsets:UIEdgeInsetsMake(2.0f, 160.0f, 20.0f, 160.0f)];
  [_fShopBGImageView setImage:bgImage];
  //伸缩按钮背景
  [_stretchBgView.layer setMasksToBounds:YES];
  [_stretchBgView.layer setCornerRadius:18.0f];
  //伸缩按钮
  [_stretchButton.layer setMasksToBounds:YES];
  [_stretchButton.layer setCornerRadius:16.0f];

  [_stretchImageView.layer setMasksToBounds:YES];
  [_stretchImageView.layer setCornerRadius:16.0f];
  UIImage *stretchImage = [UIImage imageNamed:@"左小箭头"];
  [_stretchButton setImage:stretchImage forState:UIControlStateNormal];
  //防重点击
  __weak FPFinacingShopHeadView *weakSelf = self;
  ButtonPressed buttonPressed = ^{
    FPFinacingShopHeadView *strongSelf = weakSelf;
    if (strongSelf) {
      [strongSelf stretchHeadView:_stretchButton];
    }
  };
  [_stretchButton setOnButtonPressedHandler:buttonPressed];

  _stretchButton.contentMode = UIViewContentModeScaleAspectFill;
  _stretchButton.clipsToBounds = YES;
  originRotation = CGAffineTransformMakeRotation(M_PI / 2.0f);
  _stretchButton.transform = originRotation;
  //初始状态
  self.frame = CGRectMake(0, -163.0f, self.frame.size.width, unfoldViewHeight);
  tempBtnIndex = midGainsStatus;
}
/** 创建消息通知 */
- (void)createNotification {
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(headStretch)
                                               name:@"stretchHeadView"
                                             object:nil];
  [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FirstIntoFundPage"];
  [[NSUserDefaults standardUserDefaults] synchronize];
  if (self.frame.origin.y < 0) {
    [self stretchHeadView:_stretchButton];
  }
}
/** 创建收缩视图模块 */
- (void)createShrinkView {
  //低按钮
  [_lowButton.layer setMasksToBounds:YES];
  [_lowButton.layer setCornerRadius:21.0f];
  [_lowButton.layer setBorderWidth:2.0f];
  [_lowButton.layer setBorderColor:[UIColor whiteColor].CGColor];
  [_lowButton setButtonHighlightStateWithTitleColor:@"ffffff"];
  [_highButton.layer setMasksToBounds:YES];
  [_highButton.layer setCornerRadius:21.0f];
  [_highButton.layer setBorderWidth:2.0f];
  [_highButton.layer setBorderColor:[UIColor whiteColor].CGColor];
  [_highButton setButtonHighlightStateWithTitleColor:@"ffffff"];

  [_shrinkBGImageView.layer setCornerRadius:85.0f];

  [_shrinkBGView.layer setMasksToBounds:YES];
  [_shrinkBGView.layer setCornerRadius:90.0f];

  [_shrinkInterBGView.layer setMasksToBounds:YES];
  [_shrinkInterBGView.layer setCornerRadius:85.0f];
  _shrinkInterBGView.hidden = NO;
}
/** 创建展开视图模块 */
- (void)createUnfoldView {
  //圆形背景
  [_fShopRoundView.layer setMasksToBounds:YES];
  [_fShopRoundView.layer setCornerRadius:83.0f];
  btnTitleArray = @[ @"风险评测", @"我的资产", @"账户中心", @"我的自选", @"搜索" ];
}
#pragma mark 波浪效果
/** 创建波浪效果 */
- (void)createWaveAnimation {
  _shrinkInterBGView.waveHeight = 110.0f;
}
#pragma mark - 视图拖动效果
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  //保存触摸起始点位置
  CGPoint point = [[touches anyObject] locationInView:self];
  startPoint = point;
  currentPoint = startPoint;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  _shrinkBgView.userInteractionEnabled = NO;
  _unfoldBgView.userInteractionEnabled = NO;

  CGPoint point = [[touches anyObject] locationInView:self];
  float dy = point.y - startPoint.y;

  //计算移动后的view中心点
  CGPoint newcenter = CGPointMake(self.center.x, self.center.y + dy);
  if (newcenter.y <= unfoldHeight / 2.0f && newcenter.y >= (shrinkHeight - unfoldHeight) / 2.0f) {
    //移动view
    self.center = newcenter;
  }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  _shrinkBgView.userInteractionEnabled = YES;
  _unfoldBgView.userInteractionEnabled = YES;
  //计算移动后的view中心点
  endPoint = [[touches anyObject] locationInView:self];
  NSLog(@"end y - y = %f", endPoint.y - startPoint.y);

  if (endPoint.y - startPoint.y > 3.0f) {
    [self showUnfoldView];
  } else if (endPoint.y - startPoint.y < -3.0f) {
    [self showShrinkView];
  } else if (self.frame.origin.y < shrinkHeight - unfoldHeight + 30) {
    [self showShrinkView];
  } else {
    [self showUnfoldView];
  }
}
/** 点击取消 */
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
  _shrinkBgView.userInteractionEnabled = YES;
  _unfoldBgView.userInteractionEnabled = YES;
  //计算移动后的view中心点
  endPoint = [[touches anyObject] locationInView:self];
  NSLog(@"cancel y - y = %f", endPoint.y - startPoint.y);
  if (endPoint.y - startPoint.y > 3.0f) {
    [self showUnfoldView];
  } else if (endPoint.y - startPoint.y < -3.0f) {
    [self showShrinkView];
  } else if (self.frame.origin.y < shrinkHeight - unfoldHeight + 30) {
    [self showShrinkView];
  } else {
    [self showUnfoldView];
  }
}
#pragma mark 视图收缩
/** 显示收缩图 */
- (void)showShrinkView {
  _shrinkInterBGView.hidden = NO;
  _searchTextClickBtn.hidden = NO;
  isSelected = NO;
  _shrinkBgView.hidden = NO;
  __weak FPFinacingShopHeadView *weakSelf = self;
  if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f) {
#pragma mark - 小于ios7
    [UIView animateWithDuration:0.3f
        animations:^{
          FPFinacingShopHeadView *strongSelf = weakSelf;
          if (strongSelf) {
            strongSelf.frame = CGRectMake(0, -163.0f, self.frame.size.width, unfoldViewHeight);
            _stretchButton.transform = originRotation;
            if (strongSelf.frame.origin.y >= -163.0f) {
              _unfoldBgView.alpha = 0.0f;
              _shrinkBgView.alpha = 1.0f;
            }
          }
          _stretchButton.selected = NO;
        }
        completion:^(BOOL finished) {
          if (finished) {
            //打开定时器
            [firstPageTimer setFireDate:[NSDate distantPast]];
            _stretchButton.selected = YES;
            FPFinacingShopHeadView *strongSelf = weakSelf;
            if (strongSelf) {
              [UIView animateWithDuration:0.3f
                  animations:^{
                    [strongSelf showShrinkView:NO];
                  }
                  completion:^(BOOL finished){
                  }];
            }
          }
        }];

  } else {
#pragma mark - 超过 ios7

    [UIView animateKeyframesWithDuration:0.3f
        delay:0.0f
        options:UIViewKeyframeAnimationOptionCalculationModeLinear
        animations:^{
          FPFinacingShopHeadView *strongSelf = weakSelf;
          if (strongSelf) {
            strongSelf.frame = CGRectMake(0, -163.0f, self.frame.size.width, unfoldViewHeight);
            _stretchButton.transform = originRotation;
            if (strongSelf.frame.origin.y >= -163.0f) {
              _unfoldBgView.alpha = 0.0f;
              _shrinkBgView.alpha = 1.0f;
            }
          }
          _stretchButton.selected = NO;
        }
        completion:^(BOOL finished) {
          //打开定时器
          [firstPageTimer setFireDate:[NSDate distantPast]];
          _stretchButton.selected = YES;
          FPFinacingShopHeadView *strongSelf = weakSelf;
          if (strongSelf) {
            [UIView animateWithDuration:0.3f
                animations:^{
                  [strongSelf showShrinkView:NO];
                }
                completion:^(BOOL finished){
                }];
          }
        }];
  }
}
- (void)showShrinkView:(BOOL)isHidden {
  _shrinkBgView.hidden = isHidden;
  _unfoldBgView.hidden = !isHidden;
  if (!isHidden && !isSelected) {
    _shrinkBgView.alpha = 1.0f;
    _shrinkInterBGView.alpha = 1.0f;
  }
  if (isHidden && isSelected) {
    _unfoldBgView.alpha = 1.0f;
  }
}
/** 显示展开图 */
- (void)showUnfoldView {
  _shrinkInterBGView.hidden = YES;
  isSelected = YES;
  _searchTextClickBtn.hidden = YES;
  __weak FPFinacingShopHeadView *weakSelf = self;
  /*
   UIViewKeyframeAnimationOptionCalculationModeLinear线性= 0 << 10, // default
   UIViewKeyframeAnimationOptionCalculationModeDiscrete离散   = 1 << 10,
   UIViewKeyframeAnimationOptionCalculationModePaced 缓慢     = 2 << 10,
   UIViewKeyframeAnimationOptionCalculationModeCubic 立体     = 3 << 10,
   UIViewKeyframeAnimationOptionCalculationModeCubicPaced 缓慢立体 = 4 << 10
   */

  //  [self setViewAlpha:1.0f];
  if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f) {
#pragma mark - 小于ios7
    [UIView animateWithDuration:0.3f
        animations:^{
          FPFinacingShopHeadView *strongSelf = weakSelf;
          if (strongSelf) {
            [strongSelf showShrinkView:YES];
            _stretchButton.transform = CGAffineTransformRotate(originRotation, M_PI);
            strongSelf.frame = CGRectMake(0, 0, self.frame.size.width, unfoldViewHeight);
            _unfoldBgView.alpha = 1.0f;
            _shrinkBgView.alpha = 0.0f;
          }
          _stretchButton.selected = NO;

        }
        completion:^(BOOL finished) {
          if (finished) {
            //关闭定时器
            [firstPageTimer setFireDate:[NSDate distantFuture]];
            _stretchButton.selected = YES;
          }
        }];
  } else {
#pragma mark - 大于等于ios 7
    [UIView animateKeyframesWithDuration:0.3f
        delay:0.0f
        options:UIViewKeyframeAnimationOptionCalculationModeLinear
        animations:^{
          FPFinacingShopHeadView *strongSelf = weakSelf;
          if (strongSelf) {
            [strongSelf showShrinkView:YES];
            _stretchButton.transform = CGAffineTransformRotate(originRotation, M_PI);
            strongSelf.frame = CGRectMake(0, 0, self.frame.size.width, unfoldViewHeight);
            _unfoldBgView.alpha = 1.0f;
            _shrinkBgView.alpha = 0.0f;
          }
          _stretchButton.selected = NO;
        }
        completion:^(BOOL finished) {
          if (finished) {
            //关闭定时器
            [firstPageTimer setFireDate:[NSDate distantFuture]];
            _stretchButton.selected = YES;
          }
        }];
  }
}
/** 伸展按钮 */
- (void)stretchHeadView:(UIButton *)sender {
  __weak FPFinacingShopHeadView *weakSelf = self;
  [UIView animateWithDuration:0.3f
                   animations:^{
                     FPFinacingShopHeadView *strongSelf = weakSelf;
                     if (strongSelf) {
                       if (self.frame.origin.y < 0) {
                         [strongSelf showUnfoldView];
                         //旋转180度
                         sender.transform = CGAffineTransformRotate(originRotation, M_PI);
                       } else {
                         [strongSelf showShrinkView];
                         //旋转180度
                         sender.transform = originRotation;
                       }
                     }
                   }];
}
/** 风险评测 */
- (IBAction)showRiskAssessmentPage:(id)sender {
  //  [self delayStretch];
}

- (IBAction)showMyAssetsPage:(UIButton *)sender {
  [Login_ViewController checkLoginStatusWithCallback:^(BOOL logonSuccess) {
    if (![FPYouguUtil isExistNetwork]) {
      YouGu_animation_Did_Start(networkFailed);
      return;
    }
    if (logonSuccess) {
      [[FPOpenAccountInfo shareInstance] openAccountStatusJudgementWithFromPage:OpenAccountSwitchTypeMyAssets];
    }
  }];
}

- (IBAction)showAccountCenterPage:(UIButton *)sender {
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  [Login_ViewController checkLoginStatusWithCallback:^(BOOL logonSuccess) {
    if (logonSuccess) {
      ///账户中心
      FPCountCenterVC *countVC = [[FPCountCenterVC alloc] init];
      [AppDelegate pushViewControllerFromRight:countVC];
    }
  }];
}
/** 刷新当前按钮状态 */
- (void)changeButtonStatus:(NSInteger)currentStatus {
  if (tempBtnIndex == currentStatus) {
    return;
  }
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:0.3f];
  switch (currentStatus) {
  case lowGainsStatus: {
    if (tempBtnIndex == highGainsStatus) {
      [self productLabelAnimationWithText:@"低收益产品"
                   withAnimationDirection:animationLeft
                       withMobileDistance:productLabelTranlateWidth * 2];
    } else {
      [self productLabelAnimationWithText:@"低收益产品"
                   withAnimationDirection:animationLeft
                       withMobileDistance:productLabelTranlateWidth];
    }

    [_lowButton setTitle:@"高" forState:UIControlStateNormal];
    [_highButton setTitle:@"中" forState:UIControlStateNormal];
    //水位
    _shrinkInterBGView.waveHeight = 130.0f;
    leftFrame = CGRectMake(-360.f, 130.0f, 530.0f, 40.0f);
    rightFrame = CGRectMake(0, 130.0f, 530.0f, 40.0f);
  } break;
  case midGainsStatus: {
    if (tempBtnIndex == lowGainsStatus) {
      [self productLabelAnimationWithText:@"中等收益产品"
                   withAnimationDirection:animationRight
                       withMobileDistance:productLabelTranlateWidth];
    } else {
      [self productLabelAnimationWithText:@"中等收益产品"
                   withAnimationDirection:animationLeft
                       withMobileDistance:productLabelTranlateWidth];
    }

    [_lowButton setTitle:@"低" forState:UIControlStateNormal];
    [_highButton setTitle:@"高" forState:UIControlStateNormal];
    //水位
    _shrinkInterBGView.waveHeight = 110.0f;
    leftFrame = CGRectMake(-360.f, 110.0f, 530.0f, 60.0f);
    rightFrame = CGRectMake(0, 110.0f, 530.0f, 60.0f);
  } break;
  case highGainsStatus: {
    if (tempBtnIndex == lowGainsStatus) {
      [self productLabelAnimationWithText:@"高收益产品"
                   withAnimationDirection:animationRight
                       withMobileDistance:productLabelTranlateWidth * 2];
    } else {
      [self productLabelAnimationWithText:@"高收益产品"
                   withAnimationDirection:animationRight
                       withMobileDistance:productLabelTranlateWidth];
    }

    [_lowButton setTitle:@"中" forState:UIControlStateNormal];
    [_highButton setTitle:@"低" forState:UIControlStateNormal];
    //水位
    _shrinkInterBGView.waveHeight = 90.0f;
    leftFrame = CGRectMake(-360.0f, 90.0f, 530.0f, 80.0f);
    rightFrame = CGRectMake(0, 90.0f, 530.0f, 80.0f);
  } break;
  default:
    break;
  }
  [UIView commitAnimations];
  //保存上次状态
  tempBtnIndex = currentStatus;
}
- (IBAction)showMyOptionPage:(UIButton *)sender {
  if ([SimuControl OnLoginType] == 1) {
    FPMyOptionalFundVController *myVC = [[FPMyOptionalFundVController alloc] init];
    [AppDelegate pushViewControllerFromRight:myVC];
  } else {
    [Login_ViewController checkLoginStatusWithCallback:^(BOOL logonSuccess) {
      if (logonSuccess) {
        FPMyOptionalFundVController *myVC = [[FPMyOptionalFundVController alloc] init];
        [AppDelegate pushViewControllerFromRight:myVC];
      }
    }];
  }
}
/** 产品切换动画 */
- (void)productLabelAnimationWithText:(NSString *)text
               withAnimationDirection:(NSInteger)direction
                   withMobileDistance:(float)mDistance {
  _midProductNameLabel.text = text;
  return;
  [UIView animateWithDuration:0.3f
      delay:0.0f
      options:UIViewAnimationOptionTransitionFlipFromRight
      animations:^{
        if (direction == animationLeft) {
          _lowProductNameLabel.transform =
              CGAffineTransformTranslate(_lowProductNameLabel.transform, mDistance, 0);
          _midProductNameLabel.transform =
              CGAffineTransformTranslate(_midProductNameLabel.transform, mDistance, 0);
          _highProductNameLabel.transform =
              CGAffineTransformTranslate(_highProductNameLabel.transform, mDistance, 0);

        } else {
          _lowProductNameLabel.transform =
              CGAffineTransformTranslate(_lowProductNameLabel.transform, -mDistance, 0);
          _midProductNameLabel.transform =
              CGAffineTransformTranslate(_midProductNameLabel.transform, -mDistance, 0);
          _highProductNameLabel.transform =
              CGAffineTransformTranslate(_highProductNameLabel.transform, -mDistance, 0);
        }
      }
      completion:^(BOOL finished){

      }];
}
/** 搜索 */
- (IBAction)showSearchPage:(id)sender {
  FPSearchFundViewController *sVC = [[FPSearchFundViewController alloc] init];
  [AppDelegate pushViewControllerFromRight:sVC];
}
/** 评测，搜索按钮延时收回 */
- (void)headStretch {
  if (self.frame.origin.y >= 0) {
    [self stretchHeadView:_stretchButton];
  }
}

@end
