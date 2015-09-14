//
//  AddBankCardViewController.m
//  优顾理财
//
//  Created by jhss on 15-4-13.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPAddBankCardViewController.h"
#import "ZKControl.h"
#import "FPBankListTableViewCell.h"
#import "FPAddbankAuthViewController.h"
#import "NetLoadingWaitView.h"
#import "UIImageView+WebCache.h"

#define NUMBERS @"0123456789\n"
@interface FPAddBankCardViewController () <UITextFieldDelegate>

@end

@implementation FPAddBankCardViewController {

  NSArray *_bankArray;
  NSArray *_nameArray;

  IBOutlet UIButton *presentBtn;
  IBOutlet UIButton *navBtn;
  ///存储银行卡
  NSMutableArray *_bankMutArray;
  ///建立添加银行卡表
  UITableView *_tableView;
  IBOutlet UILabel *bankLabel;
  ///存储选中的银行卡
  NSMutableArray *bankArray;
  /** 银行卡图标数组 */
  NSArray *bankIconArray;
}
/** 释放当前界面 */
-(void)remove_to_before_VC{
  [self removeFromParentViewController];
}
- (void)viewDidLoad {
  [super viewDidLoad];
  bankLabel.hidden = NO;
  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(remove_to_before_VC) name:@"remove_to_before_VC" object:nil];
  
  self.childView.userInteractionEnabled = NO;
  self.bankNumTextField.delegate = self;
  self.iphoneNumTextField.delegate = self;

  self.btnTextField.layer.borderWidth = 1;
  self.btnTextField.layer.borderColor =
      [Globle colorFromHexRGB:@"c7c7c7"].CGColor;
  self.btnTextField.userInteractionEnabled = NO;

  self.bankNumTextField.layer.borderWidth = 1;
  self.bankNumTextField.layer.borderColor =
      [Globle colorFromHexRGB:@"cfcfcf"].CGColor;
  self.bankNumTextField.clearButtonMode = UITextFieldViewModeAlways;
  self.bankNumTextField.keyboardType = UIKeyboardTypeNumberPad;
  self.bankNumTextField.leftView =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
  self.bankNumTextField.leftView.userInteractionEnabled = NO;
  self.bankNumTextField.leftViewMode = UITextFieldViewModeAlways;

  _bankNumTextField.tag = 10;

  self.iphoneNumTextField.layer.borderWidth = 1;
  self.iphoneNumTextField.layer.borderColor =
      [Globle colorFromHexRGB:@"cfcfcf"].CGColor;
  self.iphoneNumTextField.keyboardType = UIKeyboardTypeNumberPad;
  self.iphoneNumTextField.clearButtonMode = UITextFieldViewModeAlways;
  self.iphoneNumTextField.leftView =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
  self.iphoneNumTextField.leftView.userInteractionEnabled = NO;
  self.iphoneNumTextField.leftViewMode = UITextFieldViewModeAlways;


  //银行按钮上的小图标
  [self createBankButton];

  UIImage *highLightImage = [FPYouguUtil
      createImageWithColor:[Globle colorFromHexRGB:@"000000" withAlpha:0.1f]];
  [presentBtn setBackgroundImage:highLightImage
                        forState:UIControlStateHighlighted];
  presentBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
  

  [navBtn setImage:[UIImage imageNamed:@"返回小箭头.png"]
          forState:UIControlStateNormal];
  [navBtn setImage:[UIImage imageNamed:@"返回小箭头.png"]
          forState:UIControlStateHighlighted];
  navBtn.imageEdgeInsets = UIEdgeInsetsMake(15, 20, 15, 20);
  UIImage *highlightImage = [FPYouguUtil
      createImageWithColor:[Globle colorFromHexRGB:@"000000" withAlpha:0.1f]];
  [navBtn setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
  
  
  
  //温馨提示
  UILabel *label1 =
  [[UILabel alloc] initWithFrame:CGRectMake(17,195, windowWidth - 34.0f, 120)];
  label1.text =
  @"目前优顾理财支持的银行卡包括：工行、建行、农行、中行、招行、兴业、民生、浦发、平安、广发、华夏等多家银行的借记卡。后期会有更多可支持银行，敬请期待。";
  label1.font = [UIFont systemFontOfSize:12];
  label1.numberOfLines = 0;
  label1.textColor = [Globle colorFromHexRGB:@"84929e"];
  [self.childView addSubview:label1];

  

  [self sendRequestWithBankList:@"001"];
}
// bank的button
- (void)createBankButton {
  UIImage *pictureImage = [UIImage imageNamed:@"卡片小图标"];
  UIImageView *pictureImageVIew =
      [[UIImageView alloc] initWithImage:pictureImage];
  pictureImageVIew.frame = CGRectMake(10, 8, 19.0f,
                                      16.0f);
  [self.bankListBtn addSubview:pictureImageVIew];

  self.bankName = [[UILabel alloc]
      initWithFrame:CGRectMake(CGRectGetMaxX(pictureImageVIew.frame) + 10, 8,
                               100, 16.0f)];
  self.bankName.text = @"请选择银行";
  [self.bankListBtn addSubview:self.bankName];
  [self.bankListBtn addTarget:self
                       action:@selector(bankListButton:)
             forControlEvents:UIControlEventTouchUpInside];
}
- (void)bankListButton:(UIButton *)btn {
  
  [self.bankNumTextField resignFirstResponder];
  [self.iphoneNumTextField resignFirstResponder];
  //银行列表
  [self bankListView];
}
- (IBAction)navBtn:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
}

//提交按钮
- (IBAction)presentBtn:(id)sender {
  [self.bankNumTextField resignFirstResponder];
  [self.iphoneNumTextField resignFirstResponder];
  
  ///发送请求数据
  [self sendAddBank];
}

//提交按钮 的数据请求
- (void)sendAddBank {
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  if (bankArray.count==0) {
    YouGu_animation_Did_Start(@"请选择银行卡");
    return;
  }
  //银行卡
  if ([self.bankNumTextField.text length] == 0) {
    
    YouGu_animation_Did_Start(@"请输入银行卡号");
    return;
  } else if (![SimuControl
               citizensInformationAndIdentityCardNumberAndBank:
               [self.bankNumTextField.text
                stringByReplacingOccurrencesOfString:@" "
                withString:@""]
               bankIdentity:
               BankCarNumber]) {
    
    YouGu_animation_Did_Start(@"请输入正确的银行卡号");
    return;
  }
  //手机号
  if ([self.iphoneNumTextField.text length] == 0) {
    YouGu_animation_Did_Start(@"请输入手机号");
    return;
  } else if (![SimuControl lengalPhoneNumber:self.iphoneNumTextField.text]) {
    YouGu_animation_Did_Start(@"请输入正确的手机号");
    return;
  }
  [NetLoadingWaitView startAnimating];
  [[WebServiceManager sharedManager]
      sendRequestWithAddBankUserId:YouGu_User_USerid
                          mobileId:self.iphoneNumTextField.text
                          banknoId:self.bankNumber
                     andbankaccoId:[self.bankNumTextField.text
                                       stringByReplacingOccurrencesOfString:
                                           @" " withString:@""]
                    withCompletion:^(NSDictionary *dic) {
                      if (dic && [dic[@"status"]
                                     isEqualToString:@"0000"]) {
                         
                        [NetLoadingWaitView stopAnimating];
                        //解析
                        [self showAddBankWithResponse:dic];

                        FPAddbankAuthViewController *authVC =
                            [[FPAddbankAuthViewController alloc] init];
                        authVC.serianoStr = self.serialno;
                        authVC.userBankidStr = self.userbankid;
                        [AppDelegate pushViewControllerFromRight:authVC];

                      }
                      else {
                        [NetLoadingWaitView stopAnimating];
                        if (dic && [dic[@"status"]
                                    isEqualToString:@"100020"]){
                          YouGu_animation_Did_Start(@"您与开户时输入的卡号与姓名不一致");
                          
                          return ;
                        }
                        
                        NSString *message = [NSString
                            stringWithFormat:@"%@",
                                             dic[@"message"]];
                        if (!message || [message length] == 0 ||
                            [message isEqualToString:@"(null)"]) {
                          message = networkFailed;
                        }
                        if (dic &&
                            [dic[@"status"] isEqualToString:@"0101"]){
                        }else{
                          YouGu_animation_Did_Start(message);
                        }
                      }

                    }];
}
- (void)showAddBankWithResponse:(NSDictionary *)dic {
  FPConnectBankItem *item = [DicToArray parseConnectBankLists:dic];
  ///绑卡流水号
  self.serialno = item.serialno;
  ///用户银行卡ID
  self.userbankid = item.userbankid;
}
//银行列表
- (void)bankListView {

  //灰色的背景视图
  UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
  view.backgroundColor = [UIColor grayColor];
  view.alpha = 0.8;
  view.tag = 100;
  [self.view addSubview:view];

  ///添加手势让其点击空白处银行卡列表移除
  UITapGestureRecognizer *tap =
      [[UITapGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(removeView)];
  [view addGestureRecognizer:tap];

  //白色银行试图
  UIView *view1 = [[UIView alloc]
      initWithFrame:CGRectMake(30, (windowHeight/2.0f - 150.0f), self.view.size.width - 60, 300)];
  view1.backgroundColor = [UIColor whiteColor];
  view1.layer.masksToBounds = YES;
  view1.layer.cornerRadius = 8;
  view1.tag = 101;
  [self.view addSubview:view1];

  _tableView = [[UITableView alloc]
      initWithFrame:CGRectMake(0, 43, view1.size.width, view1.size.height - 43)
              style:UITableViewStylePlain];
  _tableView.delegate = self;
  _tableView.dataSource = self;
  [view1 addSubview:_tableView];

  UILabel *lab = [UILabel labelWithFrame:CGRectMake(0, 17, view1.size.width, 17)
                                   title:@"选择银行"
                                    font:17];
  lab.textAlignment = NSTextAlignmentCenter;
  [view1 addSubview:lab];
  //黄色view
  UIView *view2 =
      [[UIView alloc] initWithFrame:CGRectMake(0, 43, view1.size.width, 1)];
  view2.backgroundColor =
      [UIColor colorWithRed:0.95f green:0.47f blue:0.18f alpha:1.00f];
  [view1 addSubview:view2];
}

///请求银行卡列表
- (void)sendRequestWithBankList:(NSString *)partnerId {
  if (![FPYouguUtil isExistNetwork]) {
    YouGu_animation_Did_Start(networkFailed);
    return;
  }
  [NetLoadingWaitView startAnimating];
  [[WebServiceManager sharedManager]
      sendRequestWithpartnerId:partnerId
                withCompletion:^(NSDictionary *dic) {
                  if (dic &&
                      [dic[@"status"] isEqualToString:@"0000"]) {
                    [NetLoadingWaitView stopAnimating];
                    //解析
                    [self showBankListWithResponse:dic];
                    //提示语，动画
                    //            YouGu_animation_Did_Start(@"请求成功");

                  } else {
                    [NetLoadingWaitView stopAnimating];
                    NSString *message = [NSString
                        stringWithFormat:@"%@", dic[@"message"]];
                    if (!message || [message length] == 0 ||
                        [message isEqualToString:@"(null)"]) {
                      message = networkFailed;
                    }
                    if (dic &&
                        [dic[@"status"] isEqualToString:@"0101"]){
                    }else{
                      YouGu_animation_Did_Start(message);
                    }                  }

                }];
}
//显示银行卡信息，默认选中第一个
- (void)showBankListWithResponse:(NSDictionary *)dict {

  _bankMutArray = [DicToArray parseBankWithLists:dict];
//显示银行卡信息，默认选中第一个11  
//  if ([_bankMutArray count] > 0) {
//    BankItem *item = [_bankMutArray objectAtIndex:0];
//    self.bankName.text = item.name;
//    self.bankNumber = item.no;
//  }
}
#pragma mark--tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return _bankMutArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  static NSString *indent = @"cell";
  FPBankListTableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:indent];

  if (!cell) {
    cell =
        [[FPBankListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:indent];
  }

  FPBankItem *item = _bankMutArray[indexPath.row];
  cell.bankNameLabel.text = item.name;
  [cell.bankImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",
                                                            IP_HTTP, item.logo]]];
  //设置表的分割线的左右长度   上  下   左   右
  [cell setSeparatorInset:UIEdgeInsetsMake(0, 65, 0, 0)];
  return cell;
}
- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {

  return 41;
}
- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  self.selectedIndex = indexPath.row;
  FPBankItem *item = _bankMutArray[self.selectedIndex];
  self.bankName.text = item.name;
  self.bankNumber = item.no;
  NSLog(@"%@", self.bankNumber);
  
  bankArray = [[NSMutableArray alloc]init];
  //把锁定的元素放在一个数组中
  [bankArray
      addObject:_bankMutArray[self.selectedIndex]];
  
  [tableView reloadData];
  [self removeView];
}

//移除视图
- (void)removeView {
  UIView *view = (UIView *)[self.view viewWithTag:100];
  UIView *view1 = (UIView *)[self.view viewWithTag:101];
  [view removeFromSuperview];
  [view1 removeFromSuperview];
}
#pragma mark-----textFieldDelegate
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [self.bankNumTextField resignFirstResponder];
  [self.iphoneNumTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return YES;
}
-(BOOL)textFieldShouldClear:(UITextField *)textField{
    if (textField==_iphoneNumTextField) {
    bankLabel.hidden = NO;
  }
  return YES;
}
- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string {
  NSString *toBeString =
  [textField.text stringByReplacingCharactersInRange:range
                                          withString:string];
  /** 提示输入数字*/
  NSCharacterSet *cs;
  if (textField == _iphoneNumTextField) {
    
    bankLabel.hidden = YES;
    cs = [[NSCharacterSet
           characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]
                          componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if (!basicTest) {
      
      return NO;
    }
    if (toBeString.length > 11) {
      textField.text = [toBeString substringToIndex:11];
      return NO;
    }else{
      if (toBeString.length==0) {
        bankLabel.hidden = NO;
      }
      return YES;
    }
    

  }
  if (textField ==_bankNumTextField) {
    NSString *text = [textField text];

    NSCharacterSet *characterSet =
        [NSCharacterSet characterSetWithCharactersInString:NUMBERS];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location !=
        NSNotFound) {
      return NO;
    }
    
    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];

    NSString *newString = @"";
    while (text.length > 0) {
      NSString *subString = [text substringToIndex:MIN(text.length, 4)];
      newString = [newString stringByAppendingString:subString];
      if (subString.length == 4) {
        newString = [newString stringByAppendingString:@" "];
      }
      text = [text substringFromIndex:MIN(text.length, 4)];
    }

    newString =
        [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];

    if (newString.length >= 24) {
      return NO;
    }

    [textField setText:newString];

    return NO;

  } else
    return YES;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
