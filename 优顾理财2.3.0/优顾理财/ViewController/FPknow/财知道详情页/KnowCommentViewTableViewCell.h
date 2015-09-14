//
//  KnowCommentViewTableViewCell.h
//  优顾理财
//
//  Created by Mac on 15/7/27.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PicUserHeader.h"
#import "RTLabel.h"
@interface KnowCommentViewTableViewCell : UITableViewCell<PicUserHeaderDelegate>
@property (weak, nonatomic) IBOutlet PicUserHeader *userPicHeaderImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIButton *userBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet RTLabel *commentLable;
@property (weak, nonatomic) IBOutlet UILabel *praiseLabel;
@property (nonatomic) int praiseNum;
@property (weak, nonatomic) IBOutlet UIButton *praiseBtn;
@property (weak, nonatomic) IBOutlet UIButton *reviewBtn;
/** 赞 + 1 */
@property (strong, nonatomic) UILabel *praiseAnimateLabel;
+ (RTLabel *)textLabel;
-(void)praiseBtnStatus:(BOOL)status;
/** 赞按钮点击 */
- (IBAction)praiseButtonClicked:(id)sender;

@end
