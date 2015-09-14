//
//  FPthirdShareView.m
//  优顾理财
//
//  Created by Mac on 14-1-7.
//  Copyright (c) 2014年 Ling YU. All rights reserved.
//

#import "FPthirdShareView.h"

@implementation FPthirdShareView
- (void)setType:(int)type {
  _type = type;
  if (type != 2) {
    _collectView.hidden = YES;
  }
}

-(void)setIsCollect:(BOOL)isCollect
{
  _isCollect = isCollect;
  if (isCollect) {
    _sixLable.text =@"取消收藏";
  }else
  {
    _sixLable.text = @"帖子收藏";
  }
}

- (void)awakeFromNib {
  [super awakeFromNib];
  [self creatCommentBox];
  [self.cancelBtnClick
      setBackgroundImage:[[UIImage imageNamed:@"意见反馈-提交"]
                             stretchableImageWithLeftCapWidth:30
                                                 topCapHeight:27]
                forState:UIControlStateNormal];
  self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
  self.shareView.layer.cornerRadius =5;
  [self animation_start];
}
- (IBAction)shareClickBtn:(UIButton*)sender {
  if (sender.tag == 1005) {
    //判断是否有网络
    if (![FPYouguUtil isExistNetwork]) {
      YouGu_animation_Did_Start(networkFailed);
      return;
    }
    if ([_delegate respondsToSelector:@selector(Collect_NEWS:)]) {
      self.isCollect = ! self.isCollect;
      [_delegate Collect_NEWS:self.isCollect];
      [self backBtnClick];
    }
    return;
  } else if (sender.tag == 1000 || sender.tag == 1001) {
    _commentBox.mainTextview.text = [NSString
        stringWithFormat:@"//分享优顾理财:%@", self.shareTitle];
    if (self.type == 2) {
      _commentBox.mainTextview.text = @"//分享优顾理财(财知道)";
    }
    _commentBox.mainTextview.selectedRange = NSMakeRange(0, 0);
    if (sender.tag == 1000) {
      _commentBox.titleName.text = @"分享到新浪微博";
    }
    if (sender.tag == 1001) {
      _commentBox.titleName.text = @"分享到腾讯微博";
    }
    change_num = (int)sender.tag;
    [UIView animateWithDuration:0.2
        animations:^{
          self.shareView.top = self.bottom;
        }
        completion:^(BOOL finished) {
          if (finished) {
            [self first_button_Comment];
          }
        }];
    return;
  }
  //有网络情况
  [self NotificationCenter:@(sender.tag-1000)];
}
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
  [self backBtnClick];
}
- (void)NotificationCenter:(NSNumber *)num {
  if (self.shareContent.length>200) {
    self.shareContent = [self.shareContent substringToIndex:200];
  }
  YouGu_defaults_double(self.shareTitle, @"content_title_news");
  YouGu_defaults_double(self.shareContent, @"share_content_to_youguu");
  YouGu_defaults_double(self.shareWebUrl, @"weburl");
  [[NSNotificationCenter defaultCenter] postNotificationName:@"shareContentSDK"
                                                      object:num];
  [self endEditing:NO];
  [self removeAllSubviews];
  [self removeFromSuperview];
}
#pragma mark - 评论独立界面，第三方分享界面，设置更多节目
//创建评论框
- (void)creatCommentBox {
  _commentBox = [[[NSBundle mainBundle] loadNibNamed:@"CommentBox"
                                               owner:self
                                             options:nil] firstObject];
  _commentBox.delegate = self;
  _commentBox.userInteractionEnabled = YES;
  _commentBox.hidden = YES;
  [self addSubview:_commentBox];
  [self bringSubviewToFront:_commentBox];
}
// _commentBox  代理1
- (void)CommentsTextOnPosts:(NSString*)text {
  self.shareContent = text;
  _commentBox.mainTextview.text = nil;
  _commentBox.rightBtn.userInteractionEnabled = NO;

  [self NotificationCenter:@(change_num-1000)];
}
// _commentBox  代理2
- (void)exitCommentBox {
  //    请选择要删除的条目
  UIAlertView* alter_upload_view = [[UIAlertView alloc]
          initWithTitle:@"通知"
                message:@"您要放弃精彩内容的分享吗？"
               delegate:self
      cancelButtonTitle:@"取消"
      otherButtonTitles:@"放弃", nil];
  alter_upload_view.tag = 1000;
  [alter_upload_view show];
}
#pragma mark - UIalertviewDelegate
- (void)alertView:(UIAlertView*)alertView
    clickedButtonAtIndex:(NSInteger)buttonIndex {
  //    放弃分享内容
  if (alertView.tag == 1000) {
    if (buttonIndex != alertView.cancelButtonIndex) {
      [self removeAllSubviews];
      [self removeFromSuperview];
    } else {
      [self first_button_Comment];
    }
  }
}
// first 按钮
- (void)first_button_Comment {
  //让textview，获得第一相应者
  _commentBox.hidden = NO;
  [_commentBox get_becomefirstResponder];
}
- (void)dealloc {
  [self endEditing:NO];
  [self removeAllSubviews];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 收回 第三方分享页
//动画出现
- (void)animation_start {
  self.shareView.top = self.bottom;
  [UIView animateWithDuration:0.5
      delay:0.0f
      options:0
      animations:^{
        self.shareView.bottom = self.bottom - 30;
      }
      completion:^(BOOL finished){
      }];
}
- (IBAction)backBtnClick:(id)sender {
  [self backBtnClick];
}
//收回分享界面
- (void)backBtnClick {
  [UIView animateWithDuration:0.5
      animations:^{
        self.shareView.top = self.bottom;
      }
      completion:^(BOOL finished) {
        if (finished) {
          if ([_delegate respondsToSelector:@selector(button_shard_2)]) {
            [_delegate button_shard_2];
          }
          [self endEditing:NO];
          [self removeAllSubviews];
          [self removeFromSuperview];
        }
      }];
}
- (void)pan_back_view_click:(UIPanGestureRecognizer*)recognizer {
  static CGPoint old_point;
  CGPoint point = [recognizer translationInView:recognizer.view];
  if (recognizer.state == UIGestureRecognizerStateBegan) {
    old_point = point;
  }
  if (recognizer.state == UIGestureRecognizerStateCancelled ||
      recognizer.state == UIGestureRecognizerStateEnded) {
    [self backBtnClick];
  }
}
@end
