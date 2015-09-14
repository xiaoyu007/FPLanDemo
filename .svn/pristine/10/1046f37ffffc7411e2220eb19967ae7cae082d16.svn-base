//
//  AuthorizationViewController.m
//  优顾理财
//
//  Created by jhss on 15-4-10.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPAuthorizationViewController.h"
#import "FPSetPasswordViewController.h"
#import "NetLoadingWaitView.h"

@interface FPAuthorizationViewController () <UIWebViewDelegate>

@end

@implementation FPAuthorizationViewController {

  ///导航按钮
  IBOutlet UIButton *navgBtn;
  
  UIWebView *YGWebView;
  
  NSString *rstcodeStr;
  NSString *userauthcodeStr;
  NSString *succesStr;
  NSString *failStr;
 
}
//移除当前界面
- (void)removeCurrentView {
  [self removeFromParentViewController];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  //接收完成页通知移除当前页面

  

  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(removeCurrentView)
                                               name:@"remove_before_view"
                                             object:nil];

  
  [self loadWepPage];
  
  
//  [self CreatNavBarWithTitle:@"用户授权"];
//
//  self.childView.userInteractionEnabled = YES;
  
  UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, windowWidth, 50)];
  view.backgroundColor = [UIColor whiteColor];
  [self.childView  addSubview:view];
  
  navgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  
  navgBtn.frame = CGRectMake(0, 0, 50, 50);
  [view addSubview:navgBtn];
  
  [navgBtn addTarget:self
                action:@selector(navBtn)
      forControlEvents:UIControlEventTouchUpInside];
  [navgBtn setImage:[UIImage imageNamed:@"返回小箭头.png"]
           forState:UIControlStateNormal];
  [navgBtn setImage:[UIImage imageNamed:@"返回小箭头.png"]
           forState:UIControlStateHighlighted];
  navgBtn.imageEdgeInsets = UIEdgeInsetsMake(15, 20, 15, 20);
  UIImage *highlightImage =
      [FPYouguUtil createImageWithColor:btnAccordingToTheNormal];
  [navgBtn setBackgroundImage:highlightImage
                     forState:UIControlStateHighlighted];
  UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, windowWidth, 50)];
  lab.text = @"用户授权";
  lab.textAlignment = NSTextAlignmentCenter;
  lab.textColor = [Globle colorFromHexRGB:@"f07533"];
  [view addSubview:lab];
}
//加载wep页
- (void)loadWepPage {
  YGWebView = [[UIWebView alloc]
      initWithFrame:CGRectMake(0,navigationHeght, windowWidth,
                               windowHeight)];
  [self.childView addSubview:YGWebView];

  NSString *path = [NSString
      stringWithFormat:@"https://test.zlfund.cn/mobile/trade/col_oauth/"
                       @"?from=yougu&mctcustno=%@&backurl=%@",
                    YouGu_User_USerid,@"http://192.168.1.12:4042//financeMarketWeb/financeMarket/"
                    @"oauthCallBackZL?refer=zlfund"];
  
  
  
//  NSString *path = [NSString stringWithFormat:@"https://test.zlfund.cn/mobile/trade/col_oauth/?from=yougu"];
  
  
  NSURL *url = [NSURL URLWithString:path];

  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  // 3下载请求的数据
  [YGWebView loadRequest:request];

  YGWebView.delegate = self;
}
- (void)navBtn {
  [self.navigationController popToRootViewControllerAnimated:YES];

}
- (BOOL)webView: (UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest
*)request navigationType:(UIWebViewNavigationType)navigationType{
  self.loading.hidden = YES;
  if ([request.URL.relativeString
       rangeOfString:@"financeMarketWeb/financeMarket/oauthCallBackZL?refer=zlfund&rstcode=40"]
      .length > 0) {
    succesStr = [NSString
                 stringWithFormat:@"%@financeMarketWeb/financeMarket/oauthCallBackZL?refer=zlfund&rstcode=40&rstmsg=授权成功&mctcustno=", IP_HTTP_SHOPPING] ;
    [self sendSetPassword:succesStr];
    
      }
  
  if ([request.URL.relativeString
       rangeOfString:@"financeMarketWeb/financeMarket/oauthCallBackZL?refer=zlfund&rstcode=25"]
      .length > 0) {
      failStr =[NSString
              stringWithFormat:@"%@financeMarketWeb/financeMarket/oauthCallBackZL?refer=zlfund&rstcode=25&rstmsg=亲，您之前已经授权过啦&mctcustno=", IP_HTTP_SHOPPING] ;
    [self sendSetPassword:failStr];
  }
return YES;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
{
  if (error) {
    if (error.code == -1009 || error.code == -1003) {
      self.loading.hidden = NO;
      YouGu_animation_Did_Start(networkFailed);
    } else
      self.loading.hidden = YES;
      YouGu_animation_Did_Start(error.userInfo[@"NSLocalizedDescription"]);
  }
}

//发送数据请求
- (void)sendSetPassword:(NSString *)string {
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  [NetLoadingWaitView startAnimating];
  
  
  [[WebServiceManager sharedManager]sendRequestWithAuthorizationPageRstcode:string  withCompletion:^(NSDictionary *dic)
  
  {
     if (dic && [[dic objectForKey:@"status"]
                 isEqualToString:@"0000"]) {
       [NetLoadingWaitView stopAnimating];
       
       [self setPassWordViewController];
       
     } else {
       [NetLoadingWaitView stopAnimating];
       if (dic && [[dic objectForKey:@"status"]
                   isEqualToString:@"1001"]) {
         
         
         [self setPassWordViewController];
       }
       if (dic && [[dic objectForKey:@"status"]
                   isEqualToString:@"1002"]) {
         
         [self setPassWordViewController];
         
       }

       [NetLoadingWaitView stopAnimating];
       NSString *message = [NSString
                            stringWithFormat:@"%@",
                            [dic
                             objectForKey:@"message"]];
       if (!message || [message length] == 0 ||
           [message isEqualToString:@"(null)"]) {
         message = networkFailed;
       }
       if (dic &&
           [dic[@"status"] isEqualToString:@"0101"]){
       }else{
         YouGu_animation_Did_Start(message);
       }
       return;
     }
    
   }];
}
-(void)setPassWordViewController{
  FPSetPasswordViewController *set = [[FPSetPasswordViewController alloc]init];
  
  [AppDelegate pushViewControllerFromRight:set];
  
}
- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
