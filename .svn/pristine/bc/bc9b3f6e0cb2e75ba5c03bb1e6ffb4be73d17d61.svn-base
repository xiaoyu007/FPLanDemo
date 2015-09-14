//
//  YG_Four_QC_ScrollView.m
//  优顾理财
//
//  Created by Mac on 14/10/22.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "YG_Four_QC_ScrollView.h"

#import "CommercialLoansView.h"
#import "ProvidentFundLoans.h"
#import "LoansRepaymentView.h"
#import "TheLoanPortfolioView.h"
#import "SecondHandHouseTaxView.h"

static const CGFloat kHeightOfTopScrollView = 40.0f;
static const CGFloat kWidthOfButtonMargin = 20.0f;
static const CGFloat kFontSizeOfTabButton = 16.0f;

@implementation YG_Four_QC_ScrollView

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self initValues];
  }
  return self;
}

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self initValues];
  }
  return self;
}

#pragma mark - 初始化参数

- (void)initValues {
  //    //两个 scrollview  分割线
  D_View = [[UIView alloc] initWithFrame:CGRectMake(0, 39, windowWidth, 1)];
  [self addSubview:D_View];

  //创建顶部可滑动的tab
  _topScrollView = [[UIScrollView alloc]
      initWithFrame:CGRectMake(0, 0, self.bounds.size.width,
                               kHeightOfTopScrollView)];
  _topScrollView.delegate = self;
  _topScrollView.backgroundColor = [UIColor clearColor];
  _topScrollView.pagingEnabled = NO;
  _topScrollView.showsHorizontalScrollIndicator = NO;
  _topScrollView.showsVerticalScrollIndicator = NO;
  _topScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  [self addSubview:_topScrollView];
  _userSelectedChannelID = 100;

  //创建主滚动视图
  _rootScrollView = [[UIScrollView alloc]
      initWithFrame:CGRectMake(
                        0, kHeightOfTopScrollView, self.bounds.size.width,
                        self.bounds.size.height - kHeightOfTopScrollView)];
  _rootScrollView.delegate = self;
  _rootScrollView.pagingEnabled = YES;
  _rootScrollView.userInteractionEnabled = YES;
  _rootScrollView.bounces = NO;
  _rootScrollView.showsHorizontalScrollIndicator = NO;
  _rootScrollView.showsVerticalScrollIndicator = NO;
  _rootScrollView.autoresizingMask =
      UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
  _userContentOffsetX = 0;
  //    [_rootScrollView.panGestureRecognizer addTarget:self
  //    action:@selector(scrollHandlePan:)];
  [self addSubview:_rootScrollView];

  _isBuildUI = NO;

  [self createNameButtons];
  [self Night_to_Day];
}

/*!
 * @method 初始化顶部tab的各个按钮
 * @abstract
 * @discussion
 * @param
 * @result
 */
- (void)createNameButtons {
  _shadowImageView = [[UIImageView alloc] init];
  [_topScrollView addSubview:_shadowImageView];

  ///,@"房贷提前还款",@"组合贷款",@"二手房贷款"
  NSArray *viewArray = @[
    @"商业贷款",
    @"公积金贷款",
    @"房贷提前还款",
    @"组合贷款",
    @"二手房税率"
  ];

  //顶部tabbar的总长度
  CGFloat topScrollViewContentWidth = kWidthOfButtonMargin;
  //每个tab偏移量
  CGFloat xOffset = 10;
  for (int i = 0; i < [viewArray count]; i++) {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize textSize = [viewArray[i]
             sizeWithFont:[UIFont systemFontOfSize:kFontSizeOfTabButton]
        constrainedToSize:CGSizeMake(_topScrollView.bounds.size.width,
                                     kHeightOfTopScrollView)
            lineBreakMode:NSLineBreakByTruncatingTail];
    //累计每个tab文字的长度
    topScrollViewContentWidth += kWidthOfButtonMargin + textSize.width;
    //设置按钮尺寸
    [button setFrame:CGRectMake(xOffset, 4, textSize.width + 20,
                                kHeightOfTopScrollView - 10)];
    //计算下一个tab的x偏移量
    xOffset += textSize.width + kWidthOfButtonMargin;

    [button setTag:i + 100];
    if (i == 0) {
      _shadowImageView.frame = CGRectMake(button.center.x - 7.0f,
                                          navigationHeght - 7.0f, 14.0f, 7.0f);
      button.selected = YES;
    }
    [button setTitle:viewArray[i] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:kFontSizeOfTabButton];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setTitleColor:[Globle colorFromHexRGB:@"868686"]
                 forState:UIControlStateNormal];
    [button setTitleColor:[Globle colorFromHexRGB:@"ffffff"]
                 forState:UIControlStateSelected];

      button.layer.cornerRadius = 11;
      [button setBackgroundImage:[UIImage imageNamed:@"房贷_滑块.png"]
                        forState:UIControlStateSelected];


    button.clipsToBounds = YES;
    [button addTarget:self
                  action:@selector(selectNameButton:)
        forControlEvents:UIControlEventTouchUpInside];
    [_topScrollView addSubview:button];

    switch (i) {
    case 0: {
      CommercialLoansView *loans_View = [[CommercialLoansView alloc]
          initWithFrame:CGRectMake(0, 0, windowWidth, _rootScrollView.height)];
      [_rootScrollView addSubview:loans_View];

    } break;
    case 1: {
      ProvidentFundLoans *fund_loans = [[ProvidentFundLoans alloc]
          initWithFrame:CGRectMake(windowWidth, 0, windowWidth,
                                   _rootScrollView.height)];
      [_rootScrollView addSubview:fund_loans];

    } break;

    case 2: {
      LoansRepaymentView *loans_repayment = [[LoansRepaymentView alloc]
          initWithFrame:CGRectMake(windowWidth * 2, 0, windowWidth,
                                   _rootScrollView.height)];
      [_rootScrollView addSubview:loans_repayment];

    } break;
    case 3: {
      TheLoanPortfolioView *portfolio_View = [[TheLoanPortfolioView alloc]
          initWithFrame:CGRectMake(windowWidth * 3, 0, windowWidth,
                                   _rootScrollView.height)];
      [_rootScrollView addSubview:portfolio_View];

    } break;
    case 4: {
      SecondHandHouseTaxView *housing_tax_View =
          [[SecondHandHouseTaxView alloc]
              initWithFrame:CGRectMake(windowWidth * 4, 0, windowWidth,
                                       _rootScrollView.height)];
      [_rootScrollView addSubview:housing_tax_View];

    } break;

    default:
      break;
    }
  }

  //设置顶部滚动视图的内容总尺寸
  _topScrollView.contentSize =
      CGSizeMake(topScrollViewContentWidth, kHeightOfTopScrollView);
  _rootScrollView.contentSize =
      CGSizeMake(windowWidth * 5, self.height - kHeightOfTopScrollView);
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

    [UIView animateWithDuration:0.25
        animations:^{

          [_shadowImageView
              setFrame:CGRectMake(sender.center.x - 7.0f,
                                  navigationHeght - 7.0f, 14.0f, 7.0f)];

        }
        completion:^(BOOL finished) {
          if (finished) {
            //设置新页出现
            //                if (!_isRootScroll) {
            [_rootScrollView
                setContentOffset:CGPointMake((sender.tag - 100) *
                                                 self.bounds.size.width,
                                             0)
                        animated:YES];
            //                }
            //                _isRootScroll = NO;
            [self center_scrollview:sender];
          }
        }];

  }
  //重复点击选中按钮
  else {
  }
}

//被选中的，频道，居中显示
- (void)center_scrollview:(UIButton *)sender {
  float y_w = sender.frame.origin.x - 160 + sender.width / 2;
  if (y_w < 0) {
    y_w = 0;
  }
  if (y_w > _topScrollView.contentSize.width - _topScrollView.width) {
    y_w = _topScrollView.contentSize.width - _topScrollView.width;
  }

  [_topScrollView setContentOffset:CGPointMake(y_w, 0) animated:YES];
}

#pragma mark 主视图逻辑方法

//滚动视图开始时
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
  if (scrollView == _rootScrollView) {
    _userContentOffsetX = scrollView.contentOffset.x;
  }
}

//滚动视图结束
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (scrollView == _rootScrollView) {
    //判断用户是否左滚动还是右滚动
    if (_userContentOffsetX < scrollView.contentOffset.x) {
      _isLeftScroll = YES;
    } else {
      _isLeftScroll = NO;
    }
  }
}

//滚动视图释放滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  if (scrollView == _rootScrollView) {
    _isRootScroll = YES;
    //调整顶部滑条按钮状态
    int tag = (int)scrollView.contentOffset.x / self.bounds.size.width + 100;
    UIButton *button = (UIButton *)[_topScrollView viewWithTag:tag];
    [self selectNameButton:button];
  }
}

#pragma mark - 工具方法

/*!
 * @method 通过16进制计算颜色
 * @abstract
 * @discussion
 * @param 16机制
 * @result 颜色对象
 */
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString {
  UIColor *result = nil;
  unsigned int colorCode = 0;
  unsigned char redByte, greenByte, blueByte;

  if (nil != inColorString) {
    NSScanner *scanner = [NSScanner scannerWithString:inColorString];
    (void)[scanner scanHexInt:&colorCode]; // ignore error
  }
  redByte = (unsigned char)(colorCode >> 16);
  greenByte = (unsigned char)(colorCode >> 8);
  blueByte = (unsigned char)(colorCode); // masks off high bits
  result = [UIColor colorWithRed:(float)redByte / 0xff
                           green:(float)greenByte / 0xff
                            blue:(float)blueByte / 0xff
                           alpha:1.0];
  return result;
}

//夜间模式和白天模式
- (void)Night_to_Day {
    self.backgroundColor = [Globle colorFromHexRGB:customBGColor];
    D_View.backgroundColor = [Globle colorFromHexRGB:@"d1d1d1"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
