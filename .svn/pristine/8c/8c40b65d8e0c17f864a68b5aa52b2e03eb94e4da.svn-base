//
//  ConnectBankViewController.m
//  优顾理财
//
//  Created by Mac on 15/3/10.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

@implementation FPConnectBankCardViewController
-(void)viewDidLoad
{
  [super viewDidLoad];
  [self creatUI];
}

-(void)creatUI
{
  UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
  view.backgroundColor = [UIColor colorWithRed:0.76f green:0.76f blue:0.76f alpha:1.00f];
  [self.view addSubview:view];
  
  UIButton *BackBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 60, 30)];
  [BackBtn setTitle:@"上一步" forState:UIControlStateNormal];
  BackBtn.backgroundColor = [UIColor orangeColor];
  BackBtn.tag = 100;
  [BackBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
  [view addSubview:BackBtn];
  
  UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 10, 100, 30)];
  titleLabel.text = @"关联银行卡";
  titleLabel.textColor = [UIColor orangeColor];
  [view addSubview:titleLabel];
  
  UIButton *nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(260, 10, 60, 30)];
  [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
  nextBtn.backgroundColor = [UIColor orangeColor];
  BackBtn.tag = 100;
  [nextBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
  [view addSubview:nextBtn];
  
  
  UIImage *img0 = [UIImage imageNamed:@"drawer_arrow.png"];
  UIImageView *imgView0 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 84, 50, 50)];
  imgView0.image = img0;
  [self.view addSubview:imgView0];
  
  UIImage *img1 = [UIImage imageNamed:@"drawer_arrow.png"];
  UIImageView *imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(140, 84, 50, 50)];
  imgView1.image = img1;
  [self.view addSubview:imgView1];
  
  
  UIImage *img2 = [UIImage imageNamed:@"drawer_arrow.png"];
  UIImageView *imgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(250, 84, 50, 50)];
  imgView2.image = img2;
  [self.view addSubview:imgView2];
  
  UIButton *button0 =[[UIButton alloc]initWithFrame:CGRectMake(20, 150, 280, 40)];
  button0.backgroundColor = [UIColor greenColor];
  [button0 setTitle:@"工商银行              >" forState:UIControlStateNormal];
  [self .view addSubview:button0];
  
  UITextField *textField0 = [[UITextField alloc]initWithFrame:CGRectMake(20, 200, 280, 40)];
  textField0.layer.borderWidth = 1;
  textField0.layer.borderColor = [[UIColor colorWithRed:0.87f green:0.87f blue:0.87f alpha:1.00f]CGColor];
  textField0.placeholder = @"  请输入银行账号";
  [self.view addSubview:textField0];
  
  UITextField *textField1 = [[UITextField alloc]initWithFrame:CGRectMake(20, 250, 280, 40)];
  textField1.layer.borderWidth = 1;
  textField1.layer.borderColor = [[UIColor colorWithRed:0.87f green:0.87f blue:0.87f alpha:1.00f]CGColor];
  textField1.placeholder = @"  请填写您的真实姓名";
  [self.view addSubview:textField1];
  
  UITextField *textField2 = [[UITextField alloc]initWithFrame:CGRectMake(20, 300, 280, 40)];
  textField2.layer.borderWidth = 1;
  textField2.layer.borderColor = [[UIColor colorWithRed:0.87f green:0.87f blue:0.87f alpha:1.00f]CGColor];
  textField2.placeholder = @"  请填写18位身份证号";
  [self.view addSubview:textField2];
  
  UITextField *textField3 = [[UITextField alloc]initWithFrame:CGRectMake(20, 350, 280, 40)];
  textField3.layer.borderWidth = 1;
  textField3.layer.borderColor = [[UIColor colorWithRed:0.87f green:0.87f blue:0.87f alpha:1.00f]CGColor];
  textField3.placeholder = @" 银行预留手机号";
  [self.view addSubview:textField3];
  
  UILabel *label0 = [[UILabel alloc]initWithFrame:CGRectMake(20, 410, 100, 30)];
  label0.text = @"温馨提示:";
  label0.font = [UIFont systemFontOfSize:12];
  label0.textColor = [UIColor colorWithRed:0.94f green:0.46f blue:0.20f alpha:1.00f];
  [self.view addSubview:label0];
  
  UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 410, 280, 100)];
  label1.text = @"支付系统由第三方支付机构——快钱提供，请在上侧填写快钱机构的验证码，以确保开户成功。";
  label1.font = [UIFont systemFontOfSize:12];
  label1.numberOfLines = 3;
  label1.textColor = [UIColor colorWithRed:0.74f green:0.76f blue:0.78f alpha:1.00f];
  [self.view addSubview:label1];
  
  UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(100, 300, 50, 50)];
  l.layer.cornerRadius = 25;

  
  
}

-(void)backBtnClick:(UIButton *)btn
{
  YGLog(@"返回上一步");
  FPConnectBankCardViewController *cVC = [[FPConnectBankCardViewController alloc]init];
  [AppDelegate pushViewControllerFromRight:cVC];
}

-(void)nextBtnClick:(UIButton *)btn
{
  YGLog(@"进行下一步");
  ///如果输入的验证码正确，开户成功页
  FPPutInIdentifyingCodeViewController *PVC = [[FPPutInIdentifyingCodeViewController alloc]init];
  [AppDelegate pushViewControllerFromRight:PVC];
}

@end
