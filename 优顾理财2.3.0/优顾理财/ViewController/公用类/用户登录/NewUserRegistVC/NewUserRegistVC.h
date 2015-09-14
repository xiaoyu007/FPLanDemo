//
//  NewUserRegistVC.h
//  优顾理财
//
//  Created by Mac on 14-8-1.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

//注册方式
#import "PhoneBindAccountVC.h"
#import "NormalRegistVC.h"

#import "UserRegistView.h"

@interface NewUserRegistVC : YGBaseViewController {

  UserRegistView *mobile_phone_label;
  UserRegistView *General_registration;

  UILabel *detailLabel;

  UILabel *defaults_Label;
}

@end
