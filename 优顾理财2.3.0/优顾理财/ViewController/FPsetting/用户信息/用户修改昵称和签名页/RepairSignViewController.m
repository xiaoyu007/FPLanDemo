//
//  RepairSignViewController.m
//  优顾理财
//
//  Created by Mac on 14-7-31.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "RepairSignViewController.h"
#import "OnLoginRequest.h"

@implementation RepairSignViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  [self CreatNavBarWithTitle:@"个性签名"];
  Summit_btn = [[clickLabel alloc] initWithFrame:CGRectMake(windowWidth - 60.0f, 0, 60.0f, 50)];
  Summit_btn.font = [UIFont systemFontOfSize:18];
  Summit_btn.textAlignment = NSTextAlignmentCenter;
  Summit_btn.text = @"完成";
  Summit_btn.backgroundColor = [UIColor clearColor];
  Summit_btn.textColor = [Globle colorFromHexRGB:customFilledColor];
  Summit_btn.highlightedColor = buttonHighLightColor;
  [Summit_btn addTarget:self action:@selector(Summit_btn_click:)];
  [self.childView addSubview:Summit_btn];

  _signture = [[UITextView alloc] initWithFrame:CGRectMake(0, 70, windowWidth, 130)];

  _signture.autocorrectionType = UITextAutocorrectionTypeNo;
  _signture.autocapitalizationType = UITextAutocapitalizationTypeNone;
  _signture.returnKeyType = UIReturnKeyDefault;
  _signture.font = [UIFont systemFontOfSize:18];
  _signture.text = [FPYouguUtil getSignture];
  _signture.delegate = self;
  [self.childView addSubview:_signture];

  CGRect frame = _signture.frame;
  textCountLabel =
      [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width - 25.0f, frame.size.height - 19.0f, 20, 14)];
  textCountLabel.backgroundColor = [Globle colorFromHexRGB:@"f0f0f0"];
  textCountLabel.textAlignment = NSTextAlignmentCenter;
  [textCountLabel.layer setMasksToBounds:YES];
  [textCountLabel.layer setCornerRadius:2.5f];
  textCountLabel.font = [UIFont systemFontOfSize:10];
  textCountLabel.text = [NSString stringWithFormat:@"%ld",(long)(30 - _signture.text.length)];
  [_signture addSubview:textCountLabel];
  //    输入字符字数，内容限制
  label2 = [[UILabel alloc] initWithFrame:CGRectMake(120, 210, 190, 20)];
  label2.backgroundColor = [UIColor clearColor];
  label2.textAlignment = NSTextAlignmentRight;
  label2.font = [UIFont systemFontOfSize:12];
  label2.text = @"";
  [self.childView addSubview:label2];

  //    上传头像是，屏蔽界面
  User_loading = [[UserLoadingView alloc] initWithFrame:self.childView.bounds];
  User_loading.hidden = YES;
  User_loading.alter_lable.text = @"正在保存";
  User_loading.userInteractionEnabled = YES;
  [self.childView addSubview:User_loading];

  animation_alter = [[AnimationLabelAlterView alloc] initWithFrame:CGRectMake(0, 50, 320, 30)];
  [self.childView addSubview:animation_alter];

  self.view.backgroundColor =
      [UIColor colorWithRed:240 / 255.0f green:240 / 255.0f blue:240 / 255.0f alpha:1.0];
  label2.textColor = [UIColor grayColor];
  textCountLabel.textColor = [UIColor blackColor];
}
#pragma mark - uitextviewdelegate
- (BOOL)textView:(UITextView *)textView
    shouldChangeTextInRange:(NSRange)range
            replacementText:(NSString *)text {
  if ([text isEqualToString:@"\n"]) {
    return NO;
  } else {
    if (textView.text.length > 30) {
      textCountLabel.textColor =
          [UIColor colorWithRed:128 / 255.0 green:3 / 255.0f blue:0 / 255.0f alpha:1.0];
    } else {
      textCountLabel.textColor = [UIColor blackColor];
    }
    textCountLabel.text = [NSString stringWithFormat:@"%ld", (long)(30 - textView.text.length)];
    return YES;
  }
}
//代理delegate
- (void)textViewDidChange:(UITextView *)textView {
  if (textView.text.length > 30) {
    textCountLabel.textColor =
        [UIColor colorWithRed:128 / 255.0 green:3 / 255.0f blue:0 / 255.0f alpha:1.0];
  } else {
    textCountLabel.textColor = [UIColor blackColor];
  }
  textCountLabel.text = [NSString stringWithFormat:@"%d", (int)(30 - textView.text.length)];
}
//字符串是否为空和都是空格
- (BOOL)isBlankString:(NSString *)string {
  if (string == nil) {
    return YES;
  }
  if (string == NULL) {
    return YES;
  }
  if ([string isKindOfClass:[NSNull class]]) {
    return YES;
  }
  if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
    return YES;
  }
  return NO;
}
- (void)Summit_btn_click:(UIView *)sender {
  [_signture resignFirstResponder];
  if ([_signture.text length] <= 30) {
    [self Mod_USER_Contif_image_data];
  } else {
    YouGu_animation_Did_Start(@"签名内容不可以超过30个字符");
  }
}

//将用户修改后的信息，上传保存
- (void)Mod_USER_Contif_image_data {
  User_loading.hidden = NO;
  [self ModificationUserWithSignture:self.signture.text];
}
////修改用户头像
- (void)ModificationUserWithSignture:(NSString *)signture {
  HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
  __weak RepairSignViewController *weakSelf = self;
  callBack.onCheckQuitOrStopProgressBar = ^{
    RepairSignViewController *strongObj = weakSelf;
    if (strongObj) {
      User_loading.hidden = YES;
      return NO;
    } else {
      return YES;
    }
  };
  callBack.onSuccess = ^(NSObject *obj) {
    RepairSignViewController *strongSelf = weakSelf;
    if (strongSelf) {
      [FPYouguUtil setSignture:self.signture.text];
      [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginNotificationCenter"
                                                          object:nil];
      [self.view endEditing:NO];
      [AppDelegate popViewController:YES];
    }
  };
  [ModificationUserInfo getModificationUserInfoWithData:[NSData data]
                                              andSysPic:[FPYouguUtil getHeadpic]
                                            andNickname:[FPYouguUtil getUserNickName]
                                            andSignture:signture
                                           WithcallBack:callBack];
}

#pragma mark - NEWS_Nav_View 自定义导航条  按钮delegate 点击函数
- (void)leftButtonPress {
  [self.view endEditing:NO];
  [self.navigationController popViewControllerAnimated:YES];
}
@end
