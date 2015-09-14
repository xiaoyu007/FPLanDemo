//
//  FackBackCell.m
//  优顾理财
//
//  Created by Mac on 14-3-27.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "FackBackCell.h"

@implementation FackBackCell
//@synthesize P_name;
@synthesize Text_Content = _Text_Content;
@synthesize lable_time;
- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    // Initialization code
    [self start];
  }
  return self;
}
- (void)start {
  lable_time = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 160, 20)];
  lable_time.textAlignment = NSTextAlignmentCenter;
  lable_time.backgroundColor = [UIColor clearColor];
  lable_time.font = [UIFont systemFontOfSize:10];
  [self addSubview:lable_time];

  Main_View =
      [[TriangleView alloc] initWithFrame:CGRectMake(16, 30, 250, 20)];
  Main_View.layer.cornerRadius = 20;
  [Main_View San_JIAO_Frame:YES];
  [self addSubview:Main_View];

  img_View =
      [[PicUserHeader alloc] initWithFrame:CGRectMake(270, 30, 40, 40)];
  [self addSubview:img_View];

  _Text_Content = [FackBackCell textLabel];
  [Main_View addSubview:_Text_Content];

  //选择cell的背景色
  [self Night_to_Day];
}

+ (RTLabel *)textLabel {
  RTLabel *label = [[RTLabel alloc] initWithFrame:CGRectMake(10, 10, 220, 20)];
  label.backgroundColor = [UIColor clearColor];
  [label setFont:[UIFont systemFontOfSize:13.0f]];
  [label setTextAlignment:RTTextAlignmentJustify];
  label.lineSpacing = 5;
  [label setParagraphReplacement:@""];
  return label;
}

- (void)Select_Users:(BOOL)is_who andHeight:(float)height {
  _Text_Content.height = height;
  [Main_View SET_VIEW_Height:20 + height];

  if (is_who) {
    img_View.picImage.image = [UIImage imageNamed:@"小优"];
    img_View.left = 10;
    Main_View.left = 54;
    //        P_name.text=@"客服小优:";
    [Main_View SET_San_background:NO];
    _Text_Content.left = 20;
    if ((int)height < 17) {
      [Main_View SAN_IMG_Width:[self setTitleName:_Text_Content.text]
                and_left_right:NO];
    }
  } else {
    UserListItem * item =[FileChangelUtil loadUserListItem];
    [img_View down_pic:item.headPic];
    img_View.left = 270;
    Main_View.left = 20;
    //        P_name.text=@"我:";
    [Main_View SET_San_background:YES];
    _Text_Content.left = 10;
    if ((int)height < 17) {
      _Text_Content.left =
          10 + 240 - [self setTitleName:_Text_Content.text];
      [Main_View SAN_IMG_Width:[self setTitleName:_Text_Content.text]
                and_left_right:YES];
    }
  }
}

//专题名字过长，调整
- (int)setTitleName:(NSString *)text {
  CGFloat width = [text sizeWithFont:[UIFont systemFontOfSize:13.0f]
                      constrainedToSize:CGSizeMake(2000, 16)
                          lineBreakMode:NSLineBreakByCharWrapping].width;
  return (int)width + 20;
}

- (void)Night_to_Day {
    _Text_Content.textColor = [UIColor blackColor];
    lable_time.textColor = [UIColor blackColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}

@end
