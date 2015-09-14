//
//  NewsListTableViewCell.h
//  优顾理财
//
//  Created by Mac on 15/7/7.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"
@interface NewsListTableViewCell : UITableViewCell

@property(weak, nonatomic) IBOutlet UILabel *titleName;
@property(weak, nonatomic) IBOutlet UIImageView *topicPIC;
@property(weak, nonatomic) IBOutlet UILabel *aidLable;
@property(weak, nonatomic) IBOutlet RTLabel *newsIntroduction;
@property(weak, nonatomic) IBOutlet UIImageView *praisePic;
@property(weak, nonatomic) IBOutlet UILabel *praiseNum;
@property(weak, nonatomic) IBOutlet UIButton *praiseBtn;

/**是否已读 */
@property(nonatomic, assign) BOOL isRead;
@property(nonatomic, assign) int isTopicid;
@property(nonatomic, assign) BOOL isPraise;
@property(nonatomic, assign) int praisenum;

@property (nonatomic,strong) UILabel * praiseLable;

+ (RTLabel*)textLabel;
- (void)addAnimation;
@end
