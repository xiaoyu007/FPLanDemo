//
//  NewsListTableViewCell.m
//  优顾理财
//
//  Created by Mac on 15/7/7.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "NewsListTableViewCell.h"
#import "YouGuNewsUtil.h"
@implementation NewsListTableViewCell

- (void)awakeFromNib {
  // Initialization code
  [super awakeFromNib];
  _aidLable.layer.cornerRadius = _aidLable.height / 2.0;
  _aidLable.layer.masksToBounds = YES;

  _newsIntroduction.backgroundColor = [UIColor clearColor];
  [_newsIntroduction setFont:[UIFont systemFontOfSize:13.0f]];
  [_newsIntroduction setTextAlignment:RTTextAlignmentJustify];
  _newsIntroduction.textColor = [Globle colorFromHexRGB:@"797979"];
  [_newsIntroduction setParagraphReplacement:@""];
  _newsIntroduction.lineSpacing = 8;

  [_praiseBtn setBackgroundImage:[YouGuNewsUtil imageFromColor:@"000000" alpha:0.3]
                        forState:UIControlStateHighlighted];
  [_praiseBtn setBackgroundImage:[YouGuNewsUtil imageFromColor:@"000000" alpha:0.3]
                        forState:UIControlStateSelected];
  [self createPraiseLabel];
  [_praiseBtn addTarget:self
                 action:@selector(addAnimation)
       forControlEvents:UIControlEventTouchUpInside];
}
+ (RTLabel *)textLabel {
  RTLabel *label = [[RTLabel alloc] initWithFrame:CGRectMake(10, 38, windowWidth - 26.0f, 20)];
  label.backgroundColor = [UIColor clearColor];
  [label setFont:[UIFont systemFontOfSize:13.0f]];
  [label setTextAlignment:RTTextAlignmentJustify];
  label.textColor = [Globle colorFromHexRGB:@"797979"];
  [label setParagraphReplacement:@""];
  label.lineSpacing = 8;
  return label;
}

- (void)setIsRead:(BOOL)isRead {
  _isRead = isRead;
  if (isRead) {
    _titleName.textColor = [Globle colorFromHexRGB:@"656565"];
  } else {
    _titleName.textColor = [UIColor blackColor];
  }
}
// 微热点，和 专题，图片
- (void)setIsTopicid:(int)isTopicid {
  _aidLable.hidden = YES;
  switch (isTopicid) {
  case 1: {
    _topicPIC.hidden = NO;
    _topicPIC.image = [UIImage imageNamed:@"微热点"];
    _praisePic.hidden = YES;
    _praiseNum.hidden = YES;
    _praiseBtn.hidden = YES;
    _aidLable.hidden = YES;
  } break;
  case 2: {
    _topicPIC.hidden = NO;
    _topicPIC.image = [UIImage imageNamed:@"专题"];
    _praisePic.hidden = YES;
    _praiseNum.hidden = YES;
    _praiseBtn.hidden = YES;
    _aidLable.hidden = YES;
  } break;
  case 3: {
    _topicPIC.hidden = YES;
    _aidLable.hidden = NO;
    _praisePic.hidden = NO;
    _praiseNum.hidden = NO;
    _praiseBtn.hidden = NO;
  } break;
  default: {
    _topicPIC.hidden = YES;
    self.topicPIC.image = nil;
    _praiseBtn.hidden = NO;
    _praisePic.hidden = NO;
    _praiseNum.hidden = NO;
    _aidLable.hidden = YES;
  } break;
  }
}
/** 创建赞控件 */
- (void)createPraiseLabel{
  self.praiseLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
  self.praiseLable.text = @"+1";
  self.praiseLable.textColor = [UIColor redColor];
  self.praiseLable.textAlignment = NSTextAlignmentCenter;
  self.praiseLable.font = [UIFont systemFontOfSize:13];
  self.praiseLable.userInteractionEnabled = NO;
  self.praiseLable.backgroundColor = [UIColor clearColor];
  [self.praiseBtn addSubview:self.praiseLable];
  self.praiseLable.hidden = YES;
}
- (void)praiseButtonClicked {
  UIViewAnimationOptions options = UIViewAnimationCurveLinear | UIViewAnimationOptionAllowUserInteraction;
  self.praiseLable.top = 20;
  self.praiseLable.hidden = NO;
  [UIView animateWithDuration:1.0f
      delay:0
      options:options
      animations:^(void) {
        self.praiseLable.top = -20;
      }
      completion:^(BOOL finished) {
        if (finished) {
          self.praiseLable.top = 20;
          self.praiseLable.hidden = YES;
          self.isPraise = YES;
          _praiseNum.text = [NSString stringWithFormat:@"%ld", [_praiseNum.text integerValue] + 1];
        }
      }];
}

- (void)addAnimation {
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  if (!_isPraise) {
    [self praiseButtonClicked];
  }
}
//赞 的 个数
- (void)setPraisenum:(int)praisenum {
  if (praisenum == 0) {
    _praiseNum.text = @"";
  } else if (praisenum > 9999) {
    _praiseNum.text = @"9999";
  }else
    _praiseNum.text = [@(praisenum) stringValue];
}
- (void)setIsPraise:(BOOL)isPraise {
  _isPraise = isPraise;
  if (isPraise) {
    _praisePic.image = [UIImage imageNamed:@"赞_Home_Cell1.png"];
    _praiseNum.textColor = [Globle colorFromHexRGB:@"e86800"];
  } else {
    _praisePic.image = [UIImage imageNamed:@"赞_Home_Cell.png"];
    _praiseNum.textColor = [Globle colorFromHexRGB:@"767676"];
  }
}
- (void)dealloc {
  [self removeAllSubviews];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
  if (highlighted == YES) {
    self.backgroundColor = [Globle colorFromHexRGB:@"E1E1E1"];
  } else {
    self.backgroundColor = [Globle colorFromHexRGB:customBGColor];
  }
  [super setHighlighted:highlighted animated:animated];
}
@end
