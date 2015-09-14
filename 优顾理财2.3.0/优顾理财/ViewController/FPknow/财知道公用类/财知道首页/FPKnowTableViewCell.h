//
//  FPKnowTableViewCell.h
//  优顾理财
//
//  Created by Mac on 15/7/24.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PicUserHeader.h"
#import "RTLabel.h"
#import "FTLabel.h"
#import "UserListItem.h"
@interface FPKnowTableViewCell : UITableViewCell<PicUserHeaderDelegate>
@property (weak, nonatomic) IBOutlet PicUserHeader *userPicHeaderImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet FTLabel *contentLable;
@property (weak, nonatomic) IBOutlet UIButton *userNameBtn;

@property (weak, nonatomic) IBOutlet UILabel *praiseNum;
@property(nonatomic, strong) UserListItem * userListItem;
/**是否已读 */
@property (nonatomic,assign) BOOL isRead;
/**是否跳转到用户中心 **/
@property (nonatomic,assign) BOOL isToUserInfoVC;
/** 长按手势 */
@property(strong, nonatomic) UILongPressGestureRecognizer *longPress;
///系统消息头像处理
-(void)systemDefaultWithPic:(NSString * )headpic andNickname:(NSString *)nickname;
+ (RTLabel *)textLabel;
@end
