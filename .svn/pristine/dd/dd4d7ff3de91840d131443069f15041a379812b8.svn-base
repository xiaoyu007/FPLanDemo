//
//  UserInfoTableViewCell.h
//  优顾理财
//
//  Created by Mac on 14-7-30.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PicUserHeader.h"

@interface UserInfoTableViewCell : UITableViewCell {
  //    标题
  UILabel *Title_label;

  PicUserHeader *PIC_image;

  UILabel *sub_label;
  //    尾图
  UIImageView *Down_imageView;

  UIView *D_View_2;

  //    是否有按下态
  BOOL is_pressed_state;
}
@property(nonatomic, strong) UILabel *Title_label;
@property(nonatomic, strong) PicUserHeader *PIC_image;
@property(nonatomic, strong) UILabel *sub_label;
@property(nonatomic, assign) BOOL is_pressed_state;

- (void)To_determine_whether_the:(NSInteger)row
                      andSection:(NSInteger)section
                        andImage:(UIImage *)image
                    andhave_type:(BOOL)have_type
                    andthirdname:(NSString *)thirdname
                  withArrowImage:(BOOL)isShowArrowImage;
@end
