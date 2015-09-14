//
//  FeedbackWriteViewController.h
//  优顾理财
//
//  Created by Mac on 14-3-27.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

//提示动画
#import "AnimationLabelAlterView.h"

@protocol youguu_FeedbackWriteViewController_delegate <NSObject>

- (void)refrash_tableview;

@end

@interface FeedbackWriteViewController
    : YGBaseViewController <UITextViewDelegate> {
  UILabel *header_label;

  UITextView *text_feedback;
  UILabel *text_label;

  UILabel *text_qq_text;

  clickLabel *Summit_btn;
}
@property(nonatomic, assign)
    id<youguu_FeedbackWriteViewController_delegate> delegate;

@property(nonatomic, strong) UITextView *text_qq;
@end
