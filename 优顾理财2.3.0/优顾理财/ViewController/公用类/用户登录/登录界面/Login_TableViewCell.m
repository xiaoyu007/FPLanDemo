//
//  Login_TableViewCell.m
//  优顾理财
//
//  Created by Mac on 14-8-4.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "Login_TableViewCell.h"

@implementation Login_TableViewCell
@synthesize label;
- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    // Initialization code
    label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 120, 30)];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:14.0f];
    label.backgroundColor = [UIColor clearColor];
    [self addSubview:label];

    DI_View = [[UIView alloc] initWithFrame:CGRectMake(0, 39, 278, 0.5f)];
    [self addSubview:DI_View];

    [self Night_to_Day];
  }
  return self;
}

//设置cell的背景颜色
- (void)Night_to_Day {
    DI_View.backgroundColor = [Globle colorFromHexRGB:textfieldBordColor];
    self.backgroundColor = [Globle colorFromHexRGB:customBGColor];
    label.textColor = [Globle colorFromHexRGB:textfieldContentColor];
}

- (void)awakeFromNib {
  // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}

@end
