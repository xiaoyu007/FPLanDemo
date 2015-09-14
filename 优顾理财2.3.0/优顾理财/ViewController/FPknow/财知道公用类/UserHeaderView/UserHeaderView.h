//
//  UserHeaderView.h
//  优顾理财
//
//  Created by Mac on 14-3-21.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "clickLabel.h"
#import "PicUserHeader.h"
#import "UserListItem.h"
@protocol UserHeaderViewDelegate <NSObject>

- (void)USerPicBtnClick;

@end

@interface UserHeaderView : UIView<PicUserHeaderDelegate>

@property (weak, nonatomic) IBOutlet PicUserHeader *picView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *signLable;
@property (nonatomic) BOOL isClick;
//    信息来源，1.为用户本人，2为，他人资料页面
@property(nonatomic, assign) int sourceType;
@property(nonatomic, strong) NSString * certifySignature;
@property(nonatomic, assign) id<UserHeaderViewDelegate> delegate;

-(void)setValue:(UserListItem *)item;
@end
