//
//  UserPicViewCell.m
//  优顾理财
//
//  Created by Mac on 14-4-30.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "UserPicViewCell.h"

@implementation UserPicViewCell
@synthesize first_label;
- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.backgroundColor = [UIColor clearColor];

    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(20, 10, 260, 40)];
    view1.layer.cornerRadius = 5;
    view1.clipsToBounds = YES;
    [self addSubview:view1];

    first_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 260, 40)];
    first_label.font = [UIFont systemFontOfSize:20];
    first_label.alpha = 0.8;
    first_label.textAlignment = NSTextAlignmentCenter;
    [view1 addSubview:first_label];

    self.backgroundColor = [UIColor colorWithRed:255 / 255.0f
                                           green:255 / 255.0f
                                            blue:255 / 255.0f
                                           alpha:1.0];
  }
  return self;
}

//按钮的颜色
- (void)button_color:(BOOL)sender {
  if (sender == YES) {
    first_label.backgroundColor = [Globle colorFromHexRGB:@"bdbdbd"];
    first_label.textColor = [Globle colorFromHexRGB:@"ffffff"];
  } else {
    first_label.backgroundColor = [Globle colorFromHexRGB:@"f65f5b"];
    first_label.textColor = [Globle colorFromHexRGB:@"ffffff"];
  }
}

- (void)dealloc {
  [self removeAllSubviews];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}
@end
