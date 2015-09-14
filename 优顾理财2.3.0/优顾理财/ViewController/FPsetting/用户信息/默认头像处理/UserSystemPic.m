//
//  UserSystemPic.m
//  优顾理财
//
//  Created by Mac on 13-12-5.
//  Copyright (c) 2013年 Ling YU. All rights reserved.
//

#import "UserSystemPic.h"
#import "YGImageDown.h"
#import "UIImageView+WebCache.h"

@implementation UserSystemPic
@synthesize content_View;
@synthesize scrollview;
@synthesize Chongse_View;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
    self.view.backgroundColor = [UIColor whiteColor];
  }
  return self;
}

- (void)viewDidAppear:(BOOL)animated {
  [self setExclusiveTouchForButtons:self.view];
  [super viewDidAppear:animated];
}

- (void)setExclusiveTouchForButtons:(UIView *)myView {
  for (UIView *v in [myView subviews]) {
    if ([v isKindOfClass:[UIButton class]])
      [((UIButton *)v)setExclusiveTouch:YES];
    else if ([v isKindOfClass:[UIView class]]) {
      [self setExclusiveTouchForButtons:v];
    }
  }
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  array_User_pic = [[NSMutableArray alloc] initWithCapacity:0];

  content_View = [[UIView alloc] initWithFrame:self.view.bounds];
  [self.view addSubview:content_View];

  if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
    UIView *ios_7_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    ios_7_view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:ios_7_view];

    content_View.frame = CGRectMake(0, 20, 320, self.view.frame.size.height - 20);
  }

  UIImageView *imageview =
      [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"User_Nav_pic.png"] stretchableImageWithLeftCapWidth:30
                                                                                                       topCapHeight:27]];
  imageview.frame = CGRectMake(0, 0, 320, 50);
  [content_View addSubview:imageview];

  Nav_title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
  Nav_title.backgroundColor = [UIColor clearColor];
  Nav_title.text = @"系统头像";
  Nav_title.textAlignment = NSTextAlignmentCenter;
  [content_View addSubview:Nav_title];

  btn_1 = [[clickLabel alloc] initWithFrame:CGRectMake(20, 10, 50, 30)];
  [btn_1 addTarget:self action:@selector(exit_button_click:)];
  btn_1.layer.cornerRadius = 5;
  btn_1.clipsToBounds = YES;
  btn_1.text = @"取消";
  btn_1.textAlignment = NSTextAlignmentCenter;
  [content_View addSubview:btn_1];

  btn_2 = [[clickLabel alloc] initWithFrame:CGRectMake(250, 10, 50, 30)];
  [btn_2 addTarget:self action:@selector(result_button_click:)];
  btn_2.layer.cornerRadius = 5;
  btn_2.clipsToBounds = YES;
  btn_2.text = @"选中";
  btn_2.textAlignment = NSTextAlignmentCenter;
  [content_View addSubview:btn_2];

  scrollview =
      [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, 320, content_View.frame.size.height - 50)];
  [content_View addSubview:scrollview];

  //    请求数据
  [self reload_upload_data];

  [self Night_to_Day];
}

//数据请求
- (void)reload_upload_data {
  [[WebServiceManager sharedManager] get_User_pic_completion:^(NSDictionary *dic) {
    if (dic && [dic[@"status"] isEqualToString:@"0000"]) {
      NSArray *pic_array = dic[@"result"];
      for (NSDictionary *dic_User in pic_array) {
        NSString *User_url = dic_User[@"url"];
        [array_User_pic addObject:User_url];
      }
      //   建立图片墙
      [self add_pic_UI];
    }
  }];
}
//建立图片墙
- (void)add_pic_UI {
  int Chanle_btn = -1;
  scrollview.contentSize = CGSizeMake(320, [array_User_pic count] / 4 * 70 + 10 + 70);
  for (int i = 0; i < [array_User_pic count]; i++) {

    NSString *url_pic = array_User_pic[i];

    if ([url_pic isEqualToString:[FPYouguUtil getHeadpic]] == YES) {
      Chanle_btn = i;
    }

    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(20 + i % 4 * 70, i / 4 * 70 + 10, 70, 70)];
    [[view1 layer] setBorderWidth:1];
    [[view1 layer] setBorderColor:[UIColor grayColor].CGColor];
    [scrollview addSubview:view1];

    UIImageView *imageview1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"头像"]];
    imageview1.frame = CGRectMake(5, 5, 60, 60);
    [view1 addSubview:imageview1];

    UIButton *view1_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    view1_btn.frame = CGRectMake(20 + i % 4 * 70, i / 4 * 70 + 10, 70, 70);
    view1_btn.tag = i;
    [view1_btn addTarget:self
                  action:@selector(view1_btn_Click:)
        forControlEvents:UIControlEventTouchUpInside];
    [scrollview addSubview:view1_btn];

//    [imageview1 setImageWithURL:[NSURL URLWithString:url_pic] placeholderImage:[UIImage imageNamed:@"头像"]];
    [[YGImageDown sharedManager] add_image:url_pic
                                completion:^(UIImage *img) {
                                  if (img) {
                                    imageview1.image = img;
                                  }
                                }];
  }
  //    选中的view
  Chongse_View = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"个人头像_选中"]];
  if (Chanle_btn == -1) {
    Chongse_View.frame = CGRectMake(0, 0, 70, 70);
    Chongse_View.hidden = YES;
  } else {
    Chongse_View.frame = CGRectMake(20 + Chanle_btn % 4 * 70, Chanle_btn / 4 * 70 + 10, 70, 70);
  }
  [scrollview addSubview:Chongse_View];

  UIImageView *imageview2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"选中"]];
  imageview2.frame = CGRectMake(40, 40, 20, 20);
  [Chongse_View addSubview:imageview2];
}

#pragma mark - 点击图片
//点击
- (void)view1_btn_Click:(UIButton *)sender {
  Chongse_View.hidden = NO;
  Chongse_View.frame = sender.frame;
}

#pragma mark - 自定义导航条 methods
//点击事件
- (void)exit_button_click:(UIButton *)sender {
  [self dismissViewControllerAnimated:YES
                           completion:^{
                           }];
}
//点击选中按钮
- (void)result_button_click:(UIButton *)sender {
  NSInteger num = (Chongse_View.frame.origin.x - 20) / 70 + (Chongse_View.frame.origin.y - 10) / 70 * 4;
  if ([array_User_pic count] > num) {
    NSString *url_pic = array_User_pic[num];
    //    保存头像的，url
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:url_pic forKey:@"USER_url_pic"];
  }

  //    消息中心  替换用户的头像
  [[NSNotificationCenter defaultCenter] postNotificationName:@"System_pic_user" object:nil];

  [self dismissViewControllerAnimated:YES
                           completion:^{
                           }];
}

#pragma mark -  调整夜间模式

/**
 *
 *  //消息中心
 *
 **/
#pragma mark - 消息中心，回调，夜间、白天和无图、有图
//夜间模式和白天模式
- (void)Night_to_Day {
  content_View.backgroundColor =
      [UIColor colorWithRed:240 / 255.0f green:240 / 255.0f blue:240 / 255.0 alpha:1.0];
  Nav_title.textColor = [UIColor blackColor];
  btn_1.NormalbackgroundColor = [Globle colorFromHexRGB:@"a0a0a0"];
  btn_1.highlightedColor = [Globle colorFromHexRGB:@"696969"];
  btn_1.backgroundColor = [Globle colorFromHexRGB:@"a0a0a0"];
  btn_2.NormalbackgroundColor = [Globle colorFromHexRGB:@"cf0200"];
  btn_2.highlightedColor = [Globle colorFromHexRGB:@"a90100"];
  btn_2.backgroundColor = [Globle colorFromHexRGB:@"cf0200"];
  btn_2.textColor = [UIColor whiteColor];
  btn_1.textColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
