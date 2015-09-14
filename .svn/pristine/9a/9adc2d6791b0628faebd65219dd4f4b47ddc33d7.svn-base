//
//  SepcialtableViewCell.m
//  优顾理财
//
//  Created by Mac on 14-3-12.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "SepcialtableViewCell.h"

@implementation SepcialtableViewCell
@synthesize imageview_head, label_data, isSelect;
- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    // Initialization code
    imageview_head =
        [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"圆.png"]];
    imageview_head.frame = CGRectMake(20, 17, 15, 15);
    [self addSubview:imageview_head];

    label_data = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 240, 30)];
    label_data.backgroundColor = [UIColor clearColor];
    label_data.textAlignment = NSTextAlignmentLeft;
    label_data.font = [UIFont systemFontOfSize:15];
    label_data.numberOfLines = 1;
    [self addSubview:label_data];
    isSelect = NO;
    self.backgroundColor = [UIColor whiteColor];
    label_data.textColor = [Globle colorFromHexRGB:@"1c1c1c"];
  }
  return self;
}
- (void)cell_backgroundcolor_label {
    label_data.textColor = [Globle colorFromHexRGB:@"989898"];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {

  if (highlighted == YES) {
      self.backgroundColor = [Globle colorFromHexRGB:@"dcdcdc"];

  } else {
      self.backgroundColor = [Globle colorFromHexRGB:customBGColor];
  }
  [super setHighlighted:highlighted animated:animated];
}
@end
