//
//  RiskEvaluatingViewController.m
//  优顾理财
//
//  Created by Mac on 15-4-13.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPRiskEvaluatingViewController.h"
#import "YouGuNewsUtil.h"

@implementation FPRiskEvaluatingViewController

- (id)initWithCallback:(evaluateLevel)callback {
  if (self = [super init]) {
    currentCallback = callback;
  }
  return self;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  self.topNavView.mainLableString = @"风险评测";
  //加载webView
  YGWebView =
      [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, windowWidth, windowHeight - navigationHeght - statusBarHeight)];
  YGWebView.backgroundColor = [UIColor clearColor];
  YGWebView.delegate = self;
  YGWebView.scrollView.backgroundColor = [UIColor clearColor];
  [YouGuNewsUtil WebViewUserAgent:YGWebView];
  [self.childView addSubview:YGWebView];
  loadingView =
      [[LoadingView alloc] initWithFrame:CGRectMake(0, 0, windowWidth, windowHeight - navigationHeght - statusBarHeight)];
  loadingView.delegate = self;
  loadingView.userInteractionEnabled = YES;
  [self.childView addSubview:loadingView];
  [self sendRequest];
}
- (void)sendRequest {
  // 1.创建网络请求
  NSURL *url = [NSURL URLWithString:riskEvaluating];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];

  //加载网络请求
  [YGWebView loadRequest:request];
}
#pragma mark - loading 代理方法
- (void)refreshNewInfo {
  if ([FPYouguUtil isExistNetwork]) {
    //加载网络请求
    [self sendRequest];
  }
}
- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView {
  //加载网络请求
  [self sendRequest];
}
#pragma mark - webviewdelegate
- (BOOL)webView:(UIWebView *)webView
    shouldStartLoadWithRequest:(NSURLRequest *)request
                navigationType:(UIWebViewNavigationType)navigationType {
  if ([request.URL.relativeString rangeOfString:@"youguu://get_risk_preference?preference="].length > 0) {
    // http://119.253.36.116/financeMarketWeb/financeMarket/riskTest
    // youguu://get_risk_preference?preference=10
    NSArray *array = [request.URL.relativeString componentsSeparatedByString:@"preference="];
    if ([array count] >= 2) {
      //切换到出现的界面
      currentCallback([array[1] integerValue]);
    }
    [AppDelegate popViewController:YES];
    return NO;
  }
  return YES;
}
/** 加载完成 */
- (void)webViewDidFinishLoad:(UIWebView *)webView {
  loadingView.hidden = YES;
}
/** 加载失败 */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
  loadingView.hidden = NO;
  [loadingView animationNoNetWork];
}
@end
