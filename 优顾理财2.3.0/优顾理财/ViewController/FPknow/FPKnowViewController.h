//
//  FPKnowViewController.h
//  优顾理财
//
//  Created by Mac on 15/6/29.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPNoTitleViewController.h"
#import "MyQuestionView.h"
#import "MyQuestionViewController.h"

@interface FPKnowViewController : FPNoTitleViewController<UIScrollViewDelegate>{
  //  添加了一个提交问题，按钮
  MyQuestionView *summit_btn;
  
  UIView *_topCuttingView;///滑动先
}
@property(nonatomic, strong) UIScrollView *rootScrollView;
@property(nonatomic, strong) UIView *topScrollView;
@property(nonatomic, assign) NSInteger userSelectedChannelID;
@end
