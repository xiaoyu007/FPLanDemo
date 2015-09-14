//
//  CommunicationCenterTableViewCell.h
//  优顾理财
//
//  Created by Mac on 15/3/20.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 交流中心cell */
@interface FPCommunicationCenterTableViewCell : UITableViewCell
/** 图标背景 */
@property(weak, nonatomic) IBOutlet UIImageView *iconBGImageView;

/** icon */
@property(strong, nonatomic) IBOutlet UIImageView *iconImageView;

/** 标题 */
@property(strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *unreadNum;
/** 设置图标背景色 */
- (void)setIconBGImageViewColor:(NSString *)bgColor;

@end
