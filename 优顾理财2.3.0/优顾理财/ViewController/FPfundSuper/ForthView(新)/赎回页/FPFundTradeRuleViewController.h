//
//  FundTradeRuleViewController.h
//  优顾理财
//
//  Created by Mac on 15/7/27.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPBaseViewController.h"
#import "LoadingView.h"
@interface FPFundTradeRuleViewController : FPBaseViewController<UIWebViewDelegate, LoadingView_delegate>
{
  //请求菊花
  LoadingView *loadingView;
}
@end
