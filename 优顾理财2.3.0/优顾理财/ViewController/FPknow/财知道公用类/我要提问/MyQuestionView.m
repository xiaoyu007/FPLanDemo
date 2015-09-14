//
//  MyQuestionView.m
//  优顾理财
//
//  Created by Mac on 14-4-22.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "MyQuestionView.h"

@implementation MyQuestionView
@synthesize image_array, title_array;
@synthesize img_View, lable;
@synthesize NormalbackgroundColor;
- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
  }
  return self;
}

- (id)initWithFrame:(CGRect)frame
         andArray_1:(NSString *)img_array
         andArray_2:(NSString *)tit_array {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
    self.image_array = img_array;
    self.title_array = tit_array;
    [self setup];
  }
  return self;
}

- (void)setup {
  [self setUserInteractionEnabled:TRUE];
  _actionView = [[UIControl alloc] initWithFrame:self.bounds];
  [_actionView setBackgroundColor:[UIColor clearColor]];
  [_actionView addTarget:self
                  action:@selector(appendHighlightedColor)
        forControlEvents:UIControlEventTouchDown];
  [_actionView
             addTarget:self
                action:@selector(removeHighlightedColor)
      forControlEvents:UIControlEventTouchCancel | UIControlEventTouchUpInside |
                       UIControlEventTouchDragOutside |
                       UIControlEventTouchUpOutside];
  [self addSubview:_actionView];
  [self sendSubviewToBack:_actionView];

  img_View =
      [[UIImageView alloc] initWithImage:[UIImage imageNamed:image_array]];
  img_View.frame = CGRectMake((self.width - 25) / 2, 9, 25, 25);
  [self addSubview:img_View];

  lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 37, self.width, 15)];
  lable.backgroundColor = [UIColor clearColor];
  lable.textAlignment = NSTextAlignmentCenter;
  lable.font = [UIFont systemFontOfSize:13];
  lable.userInteractionEnabled = NO;
  lable.text = title_array;
  [self addSubview:lable];
}

- (void)addTarget:(id)target action:(SEL)action {
  _actionView.tag = self.tag;
  [_actionView addTarget:target
                  action:action
        forControlEvents:UIControlEventTouchUpInside];
}

- (void)appendHighlightedColor {
  self.backgroundColor = self.highlightedColor;
}

- (void)removeHighlightedColor {
  self.backgroundColor = self.NormalbackgroundColor;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
