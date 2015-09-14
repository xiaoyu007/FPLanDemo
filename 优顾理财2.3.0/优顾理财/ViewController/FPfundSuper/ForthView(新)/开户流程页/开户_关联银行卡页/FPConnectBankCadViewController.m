//
//  ConnectBankCadViewController.m
//  优顾理财
//
//  Created by jhss on 15-3-30.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPConnectBankCadViewController.h"
#import "ZKControl.h"
#import "UIImageView+WebCache.h"
#import "FPBankListTableViewCell.h"
#import "FPBankStepViewController.h"
#import "FPProductAgreementViewController.h"
#import "NetLoadingWaitView.h"

#define NUMBERS @"0123456789\n"
@interface FPConnectBankCadViewController () <UITextFieldDelegate,
                                              UIScrollViewDelegate>
@property(nonatomic, strong) UILabel *bankName; ///银行名称

@end

@implementation FPConnectBankCadViewController {
  UIView *bankWhiteView;
  ///银行卡按钮
  myButton *_btn;
  ///银行卡列表（存储解析出来的数据）
  NSMutableArray *_bankMutarray;
  ///银行卡列表
  UITableView *_tableView;
  /** 封装的开户三步背景颜色类*/
  FPBankStepViewController *bankStep;
}
//移除当前界面
- (void)removeCurrentView {
  [self removeFromParentViewController];
}
- (void)viewDidLoad {
  [super viewDidLoad];
  _isColllected = YES;
  _bankMutarray = [NSMutableArray array];
  [self createNotification];
  
  ///添加手势让其点击空白处银行卡列表移除
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
      initWithTarget:self
              action:@selector(takeTheKeyboard)];
  [_scrolllView addGestureRecognizer:tap];
  ///开户三步图片
  bankStep = [[FPBankStepViewController alloc] initWithNibName:@"FPBankStepViewController" bundle:nil];
  [_scrolllView addSubview:bankStep.view];
  bankStep.view.transform = CGAffineTransformMakeTranslation(0.0f, -70.0f);
  bankStep.view.userInteractionEnabled = NO;
  
  bankStep.secondStepBGView.layer.borderColor = [Globle colorFromHexRGB:customFilledColor].CGColor;
  bankStep.secondStepInterView.backgroundColor = [Globle colorFromHexRGB:customFilledColor];
  _btnTextField.layer.borderWidth = 1;
  _btnTextField.layer.borderColor =
      [[Globle colorFromHexRGB:@"c7c7c7"] CGColor];
  _btnTextField.userInteractionEnabled = NO;
  _btn = [myButton buttonWithFrame:CGRectMake(17, 107, 288, 35)
                              font:17
                             title:@""
                              type:UIButtonTypeCustom
                             image:nil
                     selectedImage:nil
                          andBlock:^(myButton *button) {
                            //银行卡对话框
                            [self bankLists];
                            ///在输入内容时点击选择银行卡输入键盘自动收回
                            [self takeTheKeyboard];
                          }];

  [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [_scrolllView addSubview:_btn];

  _writeCardTextField.delegate = self;
  _nameTextField.delegate = self;
  _IDCardTextField.delegate = self;
  _phoneTextField.delegate = self;

  _writeCardTextField.layer.borderWidth = 1;
  _writeCardTextField.layer.borderColor =
      [[Globle colorFromHexRGB:@"c7c7c7"] CGColor];
  _writeCardTextField.keyboardType = UIKeyboardTypeNumberPad;
  _writeCardTextField.leftView =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
  _writeCardTextField.leftView.userInteractionEnabled = NO;
  _writeCardTextField.leftViewMode = UITextFieldViewModeAlways;
  _writeCardTextField.clearButtonMode = UITextFieldViewModeAlways;

  _writeCardTextField.tag = 41;

  _nameTextField.layer.borderWidth = 1;
  _nameTextField.layer.borderColor =
      [[Globle colorFromHexRGB:@"c7c7c7"] CGColor];
  _nameTextField.leftView =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
  _nameTextField.leftView.userInteractionEnabled = NO;
  _nameTextField.leftViewMode = UITextFieldViewModeAlways;
  _nameTextField.keyboardType = UIKeyboardTypeNamePhonePad;
  _nameTextField.clearButtonMode = UITextFieldViewModeAlways;

  _nameTextField.tag = 42;

  _IDCardTextField.layer.borderWidth = 1;
  _IDCardTextField.layer.borderColor =
      [[Globle colorFromHexRGB:@"c7c7c7"] CGColor];
  _IDCardTextField.leftView =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
  _IDCardTextField.leftView.userInteractionEnabled = NO;
  _IDCardTextField.leftViewMode = UITextFieldViewModeAlways;
  _IDCardTextField.clearButtonMode = UITextFieldViewModeAlways;

  _IDCardTextField.tag = 43;

  _phoneTextField.layer.borderWidth = 1;
  _phoneTextField.layer.borderColor =
      [[Globle colorFromHexRGB:@"c7c7c7"] CGColor];
  _phoneTextField.leftView =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
  _phoneTextField.leftView.userInteractionEnabled = NO;
  _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
  _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
  _phoneTextField.clearButtonMode = UITextFieldViewModeAlways;
  _phoneTextField.text = _iphoneNumber;

  _phoneTextField.tag = 44;

  UIImage *pictureImage = [UIImage imageNamed:@"卡片小图标"];
  UIImageView *pictureImageVIew =
      [[UIImageView alloc] initWithImage:pictureImage];
  pictureImageVIew.frame = CGRectMake(10, 10, 19.0f,
                                      16.0f);
  [_btn addSubview:pictureImageVIew];

  self.bankName = [[UILabel alloc]
      initWithFrame:CGRectMake(CGRectGetMaxX(pictureImageVIew.frame) + 10, 10,
                               100, 16.0f)];
  self.bankName.text = @"请选择银行";
  [_btn addSubview:self.bankName];

  UIImageView *centerImageView = [[UIImageView alloc]
      initWithImage:[UIImage imageNamed:@"进入小箭头"]];
  centerImageView.frame =
      CGRectMake(286 - 30, 10, centerImageView.size.width / 3,
                 centerImageView.size.height / 3);
  [_btn addSubview:centerImageView];
  [self refreshMainPageView];
  [self sendRequestWithBankList:@"001"];
}
/** 刷新主界面 */
- (void)refreshMainPageView{
  //银行预留手机号
  _bankLabel.hidden = NO;
  UIImage *highLightImage =
  [FPYouguUtil createImageWithColor:buttonHighLightColor];
  //同意协议按钮
  [_agreementBtn setBackgroundImage:highLightImage
                           forState:UIControlStateHighlighted];
  //单选按钮
  _selectedButton.layer.borderColor = [Globle colorFromHexRGB:@"F07533"].CGColor;
  _selectedButton.layer.borderWidth = 1;
  _tickImageView.hidden = NO;
  _scrolllView.userInteractionEnabled = YES;
  _scrolllView.contentSize = CGSizeMake(windowWidth, 498.0f);
}
/** 通知信息 */
- (void)createNotification{
  //接收完成页通知移除当前页面
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(removeCurrentView)
                                               name:@"remove_before_view"
                                             object:nil];
}
#pragma mark- 网络请求
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
                      [[dic objectForKey:@"status"] isEqualToString:@"0000"]) {
                    [NetLoadingWaitView stopAnimating];
                    //解析
                    [self showBankListWithResponse:dic];
                  } else {
                    [NetLoadingWaitView stopAnimating];
                    NSString *message = [NSString
                        stringWithFormat:@"%@", [dic objectForKey:@"message"]];
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
///显示银行卡信息，默认选中第一个
- (void)showBankListWithResponse:(NSDictionary *)dict {
  _bankMutarray = [DicToArray parseBankWithLists:dict];
}
#pragma mark- 按钮点击事件
- (IBAction)selectedButtonClicked:(id)sender {
  if (_tickImageView.hidden == NO) {
    _tickImageView.hidden = YES;
    _isColllected = NO;
  } else {
    _tickImageView.hidden = NO;
    _isColllected = YES;
  }
}
///理财协议对勾
- (void)rightBtnClick {
  if (_tickImageView.hidden == NO) {
    _tickImageView.hidden = YES;
    _isColllected = NO;
  } else {
    _tickImageView.hidden = NO;
    _isColllected = YES;
  }
}
- (IBAction)productAgreementBtn:(id)sender {
  FPProductAgreementViewController *productVC =
      [[FPProductAgreementViewController alloc] init];
  [AppDelegate pushViewControllerFromRight:productVC];
}
- (void)bankLists {
  //灰色的背景视图
  AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
  bankBgView = [[UIView alloc] initWithFrame:app.window.bounds];
  bankBgView.backgroundColor = [UIColor grayColor];
  bankBgView.alpha = 0.8;
  [app.window addSubview:bankBgView];
  ///添加手势让其点击空白处银行卡列表移除
  UITapGestureRecognizer *tap =
      [[UITapGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(removeView)];
  [bankBgView addGestureRecognizer:tap];
  //白色银行试图
  bankWhiteView = [[UIView alloc]
      initWithFrame:CGRectMake(30, (windowHeight - 40) / 2.0f - 150.0f,
                               self.view.size.width - 60, 300)];
  bankWhiteView.backgroundColor = [UIColor whiteColor];
  bankWhiteView.layer.masksToBounds = YES;
  bankWhiteView.layer.cornerRadius = 8;
  [app.window addSubview:bankWhiteView];

  _tableView = [[UITableView alloc]
      initWithFrame:CGRectMake(0, 43, bankWhiteView.size.width,
                               bankWhiteView.size.height - 43)
              style:UITableViewStylePlain];
  _tableView.delegate = self;
  _tableView.dataSource = self;
  [bankWhiteView addSubview:_tableView];

  UILabel *lab =
      [UILabel labelWithFrame:CGRectMake(0, 17, bankWhiteView.size.width, 17)
                        title:@"选择银行"
                         font:17];
  lab.textAlignment = NSTextAlignmentCenter;
  [bankWhiteView addSubview:lab];
  //黄色view
  UIView *view2 = [[UIView alloc]
      initWithFrame:CGRectMake(0, 43, bankWhiteView.size.width, 1)];
  view2.backgroundColor =
      [UIColor colorWithRed:0.95f green:0.47f blue:0.18f alpha:1.00f];
  [bankWhiteView addSubview:view2];
}
//移除视图
- (void)removeView {
  [bankBgView removeFromSuperview];
  [bankWhiteView removeFromSuperview];
}
#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return _bankMutarray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *indent = @"cell";
  FPBankListTableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:indent];
  if (!cell) {
    cell = [[FPBankListTableViewCell alloc]
          initWithStyle:UITableViewCellStyleDefault
        reuseIdentifier:indent];
  }
  FPBankItem *item = _bankMutarray[indexPath.row];
  cell.bankNameLabel.text = item.name;
  [cell.bankImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",
                                                            IP_HTTP, item.logo]]];
  [cell setSeparatorInset:UIEdgeInsetsMake(0, 65, 0, 0)];
  return cell;
}
- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 41;
}
- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  FPBankItem *item = _bankMutarray[indexPath.row];
  self.bankName.text = item.name;
  self.bankNumber = item.no;
  NSLog(@"%@", self.bankNumber);
  _bankArray = [[NSMutableArray alloc] init];
  //把锁定的元素放在一个数组中
  [_bankArray addObject:[_bankMutarray objectAtIndex:indexPath.row]];
  [tableView reloadData];
  [self removeView];
}
#pragma mark - textFieldDelegate

///在输入内容时点击选择银行卡输入键盘自动收回
- (void)takeTheKeyboard {
  UITextField *writeField = (UITextField *)[self.view viewWithTag:41];
  UITextField *nameField = (UITextField *)[self.view viewWithTag:42];
  UITextField *idCardField = (UITextField *)[self.view viewWithTag:43];
  UITextField *iphoneField = (UITextField *)[self.view viewWithTag:44];
  [writeField resignFirstResponder];
  [nameField resignFirstResponder];
  [idCardField resignFirstResponder];
  [iphoneField resignFirstResponder];
  [self animationTextField];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [self takeTheKeyboard];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
  [UIView beginAnimations:nil context:nil]; //设置一个动画
  [UIView setAnimationDuration:0.3];        //设置持续的时间
  [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut]; //设置动画
  if (textField == _nameTextField||textField == _IDCardTextField||textField == _phoneTextField) {
    if (windowHeight < 500) {
      _scrolllView.transform = CGAffineTransformMakeTranslation(0, -150.0f);
    }else{
      _scrolllView.transform = CGAffineTransformMakeTranslation(0, -200.0f);
    }
  }
  [UIView commitAnimations]; //提交动画
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [self animationTextField];
  [textField resignFirstResponder];
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
  if (textField == _phoneTextField || textField == _writeCardTextField) {
    cs = [[NSCharacterSet
        characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]
        componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if (!basicTest) {
      return NO;
    }
  }
  if (textField == _writeCardTextField) {
    NSString *text = [textField text];
    NSCharacterSet *characterSet =
        [NSCharacterSet characterSetWithCharactersInString:@"0123456789\n"];
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
  }
  if (textField == _phoneTextField) {
    _bankLabel.hidden = YES;
    if (toBeString.length > 11) {
      textField.text = [toBeString substringToIndex:11];
      return NO;
    } else {
      if (toBeString.length == 0) {
        _bankLabel.hidden = NO;
      }
      return YES;
    }
  }
  if (textField == _IDCardTextField) {
    NSString *str = [toBeString uppercaseString];
    toBeString = str;
    if (toBeString.length > 21) {
      textField.text = [toBeString substringToIndex:21];
      return NO;
    } else {
      textField.text = toBeString;
      return NO;
    }
  }
  return YES;
}
///设置动画
- (void)animationTextField {
  [UIView beginAnimations:nil context:nil]; //设置一个动画
  [UIView setAnimationDuration:0.3];        //设置持续的时间
  [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut]; //设置动画
  _scrolllView.transform = CGAffineTransformMakeTranslation(0, 0);
  [UIView commitAnimations]; //提交动画
}
@end
