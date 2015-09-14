//
//  RelatedArticlesTableViewCell.m
//  优顾理财
//
//  Created by Mac on 15/7/14.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "RelatedArticlesTableViewCell.h"

@implementation RelatedArticlesTableViewCell

- (void)awakeFromNib {
    // Initialization code
  self.titleLable.layer.cornerRadius = 5;
}
//- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
//  if (highlighted == YES) {
//    self.titleLable.backgroundColor = [Globle colorFromHexRGB:@"989898"];
//  } else {
//    self.titleLable.backgroundColor = [UIColor clearColor];
//  }
//  [super setHighlighted:highlighted animated:animated];
//}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


@end
