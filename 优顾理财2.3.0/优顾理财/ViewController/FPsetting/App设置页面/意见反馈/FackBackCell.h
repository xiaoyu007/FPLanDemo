//
//  FackBackCell.h
//  优顾理财
//
//  Created by Mac on 14-3-27.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"
#import "TriangleView.h"
#import "PicUserHeader.h"
@interface FackBackCell : UITableViewCell {
  TriangleView *Main_View;

  PicUserHeader *img_View;

  //    用户反馈的意见文本
  RTLabel *Text_Content;

  //    文字气泡，
  UIImageView *text_imageview;

  //    时间
  UILabel *lable_time;
}
//@property(nonatomic,retain)UILabel * P_name;
@property(nonatomic, retain) RTLabel *Text_Content;
@property(nonatomic, retain) UILabel *lable_time;
+ (RTLabel *)textLabel;
- (void)Select_Users:(BOOL)is_who andHeight:(float)height;
@end
