//
//  Toolbox_Single.m
//  优顾理财
//
//  Created by Mac on 14/10/20.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "Toolbox_Single.h"

@implementation Toolbox_Single

@synthesize background_View;
@synthesize head_image;
@synthesize title_View;
@synthesize Click_btn;

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];

  if (self) {

    [self start];
  }

  return self;
}

- (void)start {
  self.background_View = [[UIView alloc] initWithFrame:self.bounds];
  [self addSubview:background_View];

  self.head_image =
      [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, self.width - 40,
                                                    self.height * 2 / 3 - 30)];
  [self addSubview:head_image];

  self.title_View =
      [[UILabel alloc] initWithFrame:CGRectMake(0, self.height * 2 / 3,
                                                self.width, self.height / 3)];
  title_View.textAlignment = NSTextAlignmentCenter;
  title_View.textColor = [UIColor whiteColor];
  title_View.backgroundColor = [UIColor clearColor];
  [self addSubview:title_View];

  self.Click_btn = [UIButton buttonWithType:UIButtonTypeCustom];
  Click_btn.tag = self.tag;
  Click_btn.frame = self.bounds;
  [self addSubview:Click_btn];
  UIImage *highlightImage = [FPYouguUtil createImageWithColor:buttonHighLightColor];
  [self.Click_btn setBackgroundImage:highlightImage
                            forState:UIControlStateHighlighted];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
