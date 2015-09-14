//
//  Tools_ViewController.m
//  优顾理财
//
//  Created by Mac on 14/10/28.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "Tools_ViewController.h"

#import "Toolbox_Single.h"

#import "FourPayViewController.h"
#import "FourDepositViewController.h"
#import "FourFiscalViewController.h"
#import "FourForeignViewController.h"
#import "Four_Mortgage_ViewController.h"
#import "FourCarViewController.h"


#import "FourForeignVC.h"

@implementation Tools_ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  [self.topNavView setMainLableString:@"工具箱"];
  self.content_view.contentSize = CGSizeMake(self.view.width, self.view.height);
  self.content_view.scrollEnabled = NO;

  NSString *path_1 =
      [[NSBundle mainBundle] pathForResource:@"Tools.plist" ofType:nil];
  NSArray *YG_array = [NSMutableArray arrayWithContentsOfFile:path_1];

  for (int i = 0; i < [YG_array count]; i++) {
    Toolbox_Single *toolsbox = [[Toolbox_Single alloc]
        initWithFrame:CGRectMake(i % 2 * (content_view.width - 20) / 2 + 20,
                                 i / 2 * (content_view.height - 20) / 3 + 20,
                                 (content_view.width - 20) / 2 - 20,
                                 (content_view.height - 20) / 3 - 20)];
      toolsbox.background_View.backgroundColor =
          [Globle colorFromHexRGB:[YG_array[i] objectAtIndex:3]];
      toolsbox.head_image.image =
          [UIImage imageNamed:[YG_array[i] objectAtIndex:1]];
    toolsbox.title_View.text = [YG_array[i] objectAtIndex:0];
    toolsbox.Click_btn.tag = 1000 + i;
    [toolsbox.Click_btn addTarget:self
                           action:@selector(tools_click:)
                 forControlEvents:UIControlEventTouchUpInside];
    [self.content_view addSubview:toolsbox];
  }

  self.view.backgroundColor = [Globle colorFromHexRGB:customBGColor];
}

- (void)tools_click:(UIButton *)sender {
  switch (sender.tag - 1000) {
  case 0: {
    FourPayViewController *fourPayVC = [[FourPayViewController alloc] init];
    [AppDelegate pushViewControllerFromRight:fourPayVC];
  } break;
  case 1: {
    FourDepositViewController *fourDepositVC =
        [[FourDepositViewController alloc] init];
    [AppDelegate pushViewControllerFromRight:fourDepositVC];
  } break;
  case 2: {
    FourFiscalViewController *fourFiscalVC =
        [[FourFiscalViewController alloc] init];
    [AppDelegate pushViewControllerFromRight:fourFiscalVC];
  } break;
  case 3: {//外汇
//    FourForeignViewController *fourForeignVC =
//        [[FourForeignViewController alloc] init];
//    [AppDelegate pushViewControllerFromRight:fourForeignVC];
    FourForeignVC *fourForeignVC =
    [[FourForeignVC alloc] init];
    [AppDelegate pushViewControllerFromRight:fourForeignVC];

    
  } break;
  case 4: {
    Four_Mortgage_ViewController *fourMortgageVC =
        [[Four_Mortgage_ViewController alloc] init];
    [AppDelegate pushViewControllerFromRight:fourMortgageVC];
  } break;
  case 5: {
    FourCarViewController *fourCarVC = [[FourCarViewController alloc] init];
    [AppDelegate pushViewControllerFromRight:fourCarVC];
  } break;
  default:
    break;
  }
}
@end
