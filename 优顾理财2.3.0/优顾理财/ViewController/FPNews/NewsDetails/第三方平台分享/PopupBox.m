//
//  Pop-up_box.m
//  优顾理财
//
//  Created by moulin wang on 13-10-14.
//  Copyright (c) 2013年 Ling YU. All rights reserved.
//

#import "PopupBox.h"

@implementation PopupBox

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
    [self Creat_UI];
  }
  return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
  self = [super initWithCoder:aDecoder];
  if (self) {
   [self Creat_UI]; 
  }
  return self;
}
- (void)Creat_UI {
  self.backgroundColor = [UIColor clearColor];

  UIPanGestureRecognizer* pan_back_view = [[UIPanGestureRecognizer alloc]
      initWithTarget:self
              action:@selector(pan_back_view_click:)];
  [self addGestureRecognizer:pan_back_view];
  UITapGestureRecognizer* shard_shadow_view_tap =
      [[UITapGestureRecognizer alloc]
          initWithTarget:self
                  action:@selector(backBtnClick)];
  shard_shadow_view_tap.delegate = self;
  [self addGestureRecognizer:shard_shadow_view_tap];

  box_view = [[UIView alloc] init];
  box_view.frame =
      CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 20);
  [self addSubview:box_view];

  Arrow_image = [[UIImageView alloc] init];
  Arrow_image.frame = CGRectMake(self.frame.size.width - 14 - 18,
                                 self.frame.size.height - 22, 18, 13);
  Arrow_image.userInteractionEnabled = YES;
  [self addSubview:Arrow_image];

  box_view.backgroundColor = [UIColor whiteColor];
  box_view.layer.cornerRadius = 5;
  [[box_view layer]
      setBorderColor:[Globle colorFromHexRGB:@"969696" withAlpha:1.0].CGColor];
  [[box_view layer] setBorderWidth:1];
  Arrow_image.image = [UIImage imageNamed:@"箭头"];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer
       shouldReceiveTouch:(UITouch*)touch {
  for (UIView* view in gestureRecognizer.view.subviews) {
    if ([view isKindOfClass:[UITableView class]] ||
        [view isKindOfClass:[UIButton class]]) {
      return NO;
    }
  }
  return YES;
}
- (void)dealloc {
  [self removeAllSubviews];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//收回分享界面
- (void)backBtnClick {
}

- (void)pan_back_view_click:(UIPanGestureRecognizer*)recognizer {
  static CGPoint old_point;
  CGPoint point = [recognizer translationInView:recognizer.view];
  if (recognizer.state == UIGestureRecognizerStateBegan) {
    old_point = point;
  }
  if (recognizer.state == UIGestureRecognizerStateCancelled ||
      recognizer.state == UIGestureRecognizerStateEnded) {
  }
}
//选择箭头的位置
- (void)Arrow_frame:(CGRect)arrow_frame {
  Arrow_image.frame = arrow_frame;
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
