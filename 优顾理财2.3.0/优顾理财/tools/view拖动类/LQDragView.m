//
//  LQDragView.m
//  优顾理财
//
//  Created by Mac on 15-4-26.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "LQDragView.h"
typedef NS_ENUM(NSUInteger, DragViewDirection) {
  DragViewDirectionUp,
  DragViewDirectionDown,
};

@interface LQDragView ()

/** 移动方向 */
@property(nonatomic, assign) DragViewDirection direction;

@end

@implementation LQDragView

- (id)init {
  self = [super init];
  if (self) {
    [self setup];
  }
  return self;
}
/** 添加移动手势 */
- (void)setup {
  self.userInteractionEnabled = YES;
  UIPanGestureRecognizer *pan =
      [[UIPanGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(handlePan:)];
  pan.maximumNumberOfTouches = 1;
  [self addGestureRecognizer:pan];
}

- (void)handlePan:(UIPanGestureRecognizer *)sender {
  //速度
  CGPoint velocity = [sender velocityInView:sender.view];

  if (sender.state == UIGestureRecognizerStateBegan) {
    if (velocity.y > 0) {
      _direction = DragViewDirectionDown;
    } else {
      _direction = DragViewDirectionUp;
    }
    // self.delegate = nil情况
    if ([self.delegate respondsToSelector:@selector(dragViewDidBeginDragging:)])
      [self.delegate dragViewDidBeginDragging:self];
  }

  [self handleUpDownGesture:sender];
}

- (void)handleUpDownGesture:(UIPanGestureRecognizer *)sender {
  if (sender.state == UIGestureRecognizerStateBegan) {
#if 0
    CGRect beginFrame = _currentRect;
    CGFloat height = self.bounds.size.height;
    
    if (_direction == DragViewDirectionUp)
      beginFrame.origin.y = height;
    else
      beginFrame.origin.y = -height;
    
    nextImageView.frame = beginFrame;
    
    [self bringSubviewToFront:nextImageView];
#endif
  }

  if (sender.state == UIGestureRecognizerStateChanged)
    if ([self.delegate respondsToSelector:@selector(dragViewDidDragging:)])
      [self.delegate dragViewDidDragging:self];

  CGFloat translationY = [sender translationInView:self].y;
  CGRect nextImageFrame = self.frame;
  nextImageFrame.origin.y += translationY;
  self.frame = nextImageFrame;
#if 0
  CGFloat offset = 1000 - nextImageView.bounds.size.height * .35;
  CGFloat scale = (fabs(nextImageView.frame.origin.y) * .35 + offset) * 0.001;
  currentImageView.transform = CGAffineTransformMakeScale(scale, scale);
  
  CGRect currentFrame = currentImageView.frame;
  if (_direction == JZDragViewDirectionDown)
    currentFrame.origin.y = self.bounds.size.height - currentImageView.frame.size.height;
  else
    currentFrame.origin.y = 0;
  currentImageView.frame = currentFrame;
#endif
  [sender setTranslation:CGPointZero inView:sender.view];

  if (sender.state == UIGestureRecognizerStateEnded) {

    CGFloat velocityY = [sender velocityInView:self].y;

    if ([self.delegate respondsToSelector:@selector(dragViewDidEndDragging:
                                                              withVelocity:
                                                       targetContentOffset:)])
      [self.delegate dragViewDidEndDragging:self
                               withVelocity:[sender velocityInView:self]
                        targetContentOffset:self.frame.origin.y];

    CGFloat height = self.bounds.size.height;
    CGFloat y = 0;
    BOOL changed = NO;
    if (_direction == DragViewDirectionUp) {
      changed = self.frame.origin.y < height - height * .2 || velocityY < -900;
      y = height;
    } else {
      changed = CGRectGetMaxY(self.frame) > height * .2 || velocityY > 800;
      y = -height;
    }

    CGRect nextImageFrame = self.frame;
    if (changed)
      nextImageFrame.origin.y = _upRect.origin.y;
    else
      nextImageFrame.origin.y = _downRect.origin.y;

    self.userInteractionEnabled = NO;
    [UIView animateWithDuration:.2
        animations:^{

          self.frame = nextImageFrame;
#if 0
      if (!changed) {
        currentImageView.transform = CGAffineTransformIdentity;
        currentImageView.frame = self.bounds;
      }
#endif
        }
        completion:^(BOOL finished) {
          self.userInteractionEnabled = YES;
          if (changed) {
#if 0
        self.currentIndex = self.nextIndex;
        [self.imageViews exchangeObjectAtIndex:0 withObjectAtIndex:1];
        currentImageView.transform = CGAffineTransformIdentity;
        currentImageView.frame = self.bounds;
        currentImageView.hidden = YES;
#endif
          }
          if ([self.delegate
                  respondsToSelector:@selector(
                                         dragViewDidEndScrollingAnimation:)])
            [self.delegate dragViewDidEndScrollingAnimation:self];
        }];
  }
}

@end
