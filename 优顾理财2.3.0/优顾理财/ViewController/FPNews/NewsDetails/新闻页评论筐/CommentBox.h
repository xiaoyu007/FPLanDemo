//
//  CommentBox.h
//  优顾理财
//
//  Created by Mac on 13-11-6.
//  Copyright (c) 2013年 Ling YU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimationLabelAlterView.h"
@protocol CommentBoxDelegate <NSObject>
- (void)CommentsTextOnPosts:(NSString *)text;
@optional
- (void)exitCommentBox;

@end

/**
 *  弹出的评论框
 */
@interface CommentBox
    : UIView <UITextViewDelegate, UIGestureRecognizerDelegate>
{
  UITextView * offtextView;
  double animationDuration;
  CGRect keyboardRect;
}

@property(nonatomic, assign) id<CommentBoxDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UITextView *mainTextview;
@property (weak, nonatomic) IBOutlet UILabel *numLable;

//让输入框获得第一相应者
- (void)get_becomefirstResponder;
@end
