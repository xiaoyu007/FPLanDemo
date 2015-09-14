//
//  CommentTableViewCell.m
//  优顾理财
//
//  Created by Mac on 15/7/10.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "YouGuNewsUtil.h"
@implementation CommentTableViewCell

- (void)awakeFromNib {
    // Initialization code
  [_userBtn setBackgroundImage:[YouGuNewsUtil imageFromColor:@"989898" alpha:0.4]forState:UIControlStateHighlighted];
  //评论内容
  [_commentLable setFont:[UIFont systemFontOfSize:15]];
  [_commentLable setTextAlignment:RTTextAlignmentJustify];
  [_commentLable setParagraphReplacement:@""];
  _commentLable.lineSpacing = 10.0f;
  self.praiseNum = 0;
  [_praiseBtn addTarget:self action:@selector(addAnimation) forControlEvents:UIControlEventTouchUpInside];
  [self createPraiseLabel];
}
+ (RTLabel *)textLabel {
  RTLabel *label =
  [[RTLabel alloc] initWithFrame:CGRectMake(57,50, windowWidth - 75.0f,2)];
  label.backgroundColor = [UIColor clearColor];
  [label setFont:[UIFont systemFontOfSize:15]];
  [label setTextAlignment:RTTextAlignmentJustify];
  [label setParagraphReplacement:@""];
  label.lineSpacing = 10.0f;
  return label;
}
-(void)praiseBtnStatus:(BOOL)status
{
  _isPraise = status;
  self.praiseBtn.selected = status;
  self.praiseLabel.textColor = [Globle colorFromHexRGB:@"989898"];
  if (status) {
    self.praiseLabel.textColor = [Globle colorFromHexRGB:@"F07533"];
  }
}

/** 创建赞控件 */
- (void)createPraiseLabel{
  _praiseAntiLabel =
  [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
  _praiseAntiLabel.text = @"+1";
  _praiseAntiLabel.textColor = [UIColor redColor];
  _praiseAntiLabel.textAlignment = NSTextAlignmentCenter;
  _praiseAntiLabel.font = [UIFont systemFontOfSize:13];
  _praiseAntiLabel.hidden = NO;
  _praiseAntiLabel.userInteractionEnabled = NO;
  _praiseAntiLabel.backgroundColor = [UIColor clearColor];
  _praiseAntiLabel.top = 20;
  [_praiseBtn addSubview:_praiseAntiLabel];
  _praiseAntiLabel.hidden = YES;
}
- (void)praiseButtonClicked {
  _praiseAntiLabel.hidden = NO;
  _praiseAntiLabel.top = 20;
  UIViewAnimationOptions options =
  UIViewAnimationCurveLinear | UIViewAnimationOptionAllowUserInteraction;
  [UIView animateWithDuration:1.0f
                        delay:0
                      options:options
                   animations:^(void) {
                     _praiseAntiLabel.top = -20;
                   }
                   completion:^(BOOL finished) {
                     if (finished) {
                        _praiseAntiLabel.top = 20;
                       _praiseAntiLabel.hidden = YES;
                       _praiseLabel.hidden = NO;
                       _praiseLabel.text = [NSString stringWithFormat:@"%ld", [_praiseLabel.text integerValue] + 1];
                      _praiseLabel.textColor = [Globle colorFromHexRGB:@"F07533"];
                     }
                   }];
}
- (void)addAnimation {
  if (![FPYouguUtil isExistNetwork]) {
    return;
  }
  if (!_isPraise) {
    _isPraise = YES;
    [self praiseButtonClicked];
  }
}

-(void)setPraiseNum:(int)praiseNum
{
  _praiseNum = praiseNum;
  if (praiseNum == 0) {
    _praiseLabel.hidden = YES;
  }
  else{
    _praiseLabel.hidden = NO;
    _praiseLabel.text = [@(praiseNum) stringValue];
  }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
