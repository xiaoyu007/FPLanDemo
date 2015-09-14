//
//  SimTopBannerView.m
//  SimuStock
//
//  Created by Mac on 13-8-16.
//  Copyright (c) 2013年 Mac. All rights reserved.
//

#import "SimTopBannerView.h"

@implementation SimTopBannerView

- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {

    sbv_bgView = [[UIView alloc]
        initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    sbv_bgView.backgroundColor = [Globle colorFromHexRGB:Color_Blue_but];
    [self addSubview:sbv_bgView];

    //加入侧滑按钮
    self.backButton = leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbutton.frame = CGRectMake(0, frame.size.height - 45, 50, 45);
    [leftbutton setImage:[UIImage imageNamed:@"返回键"]
                    forState:UIControlStateNormal];
    [leftbutton setImage:[UIImage imageNamed:@"返回键"]
                    forState:UIControlStateHighlighted];
    [leftbutton setBackgroundImage:[UIImage imageNamed:@"return_touch_down"]
                              forState:UIControlStateHighlighted];
    [leftbutton addTarget:self
                       action:@selector(leftButtonPress)
             forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftbutton];
    //加入页面名称lq
    self.sbv_nameLable = [[UILabel alloc]
        initWithFrame:CGRectMake(55,
                                 frame.size.height - 45, 190, 45)];
    self.sbv_nameLable.textColor = [UIColor whiteColor];
    self.sbv_nameLable.backgroundColor = [UIColor clearColor];
    self.sbv_nameLable.textAlignment = NSTextAlignmentLeft;
    self.sbv_nameLable.text = @"我的股友";
    self.sbv_nameLable.font = [UIFont systemFontOfSize:18];
    self.sbv_nameLable.clipsToBounds=YES;
    [self addSubview:self.sbv_nameLable];
  }
  return self;
}

///标题居中
- (void)setTitleCenter:(NSString *)text {
  if ([self.delegate respondsToSelector:@selector(hideRefreshButton)]) {
    [self.delegate hideRefreshButton];
  }
  leftbutton.hidden = YES;
  self.sbv_nameLable.hidden = YES;
  [self createTitlelabel:text];
  [self create_Left_Btn];
  [self createRightBtn];
}

/**
 *创建中间,标题
 */
- (void)createTitlelabel:(NSString *)text {
  //加入页面名称lq
  UILabel *titleLable = [[UILabel alloc]
      initWithFrame:CGRectMake(50, self.frame.size.height - 45,
                               self.frame.size.width - 100, 45)];
  titleLable.textColor = [UIColor whiteColor];
  titleLable.backgroundColor = [UIColor clearColor];
  titleLable.textAlignment = NSTextAlignmentCenter;
  titleLable.clipsToBounds=YES;
  titleLable.userInteractionEnabled = NO;
  titleLable.text = text;
  titleLable.font = [UIFont boldSystemFontOfSize:20];
  [self addSubview:titleLable];
}

/**
 *创建左部，发布按钮
 */
- (void)create_Left_Btn {
  UIButton *inviteButton = [UIButton buttonWithType:UIButtonTypeCustom];
  inviteButton.frame = CGRectMake(0, self.bounds.size.height - 45, 50, 45);
  inviteButton.backgroundColor = [UIColor clearColor];
  [inviteButton setTitleColor:[Globle colorFromHexRGB:@"4dfdff"]
                       forState:UIControlStateNormal];
  inviteButton.clipsToBounds = NO;
  [inviteButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
  [inviteButton setTitle:@"取消" forState:UIControlStateNormal];
  UIImage *leftImage = [[UIImage imageNamed:@"return_touch_down"]
      resizableImageWithCapInsets:UIEdgeInsetsMake(14, 14, 14, 14)];
  [inviteButton setBackgroundImage:leftImage
                            forState:UIControlStateHighlighted];
  [inviteButton addTarget:self
                     action:@selector(leftButtonPress:)
           forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:inviteButton];
}

/**
 *创建右部，发布按钮
 */
- (void)createRightBtn {
  //发布
  UIButton *inviteFriendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  inviteFriendBtn.frame = CGRectMake(self.frame.size.width - 50,
                                     self.bounds.size.height - 45, 50, 45);
  inviteFriendBtn.backgroundColor = [UIColor clearColor];
  [inviteFriendBtn setTitleColor:[Globle colorFromHexRGB:@"4dfdff"]
                        forState:UIControlStateNormal];
  inviteFriendBtn.clipsToBounds = NO;
  [inviteFriendBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
  [inviteFriendBtn setTitle:@"发布" forState:UIControlStateNormal];
  UIImage *rightImage = [[UIImage imageNamed:@"return_touch_down"]
      resizableImageWithCapInsets:UIEdgeInsetsMake(14, 14, 14, 14)];
  [inviteFriendBtn setBackgroundImage:rightImage
                             forState:UIControlStateHighlighted];
  [inviteFriendBtn addTarget:self
                      action:@selector(rightButtonPress:)
            forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:inviteFriendBtn];
}
- (void)leftButtonPress:(UIButton *)sender {
  if ([self.delegate respondsToSelector:@selector(leftButtonPress)]) {
    [self.delegate leftButtonPress];
  }
}

- (void)rightButtonPress:(UIButton *)sender {
  if ([self.delegate respondsToSelector:@selector(rightButtonPress)]) {
    [self.delegate rightButtonPress];
  }
}

- (void)leftButtonPress {
  //重新设置的处理逻辑块优先
  if (self.onBackButtonPressed) {
    self.onBackButtonPressed();
    return;
  }
  //滑动按钮点击
  if (self.delegate) {
    [self.delegate leftButtonPress];
  }
}
- (void)resetContentAndFlage:(NSString *)content Mode:(TopToolBarMode)modetype {
  if (content) {
    self.sbv_nameLable.text = content;
  }
  if (modetype == TTBM_Mode_Leveltwo) {
    //二级菜单模式
    [leftbutton setImage:[UIImage imageNamed:@"返回键"]
                    forState:UIControlStateNormal];
    [leftbutton setImage:[UIImage imageNamed:@"返回键"]
                    forState:UIControlStateHighlighted];
  }
}

@end
