//
//  FPFundDetailWebVC.m
//  优顾理财
//
//  Created by Mac on 15/7/13.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPFundDetailWebVC.h"
#import "FPOpenAccountInfo.h"

@implementation FPFundDetailWebVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    //底部按钮存在按下态延时问题
    for (UIView *currentView in _bottomBgView.subviews) {
      if ([currentView isKindOfClass:[UIScrollView class]]) {
        ((UIScrollView *)currentView).delaysContentTouches = NO;
        ((UIScrollView *)currentView).canCancelContentTouches = NO;
        break;
      }
    }
  }
  return self;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  //按下态
  UIImage *highLightImage = [FPYouguUtil createImageWithColor:buttonHighLightColor];
  [_buyFundButton setBackgroundImage:highLightImage forState:UIControlStateHighlighted];
  [_redeemFundButton setBackgroundImage:highLightImage forState:UIControlStateHighlighted];
  [_optionalFundButton setBackgroundImage:highLightImage forState:UIControlStateHighlighted];

  _fundDetailScrView.delegate = self;
  _fundDetailScrView.contentSize = CGSizeMake(windowWidth * 4, _fundDetailScrView.height);
  _bottomCuttingLine.height = 0.5f;
  _bottomCuttingLine.transform = CGAffineTransformMakeScale(1.0f, 0.5f);
  [_topCuttingLine.layer setMasksToBounds:YES];
  [_topCuttingLine.layer setCornerRadius:1.5f];
}
- (IBAction)fundTrendButtonClicked:(id)sender {
  [self topCuttingLineAnimationWithIndex:0 withButton:sender];
}
- (IBAction)fundProfileButtonClicked:(id)sender {
  [self topCuttingLineAnimationWithIndex:1 withButton:sender];
}
- (IBAction)fundManagerButtonClicked:(id)sender {
  [self topCuttingLineAnimationWithIndex:2 withButton:sender];
}
- (IBAction)fundRatingButtonClicked:(id)sender {
  [self topCuttingLineAnimationWithIndex:3 withButton:sender];
}
- (void)resetTopButtonTitleColor {
  [_fundTrendButton setTitleColor:[Globle colorFromHexRGB:@"84929e"] forState:UIControlStateNormal];
  [_fundProfileButton setTitleColor:[Globle colorFromHexRGB:@"84929e"]
                           forState:UIControlStateNormal];
  [_fundManagerButton setTitleColor:[Globle colorFromHexRGB:@"84929e"]
                           forState:UIControlStateNormal];
  [_fundRatingButton setTitleColor:[Globle colorFromHexRGB:@"84929e"]
                          forState:UIControlStateNormal];
}
- (void)topCuttingLineAnimationWithIndex:(NSInteger)index withButton:(UIButton *)button {
  [UIView animateWithDuration:0.3
      animations:^{
        [_fundDetailScrView setContentOffset:CGPointMake(windowWidth * index, 0)];
      }
      completion:^(BOOL finished) {
        [self resetTopButtonTitleColor];
        [button setTitleColor:[Globle colorFromHexRGB:customFilledColor]
                     forState:UIControlStateNormal];
      }];
}
/** 切换到费率一栏 */
- (void)switchToFeeRate {
  [_fundDetailScrView setContentOffset:CGPointMake(windowWidth * 3.0f, 0)];
  [self resetTopButtonTitleColor];
  [_fundRatingButton setTitleColor:[Globle colorFromHexRGB:customFilledColor]
                          forState:UIControlStateNormal];
}
- (IBAction)buyFundButtonClicked:(id)sender {
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  [Login_ViewController checkLoginStatusWithCallback:^(BOOL logonSuccess) {
    if (logonSuccess) {
      if ([SimuControl OnLoginType] == 1) {
        [[FPOpenAccountInfo shareInstance] openAccountStatusJudgementWithFromPage:YouGu_User_USerid
                                                                 andCurrentFundId:_currentFundId];
      }
    }
  }];
}

- (IBAction)redeemButtonClicked:(id)sender {
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  [Login_ViewController checkLoginStatusWithCallback:^(BOOL logonSuccess) {
    if (logonSuccess) {
      if ([SimuControl OnLoginType] == 1) {
        [[FPOpenAccountInfo shareInstance] openAccountStatusJudgementWithFromRedeem:YouGu_User_USerid
                                                                   andCurrentFundId:_currentFundId
                                                                     andTradeaccoId:@""
                                                                       withCallBack:^(BOOL isSuccess) {
                                                                         //赎回成功
                                                                         if (isSuccess) {
                                                                         }
                                                                       }];
      }
    }
  }];
}

- (IBAction)optionalButtonClicked:(id)sender {
}
#pragma mark - 滚动视图
//分页控制
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  //获得页码
  CGFloat page = scrollView.contentOffset.x / scrollView.frame.size.width;
  for (UIView *view in _topBgView.subviews) {
    if ([view isKindOfClass:[UIButton class]]) {
      UIButton *btn = (UIButton *)[_topBgView viewWithTag:200 + page];
      [self topCuttingLineAnimationWithIndex:page withButton:btn];
    }
  }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  //标签动态
  if (scrollView == _fundDetailScrView) {
    _topCuttingLine.frame = CGRectMake(scrollView.contentOffset.x / 4.0f + 10, 38, windowWidth / 4 - 20, 2);
  }
}

@end
