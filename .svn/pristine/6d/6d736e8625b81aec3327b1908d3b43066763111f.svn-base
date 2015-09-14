//
//  RotViewController.m
//  优顾理财
//
//  Created by Mac on 14-3-10.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "RotViewController.h"

@implementation RotViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}
- (void)viewDidAppear:(BOOL)animated {
  [MobClick beginLogPageView:@"RotViewController"];
  [[PV_view_sql sharedManager] PV_DB_DATA:@"RotViewController"];

  [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [MobClick endLogPageView:@"RotViewController"];
}
- (id)initWithTopicid:(NSString *)topicid {
  self = [super init];
  if (self) {
    self.topicid = topicid;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.topNavView.mainLableString = @"微热点";
//  RotTableViewController *rotVC =
//      [[RotTableViewController alloc] initWithFrame:self.childView.bounds AndTopicid:self.topicid];
//  [self.childView addSubview:rotVC.view];
}

@end
