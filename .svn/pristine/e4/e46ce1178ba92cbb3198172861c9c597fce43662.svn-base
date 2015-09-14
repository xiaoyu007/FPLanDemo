//
//  Loading.m
//  tt
//
//  Created by haobao on 14-1-2.
//

#define ANGLE(a) 2 * M_PI / 360 * a

@interface Loading ()

// 0.0 - 1.0
@property(nonatomic, assign) CGFloat anglePer;

@property(nonatomic, strong) NSTimer *timer;

@end

@implementation Loading

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    self.image = [UIImage imageNamed:@"release-to-refresh-noarrow.png"];
    [self startAnimation];
  }
  return self;
}

- (id)init {
  self = [super init];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    self.image = [UIImage imageNamed:@"release-to-refresh-noarrow.png"];
    [self startAnimation];
  }
  return self;
}

- (void)setAnglePer:(CGFloat)anglePer {
  _anglePer = anglePer;
  [self setNeedsDisplay];
}

- (void)startAnimation {
  if (self.isAnimating) {
    [self stopAnimation];
    [self.layer removeAllAnimations];
  }
  _isAnimating = YES;

  self.anglePer = 1.0;
  self.timer =
      [NSTimer scheduledTimerWithTimeInterval:0.05f
                                       target:self
                                     selector:@selector(drawPathAnimation:)
                                     userInfo:nil
                                      repeats:YES];
  [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopAnimation {
  _isAnimating = NO;

  if ([self.timer isValid]) {
    [self.timer invalidate];
    self.timer = nil;
  }
  [self stopRotateAnimation];
}

- (void)drawPathAnimation:(NSTimer *)timer {
  self.anglePer += 0.03f;

  if (self.anglePer >= 1) {
    self.anglePer = 1;
    [timer invalidate];
    self.timer = nil;
    [self startRotateAnimation];
  }
}

- (void)startRotateAnimation {
  CABasicAnimation *animation =
      [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
  animation.fromValue = @(0);
  animation.toValue = @(2 * M_PI);
  animation.duration = 2.5f;
  animation.repeatCount = INT_MAX;

  [self.layer addAnimation:animation forKey:@"keyFrameAnimation"];
}

- (void)stopRotateAnimation {
  [UIView animateWithDuration:0.3f
      animations:^{
        self.alpha = 0;
      }
      completion:^(BOOL finished) {
        self.anglePer = 0;
        [self.layer removeAllAnimations];
        self.alpha = 1;
      }];
}

- (void)drawRect:(CGRect)rect {
  if (self.anglePer <= 0) {
    _anglePer = 0;
  }

  CGFloat lineWidth = 1.f;
  UIColor *lineColor = [UIColor lightGrayColor];
  if (self.lineWidth) {
    lineWidth = self.lineWidth;
  }
  if (self.lineColor) {
    lineColor = self.lineColor;
  }

  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetLineWidth(context, lineWidth);
  CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
  CGContextAddArc(context, CGRectGetMidX(self.bounds),
                  CGRectGetMidY(self.bounds),
                  CGRectGetWidth(self.bounds) / 2 - lineWidth, ANGLE(120),
                  ANGLE(120) + ANGLE(330) * self.anglePer, 0);
  CGContextStrokePath(context);
}

- (void)dealloc {
  if ([self.timer isValid]) {
    [self.timer invalidate];
    self.timer = nil;
  }
  [self removeAllSubviews];
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
