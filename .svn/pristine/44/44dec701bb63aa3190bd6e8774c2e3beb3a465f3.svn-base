//
//  FPKnowViewController.m
//  优顾理财
//
//  Created by Mac on 15/6/29.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPKnowViewController.h"
//#import "KnowFirstListViewController.h"
#import "KnowFirstTableViewController.h"
#import "Lineview.h"

static const CGFloat kHeightOfTopScrollView = 50.0f;
static const CGFloat kFontSizeOfTabButton = 20.0f;

@implementation FPKnowViewController
- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {

  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self start:self.rectFrame];
  // Do any additional setup after loading the view from its nib.
  self.loading.hidden = YES;
//  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeBtnType) name:@"changeBtnType" object:nil];
  
}
//-(void)changeBtnType{
//
//  summit_btn.hidden = NO;
//  //注意：使用完通知后，立即将观察者注销
//  [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
- (void)start:(CGRect)frame {
  //创建顶部可滑动的tab
  _topScrollView = [[UIView alloc]
      initWithFrame:CGRectMake(0, 0, windowWidth, kHeightOfTopScrollView)];
  [self.childView addSubview:_topScrollView];
  _userSelectedChannelID = 100;

  //滑动线
  Lineview *lineView =
      [[Lineview alloc] initWithFrame:CGRectMake(0, 49, windowWidth, 1)];
  lineView.backgroundColor = [Globle colorFromHexRGB:customGrayCuttingLine];
  [_topScrollView addSubview:lineView];

  //创建主滚动视图
  _rootScrollView = [[UIScrollView alloc]
      initWithFrame:CGRectMake(0, kHeightOfTopScrollView, self.childView.width,
                               frame.size.height - kHeightOfTopScrollView)];
  _rootScrollView.delegate = self;
  _rootScrollView.pagingEnabled = YES;
  _rootScrollView.userInteractionEnabled = YES;
  _rootScrollView.bounces = NO;
  _rootScrollView.showsHorizontalScrollIndicator = NO;
  _rootScrollView.showsVerticalScrollIndicator = NO;
  [self.childView addSubview:_rootScrollView];

  [self createNameButtons];
  [self addQuestionBtn];
}
#pragma mark - 提问按钮
- (void)addQuestionBtn {
  //添加了一个提交问题，按钮
  summit_btn =
      [[MyQuestionView alloc] initWithFrame:CGRectMake(242, 200, 60, 60)
                                 andArray_1:@"发布图标_白天.png"
                                 andArray_2:@"提问"];
  summit_btn.layer.cornerRadius = 30;
  summit_btn.clipsToBounds = YES;
  summit_btn.bottom = self.view.bottom - 40;
  [summit_btn addTarget:self action:@selector(summit_btn_Click:)];
  [self.view addSubview:summit_btn];

  summit_btn.backgroundColor =
      [Globle colorFromHexRGB:@"4a4f51" withAlpha:0.85];
  summit_btn.NormalbackgroundColor =
      [Globle colorFromHexRGB:@"4a4f51" withAlpha:0.85];
  summit_btn.highlightedColor = [Globle colorFromHexRGB:COLOR_DARK_BLUE];
  summit_btn.img_View.image = [UIImage imageNamed:@"发布图标_白天.png"];
  summit_btn.lable.textColor = [UIColor whiteColor];
}

#pragma mark -summit_btn 提问按钮的的点击事件
- (void)summit_btn_Click:(UIButton *)sender {
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
  }
  [[event_view_log sharedManager] event_log:@"1000037"];
  [MobClick event:@"1000037"];
  [Login_ViewController checkLoginStatusWithCallback:^(BOOL logonSuccess) {
    if (logonSuccess) {
      MyQuestionViewController *us_question_VC =
          [[MyQuestionViewController alloc] init];
      [AppDelegate pushViewControllerFromRight:us_question_VC];
    }
  }];
}
/*!
 * @method 初始化顶部tab的各个按钮
 * @abstract
 * @discussion
 * @param
 * @result
 */
- (void)createNameButtons {
  _topCuttingView = [[UIView alloc] init];
  [_topCuttingView.layer setMasksToBounds:YES];
  [_topCuttingView.layer setCornerRadius:2.0f];
  [_topCuttingView
      setBackgroundColor:[Globle colorFromHexRGB:customFilledColor]];
  [_topScrollView addSubview:_topCuttingView];

  NSArray *viewArray = @[ @"最新", @"热点" ];
  for (int i = 0; i < [viewArray count]; i++) {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //设置按钮尺寸
    [button setFrame:CGRectMake(windowWidth / 2.0f * i, 0, windowWidth / 2.0f,
                                kHeightOfTopScrollView)];
    [button setTag:i + 100];
    if (i == 0) {
      _topCuttingView.frame =
          CGRectMake(windowWidth / 2.0f * i + 20.0f, navigationHeght - 5.0f,
                     windowWidth / 2.0f - 40.0f, 4.0f);
      button.selected = YES;
    }
    [button setTitle:viewArray[i] forState:UIControlStateNormal];

    button.titleLabel.font = [UIFont systemFontOfSize:kFontSizeOfTabButton];
    [button setTitleColor:[Globle colorFromHexRGB:@"868686"]
                 forState:UIControlStateNormal];
    [button setTitleColor:[Globle colorFromHexRGB:customFilledColor]
                 forState:UIControlStateSelected];
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self
                  action:@selector(selectNameButton:)
        forControlEvents:UIControlEventTouchUpInside];
    [_topScrollView addSubview:button];
    if (i == 0) { //最新
      KnowFirstTableViewController *newVC = [[KnowFirstTableViewController alloc]
          initWithFrame:_rootScrollView.bounds 
               AndStart:NEWListViewController ];
      [self addChildViewController:newVC];
      newVC.view.frame = CGRectMake(0, 0, windowWidth, _rootScrollView.height);
      [self.rootScrollView addSubview:newVC.view];
    } else {
      //热点
      KnowFirstTableViewController *rotVC = [[KnowFirstTableViewController alloc]
          initWithFrame:_rootScrollView.bounds
               AndStart:RotPointViewController];
      rotVC.view.frame =
          CGRectMake(windowWidth, 0, windowWidth, _rootScrollView.height);
      [self addChildViewController:rotVC];
      [self.rootScrollView addSubview:rotVC.view];
    }
  }
  //设置顶部滚动视图的内容总尺寸
  _rootScrollView.contentSize =
      CGSizeMake(windowWidth * 2, _rootScrollView.height);
}

#pragma mark - 顶部滚动视图逻辑方法

/*!
 * @method 选中tab时间
 * @abstract
 * @discussion
 * @param 按钮
 * @result
 */
- (void)selectNameButton:(UIButton *)sender {
  //如果更换按钮
  if (sender.tag != _userSelectedChannelID) {
    //取之前的按钮
    UIButton *lastButton =
        (UIButton *)[_topScrollView viewWithTag:_userSelectedChannelID];
    lastButton.selected = NO;
    //赋值按钮ID
    _userSelectedChannelID = sender.tag;
  }
  //按钮选中状态
  if (!sender.selected) {
    sender.selected = YES;
    NSInteger index = sender.tag - 100;
    if (index >= 0) {
      [UIView animateWithDuration:0.3f
          animations:^{
            [_rootScrollView
                setContentOffset:CGPointMake(index * self.childView.width, 0)
                        animated:YES];
          }
          completion:^(BOOL finished) {
            if (finished) {
            }
          }];
    } else {
      NSLog(@"财知道首页点击时，sender。tag小于0");
    }
  }
}

#pragma mark 主视图逻辑方法
//滚动视图结束
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (scrollView == _rootScrollView) {
    _topCuttingView.origin = CGPointMake(
        scrollView.contentOffset.x / 2.0f + 20.0f, navigationHeght - 5.0f);
  }
}

//滚动视图释放滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  if (scrollView == _rootScrollView) {
    //调整顶部滑条按钮状态
    int tag = (int)scrollView.contentOffset.x / self.childView.width + 100;
    UIButton *button = (UIButton *)[_topScrollView viewWithTag:tag];
    [self selectNameButton:button];
  }
}
@end
