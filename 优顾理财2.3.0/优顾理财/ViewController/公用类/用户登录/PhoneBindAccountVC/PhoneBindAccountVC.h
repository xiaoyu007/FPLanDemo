//
//  PhoneBindAccountVC.h
//  优顾理财
//
//  Created by Mac on 14-7-31.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

@interface PhoneBindAccountVC
    : YGBaseViewController <UITextFieldDelegate> {
  UIButton *getAuthCodeButton;
  UIButton *nextStepButton;
  UITextField *phoneNumber;
  UITextField *authCodeTextFeild;
  NSInteger time;
  NSTimer *timer;

  AnimationLabelAlterView *animation_alter;
      BOOL requesting;
}
@end
