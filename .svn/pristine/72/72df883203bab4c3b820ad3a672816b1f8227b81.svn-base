//
//  KnowDetailTableViewHeaderView.m
//  优顾理财
//
//  Created by Mac on 15/7/26.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "KnowDetailTableViewHeaderView.h"
#import "UserDetailViewController.h"
#import "YouGuNewsUtil.h"
@implementation KnowDetailTableViewHeaderView
- (void)awakeFromNib {
  [super awakeFromNib];
  self.picHeaderView.delegate = self;
  //评论内容
  [_contentText setFont:[UIFont systemFontOfSize:[YouGu_Font_text_Model integerValue] - 3]];
  [_contentText setTextAlignment:RTTextAlignmentJustify];
  [_contentText setParagraphReplacement:@""];
  _contentText.lineSpacing = 7.0f;
  
  [_nickNameBtn setBackgroundImage:[YouGuNewsUtil imageFromColor:@"989898" alpha:0.4] forState:UIControlStateHighlighted];
}

- (IBAction)nickNameBtnClick:(id)sender {
  [self picBtnClick:0];
}
#pragma 代理
- (void)picBtnClick:(NSInteger)index
{
  if (self.userListItem) {
    UserDetailViewController* userVC =
    [[UserDetailViewController alloc] initWithUserListItem:self.userListItem];
    [userVC.headerView setValue:self.userListItem];
    [AppDelegate pushViewControllerFromRight:userVC];
  }
}

+ (RTLabel *)textLabel {
  RTLabel *label = [[RTLabel alloc] initWithFrame:CGRectMake(20, 50, 280, 20)];
  label.backgroundColor = [UIColor clearColor];
  [label setFont:[UIFont systemFontOfSize:[YouGu_Font_text_Model integerValue] - 3]];
  [label setTextAlignment:RTTextAlignmentJustify];
  label.lineSpacing = 7.0f;
  [label setParagraphReplacement:@""];
  return label;
}

- (void)getContentWithText:(KnowDetailItem *)item {
  self.userListItem = item.userListItem;
  self.userName.text = item.userListItem.nickName;
  if (item.title.length>0) {
    self.titleName.text = item.title;
    self.height = 81 + 20 + [self headeViewHeight:item];
  } else {
    self.height = 81 + [self headeViewHeight:item];
  }
  self.timeLable.text = item.creatTime;
  [self.picHeaderView down_pic:item.userListItem.headPic];
  self.contentText.text = [self htmlText:item];
}

#pragma mark - 计算cell的高度，和，html的形成
//计算cell的高度
- (CGFloat)headeViewHeight:(KnowDetailItem *)item {
  RTLabel *rtLabel = [KnowDetailTableViewHeaderView textLabel];
  [rtLabel setText:[self htmlText:item]];
  CGSize optimumSize = [rtLabel optimumSize];
  return optimumSize.height + 2;
}

//组成html，的文本，
- (NSString *)htmlText:(KnowDetailItem *)item {
  NSString *content = item.content;
  if (item) {
    if (item.sourceType == 2) {
      content = [NSString stringWithFormat:@"<font color=#14a5f0><a "
                                           @"href='http://store.apple.com'>#%@#</" @"a></font>%@",
                                           item.title, content];
      return content;
    } else if (item.sourceType == 0) {
    }
    if ([item.rotBeNickname length] > 0) {
      content =
          [NSString stringWithFormat:@"<p><font color=#14a5f0>@%@:</font></p><font> %@</font>", item.rotBeNickname, content];
    }
  }
  return content;
}

@end
