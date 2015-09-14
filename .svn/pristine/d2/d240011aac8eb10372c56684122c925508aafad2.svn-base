//
//  BankManagerTableViewCell.m
//  优顾理财
//
//  Created by jhss on 15-5-5.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPBankManagerTableViewCell.h"

@implementation FPBankManagerTableViewCell

- (void)awakeFromNib {
  // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {

    _bankImageView =
        [[UIImageView alloc] initWithFrame:CGRectMake(25,13, 25, 25)];
    [self.contentView addSubview:_bankImageView];

    _bankNameLabel =
        [[UILabel alloc] initWithFrame:CGRectMake(66,0, 100, 50)];
    _bankNameLabel.font = [UIFont systemFontOfSize:14];
    _bankNameLabel.textColor = [Globle colorFromHexRGB:@"5b5f62"];
    [self.contentView addSubview:_bankNameLabel];

    _bankNum = [[UILabel alloc]
        initWithFrame:CGRectMake(windowWidth - 100,0, 100,50)];
    _bankNum.textAlignment = NSTextAlignmentCenter;
    _bankNum.font = [UIFont systemFontOfSize:14];
    _bankNum.textColor = [Globle colorFromHexRGB:@"84929e"];
    [self.contentView addSubview:_bankNum];
  }
  return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}

@end
