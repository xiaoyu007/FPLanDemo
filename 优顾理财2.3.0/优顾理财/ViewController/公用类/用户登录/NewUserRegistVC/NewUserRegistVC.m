//
//  NewUserRegistVC.m
//  优顾理财
//
//  Created by Mac on 14-8-1.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "NewUserRegistVC.h"


@implementation NewUserRegistVC

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  [self.childView setUserInteractionEnabled:YES];
  [self CreatNavBarWithTitle:@"注册新用户"];

  detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 90, 280, 50)];
  detailLabel.font = [UIFont systemFontOfSize:20];
  detailLabel.textAlignment = NSTextAlignmentLeft;
  detailLabel.text = @"欢迎注册优顾理财";
  detailLabel.backgroundColor = [UIColor clearColor];
  detailLabel.textColor = [Globle colorFromHexRGB:@"5b5b5b"];
  [self.childView addSubview:detailLabel];

  mobile_phone_label = [[UserRegistView alloc]
      initWithFrame:CGRectMake(20, 160, windowWidth - 40.0f, 50)];
  [mobile_phone_label.btn_Main addTarget:self
                                  action:@selector(mobile_phone_label_click:)];
  mobile_phone_label.top_imageView.image = [UIImage imageNamed:@"注册.png"];
  mobile_phone_label.title_label.text = @"手机号注册";
  mobile_phone_label.title_label_Subtitle.text = @"(免费验证短信,快速注册)";
  [self.childView addSubview:mobile_phone_label];

  defaults_Label = [[UILabel alloc] initWithFrame:CGRectMake(20, 230, 280, 20)];
  defaults_Label.font = [UIFont systemFontOfSize:12.0f];
  defaults_Label.textAlignment = NSTextAlignmentLeft;
  defaults_Label.text = @"登录之后可以同步收藏," @"收"
                                                           @"到别人对你的评论"
                                                           @".";
  defaults_Label.backgroundColor = [UIColor clearColor];
  defaults_Label.textColor = [Globle colorFromHexRGB:@"5b5b5b"];
  [self.childView addSubview:defaults_Label];

  [self Night_to_Day];
}
- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - NEWS_Nav_View 自定义导航条  按钮delegate 点击函数
- (void)leftButtonPress {
  [self.view endEditing:NO];
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)mobile_phone_label_click:(id)sender {
  PhoneBindAccountVC *phoneBindAccountVC =
      [[PhoneBindAccountVC alloc] init];
  [AppDelegate pushViewControllerFromRight:phoneBindAccountVC];
}

- (void)General_registration_click:(id)sender {
  NormalRegistVC *normalRegistVC =
      [[NormalRegistVC alloc] init];
  [AppDelegate pushViewControllerFromRight:normalRegistVC];
}

/**
 *
 *  //消息中心
 *
 **/
#pragma mark - 消息中心，回调，夜间、白天和无图、有图

//夜间模式和白天模式
- (void)Night_to_Day {
    self.view.backgroundColor = [UIColor colorWithRed:240 / 255.0f
                                                green:240 / 255.0f
                                                 blue:240 / 255.0f
                                                alpha:1.0];
    mobile_phone_label.top_imageView.image = [UIImage imageNamed:@"注册.png"];
    General_registration.top_imageView.image =
        [UIImage imageNamed:@"普通注册.png"];
    mobile_phone_label.title_label.textColor =
        [Globle colorFromHexRGB:@"ffffff"];
    General_registration.title_label.textColor =
        [Globle colorFromHexRGB:@"ffffff"];
    mobile_phone_label.title_label_Subtitle.textColor =
        [Globle colorFromHexRGB:@"95dbf3"];
    General_registration.title_label_Subtitle.textColor =
        [Globle colorFromHexRGB:@"95dbf3"];
    mobile_phone_label.btn_Main.backgroundColor =
        [Globle colorFromHexRGB:@"48b8e5"];
    General_registration.btn_Main.backgroundColor =
        [Globle colorFromHexRGB:@"f4a444"];
    mobile_phone_label.btn_Main.NormalbackgroundColor =
        [Globle colorFromHexRGB:@"48b8e5"];
    General_registration.btn_Main.NormalbackgroundColor =
        [Globle colorFromHexRGB:@"f4a444"];
    mobile_phone_label.btn_Main.highlightedColor =
        [Globle colorFromHexRGB:@"274a58"];
    General_registration.btn_Main.highlightedColor =
        [Globle colorFromHexRGB:@"5e4321"];
}
@end
