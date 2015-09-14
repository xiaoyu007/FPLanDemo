//
//  QATableViewCell.m
//  优顾理财
//
//  Created by Mac on 15/7/20.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "QATableViewCell.h"

@implementation QATableViewCell
- (void)awakeFromNib {
  // Initialization code
  _firstView.layer.cornerRadius = _firstView.height / 2;

  _contentLable.fontSize = [UIFont systemFontOfSize:15.f];
  _contentLable.lineLimit = 3;
  _contentLable.linsSpacing = 10;
  _contentLable.lineBreakMode = NSLineBreakByTruncatingTail;
  _contentLable.nameColor = [Globle colorFromHexRGB:@"14a5f0"];
}

#pragma mark - dealloc
- (void)dealloc {
  [self removeAllSubviews];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//判断是不是第一个，cell
- (void)JudgeFirst:(BOOL)isright {
  if (isright) {
    _firstView.hidden = NO;
    _lineView.frame = CGRectMake(30, 10, 2, 50);
  } else {
    _firstView.hidden = YES;
    _lineView.frame = CGRectMake(30, 0, 2, 60);
  }
}
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
  if (highlighted == YES) {
    self.backgroundColor = [Globle colorFromHexRGB:@"d2dde2"];
  } else {
    self.backgroundColor = [UIColor clearColor];
  }
  [super setHighlighted:highlighted animated:animated];
}
@end
