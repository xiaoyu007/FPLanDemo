//
//  Collection_Cell.m
//  DDMenuController
//
//  Created by mac on 13-7-29.
//
//

#import "Collection_Cell.h"

@implementation Collection_Cell
@synthesize label_data;
@synthesize is_Has_been_selected;
@synthesize is_Uncheck;
- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {

    self.backgroundColor = [UIColor clearColor];
    // Initialization code

    imageview_head = [[UIView alloc] initWithFrame:CGRectMake(15, 20, 10, 10)];
    imageview_head.backgroundColor = [Globle colorFromHexRGB:@"0077dc"];
    imageview_head.layer.cornerRadius = 5;
    [self addSubview:imageview_head];

    label_data = [[UILabel alloc] initWithFrame:CGRectMake(35, 15, 250, 20)];
    label_data.backgroundColor = [UIColor clearColor];
    label_data.textAlignment = NSTextAlignmentLeft;
    label_data.textColor = [Globle colorFromHexRGB:textfieldContentColor];
    label_data.font = [UIFont systemFontOfSize:15.0f];
    label_data.numberOfLines = 1;
    [self addSubview:label_data];
    //        设置背景
    label_data.textColor = [Globle colorFromHexRGB:@"1c1c1c"];
  }
  return self;
}
- (void)dealloc {
  [self removeAllSubviews];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {

  if (is_Uncheck) {
    return;
  }

  if (highlighted == YES) {
    self.backgroundColor = [Globle colorFromHexRGB:@"d8d8d8"];
  } else {
    self.backgroundColor = [UIColor clearColor];
  }
  [super setHighlighted:highlighted animated:animated];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}

@end
