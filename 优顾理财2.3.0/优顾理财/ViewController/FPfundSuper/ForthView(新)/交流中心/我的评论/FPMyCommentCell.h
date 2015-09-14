//
//  MyCommentCell.h
//  优顾理财
//
//  Created by Mac on 15-4-9.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 我的评论cell */
@interface FPMyCommentCell : UITableViewCell
/** 评论标题 */
@property(weak, nonatomic) IBOutlet UILabel *commentTitleLabel;

/** 评论时间 */
@property(weak, nonatomic) IBOutlet UILabel *commentTimeLabel;
/** 评论内容 */
@property(weak, nonatomic) IBOutlet UILabel *commentContentLabel;

@end
