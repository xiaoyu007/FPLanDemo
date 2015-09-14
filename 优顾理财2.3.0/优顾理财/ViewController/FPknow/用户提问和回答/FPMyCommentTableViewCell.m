//
//  FPMyCommentTableViewCell.m
//  优顾理财
//
//  Created by Mac on 15/8/11.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPMyCommentTableViewCell.h"

@implementation FPMyCommentTableViewCell

- (void)awakeFromNib {
  // Initialization code
  //评论内容
  self.commentLabel.fontSize = [UIFont systemFontOfSize:15.f];
  self.commentLabel.lineLimit = 2;
  self.commentLabel.linsSpacing = 8;
  self.commentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
  self.commentLabel.nameColor = [Globle colorFromHexRGB:@"14a5f0"];

  [self.commentTitleLabel setFont:[UIFont systemFontOfSize:16.0f]];
  //添加长按手势
  _longPress = [[UILongPressGestureRecognizer alloc] init];
  [self addGestureRecognizer:_longPress];
}

- (void)setIsRead:(BOOL)isRead {
  _isRead = isRead;
  if (isRead) {
    _commentLabel.textColor = [Globle colorFromHexRGB:@"656565"];
  } else {
    _commentLabel.textColor = [Globle colorFromHexRGB:@"5b5f62"];
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}

@end
