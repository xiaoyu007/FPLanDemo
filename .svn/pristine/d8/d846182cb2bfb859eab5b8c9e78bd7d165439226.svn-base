//
//  UserInfoTableViewCell.m
//  优顾理财
//
//  Created by Mac on 14-7-30.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "UserInfoTableViewCell.h"
//#import "YGImageDown.h"

@implementation UserInfoTableViewCell
@synthesize Title_label;
@synthesize PIC_image;
@synthesize sub_label;
@synthesize is_pressed_state;
//[[UserInfoTableViewCell alloc]
// initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    CGFloat cellHeight = self.frame.size.height;
    is_pressed_state = NO;
    // Initialization code
    Title_label = [[UILabel alloc]
        initWithFrame:CGRectMake(20, (cellHeight - 20.0f) / 2.0f, 80, 20)];
    Title_label.backgroundColor = [UIColor clearColor];
    Title_label.font = [UIFont systemFontOfSize:18.0f];
    Title_label.textColor = [Globle colorFromHexRGB:@"5b5f62"];
    [self addSubview:Title_label];

    PIC_image = [[PicUserHeader alloc]
        initWithFrame:CGRectMake(windowWidth - 90.0f, 10, 40, 40)];
    PIC_image.picImage.image = [UIImage imageNamed:@"小优"];
    PIC_image.picImage.userInteractionEnabled = NO;
    PIC_image.hidden = YES;
    [self addSubview:PIC_image];

    sub_label = [[UILabel alloc]
        initWithFrame:CGRectMake(windowWidth - 200.0f,
                                 (cellHeight - 17.0f) / 2.0f, 170.0f, 17.0f)];
    sub_label.backgroundColor = [UIColor clearColor];
    sub_label.font = [UIFont systemFontOfSize:15.0f];
    sub_label.textColor = [Globle colorFromHexRGB:@"5b5f62"];
    sub_label.textAlignment = NSTextAlignmentRight;
    sub_label.userInteractionEnabled = NO;
    sub_label.text = @"未填写";
    [self addSubview:sub_label];

    Down_imageView = [[UIImageView alloc]
        initWithFrame:CGRectMake(windowWidth - 30.0f,
                                 (cellHeight - 28.0f) / 2.0f, 22, 28)];
    [self addSubview:Down_imageView];

    D_View_2 =
        [[UIView alloc] initWithFrame:CGRectMake(20, cellHeight - 0.5f,
                                                 windowWidth - 40.0f, 0.5f)];
    [self addSubview:D_View_2];

    //        正文——主视图
    self.backgroundColor = [Globle colorFromHexRGB:customBGColor];
    
    Title_label.textColor = [Globle colorFromHexRGB:@"5b5f62"];
    //        尾图
    Down_imageView.image = [UIImage imageNamed:@"更多_白天.png"];
    
    D_View_2.backgroundColor = [Globle colorFromHexRGB:textfieldBordColor];
  }

  return self;
}

- (void)To_determine_whether_the:(NSInteger)row
                      andSection:(NSInteger)section
                        andImage:(UIImage *)image
                    andhave_type:(BOOL)have_type
                    andthirdname:(NSString *)thirdname
                  withArrowImage:(BOOL)isShowArrowImage{
  Title_label.frame = CGRectMake(20, 20, 80, 20);
  PIC_image.frame = CGRectMake(windowWidth - 90.0f, 10.0f, 40, 40);
  sub_label.frame = CGRectMake(windowWidth - 200.0f, 22, 170.0f, 17.0f);
  Down_imageView.frame = CGRectMake(windowWidth - 30.0f, 16.0, 22.0f, 28.0f);
  D_View_2.frame = CGRectMake(20, 59.5f, windowWidth - 40.0f, 0.5f);

  D_View_2.hidden = NO;
  Down_imageView.hidden = NO;
  if (section == 0) {
    sub_label.text = @"未填写";
    switch (row) {
    case 0: {
      PIC_image.hidden = NO;
      sub_label.hidden = YES;
      PIC_image.picImage.image = image;
    } break;
    case 1: {
      PIC_image.hidden = YES;
      sub_label.hidden = NO;
      sub_label.text = [FPYouguUtil getUserNickName];
    } break;
    case 2: {
      PIC_image.hidden = YES;
      sub_label.hidden = NO;
      Down_imageView.hidden = YES;
      sub_label.text = [FPYouguUtil getUserName];
    } break;
    case 3: {
      PIC_image.hidden = YES;
      sub_label.hidden = NO;
      D_View_2.hidden = YES;
      sub_label.numberOfLines = 0;
      Title_label.frame = CGRectMake(20, 30, 80, 20);
      PIC_image.frame = CGRectMake(windowWidth - 90.0f, 20.0f, 40, 40);
      sub_label.frame = CGRectMake(windowWidth - 200.0f, 32, 170.0f, 17.0f);
      Down_imageView.frame =
          CGRectMake(windowWidth - 30.0f, 26.0, 22.0f, 28.0f);
      D_View_2.frame = CGRectMake(20, 79.5f, windowWidth - 40.0f, 0.5f);

      NSString *signature = [FPYouguUtil getSignture];
      UIFont *font = [UIFont systemFontOfSize:15.0f];
      CGFloat height = [signature sizeWithFont:font
                             constrainedToSize:CGSizeMake(170.0f, 2000)
                                 lineBreakMode:NSLineBreakByCharWrapping]
                           .height;
      if (height > 20) {
        sub_label.frame = CGRectMake(windowWidth - 200.0f, 10, 170.0f, 60.0f);
        sub_label.textAlignment = NSTextAlignmentLeft;
      } else {
        sub_label.frame = CGRectMake(windowWidth - 200.0f, 25, 170.0f, 30.0f);
        sub_label.textAlignment = NSTextAlignmentRight;
      }
      if ([signature length] > 0) {
        sub_label.text = signature;
      }

    } break;
    default:
      break;
    }
  } else if (section == 1) {
    sub_label.text = @"未绑定";
    sub_label.hidden = NO;
    PIC_image.hidden = YES;
    if (isShowArrowImage) {
      Down_imageView.hidden = YES;
      self.userInteractionEnabled = NO;
    }else{
      Down_imageView.hidden = NO;
    }
    if (have_type == YES) {
      //手机号加密显示
      if (row == 0) {
        sub_label.text = [self phoneNumberWithStars:thirdname];
      }else{
        sub_label.text = thirdname;
      }
    }
  }
}
- (NSString *)phoneNumberWithStars:(NSString *)phoneNumber {
  if ([phoneNumber length] > 8) {
    return
    [phoneNumber stringByReplacingCharactersInRange:NSMakeRange(3, 4)
                                         withString:@"****"]; // number是6位
  }
  return phoneNumber;
}
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
  if (is_pressed_state == YES) {
    if (highlighted == YES) {
        self.backgroundColor = [Globle colorFromHexRGB:@"d0d0d0"];
    } else {
        self.backgroundColor = [Globle colorFromHexRGB:customBGColor];
    }
  }
  [super setHighlighted:highlighted animated:animated];
}

- (void)dealloc {
  [self removeAllSubviews];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
