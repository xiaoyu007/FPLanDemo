//
//  FundTradeRuleViewController.m
//  优顾理财
//
//  Created by Mac on 15/7/27.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPFundTradeRuleViewController.h"

@implementation FPFundTradeRuleViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.topNavView.mainLableString = @"收益及取出规则";
  [self loadWapPage];
  loadingView =
      [[LoadingView alloc] initWithFrame:CGRectMake(0, 0, windowWidth, windowHeight - navigationHeght - statusBarHeight)];
  loadingView.delegate = self;
  loadingView.userInteractionEnabled = YES;
  [self.childView addSubview:loadingView];
  NSLog(@"subviews = %@", self.view.subviews);
}
//加载wap页
- (void)loadWapPage {
  UIWebView *webview =
      [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, windowWidth, windowHeight - navigationHeght - statusBarHeight)];
  webview.delegate = self;
  //滑动快慢控制参数
  webview.scrollView.decelerationRate = 1.0f;
  [self.childView addSubview:webview];
  NSString *path =
      [NSString stringWithFormat:@"%@mobile/wap_agreement/areement_commonproblem.html", FundDetailIP];
  NSURL *url = [NSURL URLWithString:path];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  // 3下载请求的数据
  [webview loadRequest:request];
}
#pragma mark - loading 代理方法
- (void)refreshNewInfo {
  if ([FPYouguUtil isExistNetwork]) {
    //加载网络请求
    [self loadWapPage];
  }
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
