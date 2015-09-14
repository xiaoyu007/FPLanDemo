//
//  FPMyCommentTableViewCell.h
//  优顾理财
//
//  Created by Mac on 15/8/11.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTLabel.h"

@interface FPMyCommentTableViewCell : UITableViewCell
/** 评论标题 */
@property(weak, nonatomic) IBOutlet UILabel *commentTitleLabel;
/** 评论时间 */
@property(weak, nonatomic) IBOutlet UILabel *commentTimeLabel;
/** 评论内容 */
@property(weak, nonatomic) IBOutlet FTLabel *commentLabel;
/** 分割线高度 */
@property(weak, nonatomic) IBOutlet NSLayoutConstraint *cuttingLineViewHeight;

/**是否已读 */
@property(nonatomic, assign) BOOL isRead;
/** 长按手势 */
@property(strong, nonatomic) UILongPressGestureRecognizer *longPress;

@end
