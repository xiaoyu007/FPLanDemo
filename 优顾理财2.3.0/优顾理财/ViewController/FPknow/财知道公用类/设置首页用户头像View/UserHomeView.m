//
//  UserHomeView.m
//  优顾理财
//
//  Created by Mac on 15/7/21.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "UserHomeView.h"

@implementation UserHomeView

- (instancetype)initWithCoder:(NSCoder*)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
  }

  return self;
}
- (void)awakeFromNib {
  [super awakeFromNib];
  self.userInteractionEnabled = YES;
  [self changeWithStatus:YES];
  [self.qtBtn addTarget:self
                 action:@selector(selectedQTClick)
       forControlEvents:UIControlEventTouchUpInside];
  [self.awBtn addTarget:self
                 action:@selector(selectedAWClick)
       forControlEvents:UIControlEventTouchUpInside];
}

- (void)selectedQTClick {
  if (_delegate &&
      [_delegate respondsToSelector:@selector(selectHomeBtnClick:)]) {
    [_delegate selectHomeBtnClick:0];
    [self changeWithStatus:YES];
  }
}
- (void)selectedAWClick {
  if (_delegate &&
      [_delegate respondsToSelector:@selector(selectHomeBtnClick:)]) {
    [_delegate selectHomeBtnClick:1];
    [self changeWithStatus:NO];
  }
}
////选择按钮的状态
- (void)changeWithStatus:(BOOL)selected {
  if (selected) {
    [self.qtBtn setTitleColor:[Globle colorFromHexRGB:customFilledColor]
                     forState:UIControlStateNormal];
    [self.awBtn setTitleColor:[Globle colorFromHexRGB:@"989898"]
                     forState:UIControlStateNormal];
  } else {
    [self.qtBtn setTitleColor:[Globle colorFromHexRGB:@"989898"]
                     forState:UIControlStateNormal];
    [self.awBtn setTitleColor:[Globle colorFromHexRGB:customFilledColor]
                     forState:UIControlStateNormal];
  }
}
@end
