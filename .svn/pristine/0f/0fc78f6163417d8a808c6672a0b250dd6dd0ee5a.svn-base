//
//  ProductAgreementViewController.m
//  优顾理财
//
//  Created by jhss on 15-5-14.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//
/**
 该类主要是优购协议类，读取出协议的内容
 */
#import "FPProductAgreementViewController.h"

@interface FPProductAgreementViewController () <UIScrollViewDelegate>

@end

@implementation FPProductAgreementViewController

    {
///
//  UIScrollView *productScrollView;
      
      
}
- (void)viewDidLoad {
  [super viewDidLoad];

  [self CreatNavBarWithTitle:@"优顾理财产品协议"];

  //文本自适应
//  NSString *content = [self readFile];
//  UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(5, navigationHeght, windowWidth - 10, windowHeight - navigationHeght)];
//  textView.showsVerticalScrollIndicator = NO;
//  textView.font = [UIFont systemFontOfSize:12.0f];
//  textView.textColor = [Globle colorFromHexRGB:@"4d433e"];
//  textView.text = content;
//  [self.childView addSubview:textView];
 
  
  
  [self loadWepPage];
  
  
}
//加载wep页
-(void)loadWepPage
{
  UIWebView * YGWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 50, windowWidth,windowHeight-70)];
  [self.childView addSubview: YGWebView];
  //1.创建资源路径
  
  NSURL *url=[NSURL URLWithString:@"http://test.youguu.com/mobile/wap_agreement/agreement_yougou.html"];
  //2.创建请求
  NSURLRequest *request=[NSURLRequest requestWithURL:url];
  //3下载请求的数据
  [YGWebView loadRequest:request];
}


//- (NSString *)readFile {
//  NSString *str = [[NSString alloc]
//      initWithData:[NSData dataWithContentsOfFile:
//                               [[NSBundle mainBundle]
//                                   pathForResource:@"优购开户协议"
//                                            ofType:@"txt"]]
//          encoding:NSUTF8StringEncoding];
//
//  return str;
//}

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
