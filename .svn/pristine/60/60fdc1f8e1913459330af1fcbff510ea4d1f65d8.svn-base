//
//  AboutUsViewController.m
//  优顾理财
//
//  Created by Mac on 15/8/4.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//
@interface AboutUsViewController ()

@end

@implementation AboutUsViewController
#pragma mark - pv, 选择正确的pvjiem
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [MobClick beginLogPageView:@"About_Us_view"];
  [[PV_view_sql sharedManager] PV_DB_DATA:@"About_Us_view"];
}
- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [MobClick endLogPageView:@"About_Us_view"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.topNavView.mainLableString = @"关于我们";
  AboutUsView * aboutView = [[NSBundle mainBundle] loadNibNamed:@"AboutUsView" owner:self options:nil];
}
- (IBAction)sendTelephone:(UIButton *)sender {
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://010-80443260"]];
}
@end
