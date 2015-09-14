//
//  TouchView.m
//  TouchDemo
//
//  Created by Zer0 on 13-8-11.
//  Copyright (c) 2013年 Zer0. All rights reserved.
//

#import "TouchView.h"

@implementation TouchView
@synthesize is_not_GestureRecognizer;

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
    self.multipleTouchEnabled = YES;
    self.userInteractionEnabled = YES;
    _sign = 0;
    self.font=[UIFont systemFontOfSize:Font_Height_13_0];
    self.adjustsFontSizeToFitWidth = YES;
    [self.layer setBorderWidth:0.5f];
    self.layer.borderColor = [Globle colorFromHexRGB:Color_Gray_Edge].CGColor;
  }
  return self;
}

-(void)setIsEditable:(BOOL)isEditable
{
  _isEditable = isEditable;
  if (!self.isEditable)
  {
    self.userInteractionEnabled = NO;
    self.textColor=[UIColor whiteColor];
    self.backgroundColor =[Globle colorFromHexRGB:Color_Blue_Profit];
  }
  else
  {
    self.textColor = [UIColor blackColor];
    self.backgroundColor = [UIColor clearColor];
  }
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
  stateFrame = self.frame;
//  if (!_isEditable) {
//    self.textColor=[UIColor whiteColor];
//    self.backgroundColor =[Globle colorFromHexRGB:Color_Blue_Profit];
//    return;
//  }

  NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
  if ([[defaults objectForKey:@"Move_View"] intValue] == 1) {
    is_not_GestureRecognizer = NO;
    return;
  } else {
    [defaults setObject:@"1" forKey:@"Move_View"];
    [defaults synchronize];
    is_not_GestureRecognizer = YES;
  }
  [self setBackgroundColor:[Globle colorFromHexRGB:Color_Gray_Edge]];
//  self.transform = CGAffineTransformScale(self.transform, 1.25, 1.25);

  UITouch* touch = [touches anyObject];
  _point = [touch locationInView:self];
  _point2 = [touch locationInView:self.superview];

  [self.superview
      exchangeSubviewAtIndex:[self.superview.subviews indexOfObject:self]
          withSubviewAtIndex:[[self.superview subviews] count] - 1];
}

- (void)touchesCancelled:(NSSet*)touches withEvent:(UIEvent*)event {
//  if (!_isEditable) {
//    self.textColor=[UIColor whiteColor];
//    self.backgroundColor =[Globle colorFromHexRGB:Color_Blue_Profit];
//    return;
//  }

  if (is_not_GestureRecognizer == NO) {
    return;
  }
  self.backgroundColor =[UIColor whiteColor];
//  self.transform = CGAffineTransformScale(self.transform, 0.8, 0.8);
  //    取消移动
  NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
  [defaults setObject:@"0" forKey:@"Move_View"];
  [defaults synchronize];
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
//  if (!_isEditable) {
//    self.textColor=[UIColor whiteColor];
//    self.backgroundColor =[Globle colorFromHexRGB:Color_Blue_Profit];
//    return;
//  }

  if (is_not_GestureRecognizer == NO) {
    return;
  }
  self.backgroundColor =[UIColor whiteColor];
//  self.transform = CGAffineTransformScale(self.transform, 0.8, 0.8);

  UITouch* touch = [touches anyObject];
  CGPoint point = [touch locationInView:self.superview];
  int a = point.x - _point.x;
  int b = point.y - _point.y;

  if ([_viewArr11 count] <= 5 && _array == _viewArr11) {
    if (CGRectEqualToRect(stateFrame, self.frame)|| point.y > self.moreChannelsLabel.top)
    {
      //提示语 动画
      YouGu_animation_Did_Start(@"最少保留5个栏目");
    }

    [self animationAction];
    _sign = 0;

    //    取消移动
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"0" forKey:@"Move_View"];
    [defaults synchronize];
    return;
  }

  if (self.isEditable) {
    if (_sign == 0) {
      if (_array == _viewArr11) {
        [_viewArr11 removeObject:self];
        [_viewArr22 insertObject:self atIndex:_viewArr22.count];
        _array = _viewArr22;
        [self animationAction];
      } else if (_array == _viewArr22) {
        [_viewArr22 removeObject:self];
        [_viewArr11 insertObject:self atIndex:_viewArr11.count];
        _array = _viewArr11;
        [self animationAction];
      }
    } else if (([self buttonInArrayArea1:_viewArr11 Point:point] ||
                [self buttonInArrayArea2:_viewArr22 Point:point]) &&
               !(point.x - _point.x > KTableStartPointX &&
                 point.x - _point.x < KTableStartPointX + KButtonWidth +
                                          KTable_Distance_PointX &&
                 point.y - _point.y > KTableStartPointY &&
                 point.y - _point.y < KTableStartPointY + KButtonHeight +
                                          KTable_Distance_PointY)) {
      if (point.x < KTableStartPointX || point.y < KTableStartPointY) {
        [self
            setFrame:CGRectMake(_point2.x - _point.x, _point2.y - _point.y,
                                self.frame.size.width, self.frame.size.height)];
      } else {
        [self
            setFrame:CGRectMake(
                         KTableStartPointX +
                             (a + (KButtonWidth + KTable_Distance_PointX) / 2 -
                              KTableStartPointX) /
                                 (KButtonWidth + KTable_Distance_PointX) *
                                 (KButtonWidth + KTable_Distance_PointX),
                         KTableStartPointY +
                             (b + (KButtonHeight + KTable_Distance_PointY) / 2 -
                              KTableStartPointY) /
                                 (KButtonHeight + KTable_Distance_PointY) *
                                 (KButtonHeight + KTable_Distance_PointY),
                         self.frame.size.width, self.frame.size.height)];
      }
      [self animationAction];

    } else {
      [self animationAction];
    }
    _sign = 0;
  }

  //    取消移动
  NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
  [defaults setObject:@"0" forKey:@"Move_View"];
  [defaults synchronize];
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
  if (is_not_GestureRecognizer == NO) {
    return;
  }
  _sign = 1;
  UITouch* touch = [touches anyObject];
  CGPoint point = [touch locationInView:self.superview];
  if (self.isEditable) {
    [self setFrame:CGRectMake(point.x - _point.x, point.y - _point.y,
                              self.frame.size.width, self.frame.size.height)];

    CGFloat newX =
        point.x - _point.x + (KButtonWidth + KTable_Distance_PointX) / 2;
    CGFloat newY =
        point.y - _point.y + (KButtonHeight + KTable_Distance_PointY) / 2;

    if (!CGRectContainsPoint([_viewArr11[0] frame],
                             CGPointMake(newX, newY))) {
      if (_array == _viewArr22) {
        //              是否在，上面已订阅里
        if ([self buttonInArrayArea1:_viewArr11 Point:point]) {
          int index =
              ((int)newX - KTableStartPointX) /
                  (KButtonWidth + KTable_Distance_PointX) +
              (KTable_Num_btn * (((int)newY - KTableStartPointY) /
                                 (KButtonHeight + KTable_Distance_PointY)));
          if (index != 0) {
            [_array removeObject:self];
            [_viewArr11 insertObject:self atIndex:index];
          }
          _array = _viewArr11;
          [self animationAction1a];
          [self animationAction2];
        } else if (newY < KTableStartPointY +
                              [self array2StartY] *
                                  (KButtonHeight + KTable_Distance_PointY) &&
                   ![self buttonInArrayArea1:_viewArr11 Point:point]) {
          [_array removeObject:self];
          [_viewArr11 insertObject:self atIndex:_viewArr11.count];
          _array = _viewArr11;
          [self animationAction2];

        } else if ([self buttonInArrayArea2:_viewArr22 Point:point]) {
          int index =
              ((int)(newX)-KTableStartPointX) /
                  (KButtonWidth + KTable_Distance_PointX) +
              (KTable_Num_btn * (((int)(newY) -
                                  [self array2StartY] *
                                      (KButtonHeight + KTable_Distance_PointY) -
                                  KTableStartPointY) /
                                 (KButtonHeight + KTable_Distance_PointY)));
          [_array removeObject:self];
          [_viewArr22 insertObject:self atIndex:index];
          [self animationAction2a];

        } else if (newY > KTableStartPointY +
                              [self array2StartY] *
                                  (KButtonHeight + KTable_Distance_PointY) &&
                   ![self buttonInArrayArea2:_viewArr22 Point:point]) {
          [_array removeObject:self];
          [_viewArr22 insertObject:self atIndex:_viewArr22.count];
          [self animationAction2a];
        }
      } else if (_array == _viewArr11) {
        if ([self buttonInArrayArea1:_viewArr11 Point:point]) {
          int index =
              ((int)newX - KTableStartPointX) /
                  (KButtonWidth + KTable_Distance_PointX) +
              (KTable_Num_btn * (((int)(newY)-KTableStartPointY) /
                                 (KButtonHeight + KTable_Distance_PointY)));
          if (index != 0) {
            [_array removeObject:self];
            [_viewArr11 insertObject:self atIndex:index];
          }
          _array = _viewArr11;
          [self animationAction1a];
          [self animationAction2];
        } else if (newY < KTableStartPointY +
                              [self array2StartY] *
                                  (KButtonHeight + KTable_Distance_PointY) &&
                   ![self buttonInArrayArea1:_viewArr11 Point:point]) {
          [_array removeObject:self];
          [_viewArr11 insertObject:self atIndex:_viewArr11.count];
          [self animationAction1a];
          [self animationAction2];
        } else if ([self buttonInArrayArea2:_viewArr22 Point:point]) {
          int index =
              ((int)(newX)-KTableStartPointX) /
                  (KButtonWidth + KTable_Distance_PointX) +
              (KTable_Num_btn * (((int)(newY) -
                                  [self array2StartY] *
                                      (KButtonHeight + KTable_Distance_PointY) -
                                  KTableStartPointY) /
                                 (KButtonHeight + KTable_Distance_PointY)));

          if (([_viewArr11 count] <= 5 && _array == _viewArr11)) {
            [self animationAction2a];
          } else {
            [_array removeObject:self];
            [_viewArr22 insertObject:self atIndex:index];
            _array = _viewArr22;
            [self animationAction2a];
          }
        } else if (newY > KTableStartPointY +
                              [self array2StartY] *
                                  (KButtonHeight + KTable_Distance_PointY) &&
                   ![self buttonInArrayArea2:_viewArr22 Point:point]) {
          if (([_viewArr11 count] <= 5 && _array == _viewArr11)) {
            [self animationAction2a];
          } else {
            [_array removeObject:self];
            [_viewArr22 insertObject:self atIndex:_viewArr22.count];
            _array = _viewArr22;
            [self animationAction2a];
          }
        }
      }
    }
  }
}
- (void)animationAction1 {
  for (int i = 0; i < _viewArr11.count; i++) {
    [UIView animateWithDuration:0.3
        delay:0
        options:UIViewAnimationOptionLayoutSubviews
        animations:^{

          [_viewArr11[i]
              setFrame:CGRectMake(
                           KTableStartPointX +
                               (i % KTable_Num_btn) *
                                   (KButtonWidth + KTable_Distance_PointX),
                           KTableStartPointY +
                               (i / KTable_Num_btn) *
                                   (KButtonHeight + KTable_Distance_PointY),
                           KButtonWidth, KButtonHeight)];
        }
        completion:^(BOOL finished){

        }];
  }
}
- (void)animationAction1a {
  for (int i = 0; i < _viewArr11.count; i++) {
    if (_viewArr11[i] != self) {
      [UIView animateWithDuration:0.3
          delay:0
          options:UIViewAnimationOptionLayoutSubviews
          animations:^{

            [_viewArr11[i]
                setFrame:CGRectMake(
                             KTableStartPointX +
                                 (i % KTable_Num_btn) *
                                     (KButtonWidth + KTable_Distance_PointX),
                             KTableStartPointY +
                                 (i / KTable_Num_btn) *
                                     (KButtonHeight + KTable_Distance_PointY),
                             KButtonWidth, KButtonHeight)];
          }
          completion:^(BOOL finished){

          }];
    }
  }
}
- (void)animationAction2 {
  for (int i = 0; i < _viewArr22.count; i++) {
    [UIView animateWithDuration:0.3
        delay:0
        options:UIViewAnimationOptionLayoutSubviews
        animations:^{

          [_viewArr22[i]
              setFrame:CGRectMake(
                           KTableStartPointX +
                               (i % KTable_Num_btn) *
                                   (KButtonWidth + KTable_Distance_PointX),
                           KTableStartPointY +
                               [self array2StartY] *
                                   (KButtonHeight + KTable_Distance_PointY) +
                               (i / KTable_Num_btn) *
                                   (KButtonHeight + KTable_Distance_PointY),
                           KButtonWidth, KButtonHeight)];

        }
        completion:^(BOOL finished){

        }];
  }
  [UIView animateWithDuration:0.3
      delay:0
      options:UIViewAnimationOptionLayoutSubviews
      animations:^{

        [self.moreChannelsLabel
            setFrame:CGRectMake(self.moreChannelsLabel.frame.origin.x,
                                KTableStartPointY +
                                    (KButtonHeight + KTable_Distance_PointY) *
                                        ([self array2StartY] - 1),
                                self.moreChannelsLabel.frame.size.width,
                                self.moreChannelsLabel.frame.size.height)];

      }
      completion:^(BOOL finished){

      }];
}
- (void)animationAction2a {
  for (int i = 0; i < _viewArr22.count; i++) {
    if (_viewArr22[i] != self) {
      [UIView animateWithDuration:0.3
          delay:0
          options:UIViewAnimationOptionLayoutSubviews
          animations:^{

            [_viewArr22[i]
                setFrame:CGRectMake(
                             KTableStartPointX +
                                 (i % KTable_Num_btn) *
                                     (KButtonWidth + KTable_Distance_PointX),
                             KTableStartPointY +
                                 [self array2StartY] *
                                     (KButtonHeight + KTable_Distance_PointY) +
                                 (i / KTable_Num_btn) *
                                     (KButtonHeight + KTable_Distance_PointY),
                             KButtonWidth, KButtonHeight)];

          }
          completion:^(BOOL finished){
          }];
    }
  }
  [UIView animateWithDuration:0.3
      delay:0
      options:UIViewAnimationOptionLayoutSubviews
      animations:^{

        [self.moreChannelsLabel
            setFrame:CGRectMake(self.moreChannelsLabel.frame.origin.x,
                                KTableStartPointY +
                                    (KButtonHeight + KTable_Distance_PointY) *
                                        ([self array2StartY] - 1),
                                self.moreChannelsLabel.frame.size.width,
                                self.moreChannelsLabel.frame.size.height)];

      }
      completion:^(BOOL finished){

      }];
}
- (void)animationActionLabel {
}

- (void)animationAction {
  for (int i = 0; i < _viewArr11.count; i++) {
    [UIView animateWithDuration:0.3
        delay:0
        options:UIViewAnimationOptionLayoutSubviews
        animations:^{

          [_viewArr11[i]
              setFrame:CGRectMake(
                           KTableStartPointX +
                               (i % KTable_Num_btn) *
                                   (KButtonWidth + KTable_Distance_PointX),
                           KTableStartPointY +
                               (i / KTable_Num_btn) *
                                   (KButtonHeight + KTable_Distance_PointY),
                           KButtonWidth, KButtonHeight)];
        }
        completion:^(BOOL finished){

        }];
  }
  for (int i = 0; i < _viewArr22.count; i++) {
    [UIView animateWithDuration:0.3
        delay:0
        options:UIViewAnimationOptionLayoutSubviews
        animations:^{

          [_viewArr22[i]
              setFrame:CGRectMake(
                           KTableStartPointX +
                               (i % KTable_Num_btn) *
                                   (KButtonWidth + KTable_Distance_PointX),
                           KTableStartPointY +
                               [self array2StartY] *
                                   (KButtonHeight + KTable_Distance_PointY) +
                               (i / KTable_Num_btn) *
                                   (KButtonHeight + KTable_Distance_PointY),
                           KButtonWidth, KButtonHeight)];

        }
        completion:^(BOOL finished){

        }];
  }
  [UIView animateWithDuration:0.3
      delay:0
      options:UIViewAnimationOptionLayoutSubviews
      animations:^{

        [self.moreChannelsLabel
            setFrame:CGRectMake(self.moreChannelsLabel.frame.origin.x,
                                KTableStartPointY +
                                    (KButtonHeight + KTable_Distance_PointY) *
                                        ([self array2StartY] - 1),
                                self.moreChannelsLabel.frame.size.width,
                                self.moreChannelsLabel.frame.size.height)];

      }
      completion:^(BOOL finished){

      }];
}

- (BOOL)buttonInArrayArea1:(NSMutableArray*)arr Point:(CGPoint)point {
  CGFloat newX =
      point.x - _point.x + (KButtonWidth + KTable_Distance_PointX) / 2;
  CGFloat newY =
      point.y - _point.y + (KButtonHeight + KTable_Distance_PointY) / 2;
  int a = arr.count % KTable_Num_btn;
  int b = (int)arr.count / KTable_Num_btn;
  if ((newX > KTableStartPointX &&
       newX < KTableStartPointX +
                  KTable_Num_btn * (KButtonWidth + KTable_Distance_PointX) &&
       newY > KTableStartPointY &&
       newY <
           KTableStartPointY + b * (KButtonHeight + KTable_Distance_PointY)) ||
      (newX > KTableStartPointX &&
       newX < KTableStartPointX + a * (KButtonWidth + KTable_Distance_PointX) &&
       newY >
           KTableStartPointY + b * (KButtonHeight + KTable_Distance_PointY) &&
       newY < KTableStartPointY +
                  (b + 1) * (KButtonHeight + KTable_Distance_PointY))) {
    return YES;
  }
  return NO;
}
- (BOOL)buttonInArrayArea2:(NSMutableArray*)arr Point:(CGPoint)point {
  CGFloat newX =
      point.x - _point.x + (KButtonWidth + KTable_Distance_PointX) / 2;
  CGFloat newY =
      point.y - _point.y + (KButtonHeight + KTable_Distance_PointY) / 2;
  int a = arr.count % KTable_Num_btn;
  int b = (int)arr.count / KTable_Num_btn;
  if ((newX > KTableStartPointX &&
       newX < KTableStartPointX +
                  KTable_Num_btn * (KButtonWidth + KTable_Distance_PointX) &&
       newY >
           KTableStartPointY +
               [self array2StartY] * (KButtonHeight + KTable_Distance_PointY) &&
       newY < KTableStartPointY +
                  (b + [self array2StartY]) *
                      (KButtonHeight + KTable_Distance_PointY)) ||
      (newX > KTableStartPointX &&
       newX < KTableStartPointX + a * (KButtonWidth + KTable_Distance_PointX) &&
       newY > KTableStartPointY +
                  (b + [self array2StartY]) *
                      (KButtonHeight + KTable_Distance_PointY) &&
       newY < KTableStartPointY +
                  (b + [self array2StartY] + 1) *
                      (KButtonHeight + KTable_Distance_PointY))) {
    return YES;
  }
  return NO;
}
- (int)array2StartY {
  unsigned long y = 0;

  y = _viewArr11.count / KTable_Num_btn + 2;
  if (_viewArr11.count % KTable_Num_btn == 0) {
    y -= 1;
  }
  return (int)y;
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
