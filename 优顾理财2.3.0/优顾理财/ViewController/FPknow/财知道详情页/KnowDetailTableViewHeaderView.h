//
//  KnowDetailTableViewHeaderView.h
//  优顾理财
//
//  Created by Mac on 15/7/26.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KnowRequestItem.h"
#import "PicUserHeader.h"
#import "RTLabel.h"
@interface KnowDetailTableViewHeaderView : UIView<PicUserHeaderDelegate>
@property (weak, nonatomic) IBOutlet PicUserHeader *picHeaderView;
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UIButton *nickNameBtn;
@property (weak, nonatomic) IBOutlet RTLabel *contentText;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (nonatomic, strong) UserListItem * userListItem;

-(void)getContentWithText:(KnowDetailItem *)item;
@end
