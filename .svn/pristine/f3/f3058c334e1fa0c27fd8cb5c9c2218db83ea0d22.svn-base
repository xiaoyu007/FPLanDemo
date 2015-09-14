//
//  FundCell.m
//  优顾理财
//
//  Created by Mac on 15-4-16.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPFundCell.h"

@implementation FPFundCell

- (void)awakeFromNib {
  [_addOptionalBtn.layer setMasksToBounds:YES];
  [_addOptionalBtn.layer setCornerRadius:14.0f];
  _addOptionalBtn.imageEdgeInsets = UIEdgeInsetsMake(5.5f, 5.5f, 5.5f, 5.5f);
  UIImage *normalImage =
      [FPYouguUtil createImageWithColor:[Globle colorFromHexRGB:@"f07533"]];
  UIImage *highLightImage =
      [FPYouguUtil createImageWithColor:buttonHighLightColor];
  [_addOptionalBtn setBackgroundImage:normalImage
                             forState:UIControlStateNormal];
  [_addOptionalBtn setBackgroundImage:highLightImage
                             forState:UIControlStateHighlighted];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}

@end
