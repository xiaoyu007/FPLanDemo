//
//  RiskEvaluatingViewController.h
//  优顾理财
//
//  Created by Mac on 15-4-13.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPBaseViewController.h"
#import "FPFundShopViewController.h"
/** 回传评测等级 */
typedef void (^evaluateLevel)(FundType level);
/** 风险评测 */
@interface FPRiskEvaluatingViewController
    : FPBaseViewController <UIWebViewDelegate,LoadingView_delegate> {
  evaluateLevel currentCallback;
  /** 无网提示 */
  LoadingView *loadingView;
  //加载webView
  UIWebView *YGWebView;
}
/** 带回调的初始化 */
- (id)initWithCallback:(evaluateLevel)callback;

@end
