//
//  ConnectBankViewController.h
//  优顾理财
//
//  Created by Mac on 15/3/10.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//
/**
 
 本类为关联银行卡类，，主要是输入个人信息进行开户的一个流程
 
 */
#import <UIKit/UIKit.h>

@interface FPConnectBankCadViewController
    : UIViewController <UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate>
{
  //银行灰色背景
  UIView *bankBgView;
}
///绑定的手机号
@property(nonatomic,strong) NSString *iphoneNumber;
///银行的编号
@property(nonatomic, strong) NSString *bankNumber;
///判断小对勾是否点击
@property(nonatomic, assign) BOOL isColllected;
///存储选中的银行卡
@property(nonatomic, strong) NSMutableArray *bankArray;

/** 输入银行卡号 */
@property(nonatomic, strong) IBOutlet UITextField *writeCardTextField;
///输入姓名
@property(nonatomic, strong) IBOutlet UITextField *nameTextField;
///身份证号
@property(nonatomic, strong) IBOutlet UITextField *IDCardTextField;
///预留手机号
@property(nonatomic, strong) IBOutlet UITextField *phoneTextField;
///选择银行
@property(nonatomic, strong) IBOutlet UITextField *btnTextField;
/** 滚动背景 */
@property(nonatomic, strong) IBOutlet UIScrollView *scrolllView;
/** 预留手机号 */
@property(nonatomic, strong) IBOutlet UILabel *bankLabel;
///购买协议按钮
@property(nonatomic, strong) IBOutlet UIButton *agreementBtn;
///小对勾按钮
@property(nonatomic, strong) IBOutlet UIButton *selectedButton;

///小对勾图片
@property(nonatomic, strong) IBOutlet UIImageView *tickImageView;

///在输入内容时点击选择银行卡输入键盘自动收回
- (void)takeTheKeyboard;
/** 选中按钮点击 */
- (IBAction)selectedButtonClicked:(id)sender;

@end
