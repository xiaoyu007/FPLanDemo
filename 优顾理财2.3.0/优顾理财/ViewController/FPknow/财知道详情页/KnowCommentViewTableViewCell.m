//
//  KnowCommentViewTableViewCell.m
//  优顾理财
//
//  Created by Mac on 15/7/27.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "KnowCommentViewTableViewCell.h"
#import "YouGuNewsUtil.h"
@implementation KnowCommentViewTableViewCell
- (void)awakeFromNib {
  // Initialization code
  [_userBtn setBackgroundImage:[YouGuNewsUtil imageFromColor:@"989898" alpha:0.4]
                      forState:UIControlStateHighlighted];
  //评论内容
  [_commentLable setFont:[UIFont systemFontOfSize:15]];
  [_commentLable setTextAlignment:RTTextAlignmentJustify];
  [_commentLable setParagraphReplacement:@""];
  _commentLable.lineSpacing = 10.0f;
  _praiseNum = 0;
  [self createPraiseLabel];
}
- (void)createPraiseLabel {
  _praiseAnimateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
  _praiseAnimateLabel.text = @"+1";
  _praiseAnimateLabel.textColor = [UIColor redColor];
  _praiseAnimateLabel.textAlignment = NSTextAlignmentCenter;
  _praiseAnimateLabel.font = [UIFont systemFontOfSize:13];
  _praiseAnimateLabel.hidden = YES;
  _praiseAnimateLabel.userInteractionEnabled = NO;
  _praiseAnimateLabel.backgroundColor = [UIColor clearColor];
  _praiseAnimateLabel.top = 20;
  [_praiseBtn addSubview:_praiseAnimateLabel];
}
+ (RTLabel *)textLabel {
  RTLabel *label = [[RTLabel alloc] initWithFrame:CGRectMake(57, 50, windowWidth - 75.0f, 20)];
  label.backgroundColor = [UIColor clearColor];
  [label setFont:[UIFont systemFontOfSize:15]];
  [label setTextAlignment:RTTextAlignmentJustify];
  [label setParagraphReplacement:@""];
  label.lineSpacing = 10.0f;
  return label;
}
- (void)praiseBtnStatus:(BOOL)status {
  self.praiseBtn.userInteractionEnabled = !status;
  if (status) {
    self.praiseLabel.textColor = [Globle colorFromHexRGB:@"F07533"];
    [self.praiseBtn setImage:[UIImage imageNamed:@"赞_Home_Cell1.png"]
                    forState:UIControlStateNormal];
  } else {
    self.praiseLabel.textColor = [Globle colorFromHexRGB:@"989898"];
    [self.praiseBtn setImage:[UIImage imageNamed:@"赞_Home_Cell.png"]
                    forState:UIControlStateNormal];
  }
}

- (IBAction)praiseButtonClicked:(id)sender {
  _praiseAnimateLabel.hidden = NO;
  _praiseAnimateLabel.top = 20;
  UIViewAnimationOptions options = UIViewAnimationCurveLinear | UIViewAnimationOptionAllowUserInteraction;
  UIButton *button = (UIButton *)sender;
  button.userInteractionEnabled = NO;
  [UIView animateWithDuration:1.0f
      delay:0
      options:options
      animations:^(void) {
        _praiseAnimateLabel.top = -20;
      }
      completion:^(BOOL finished) {
        if (finished) {
          _praiseAnimateLabel.hidden = YES;
          _praiseLabel.hidden = NO;
          _praiseLabel.text = [NSString stringWithFormat:@"%d", _praiseNum + 1];
          [self praiseBtnStatus:YES];
        }
      }];
}
- (void)setPraiseNum:(int)praiseNum {
  _praiseNum = praiseNum;
  if (praiseNum == 0) {
    _praiseLabel.hidden = YES;
  } else {
    _praiseLabel.hidden = NO;
    _praiseLabel.text = [@(praiseNum) stringValue];
  }
}
@end
