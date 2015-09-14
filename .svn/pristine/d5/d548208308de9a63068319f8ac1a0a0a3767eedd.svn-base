//
//  CommunicationCenterTableViewCell.m
//  优顾理财
//
//  Created by Mac on 15/3/20.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

/*
 该类是交流中心页上自定制的cell类
 */

#import "FPCommunicationCenterTableViewCell.h"

@implementation FPCommunicationCenterTableViewCell

- (void)awakeFromNib {
  [super awakeFromNib];
  // icon背景圆滑
  [_iconBGImageView.layer setMasksToBounds:YES];
  [_iconBGImageView.layer setCornerRadius:15.0f];
  _unreadNum.layer.masksToBounds = YES;
  _unreadNum.layer.cornerRadius = 11.0;
}
- (void)setIconBGImageViewColor:(NSString *)bgColor {
  UIImage *image =
      [FPYouguUtil createImageWithColor:[Globle colorFromHexRGB:bgColor]];
  [_iconBGImageView setImage:image];
}
@end
