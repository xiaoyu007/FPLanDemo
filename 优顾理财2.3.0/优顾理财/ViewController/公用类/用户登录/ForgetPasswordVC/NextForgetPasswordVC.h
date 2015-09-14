//
//  NextForgetPasswordVC.h
//  优顾理财
//
//  Created by Mac on 14-8-4.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

@interface NextForgetPasswordVC
    : YGBaseViewController <UITextFieldDelegate> {
  UITextField *passwordTextField;
  UITextField *oncePassWordTextField;

  AnimationLabelAlterView *animation_alterView;
}
@property(nonatomic, strong) NSString *phone_Number;
- (id)initPhone:(NSString *)phone_Number;
@end
