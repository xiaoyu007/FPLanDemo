//
//  PicUserHeader.h
//  优顾理财
//
//  Created by Mac on 14-4-23.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserListItem.h"
@protocol PicUserHeaderDelegate <NSObject>
@optional
- (void)picBtnClick:(NSInteger)index;
@end
@interface PicUserHeader : UIView {
  UIView *image_tt;

  UIImageView *picImage;
  UIView *image_view_black;

  UIView *Q_View;
  //      加v操作
  UIImageView *V_image;
}
@property(nonatomic) id<PicUserHeaderDelegate> delegate;
@property(nonatomic, strong) UIImageView *picImage;
@property(nonatomic, strong) UIView *Q_View;
//刷新头像的图片
- (void)down_pic:(NSString *)urlstring;
//改变头像的大小
- (void)imagt_PIC_header:(CGRect)frame;

//判断，是否是，加V,用户
- (void)ishasVtype:(int)is_not;

-(void)downloadPic:(NSString *)picUrl andVtype:(BOOL)vtype;
///给用户头像赋值
-(void)setUserInfoWithUserListItem:(UserListItem *)userListItem;
@end
