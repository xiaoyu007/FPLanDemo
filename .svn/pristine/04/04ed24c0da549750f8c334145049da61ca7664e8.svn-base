//
//  PicUserHeader.m
//  优顾理财
//
//  Created by Mac on 14-4-23.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "PicUserHeader.h"
#import "YGImageDown.h"
#import "UIButton+Block.h"
#import "YouGuNewsUtil.h"
#import "UIImageView+WebCache.h"

@implementation PicUserHeader
@synthesize picImage;
@synthesize Q_View;
-(id)initWithCoder:(NSCoder *)aDecoder
{
  self = [super initWithCoder:aDecoder];
  if (self) {
    // Initialization code
    [self star];
  }
  return self;
}
- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
    [self star];
  }
  return self;
}
-(void)star{

  //    用户相片 底框
  self.backgroundColor = [UIColor clearColor];
  float radius = self.width;
  
  Q_View = [[UIView alloc] initWithFrame:self.bounds];
  Q_View.backgroundColor = [UIColor clearColor];
  Q_View.layer.cornerRadius = self.width / 2.0f;
  Q_View.clipsToBounds = YES;
  Q_View.userInteractionEnabled = YES;
  [self addSubview:Q_View];
  
  image_tt = [[UIView alloc] initWithFrame:CGRectMake(0, 0, radius, radius)];
  image_tt.layer.cornerRadius = radius / 2.0;
  image_tt.clipsToBounds = YES;
  [Q_View addSubview:image_tt];
  
  picImage = [[UIImageView alloc]
              initWithImage:[UIImage imageNamed:@"头像无网络.png"]];
  picImage.frame = CGRectMake(0, 0, radius, radius);
  picImage.userInteractionEnabled = YES;
  [image_tt addSubview:picImage];
  
  //      加v操作
  V_image = [[UIImageView alloc]
             initWithImage:[UIImage imageNamed:@"加V认证.png"]];
  V_image.frame = CGRectMake(self.width * 3 / 5, self.width * 3 / 5,
                             self.width * 2 / 5, self.width * 2 / 5);
  V_image.hidden = YES;
  [self addSubview:V_image];
  
  //    夜间将图片变暗
  image_view_black =
  [[UIView alloc] initWithFrame:CGRectMake(0, 0, radius, radius)];
  image_view_black.backgroundColor = [UIColor colorWithRed:36 / 255.0f
                                                     green:36 / 255.0f
                                                      blue:36 / 255.0f
                                                     alpha:0.6];
  image_view_black.hidden = YES;
  image_view_black.layer.cornerRadius = radius / 2.0;
  [picImage addSubview:image_view_black];
  
  Q_View.backgroundColor = [UIColor whiteColor];
  image_view_black.hidden = YES;
  V_image.image = [UIImage imageNamed:@"加V认证"];
  
  self.layer.masksToBounds =YES;
  
  UIButton * picBtn =[UIButton buttonWithType:UIButtonTypeCustom];
  picBtn.backgroundColor = [UIColor clearColor];
  picBtn.layer.masksToBounds=YES;
  picBtn.layer.cornerRadius = self.height/2.0;
  [picBtn setBackgroundImage:[YouGuNewsUtil imageFromColor:@"989898" alpha:0.4] forState:UIControlStateHighlighted];
  picBtn.frame = self.bounds;
  [picBtn setOnButtonPressedHandler:^{
    if (_delegate && [_delegate respondsToSelector:@selector(picBtnClick:)]) {
      [_delegate picBtnClick:self.tag];
    }
  }];
  [self addSubview:picBtn];
}
///给用户头像赋值
-(void)setUserInfoWithUserListItem:(UserListItem *)userListItem
{
  if (userListItem) {
    [self down_pic:userListItem.headPic];
    [self ishasVtype:[userListItem.vType intValue]];
  }else{
    picImage.image = [UIImage imageNamed:@"头像无网络.png"];
  }
}
//判断，是否是，加V,用户
- (void)ishasVtype:(int)is_not {
  if (is_not > 0) {
    V_image.hidden = NO;
  } else {
    V_image.hidden = YES;
  }
}

-(void)downloadPic:(NSString *)picUrl andVtype:(BOOL)vtype
{
  if (vtype) {
    V_image.hidden = NO;
  }else{
    V_image.hidden = YES;
  }
//  [picImage setImageWithURL:[NSURL URLWithString:picUrl] placeholderImage:[UIImage imageNamed:@"头像无网络.png"]];
  if (picUrl && [picUrl length] > 0) {
    [[YGImageDown sharedManager]
     add_image:picUrl
     completion:^(UIImage *img) {
       if (img) {
         picImage.image = img;
       } else {
         picImage.image = [UIImage imageNamed:@"头像无网络.png"];
       }
     }];
  } else {
    picImage.image = [UIImage imageNamed:@"头像无网络.png"];
  }
}

//改变头像的大小
- (void)imagt_PIC_header:(CGRect)frame {
  self.frame = frame;
  //    self.layer.cornerRadius=self.width/2.0;
  float radius = self.width;

  Q_View.frame = self.bounds;
  Q_View.layer.cornerRadius = self.width / 2.0;
  V_image.frame = CGRectMake(self.width * 3 / 5, self.width * 3 / 5,
                             self.width * 2 / 5, self.width * 2 / 5);
  image_tt.frame = CGRectMake(0, 0, radius, radius);
  image_tt.layer.cornerRadius = radius / 2.0;
  picImage.frame = CGRectMake(0, 0, radius, radius);
  picImage.layer.cornerRadius = radius / 2.0;
  image_view_black.frame = CGRectMake(0, 0, radius, radius);
  image_view_black.layer.cornerRadius = radius / 2.0;
}

//刷新头像的图片
- (void)down_pic:(NSString *)urlstring {
//  [picImage setImageWithURL:[NSURL URLWithString:urlstring] placeholderImage:[UIImage imageNamed:@"头像无网络.png"]];
  if (urlstring && [urlstring length] > 0) {
    [[YGImageDown sharedManager]
     add_image:urlstring
     completion:^(UIImage *img) {
       
       if (img) {
         picImage.image = img;
       } else {
         picImage.image = [UIImage imageNamed:@"头像无网络.png"];
       }
     }];
  } else {
    picImage.image = [UIImage imageNamed:@"头像无网络.png"];
  }
}

- (void)dealloc {
  [self removeAllSubviews];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
