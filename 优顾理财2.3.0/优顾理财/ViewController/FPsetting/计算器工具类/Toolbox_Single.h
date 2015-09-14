//
//  Toolbox_Single.h
//  优顾理财
//
//  Created by Mac on 14/10/20.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Toolbox_Single : UIView {
  UIView *background_View;

  UIImageView *head_image;

  UILabel *title_View;

  UIButton *Click_btn;
}

@property(nonatomic, retain) UIView *background_View;

@property(nonatomic, strong) UIImageView *head_image;

@property(nonatomic, strong) UILabel *title_View;

@property(nonatomic, strong) UIButton *Click_btn;

@end
