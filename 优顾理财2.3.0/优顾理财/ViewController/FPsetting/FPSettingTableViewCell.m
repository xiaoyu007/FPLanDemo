//
//  FPSettingTableViewCell.m
//  优顾理财
//
//  Created by Mac on 15/7/3.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPSettingTableViewCell.h"

@implementation FPSettingTableViewCell

- (void)awakeFromNib {
  // Initialization code
  self.colorImageView.layer.masksToBounds = YES;
  self.colorImageView.layer.cornerRadius = self.colorImageView.height / 2.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
  // Configure the view for the selected state
}

@end
