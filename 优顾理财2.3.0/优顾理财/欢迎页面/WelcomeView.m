//
//  Welcome_View.m
//  优顾理财
//
//  Created by moulin wang on 13-10-8.
//  Copyright (c) 2013年 Ling YU. All rights reserved.
//

#import "WelcomeView.h"
@implementation WelcomeView
@synthesize welcome_scroll;
@synthesize pageControl;
- (id)initWithFrame:(CGRect)frame {
  //    self = [super initWithFrame:frame];
  //    if (self) {
  //        self.backgroundColor=[UIColor blackColor];
  //        // Initialization code
  //        [self Creat_scroll];
  //    }
  //    return self;
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor blackColor];
    [self Creat_scroll];
  }
  return self;
}

- (void)Creat_scroll {
  //首次启动未进入新闻首页，停留在引导页，隐藏推送信息
  [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"hidden_push_data"];

  NSArray *array_images =
      @[ @"iphone4_1.jpg", @"iphone4_2.jpg", @"iphone4_3.jpg", @"iphone4_4.jpg" ];
  if (self.bounds.size.height > 520) {
    array_images = @[ @"iphone5_1.jpg", @"iphone5_2.jpg", @"iphone5_3.jpg", @"iphone5_4.jpg" ];
  }

  self.welcome_scroll = [[UIScrollView alloc] initWithFrame:self.bounds];
  self.welcome_scroll.delegate = self;
  self.welcome_scroll.pagingEnabled = YES;
  self.welcome_scroll.contentSize = CGSizeMake(320 * 4, self.bounds.size.height);
  self.welcome_scroll.showsHorizontalScrollIndicator = NO;
  self.welcome_scroll.bounces = NO;
  [self addSubview:welcome_scroll];

  for (int i = 0; i < [array_images count]; i++) {
    UIImageView *f_imageview = [[UIImageView alloc] init];
    f_imageview.frame = CGRectMake(320 * i, 0, 320, self.bounds.size.height);
    f_imageview.tag = 1500 + i;
    f_imageview.userInteractionEnabled = YES;
    f_imageview.image = [UIImage imageNamed:array_images[i]];
    [self.welcome_scroll addSubview:f_imageview];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(320 * i, 0, 320, self.bounds.size.height);
    btn.tag = i + 1000;
    [btn addTarget:self
                  action:@selector(fisrt_imageview:)
        forControlEvents:UIControlEventTouchUpInside];
    [self.welcome_scroll addSubview:btn];
  }

  //翻页显示器
  self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(120, 0, 80, 30)];
  // pageControl.backgroundColor=[UIColor redColor];
  self.pageControl.pageIndicatorTintColor = [Globle colorFromHexRGB:@"d9d9d9"];
  self.pageControl.currentPageIndicatorTintColor = [Globle colorFromHexRGB:@"949494"];
  self.pageControl.bottom = self.bottom;
  self.pageControl.currentPage = 0;
  self.pageControl.numberOfPages = 4;
  [self addSubview:pageControl];
}

- (void)fisrt_imageview:(UIButton *)sender {
  if (sender.tag == 1003) {
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    if ([(id)self.my_delegate respondsToSelector:@selector(introDidFinish)]) {
      [self.my_delegate introDidFinish];
    }
  } else {
    [self.welcome_scroll setContentOffset:CGPointMake((sender.tag - 1000 + 1) * 320, 0)
                                 animated:YES];
  }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  //    CGFloat pageWidth = scrollView.frame.size.width;
  int page = floor(scrollView.contentOffset.x / 320) + 1;
  pageControl.currentPage = (page - 1) % 4;

  if (scrollView.contentOffset.x > 320 * 3) {
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    if ([(id)self.my_delegate respondsToSelector:@selector(introDidFinish)]) {
      [self.my_delegate introDidFinish];
    }
  }
}

@end
