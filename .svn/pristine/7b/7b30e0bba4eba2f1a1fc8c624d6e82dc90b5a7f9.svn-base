//
//  Tap_view.m
//  DDMenuController
//
//  Created by moulin wang on 13-9-9.
//
//

#import "Tap_view.h"

@implementation Tap_view
@synthesize label;
@synthesize IMG;
@synthesize indicator;
- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
    [self start];
  }
  return self;
}
- (void)start {
  IMG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
  IMG.center = CGPointMake(160, self.frame.size.height / 2 - 40);
  [self addSubview:IMG];

  indicator = [[UIActivityIndicatorView alloc]
      initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
  indicator.frame = CGRectMake(0, 0, 60, 60);
  indicator.center = CGPointMake(IMG.center.x - 60, IMG.center.y + 60);
  indicator.hidden = YES;
  [self addSubview:indicator];
  [indicator startAnimating];

  label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
  label.center = CGPointMake(IMG.center.x, IMG.center.y + 60);
  label.font = [UIFont fontWithName:@"BodoniSvtyTwoITCTT-Bold" size:20];
  label.backgroundColor = [UIColor clearColor];
  label.textAlignment = NSTextAlignmentCenter;
  [self addSubview:label];
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
