//
//  ReplyMeCell.m
//  优顾理财
//
//  Created by Mac on 15-4-9.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPReplyMeCell.h"

@implementation FPReplyMeCell

- (void)awakeFromNib {
  [_userHeadImageView.layer setMasksToBounds:YES];
  [_userHeadImageView.layer setCornerRadius:17.0f];
}

@end
