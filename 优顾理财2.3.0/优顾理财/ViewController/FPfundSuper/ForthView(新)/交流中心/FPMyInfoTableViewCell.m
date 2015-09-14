//
//  FPMyInfoTableViewCell.m
//  优顾理财
//
//  Created by Mac on 15/8/12.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPMyInfoTableViewCell.h"
#import "UserDetailViewController.h"
@implementation FPMyInfoTableViewCell
- (void)awakeFromNib {
  // Initialization code
  self.userPicHeaderImage.delegate = self;
  //评论内容
  _contentLable.fontSize = [UIFont systemFontOfSize:15.f];
  _contentLable.lineLimit = 3;
  _contentLable.linsSpacing = 10;
  _contentLable.lineBreakMode = NSLineBreakByTruncatingTail;
  _contentLable.nameColor = [Globle colorFromHexRGB:@"14a5f0"];

  //添加长按手势
  _longPress = [[UILongPressGestureRecognizer alloc] init];
  [self addGestureRecognizer:_longPress];
}
- (void)setUserListItem:(UserListItem *)userListItem {
  _userListItem = userListItem;
  if (userListItem) {
    self.userNameBtn.userInteractionEnabled = YES;
    [self.userPicHeaderImage setUserInfoWithUserListItem:userListItem];
    self.userName.text = userListItem.nickName;
  } else {
    self.userName.text = @"游客";
  }
}
#pragma 头像昵称点击
- (void)picBtnClick:(NSInteger)index { // event 日志
  [[event_view_log sharedManager] event_log:@"1000039"];
  [MobClick event:@"1000039"];
  if (self.userListItem) {
    UserDetailViewController *userVC = [[UserDetailViewController alloc]
        initWithUserListItem:self.userListItem];
    [userVC.headerView setValue:self.userListItem];
    [AppDelegate pushViewControllerFromRight:userVC];
  }
}
- (IBAction)userNameBtnClick:(UIButton *)sender {
  [self picBtnClick:sender.tag];
}

///系统消息头像处理
- (void)systemDefaultWithPic:(NSString *)headpic
                 andNickname:(NSString *)nickname {
  self.userPicHeaderImage.picImage.image = [UIImage imageNamed:headpic];
  [self.userPicHeaderImage ishasVtype:0];
  self.userName.text = nickname;
  self.userNameBtn.userInteractionEnabled = NO;
}
- (void)setIsRead:(BOOL)isRead {
  _isRead = isRead;
  if (isRead) {
    _userName.textColor = [Globle colorFromHexRGB:@"656565"];
    _contentLable.mainColor = [Globle colorFromHexRGB:@"656565"];
  } else {
    _userName.textColor = [UIColor blackColor];
    _contentLable.mainColor = [UIColor blackColor];
  }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
  if (highlighted == YES) {
    self.backgroundColor = [Globle colorFromHexRGB:@"E1E1E1"];
  } else {
    self.backgroundColor = [Globle colorFromHexRGB:customBGColor];
  }
  [super setHighlighted:highlighted animated:animated];
}
@end
