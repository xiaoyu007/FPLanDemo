//
//  RepairInfoViewController.m
//  优顾理财
//
//  Created by Mac on 14-7-31.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "RepairInfoViewController.h"
#import "OnLoginRequest.h"

@implementation RepairInfoViewController
@synthesize nickname_lable;
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
  [self CreatNavBarWithTitle:@"昵称修改"];
  Summit_btn = [[clickLabel alloc] initWithFrame:CGRectMake(windowWidth - 60.0f, 0, 60, 50)];
  Summit_btn.font = [UIFont systemFontOfSize:18];
  Summit_btn.textAlignment = NSTextAlignmentCenter;
  Summit_btn.text = @"完成";
  Summit_btn.backgroundColor = [UIColor clearColor];
  Summit_btn.textColor = [Globle colorFromHexRGB:customFilledColor];
  Summit_btn.highlightedColor = buttonHighLightColor;
  [Summit_btn addTarget:self action:@selector(submitBtnClick:)];
  [self.childView addSubview:Summit_btn];

  UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 70, windowWidth + 2, 50)];
  bgView.backgroundColor = [UIColor whiteColor];
  bgView.userInteractionEnabled = YES;
  [self.childView addSubview:bgView];

  nickname_lable = [[UITextField alloc] initWithFrame:CGRectMake(10.0f, 15, windowWidth - 20.0f, 20)];
  [nickname_lable setBorderStyle:UITextBorderStyleNone]; //外框类型
  nickname_lable.backgroundColor = [UIColor whiteColor];
  nickname_lable.placeholder = @"亲，给自己一个响亮的昵称吧！"; //默认显示的字
  nickname_lable.autocorrectionType = UITextAutocorrectionTypeNo;
  nickname_lable.autocapitalizationType = UITextAutocapitalizationTypeNone;
  nickname_lable.returnKeyType = UIReturnKeyDone;
  nickname_lable.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
  nickname_lable.text = [FPYouguUtil getUserNickName];
  nickname_lable.delegate = self;
  [bgView addSubview:nickname_lable];

  //    输入字符字数，内容限制
  label2 = [[UILabel alloc] initWithFrame:CGRectMake(120, 130, 200, 20)];
  label2.backgroundColor = [UIColor clearColor];
  label2.textAlignment = NSTextAlignmentLeft;
  label2.font = [UIFont systemFontOfSize:12];
  label2.text = @"(3—12位字符的中文、英文、数字)";
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
}
#pragma mark - NEWS_Nav_View 自定义导航条  按钮delegate 点击函数
- (void)leftButtonPress {
  [self.view endEditing:NO];
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)submitBtnClick:(UIView *)sender {
  [nickname_lable resignFirstResponder];
  if ([nickname_lable.text length] >= 3) {
    if ([nickname_lable.text length] <= 12) {
      [self Mod_USER_Contif_image_data];
    } else {
      YouGu_animation_Did_Start(@"昵称内容不可以超过12个字符");
    }
  } else {
    YouGu_animation_Did_Start(@"昵称不能小于三个字符");
  }
}

//将用户修改后的信息，上传保存
- (void)Mod_USER_Contif_image_data {
  User_loading.hidden = NO;
  [self ModificationUserWithNickname:nickname_lable.text];
}

////修改用户头像
- (void)ModificationUserWithNickname:(NSString *)nickname {
  HttpRequestCallBack *callBack = [[HttpRequestCallBack alloc] init];
  __weak RepairInfoViewController *weakSelf = self;
  callBack.onCheckQuitOrStopProgressBar = ^{
    RepairInfoViewController *strongObj = weakSelf;
    if (strongObj) {
      User_loading.hidden = YES;
      return NO;
    } else {
      return YES;
    }
  };
  callBack.onSuccess = ^(NSObject *obj) {
    RepairInfoViewController *strongSelf = weakSelf;
    if (strongSelf) {
      [FPYouguUtil setUserNickName:nickname_lable.text];

      [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginNotificationCenter"
                                                          object:nil];

      [self.view endEditing:NO];
      [AppDelegate popViewController:YES];
    }
  };
  [ModificationUserInfo getModificationUserInfoWithData:[NSData data]
                                              andSysPic:[FPYouguUtil getHeadpic]
                                            andNickname:nickname
                                            andSignture:[FPYouguUtil getSignture]
                                           WithcallBack:callBack];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [self.nickname_lable resignFirstResponder];
  return YES;
}
@end
