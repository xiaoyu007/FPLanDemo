//
//  SettingVCTableViewCell.m
//  优顾理财
//
//  Created by Mac on 14-3-14.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "SettingVCTableViewCell.h"

@implementation SettingVCTableViewCell
@synthesize first_ImageView, first_label, D_View, Main_View;
@synthesize DI_View;
@synthesize is_Has_been_selected;
- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    is_Has_been_selected = NO;

    // Initialization code
    D_View = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, 296, 60)];
    D_View.contentMode = UIViewContentModeScaleToFill;
    D_View.userInteractionEnabled = NO;
    //        [[D_View layer]setBorderWidth:1];
    [self addSubview:D_View];

    first_ImageView =
        [[UIImageView alloc] initWithFrame:CGRectMake(9, 18, 24, 24)];
    first_ImageView.backgroundColor = [UIColor clearColor];
    [D_View addSubview:first_ImageView];

    first_label = [[UILabel alloc] initWithFrame:CGRectMake(54, 10, 140, 40)];
    first_label.backgroundColor = [UIColor clearColor];
    first_label.font = [UIFont systemFontOfSize:16.0f];
    first_label.textAlignment = NSTextAlignmentLeft;
    //        first_label.adjustsFontSizeToFitWidth=YES;
    [self addSubview:first_label];

    Main_View = [[UIView alloc] initWithFrame:CGRectMake(150, 0, 150, 60)];
    [self addSubview:Main_View];

    DI_View = [[UIView alloc] initWithFrame:CGRectMake(20, 59, 248, 1)];
    [D_View addSubview:DI_View];

    DI_View.backgroundColor = [Globle colorFromHexRGB:@"e7e7e7"];
    first_label.textColor = [UIColor blackColor];
  }
  return self;
}

//添加毛边
- (void)add_layer_View_code:(int)i {
  switch (i) {
  case 1: {
      D_View.image =
          [[UIImage imageNamed:@"cell_上"] stretchableImageWithLeftCapWidth:5
                                                               topCapHeight:0];
  } break;

  case 2: {
      D_View.image =
          [[UIImage imageNamed:@"cell_中"] stretchableImageWithLeftCapWidth:5
                                                               topCapHeight:0];

  } break;

  case 3: {
      D_View.image =
          [[UIImage imageNamed:@"cell_下"] stretchableImageWithLeftCapWidth:5
                                                               topCapHeight:60];
  } break;

  default:
    break;
  }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
  if (highlighted == YES) {
    if (is_Has_been_selected) {
      return;
    }
      D_View.backgroundColor = [Globle colorFromHexRGB:@"dfdfdf"];
  } else {
    D_View.backgroundColor = [UIColor whiteColor];
  }
  [super setHighlighted:highlighted animated:animated];
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
