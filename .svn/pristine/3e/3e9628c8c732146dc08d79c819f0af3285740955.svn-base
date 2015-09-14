//
//  OptionalManageCell.m
//  优顾理财
//
//  Created by Mac on 15-4-21.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPOptionalManageCell.h"

@implementation FPOptionalManageCell

- (void)awakeFromNib {
  [_radioButton.layer setBorderWidth:0.5f];
  [_radioButton.layer
      setBorderColor:[Globle colorFromHexRGB:customFilledColor].CGColor];
  _radioButton.imageEdgeInsets = UIEdgeInsetsMake(5, 4, 5, 4);
  _radioImageView.hidden = YES;
}

- (IBAction)radioButtonClicked:(UIButton *)sender {
  if (_radioImageView.hidden) {
    _radioImageView.hidden = NO;
  } else {
    _radioImageView.hidden = YES;
  }
}
@end
