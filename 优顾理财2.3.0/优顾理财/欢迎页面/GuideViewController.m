//
//  ViewController.m
//  CircleDemo
//
//  Created by Mac on 15/6/17.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "GuideViewController.h"

#define earthRadius 270.0f

@implementation GuideViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [[UIApplication sharedApplication] setStatusBarHidden:YES];
  _guideScrollow = [[UIScrollView alloc] initWithFrame:self.view.bounds];
  _guideScrollow.delegate = self;
  _guideScrollow.pagingEnabled = YES;
  _guideScrollow.contentSize = CGSizeMake(windowWidth * 4, windowHeight);
  _guideScrollow.bounces = NO;
  [self.view addSubview:_guideScrollow];
  /** 地球 */
  trans = CGAffineTransformMakeRotation(0.0f);
  UIImage *earthImage = [UIImage imageNamed:@"引导页地球"];
  earthImageView = [[UIImageView alloc]
      initWithFrame:CGRectMake(-earthImage.size.width / 2.0f + self.view.frame.size.width / 2.0f,
                               self.view.frame.size.height - 188.0f, earthImage.size.width, earthImage.size.height)];
  earthImageView.image = earthImage;
  [self.view addSubview:earthImageView];
  [self createButton];
  for (int st = 0; st < 4; st++) { //背景图
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(windowWidth * st, 0, windowWidth, windowHeight);
    bgView.userInteractionEnabled = YES;
    [_guideScrollow addSubview:bgView];
    //标题
    UIImageView *titleImageView =
        [[UIImageView alloc] initWithFrame:CGRectMake((windowWidth - 258) / 2.0 + windowWidth * st, 45, 258, 58)];
    [_guideScrollow addSubview:titleImageView];
    switch (st) {
    case 0: {
      [self createGradientLayerWithTarget:bgView WithStColor:@"344e7e" withEndColor:@"3d3a71"];
      titleImageView.image = [UIImage imageNamed:@"引导页标题_1"];
    } break;
    case 1: {
      [self createGradientLayerWithTarget:bgView WithStColor:@"3d3a71" withEndColor:@"56327e"];
      titleImageView.image = [UIImage imageNamed:@"引导页标题_2"];
    } break;
    case 2: {
      [self createGradientLayerWithTarget:bgView WithStColor:@"56327e" withEndColor:@"8b2f5b"];
      titleImageView.image = [UIImage imageNamed:@"引导页标题_3"];
    } break;
    case 3: {
      bgView.layer.backgroundColor = [Globle colorFromHexRGB:@"8b2f5b"].CGColor;
      titleImageView.image = [UIImage imageNamed:@"引导页标题_4"];
    } break;
    default:
      break;
    }
  }
  //人物
  [self createPersonViewWithImageName:@"引导页第一页立体图"
                            withAngle:0.0f
                             withRect:CGRectMake(-earthImageView.frame.origin.x, -earthImageView.frame.origin.y, windowWidth, windowHeight)];
  [self createPersonViewWithImageName:@"引导页人物_1"
                            withAngle:0.0f
                             withRect:CGRectMake(-earthImageView.frame.origin.x, -earthImageView.frame.origin.y, windowWidth, windowHeight)];
  [self createPersonViewWithImageName:@"引导页人物_2"
                            withAngle:M_PI / 2.0f
                             withRect:CGRectMake(earthRadius * 2.0f - 188.0f, earthRadius - windowWidth / 2.0f, windowHeight, windowWidth)];
  [self createPersonViewWithImageName:@"引导页人物_3"
                            withAngle:M_PI
                             withRect:CGRectMake(earthRadius - windowWidth / 2.0f, earthRadius * 2.0f - 188.0f, windowWidth, windowHeight)];
  [self createPersonViewWithImageName:@"引导页人物_4"
                            withAngle:3 / 2.0f * M_PI
                             withRect:CGRectMake(188.0f - windowHeight, earthRadius - windowWidth / 2.0f, windowHeight, windowWidth)];
}
- (void)createButton {
  //评测按钮
  evaluateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  evaluateBtn.frame = CGRectMake((windowWidth - 175.0f) / 2.0f, windowHeight - 130.0f, 175.0f, 46);
  [evaluateBtn setTitle:@"马上评测" forState:UIControlStateNormal];
  [evaluateBtn.layer setBorderWidth:0.5f];
  [evaluateBtn.layer setBorderColor:[Globle colorFromHexRGB:@"f7a300" withAlpha:0.5f].CGColor];
  [evaluateBtn setBackgroundColor:[Globle colorFromHexRGB:@"f7a300"]];
  evaluateBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
  [evaluateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [evaluateBtn.layer setMasksToBounds:YES];
  [evaluateBtn.layer setCornerRadius:23.0f];
  evaluateBtn.alpha = 0.95;
  [evaluateBtn addTarget:self
                  action:@selector(evaluateBtnClicked:)
        forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:evaluateBtn];
  //看看再说
  notEvaluateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  notEvaluateBtn.frame = CGRectMake((windowWidth - 175.0f) / 2.0f, windowHeight - 74.0f, 175.0f, 46);
  [notEvaluateBtn setTitle:@"看看再说" forState:UIControlStateNormal];
  [notEvaluateBtn.layer setBorderWidth:0.5f];
  [notEvaluateBtn.layer setBorderColor:[Globle colorFromHexRGB:@"ffffff" withAlpha:0.5f].CGColor];
  [notEvaluateBtn setBackgroundColor:[Globle colorFromHexRGB:@"ffffff"]];
  notEvaluateBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
  [notEvaluateBtn setTitleColor:[Globle colorFromHexRGB:@"37a6c1"] forState:UIControlStateNormal];
  [notEvaluateBtn.layer setMasksToBounds:YES];
  [notEvaluateBtn.layer setCornerRadius:23.0f];
  notEvaluateBtn.alpha = 0.95;
  [notEvaluateBtn addTarget:self
                     action:@selector(notEvaluateBtnClicked:)
           forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:notEvaluateBtn];
  evaluateBtn.hidden = YES;
  notEvaluateBtn.hidden = YES;
}
/** 评测按钮点击 */
- (void)evaluateBtnClicked:(UIButton *)sender {
  [[NSNotificationCenter defaultCenter] postNotificationName:@"guidePageRiskBtnClicked" object:nil];
  [self releaseCurrentPage];
}
- (void)releaseCurrentPage {
  self.view.userInteractionEnabled = NO;
  [UIView animateKeyframesWithDuration:0.3f
      delay:0.0f
      options:UIViewKeyframeAnimationOptionLayoutSubviews
      animations:^{
        self.view.alpha = 0.0f;
      }
      completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
      }];
}
/** 看看再说按钮点击 */
- (void)notEvaluateBtnClicked:(UIButton *)sender {
  self.view.userInteractionEnabled = NO;
  [self releaseCurrentPage];
}
/** 创建渐变视图 */
- (void)createGradientLayerWithTarget:(UIView *)target
                          WithStColor:(NSString *)stColor
                         withEndColor:(NSString *)endColor {
  target.layer.backgroundColor = [Globle colorFromHexRGB:stColor].CGColor;
  //初始化渐变层
  CAGradientLayer *gradientLayer = [CAGradientLayer layer];
  gradientLayer.frame = target.bounds;
  [target.layer addSublayer:gradientLayer];
  //设置渐变颜色方向
  gradientLayer.startPoint = CGPointMake(0.0, 0.5);
  gradientLayer.endPoint = CGPointMake(1, 0.5);
  //设定颜色组
  gradientLayer.colors = @[
    (__bridge id)[Globle colorFromHexRGB:stColor]
        .CGColor,
    (__bridge id)[Globle colorFromHexRGB:endColor].CGColor
  ];
  [target.layer addSublayer:gradientLayer];
}
/** 创建人物动作 */
- (void)createPersonViewWithImageName:(NSString *)imageName
                            withAngle:(CGFloat)angle
                             withRect:(CGRect)frame {
  UIImage *personImage = [UIImage imageNamed:imageName];
  UIImageView *imageView = [[UIImageView alloc] initWithImage:personImage];
  [earthImageView addSubview:imageView];
  //人物坐标
  CGFloat person_x = windowWidth - personImage.size.width;
  //越界情况
  if (person_x < 0) {
    person_x = 0;
  }
  imageView.frame = CGRectMake(person_x, -earthImageView.frame.origin.y, windowWidth, windowHeight);
  imageView.transform = CGAffineTransformRotate(trans, angle);
  //最终位置
  imageView.frame = frame;
}
#pragma mark - scrollowDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  CGFloat angle = (scrollView.contentOffset.x / windowWidth) * M_PI / 2.0f;
  earthImageView.transform = CGAffineTransformRotate(trans, -angle);
  if (scrollView.contentOffset.x == windowWidth * 3) {
    evaluateBtn.hidden = NO;
    notEvaluateBtn.hidden = NO;
  } else {
    evaluateBtn.hidden = YES;
    notEvaluateBtn.hidden = YES;
  }
}

@end
