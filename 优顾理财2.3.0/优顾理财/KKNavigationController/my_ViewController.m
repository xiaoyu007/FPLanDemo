//
//  my_ViewController.m
//  优顾理财
//
//  Created by Mac on 14-2-20.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "my_ViewController.h"

@implementation my_ViewController
@synthesize screenShotsList;
@synthesize backgroundView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController {
  self = [super initWithRootViewController:rootViewController];
  if (self) {
  }
  return self;
}

- (void)viewDidLayoutSubviews {
}

- (void)loadView {
  [super loadView];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  screenShotsList = [[NSMutableArray alloc] initWithCapacity:0];

  isMoving = NO;

  // Do any additional setup after loading the view.
}
- (void)dealloc {
  [self.screenShotsList removeAllObjects];
}

- (void)start {
  CGRect frame = self.view.bounds;
  if (!self.backgroundView) {
    //添加背景
    //        CGRect screenRect = [[UIScreen mainScreen] bounds];
    backgroundView = [[UIImageView alloc] initWithFrame:frame];
    //        backgroundView.bounds=frame;
    backgroundView.left = -windowWidth * 2 / 3;
    // backgroundView.backgroundColor=[UIColor blackColor];
    backgroundView.clipsToBounds = YES;

    //把backgroundView插入到Window视图上，并below低于self.view层
    [self.view.superview insertSubview:self.backgroundView belowSubview:self.view];

    //在backgroundView添加黑色的面罩
    blackMask = [[UIView alloc] initWithFrame:frame];
    blackMask.backgroundColor = [UIColor blackColor];
    [self.backgroundView addSubview:blackMask];
  } else {
    backgroundView.frame = frame;
    blackMask.frame = frame;
  }

  self.backgroundView.hidden = NO;

  UIViewController *tt =
      (UIViewController *)[self.viewControllers objectAtIndex:[self.viewControllers count] - 2];
  [tt.view setNeedsDisplay];
  backgroundView.image = [self getImageFromView:tt.view];
}

//拖动手势
- (void)handlePanGesture:(UIGestureRecognizer *)sender {
  //如果是顶级viewcontroller，结束
  if (self.viewControllers.count <= 1)
    return;

  //得到触摸中在window上拖动的过程中的xy坐标
  CGPoint translation = [sender locationInView:WINDOW];
  //状态结束，保存数据
  if (sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateCancelled) {
    isMoving = NO;

    self.backgroundView.hidden = NO;
    //如果结束坐标大于开始坐标50像素就动画效果移动
    if (translation.x - startTouch.x > 50) {
      [UIView animateWithDuration:0.3
          animations:^{
            //动画效果，移动
            [self moveViewWithX:320];
          }
          completion:^(BOOL finished) {
            //返回上一层
            [self popViewControllerAnimated:NO];
            //并且还原坐标
            CGRect frame = self.view.frame;
            frame.origin.x = 0;
            self.view.frame = frame;
          }];

    } else {
      //不大于50时就移动原位
      [UIView animateWithDuration:0.3
          animations:^{
            //动画效果
            [self moveViewWithX:0];
          }
          completion:^(BOOL finished) {
            //背景隐藏

            self.backgroundView.hidden = YES;
          }];
    }
    return;

  } else if (sender.state == UIGestureRecognizerStateBegan) {
    self.navigationBarHidden = YES;
    //开始坐标
    startTouch = translation;
    //是否开始移动
    isMoving = YES;

    [self start];

    backgroundView.frame = self.view.bounds;
    backgroundView.bottom = self.view.bottom;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
      backgroundView.frame = CGRectMake(0, 20, 320, backgroundView.frame.size.height - 20);
    }
  }

  if (isMoving) {
    [self moveViewWithX:translation.x - startTouch.x];
  }
}

- (void)moveViewWithX:(float)x {
  x = x > 320 ? 320 : x;
  x = x < 0 ? 0 : x;

  CGRect frame = self.view.frame;
  frame.origin.x = x;
  self.view.frame = frame;

  float alpha = 0.1 - (x / 800); //透明值

  self.backgroundView.left = -320 * 2 / 3 + x * 2 / 3;

  //背景颜色透明值
  blackMask.alpha = alpha;
}

- (UIImage *)getImageFromView:(UIView *)orgView {
  [orgView setNeedsDisplay];

  //    UIGraphicsBeginImageContext(orgView.bounds.size);
  UIGraphicsBeginImageContextWithOptions(orgView.bounds.size, NO, 0.0);
  [orgView.layer renderInContext:UIGraphicsGetCurrentContext()];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();

  return image;
}

#pragma UINavigationController 覆盖方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
  if ([FPYouguUtil getPushAnimtion]) {
    //    单个视图，加手势
    if ([self.viewControllers count] >= 1) {
      //拖动手势
      UIPanGestureRecognizer *panGesture =
          [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
      //添加手势
      [viewController.view addGestureRecognizer:panGesture];
      panGesture.maximumNumberOfTouches = 1;
    }
  }else{[FPYouguUtil isPushAnimtion:YES];}
  [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
  //移除最后一个
  //    [screenShotsList removeLastObject];
  [FPYouguUtil isPushAnimtion:YES];
  return [super popViewControllerAnimated:animated];
}

@end
