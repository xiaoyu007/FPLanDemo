//
//  TentacleView.m
//  GesturePassword
//
//  Created by hb on 14-8-23.
//  Copyright (c) 2014年 黑と白の印记. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "TentacleView.h"
#import "FPGesturePasswordButton.h"

@implementation TentacleView {
  CGPoint lineStartPoint;
  CGPoint lineEndPoint;
  ///存储每次移动坐标
  NSMutableArray *touchesArray;
  ///存储坐标index
  NSMutableArray *touchedArray;
  BOOL success;
}
@synthesize buttonArray;
@synthesize rerificationDelegate;
@synthesize resetDelegate;
@synthesize touchBeginDelegate;
@synthesize style;

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
    touchesArray = [[NSMutableArray alloc] initWithCapacity:0];
    touchedArray = [[NSMutableArray alloc] initWithCapacity:0];
    [self setBackgroundColor:[UIColor clearColor]];
    [self setUserInteractionEnabled:YES];
    success = 1;
  }
  return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  previousPoint = CGPointMake(0.0f, 0.0f);
  CGPoint touchPoint;
  UITouch *touch = [touches anyObject];
  [touchesArray removeAllObjects];
  [touchedArray removeAllObjects];
  //开始点击
  [touchBeginDelegate gestureTouchBegin];
  success = 1;
  if (touch) {
    touchPoint = [touch locationInView:self];
    for (int i = 0; i < buttonArray.count; i++) {
      FPGesturePasswordButton *buttonTemp =
          ((FPGesturePasswordButton *) buttonArray[i]);
      [buttonTemp setSuccess:YES];
      [buttonTemp setSelected:NO];
      if (CGRectContainsPoint(buttonTemp.frame, touchPoint)) {
        CGRect frameTemp = buttonTemp.frame;
        CGPoint point =
            CGPointMake(frameTemp.origin.x + frameTemp.size.width / 2.0f,
                        frameTemp.origin.y + frameTemp.size.height / 2.0f);
        NSDictionary *dict = @{@"x" : [NSString stringWithFormat:@"%f", point.x],
            @"y" : [NSString stringWithFormat:@"%f", point.y]};
        //数组变化(button中心点坐标)
        [touchesArray addObject:dict];
        lineStartPoint = touchPoint;
      }
      if (self.pageType == GesturePasswordPageTypeFtSetting) {
        [self.updateSmallPasswordDelegate refreshSmallPassword:buttonArray];
      }
      [buttonTemp setNeedsDisplay];
    }
    [self setNeedsDisplay];
  }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  CGPoint touchPoint;
  UITouch *touch = [touches anyObject];
  if (touch) {
    touchPoint = [touch locationInView:self];
    for (int i = 0; i < buttonArray.count; i++) {
      FPGesturePasswordButton *buttonTemp =
      ((FPGesturePasswordButton *) buttonArray[i]);
      //如果是连线上的中点坐标
      if (previousPoint.x != 0||previousPoint.y != 0) {
        CGPoint halfPoint = CGPointMake((touchPoint.x + previousPoint.x)/2.0f, (touchPoint.y + previousPoint.y)/2.0f);
        [self refreshTouchPointStatusWithPoint:halfPoint withGesButton:buttonTemp withIndex:i];
      }
      //当前坐标
      [self refreshTouchPointStatusWithPoint:touchPoint withGesButton:buttonTemp withIndex:i];
    }
    lineEndPoint = touchPoint;
    [self setNeedsDisplay];
  }
}
/** 刷新九宫格按钮状态 */
- (void)refreshTouchPointStatusWithPoint:(CGPoint)touchPoint withGesButton:(FPGesturePasswordButton *)buttonTemp withIndex:(int)i{
  if (CGRectContainsPoint(buttonTemp.frame, touchPoint)){
    //重复包含
    if ([touchedArray
         containsObject:[NSString stringWithFormat:@"num%d", i]]) {
      lineEndPoint = touchPoint;
      [self setNeedsDisplay];
      return;
    }
    [touchedArray addObject:[NSString stringWithFormat:@"num%d", i]];
    [buttonTemp setSelected:YES];
    [buttonTemp setNeedsDisplay];
    //首次设置手势密码
    if (self.pageType == GesturePasswordPageTypeFtSetting) {
      [self.updateSmallPasswordDelegate refreshSmallPassword:buttonArray];
    }
    previousPoint = touchPoint;
    CGRect frameTemp = buttonTemp.frame;
    CGPoint point =
    CGPointMake(frameTemp.origin.x + frameTemp.size.width / 2.0f,
                frameTemp.origin.y + frameTemp.size.height / 2.0f);
    NSDictionary *dict = @{@"x" : [NSString stringWithFormat:@"%f", point.x],
        @"y" : [NSString stringWithFormat:@"%f", point.y],
        @"num" : [NSString stringWithFormat:@"%d", i]};
    [touchesArray addObject:dict];
  }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
#pragma mark -密码盘的选择状态
  NSMutableString *resultString = [NSMutableString string];
  for (NSDictionary *num in touchesArray) {
    //没连接
    if (!num[@"num"])
      break;
    //连接
    [resultString appendString:num[@"num"]];
  }
//  //滑动少于4点
//  if (style == GesturePasswordPageTypeFtSetting||style == GesturePasswordPageTypeChangePasswod) {
//    if ([touchedArray count] < 4) {
//      [self inputContentFailed];
//    }
//  }
  //密码盘界面类型
  if (style == GesturePasswordPageTypeVerPassword ||
      style == GesturePasswordPageTypeChangePasswod) {
    success = [rerificationDelegate verification:resultString];
  } else {
    success = [resetDelegate resetPassword:resultString];
  }
  #pragma mark - 刷新密码盘
  for (int i = 0; i < touchesArray.count; i++) {
    NSInteger selection =
        [[touchesArray[i] objectForKey:@"num"] intValue];
    FPGesturePasswordButton *buttonTemp =
        ((FPGesturePasswordButton *) buttonArray[selection]);
    [buttonTemp setSuccess:success];
    [buttonTemp setNeedsDisplay];
    if (self.pageType == GesturePasswordPageTypeFtSetting) {
      [self.updateSmallPasswordDelegate refreshSmallPassword:buttonArray];
    }
  }
  [self setNeedsDisplay];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
  // Drawing code
  //    if (touchesArray.count<2)return;
  for (int i = 0; i < touchesArray.count; i++) {
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (![touchesArray[i]
            objectForKey:@"num"]) { //防止过快滑动产生垃圾数据
      [touchesArray removeObjectAtIndex:i];
      continue;
    }
    if (success) {
      CGContextSetRGBStrokeColor(context, 0.0f, 226.0f / 255.f, 205.0f / 255.f,
                                 1.0f); //线条颜色
    } else {
      CGContextSetRGBStrokeColor(context, 255.0f / 255.f, 83.0f / 255.f,
                                 83.0f / 255.f,
                                 1.0f); //红色
    }

    CGContextSetLineWidth(context, 2);
    CGContextMoveToPoint(
        context,
        [[touchesArray[i] objectForKey:@"x"] floatValue],
        [[touchesArray[i] objectForKey:@"y"] floatValue]);
    if (i < touchesArray.count - 1) {
      CGContextAddLineToPoint(
          context,
          [[touchesArray[i + 1] objectForKey:@"x"] floatValue],
          [[touchesArray[i + 1] objectForKey:@"y"] floatValue]);
    } else {
      if (success) {
        CGContextAddLineToPoint(context, lineEndPoint.x, lineEndPoint.y);
      }
    }
    CGContextStrokePath(context);
  }
}
/** 密码位数不够时 */
- (void)enterAgainForTheNumberOfSecLess{
  //清除滑动栏
  [self enterArgin];
  //清除显示栏
  [self clearDisplayWindow];
}
- (void)clearDisplayWindow{
  //首次设置手势密码(消除首次输入状态)
//  if (self.pageType == GesturePasswordPageTypeFtSetting) {
    [self.updateSmallPasswordDelegate refreshSmallPassword:buttonArray];
//  }
}
- (void)enterArgin {
  [touchesArray removeAllObjects];
  [touchedArray removeAllObjects];
  for (int i = 0; i < buttonArray.count; i++) {
    FPGesturePasswordButton *buttonTemp =
        ((FPGesturePasswordButton *) buttonArray[i]);
    [buttonTemp setSelected:NO];
    [buttonTemp setSuccess:YES];
    [buttonTemp setNeedsDisplay];
    if (self.pageType == GesturePasswordPageTypeFtSetting) {
      [self.updateSmallPasswordDelegate refreshSmallPassword:buttonArray];
    }
  }
  [self setNeedsDisplay];
}
- (void)inputContentFailed{
  [touchesArray removeAllObjects];
  [touchedArray removeAllObjects];
  for (int i = 0; i < buttonArray.count; i++) {
    FPGesturePasswordButton *buttonTemp =
    ((FPGesturePasswordButton *) buttonArray[i]);
    [buttonTemp setSelected:NO];
    [buttonTemp setSuccess:YES];
    [buttonTemp setNeedsDisplay];
  }
  [self setNeedsDisplay];

//  [self clearDisplayWindow];
}
@end
