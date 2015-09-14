//
//  Stock_Market_ViewController.m
//  优顾理财
//
//  Created by Jhss on 15/8/21.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "Stock_Market_ViewController.h"
#import "YouGuNewsUtil.h"

@implementation Stock_Market_ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    //    self.isStatus=NO;
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  [self.topNavView setMainLableString:@"行情"];

  UIView *listView = [[UIView alloc] initWithFrame:self.childView.bounds];
  listView.backgroundColor = [UIColor whiteColor];
  listView.height -= BOTTOM_TOOL_BAR_OFFSET_Y;
  [self.childView addSubview:listView];

  _mianWebView = [[UIWebView alloc] init];
//  _mianWebView.backgroundColor = [UIColor clearColor];
  _mianWebView.hidden = YES;
  _mianWebView.delegate = self;
  _mianWebView.scalesPageToFit = YES;
  //防止头部和底部，在往外滑动
  [(UIScrollView *)[_mianWebView subviews][0] setBounces:YES];
  ((UIScrollView *)[_mianWebView subviews][0]).decelerationRate = 1.0;
  [YouGuNewsUtil WebViewUserAgent:_mianWebView];
  CGRect frame = self.view.bounds;
  _mianWebView.frame = CGRectMake(0, statusBarHeight, frame.size.width, frame.size.height - statusBarHeight);
  [self.view addSubview:_mianWebView];
  //判断网络
  if ([FPYouguUtil isExistNetwork]) {
    [self getWebViewWithUrl];
  } else {
    self.loading.hidden = NO;
    [self.loading animationNoNetWork];
  }
}
#pragma mark - loading代理正在加载，回调
- (void)refreshNewInfo {
  if ([FPYouguUtil isExistNetwork]) {
    [self getWebViewWithUrl];
  } else {
    self.loading.hidden = NO;
    [self.loading animationNoNetWork];
  }
}
- (void)getWebViewWithUrl {
  NSString *Path = IP_HTTP_Stock_market;
  if ([YouGu_User_USerid intValue] > 0 && [YouGu_User_sessionid intValue] > 0) {
    Path = [NSString stringWithFormat:@"%@?userid=%@&sessionid=%@&ak=%@", Path,
                                      YouGu_User_USerid, YouGu_User_sessionid,
                                      ak_version];
  }
  NSLog(@"path:%@", Path);
  NSURLRequest *request =
      [NSURLRequest requestWithURL:[NSURL URLWithString:Path]];
  [_mianWebView loadRequest:request];
}

- (void)tap_click:(UIPanGestureRecognizer *)sender {
}

#pragma mark
#pragma mark - webview 代理
- (void)webViewDidFinishLoad:(UIWebView *)webView {
  _mianWebView.hidden = NO;
  self.loading.hidden = YES; // yes
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
  [self.loading animationNoNetWork];
}

- (BOOL)webView:(UIWebView *)webView
    shouldStartLoadWithRequest:(NSURLRequest *)request
                navigationType:(UIWebViewNavigationType)navigationType {
  NSString *urlString = [[request URL] absoluteString];

  if ([urlString hasSuffix:@"closebrowser"]) {
    [self.view endEditing:NO];
    [self.navigationController popViewControllerAnimated:YES];
    return NO;
  }
  return YES;
}

#pragma mark - 注销
- (void)dealloc {
  [self.view removeAllSubviews];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
