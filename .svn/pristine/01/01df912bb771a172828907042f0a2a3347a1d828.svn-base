//
//  HeadImageView.m
//  优顾理财
//
//  Created by Mac on 15-4-15.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "HeadImageView.h"
#import "YGImageDown.h"
#import "UIImageView+WebCache.h"

@implementation HeadImageView

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
  }
  return self;
}
/** 有边框 */
- (void)haveBorderWithBorderColor:(NSString *)bordrColor {
  self.clipsToBounds = NO;
  //用户相片 底框
  [self.layer setMasksToBounds:YES];
  self.layer.cornerRadius = self.size.width / 2.0;
  [self.layer setBorderWidth:0.5f];
  [self.layer setBorderColor:[Globle colorFromHexRGB:bordrColor].CGColor];

  float imageRadius = self.width - 6.0f;
  //头像
  _headImageView = [[UIImageView alloc]
      initWithFrame:CGRectMake(3.0f, 3.0f, imageRadius, imageRadius)];
  _headImageView.userInteractionEnabled = YES;
  [_headImageView.layer setMasksToBounds:YES];
  [_headImageView.layer setCornerRadius:imageRadius / 2.0f];
  [self addSubview:_headImageView];
  //加v操作
  vipImageView = [[UIImageView alloc]
      initWithImage:[UIImage imageNamed:@"加V认证.png"]];
  vipImageView.frame = CGRectMake(self.width * 3 / 5, self.width * 3 / 5,
                                  self.width * 2 / 5, self.width * 2 / 5);
  [vipImageView.layer setMasksToBounds:YES];
  [vipImageView.layer setCornerRadius:self.width / 5.0f];
  [self addSubview:vipImageView];
  //夜间/白天切换
  [self Night_to_Day];
}
/** 无边框 */
- (void)withoutBorder {
  self.clipsToBounds = NO;
  //用户相片 底框
  [self.layer setMasksToBounds:YES];
  self.layer.cornerRadius = self.size.width / 2.0f;
  float imageRadius = self.width;
  //头像
  _headImageView = [[UIImageView alloc]
      initWithFrame:CGRectMake(0.0f, 0.0f, imageRadius, imageRadius)];
  _headImageView.userInteractionEnabled = YES;
  [self addSubview:_headImageView];
  [_headImageView.layer setBorderWidth:0.5f];
  [_headImageView.layer
      setBorderColor:[Globle colorFromHexRGB:@"000000" withAlpha:0.2f].CGColor];
  [_headImageView.layer setMasksToBounds:YES];
  [_headImageView.layer setCornerRadius:imageRadius / 2.0f];

  //加v操作
  vipImageView = [[UIImageView alloc]
      initWithImage:[UIImage imageNamed:@"加V认证.png"]];
  vipImageView.frame = CGRectMake(self.width * 3 / 5.0f, self.width * 3 / 5.0f,
                                  self.width * 2 / 5.0f, self.width * 2 / 5.0f);
  vipImageView.hidden = YES;
  [vipImageView.layer setMasksToBounds:YES];
  [vipImageView.layer setCornerRadius:self.width / 5.0f];
  [self addSubview:vipImageView];
  //夜间/白天切换
  [self Night_to_Day];
}
//判断，是否是，加V,用户
- (void)ishasVtype:(int)is_not {
  if (is_not > 0) {
    vipImageView.hidden = NO;
  } else {
    vipImageView.hidden = YES;
  }
}
//改变头像的大小
- (void)changeImageViewFrame:(CGRect)frame {
}

//刷新头像的图片
- (void)refreshHeadImageStr:(NSString *)urlstring {
  if (urlstring && [urlstring length] > 0) {
    [[YGImageDown sharedManager]
     add_image:urlstring
     completion:^(UIImage *img) {
       if (img) {
         _headImageView.image = img;
       } else {
         _headImageView.image = [UIImage imageNamed:@"头像无网络.png"];
       }
     }];
  } else {
    _headImageView.image = [UIImage imageNamed:@"头像无网络.png"];
  }
//  [_headImageView setImageWithURL:[NSURL URLWithString:urlstring] placeholderImage:[UIImage imageNamed:@"头像无网络.png"]];
}

- (void)dealloc {
  [self removeAllSubviews];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 选择，有图片，无图片等情况
- (void)Night_to_Day {
    self.backgroundColor = [UIColor whiteColor];
    [self.layer setBorderColor:[Globle colorFromHexRGB:@"c1c1c1"].CGColor];
    vipImageView.image = [UIImage imageNamed:@"加V认证"];
}

@end
