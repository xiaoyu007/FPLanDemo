//
//  CommentBox.m
//  优顾理财
//
//  Created by Mac on 13-11-6.
//  Copyright (c) 2013年 Ling YU. All rights reserved.
//

#import "CommentBox.h"

/** 字符串长度 */
#define textLengthMax 140

@implementation CommentBox
- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
  }
  return self;
}
- (void)awakeFromNib {
  self.backgroundColor = [Globle colorFromHexRGB:@"000000" withAlpha:0.3];
  _titleName.font = [UIFont systemFontOfSize:16];
  _titleName.textColor = [Globle colorFromHexRGB:@"666666"];

  _mainTextview.delegate = self;
  _mainTextview.layer.cornerRadius = 3;
  _mainTextview.font = [UIFont systemFontOfSize:16];
  [[_mainTextview layer] setBorderWidth:0.5f];

  _numLable.font = [UIFont systemFontOfSize:10];
  _numLable.text = [NSString stringWithFormat:@"%d", textLengthMax];
  _rightBtn.selected = YES;
  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(keyboardChange:)
             name:UIKeyboardDidChangeFrameNotification
           object:nil];
}
- (id)initWithCoder:(NSCoder*)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
  }
  return self;
}
#pragma mark -keyboard

- (void)keyboardChange:(NSNotification*)notification {
  if (self.headerView) {
    keyboardRect =
        [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    animationDuration =
        [notification
                .userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] -
        0.05f;
    self.headerView.frame =
        CGRectMake(0, self.height - keyboardRect.size.height, 320, 150);
    [UIView animateWithDuration:0.1f
        delay:0.0f
        options:UIViewAnimationOptionCurveEaseOut
        animations:^{
          self.headerView.frame = CGRectMake(
              0, self.height - 150 - keyboardRect.size.height, 320, 150);
        }
        completion:^(BOOL finished){

        }];
  }
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
  YouGu_defaults_double(@"0", @"Start_Login_Sign");
  [_mainTextview resignFirstResponder];
  [self endEditing:YES];
  self.hidden = YES;
  if ([_delegate respondsToSelector:@selector(exitCommentBox)]) {
    [_delegate exitCommentBox];
  }
}

//让输入框获得第一相应者
- (void)get_becomefirstResponder {
  _rightBtn.selected = [FPYouguUtil isStringWithBlank:_mainTextview.text];
  _rightBtn.userInteractionEnabled = !_rightBtn.selected;

  int text_width = textLengthMax - (int)_mainTextview.text.length;
  _numLable.text = [NSString stringWithFormat:@"%d", text_width];
  self.headerView.top = self.height;

  [offtextView setInputAccessoryView:self.headerView];
  [offtextView becomeFirstResponder];
  [_mainTextview becomeFirstResponder];
}
- (void)dealloc {
  [self endEditing:NO];
  [self removeAllSubviews];
  [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - 评论框 methods
- (IBAction)Cacelkeyboard:(id)sender {
  [_mainTextview resignFirstResponder];
  [self endEditing:NO];
  self.hidden = YES;
  if ([_delegate respondsToSelector:@selector(exitCommentBox)]) {
    [_delegate exitCommentBox];
  }
}
- (IBAction)rightRelyComment:(id)sender {
  [_mainTextview resignFirstResponder];
  [self endEditing:NO];
  //    判断是否有网络
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    self.hidden = YES;
    return;
  }
  //    字数是否已超出
  if (_mainTextview.text.length > textLengthMax) {
    UIAlertView* alter_View = [[UIAlertView alloc]
            initWithTitle:nil
                  message:[NSString stringWithFormat:
                                        @"发送内容不可以超过%d个字",
                                        textLengthMax]
                 delegate:nil
        cancelButtonTitle:nil
        otherButtonTitles:@"确定", nil];
    [alter_View show];
    self.hidden = YES;
    return;
  }

  if ([_delegate respondsToSelector:@selector(CommentsTextOnPosts:)]) {
    [_delegate CommentsTextOnPosts:_mainTextview.text];
  }
  self.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView*)textField {
  [[NSNotificationCenter defaultCenter]
      removeObserver:self
                name:UIKeyboardWillChangeFrameNotification
              object:nil];
}
//代理delegate
- (void)textViewDidChange:(UITextView*)textView {
  //    判断是否为空和空格
  _rightBtn.selected = [FPYouguUtil isStringWithBlank:textView.text];
  _rightBtn.userInteractionEnabled = !_rightBtn.selected;
  if (textView.text.length > textLengthMax) {
    _numLable.textColor = [Globle colorFromHexRGB:@"760300"];
  } else {
    _numLable.textColor = [UIColor blackColor];
  }
  _numLable.text = [NSString
      stringWithFormat:@"%d", (int)(textLengthMax - textView.text.length)];
}
//如果输入超过规定的字数100，就不再让输入
- (BOOL)textView:(UITextView*)textView
    shouldChangeTextInRange:(NSRange)range
            replacementText:(NSString*)text {
  if (textView.text.length > textLengthMax) {
    _numLable.textColor = [Globle colorFromHexRGB:@"760300"];
  } else {
    _numLable.textColor = [UIColor blackColor];
  }
  _numLable.text = [NSString
      stringWithFormat:@"%ld", (long)(textLengthMax - textView.text.length)];
  return YES;
}
@end
