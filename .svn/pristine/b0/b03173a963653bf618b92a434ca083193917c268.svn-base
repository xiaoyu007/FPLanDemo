//
//  NewsDetailBottomView.m
//  优顾理财
//
//  Created by Mac on 15/7/13.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "NewsDetailBottomView.h"
#import "LRGlowingButton.h"
#import "UIButton+Block.h"
#import "SQLDataHtmlstring.h"

@implementation NewsDetailBottomView
- (void)awakeFromNib {
  [super awakeFromNib];
  [_praiseLable.layer setMasksToBounds:YES];
  [_praiseLable.layer setCornerRadius:7.0f];

  [_commentNum.layer setMasksToBounds:YES];
  [_commentNum.layer setCornerRadius:7.0f];
  [self start];
}

- (void)setNewsId:(NSString *)newsId {
  _newsId = newsId;
  self.Ispraise = [[PraiseObject sharedManager] isDonePraise:_newsId];
  [self getPraiseStatus:self.Ispraise];
}
- (void)setChannlId:(NSString *)channlId {
  _channlId = channlId;
}
//赞_正文3.png
- (void)start {
  NSArray *images_1 = @[ @"赞_Home_Cell.png", @"发言.png", @"更多.png", @"收藏_正文.png", @"分享.png" ];
  NSArray *images_2 =
      @[ @"赞_Home_Cell1.png",
         @"发言1.png",
         @"更多1.png",
         @"收藏_正文1.png",
         @"分享1.png" ];
  CGFloat width = 320.0f / 5;
  for (int i = 0; i < 5; i++) {
    LRGlowingButton *btn =
        [[LRGlowingButton alloc] initWithFrame:CGRectMake(width * i, 1, width, self.height)];
    btn.tag = 1000 + i;
    UIEdgeInsets edginset = UIEdgeInsetsMake(5, 12, 5, 12);
    btn.imageEdgeInsets = edginset;
    [btn setImage:[UIImage imageNamed:images_1[i]] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:images_2[i]] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:images_2[i]] forState:UIControlStateSelected];
    btn.backgroundColor = [UIColor clearColor];
//    [btn addTarget:self
//                  action:@selector(tabBarButtonClicked:)
//        forControlEvents:UIControlEventTouchUpInside];
    [btn setOnButtonPressedHandler:^{
      [self tabBarButtonClicked:i];
    }];
    btn.glowsWhenHighlighted = YES;
    btn.highlightedGlowColor = [Globle colorFromHexRGB:@"cfcfcf"];
    [self addSubview:btn];
  }
  [self addSubview:_animationLable];
}
- (void)tabBarButtonClicked:(NSInteger)tag {
  NewsBotttomStatus type = (NewsBotttomStatus)tag;
  if (type == NewsList || type == NewsThirdShare) {
    if ([_delegate respondsToSelector:@selector(BtnClickedWithIndex:)]) {
      [_delegate BtnClickedWithIndex:type];
    }
    return;
  }
  //    无网络情况
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  switch (type) {
  case Newspraise: {
    if (_Ispraise == YES) {
      _praiseLable.hidden = NO;
      YouGu_animation_Did_Start(@"您已赞过了");
      return;
    } else {
      [self getPraisePath];
    }
  } break;
  case NewsReview: {
  } break;
  case Newscollect: {
  } break;
  default:
    break;
  }
  if ([_delegate respondsToSelector:@selector(BtnClickedWithIndex:)]) {
    [_delegate BtnClickedWithIndex:type];
  }
}
///赞接口
- (void)getPraisePath {
  //判断网络
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
  __weak NewsDetailBottomView *weakSelf = self;
  callBack.onSuccess = ^(NSObject *obj) {
    NewsDetailBottomView *strongSelf = weakSelf;
    if (strongSelf) {
      [[PraiseObject sharedManager] addPraise:1 andTalkId:_newsId];
      _Ispraise = YES;
      [strongSelf addpraiseNum:[@([_praiseLable.text intValue] + 1) stringValue]];
      _animationLable.hidden = NO;
      UIViewAnimationOptions options = UIViewAnimationCurveLinear | UIViewAnimationOptionAllowUserInteraction;
      [UIView animateWithDuration:1.0
                            delay:0.1
                          options:options
                       animations:^(void) {
                         _animationLable.frame = CGRectMake(40, 0, 20, 20);
                       }
                       completion:^(BOOL finished) {
                         _animationLable.hidden = YES;
                         _animationLable.frame = CGRectMake(40, 50, 20, 20);
                         //    气泡不隐藏
                         _praiseLable.hidden = NO;
                       }];
      //   赞过了，替换图片
      [self getPraiseStatus:YES];
    }
  };
  [NewsItemPraise requestNewsItemWithNewsId:self.newsId
                                AndChannlid:self.channlId
                               withCallback:callBack];
}
///收藏
- (void)collectBtnClick:(BOOL)iscollect {
  LRGlowingButton *button = (LRGlowingButton *)[self viewWithTag:1003];
  if (_IsCollect) {
    YouGu_animation_Did_Start(@"已取消收藏");

    [button setImage:[UIImage imageNamed:@"收藏_正文.png"] forState:UIControlStateNormal];
    _IsCollect = NO;
  } else {
    YouGu_animation_Did_Start(@"收藏成功");
    [button setImage:[UIImage imageNamed:@"收藏_正文1.png"] forState:UIControlStateNormal];
    _IsCollect = YES;
  }
}
#pragma mark - 看看这篇文章是否被赞过了
//赞初始状态
- (void)getPraiseStatus:(BOOL)ispraise {
  _Ispraise = ispraise;
  if (ispraise) {
    UIButton *btn = (UIButton *)[self viewWithTag:1000];
    [btn setImage:[UIImage imageNamed:@"赞_Home_Cell1.png"] forState:UIControlStateNormal];
  }
}

//收藏按钮
- (void)getCollectStatus:(BOOL)iscollect {
  _IsCollect = iscollect;
  UIButton *btn = (UIButton *)[self viewWithTag:1003];
  if (iscollect) {
    [btn setImage:[UIImage imageNamed:@"收藏_正文1.png"] forState:UIControlStateNormal];
  } else {
    [btn setImage:[UIImage imageNamed:@"收藏_正文.png"] forState:UIControlStateNormal];
  }
}
//赞按钮
- (void)addpraiseNum:(NSString *)num {
  if ([num intValue] == 0) {
    _praiseLable.hidden = YES;
  } else {
    _praiseLable.hidden = NO;
    //左右留3的空隙
    float labelWidth = [self getLableTextLength:num] + 8.0f;
    if (labelWidth > 14.0f) {
      _praiseLable.width = labelWidth;
    } else {
      _praiseLable.width = 14.0f;
    }
    _praiseLable.text = num;
  }
}

//列表按钮
- (void)getlistNum:(NSString *)num {
  
  if ([num intValue] == 0) {
    _commentNum.hidden = YES;
  } else {
    _commentNum.hidden = NO;
    //左右留3得空隙
    float listWidth = [self getLableTextLength:num] + 8;
    if (listWidth > 14.0f) {
      _commentNum.width = listWidth;
    } else {
      _commentNum.width = 14.0f;
    }
    _commentNum.text = num;
  }
}
#pragma mark - 计算cell的自适应高度
//测试文字的的高度
- (CGFloat)getLableTextLength:(NSString *)text {
  //   字型及大小
  UIFont *cellFont = [UIFont systemFontOfSize:10.0];

  CGFloat width = [text sizeWithFont:cellFont
                      constrainedToSize:CGSizeMake(60, 13)
                          lineBreakMode:NSLineBreakByCharWrapping]
                      .width;
  //    获得尺寸  UILineBreakModeWordWrap

  return width + 1;
}
//代理delegate
- (void)CollectNewsWithTitle:(NSString *)title {
  if (title && title.length > 0) {
    MyCollectItem *item =
        [MyCollectItem creatMyCollectWithObject:self.newsId AndType:1 andTitle:title];
    if (![[NewsWithDidCollect sharedManager] isCollectWithNewsID:item]) {
      //实名，收藏新闻
      HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
      __weak NewsDetailBottomView *weakSelf = self;
      callBack.onSuccess = ^(NSObject *obj) {
        NewsDetailBottomView *strongSelf = weakSelf;
        if (strongSelf) {
          NewsCollectRequest *collectObject = (NewsCollectRequest *)obj;
          if (collectObject && collectObject.fid) {
            //        添加收藏
            item.fid = collectObject.fid;
            [[NewsWithDidCollect sharedManager] addNewsId:item];
          }
        }
      };
      [NewsCollectRequest getNewsCollectWithNewsId:self.newsId
                                      andNewsTitle:title
                                           andType:@"1"
                                      withCallback:callBack];
    }
    else
    {
      if (item && item.fid.length>0) {
        //         实名 ，取消收藏
        HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
        __weak NewsDetailBottomView *weakSelf = self;
        callBack.onSuccess = ^(NSObject *obj) {
          NewsDetailBottomView *strongSelf = weakSelf;
          if (strongSelf) {
            //        取消收藏
            [[NewsWithDidCollect sharedManager] removeWithId:item];
//            [[SQLDataHtmlstring sharedManager] deleteUserWithId:self.newsId andChannlid:@"1"];
          }
        };
        [NewsCollectRequest getNewsCollectWithFid:item.fid withCallback:callBack];
      } else {
        //取消收藏
        [[NewsWithDidCollect sharedManager] removeWithId:item];
      }
    }
  }
}
@end
