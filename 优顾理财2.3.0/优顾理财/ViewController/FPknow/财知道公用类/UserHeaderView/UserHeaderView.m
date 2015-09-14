//
//  UserHeaderView.m
//  优顾理财
//
//  Created by Mac on 14-3-21.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//
//其介如石
#import "UserHeaderView.h"

@implementation UserHeaderView
- (id)initWithCoder:(NSCoder*)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
  }
  return self;
}
- (id)initWithFrame:(CGRect)frame {
  UserHeaderView* userHeaderView =
      [[[NSBundle mainBundle] loadNibNamed:@"UserHeaderView"
                                     owner:self
                                   options:nil] firstObject];
  userHeaderView.frame = frame;
  return userHeaderView;
}
- (void)awakeFromNib {
  [super awakeFromNib];
  self.picView.delegate = self;
}


- (void)setValue:(UserListItem*)item {
  if (!item) {
    _nameLable.text = @"游客";
    self.picView.picImage.image = [UIImage imageNamed:@"头像无网络.png"];
    _signLable.text = @"注册登录,设置个性化签名";
    [self.picView ishasVtype:NO];
    return;
  }
  if (item.nickName.length > 0) {
    _nameLable.text = item.nickName;
  } else {
    _nameLable.text = @"游客";
  }
  //        获取用户的签名
  if ([item.userId intValue]>0) {
    if (item.signature.length > 0) {
      _signLable.text = item.signature;
    } else {
      _signLable.text = @"该用户正在构思一个伟大的签名";
    }
  }
  else{
    _signLable.text = @"注册登录,设置个性化签名";
  }

  if (item.CertifySignature.length > 0 &&
      [item.CertifySignature isEqualToString:@"<null>"] == NO) {
    [self.picView ishasVtype:YES];
  } else {
    [self.picView ishasVtype:NO];
  }
  [self.picView down_pic:item.headPic];
}
#pragma mark - 用户头像，昵称点击事件
- (IBAction)picAndnameClickBtn:(id)sender {
  if (!self.isClick) {
    NSLog(@"不让点击头像和昵称");
    return;
  }
  if ([_delegate respondsToSelector:@selector(USerPicBtnClick)]) {
    [_delegate USerPicBtnClick];
  }
}
- (void)picBtnClick:(NSInteger)index
{
  [self picAndnameClickBtn:nil];
}

#pragma mark - 注销消息中心
- (void)dealloc {
  [self removeAllSubviews];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
