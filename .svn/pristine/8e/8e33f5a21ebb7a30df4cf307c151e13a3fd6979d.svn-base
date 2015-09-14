//
//  FPMyInfoTableViewCell.h
//  优顾理财
//
//  Created by Mac on 15/8/12.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PicUserHeader.h"
#import "FTLabel.h"
#import "UserListItem.h"
@interface FPMyInfoTableViewCell : UITableViewCell <PicUserHeaderDelegate>
@property(weak, nonatomic) IBOutlet PicUserHeader *userPicHeaderImage;
@property(weak, nonatomic) IBOutlet UILabel *userName;
@property(weak, nonatomic) IBOutlet UILabel *timeLable;
/** 内容 */
@property(weak, nonatomic) IBOutlet FTLabel *contentLable;
@property(weak, nonatomic) IBOutlet UIButton *userNameBtn;
@property(nonatomic, strong) UserListItem *userListItem;
/**是否已读 */
@property(nonatomic, assign) BOOL isRead;
/** 长按手势 */
@property(strong, nonatomic) UILongPressGestureRecognizer *longPress;
///系统消息头像处理
- (void)systemDefaultWithPic:(NSString *)headpic
                 andNickname:(NSString *)nickname;

@end
