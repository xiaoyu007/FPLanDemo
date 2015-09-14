//
//  NextPhoneBindAccountVC.h
//  优顾理财
//
//  Created by Mac on 14-8-1.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

@interface NextPhoneBindAccountVC
    : YGBaseViewController <UITextFieldDelegate> {
  UITextField *passwordTextField;
  UITextField *oncePassWordTextField;

  AnimationLabelAlterView *animation_alterView;
}
@property(nonatomic, strong) NSString *phone_Number;
@property(nonatomic, strong) NSString *verification_str;
- (id)initPhone:(NSString *)phone andVerification:(NSString *)verification;
@end
