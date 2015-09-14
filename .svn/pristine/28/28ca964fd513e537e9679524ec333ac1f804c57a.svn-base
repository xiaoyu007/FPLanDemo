//
//  topNavView.m
//  优顾理财
//
//  Created by Mac on 14-3-10.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//
////创建自定义导航条

#define navBarTitleWidth 260.0f

@implementation TopNavView

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
    [self creatNavController];
  }
  return self;
}
#pragma mark - 自定义导航条
//创建自定义导航条
- (void)creatNavController {
  //返回按钮
  UIImageView *backImageView = [[UIImageView alloc]
      initWithFrame:CGRectMake(16.0f, 14.0f, 12.0f, 22.0f)];
  backImageView.image = [UIImage imageNamed:@"返回小箭头"];
  [self addSubview:backImageView];
  UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  backBtn.frame = CGRectMake(0, 0, 50.0f, navigationHeght);
  backBtn.backgroundColor = [UIColor clearColor];
  UIImage *backImage = [FPYouguUtil createImageWithColor:btnAccordingToTheNormal];
  [backBtn setBackgroundImage:backImage forState:UIControlStateHighlighted];
  [backBtn addTarget:self
                action:@selector(exit_button_click:)
      forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:backBtn];

  //标题
  _mainLable =
      [[UILabel alloc] initWithFrame:CGRectMake(50,15.0f,windowWidth - 100.0f, 18.0f)];
  _mainLable.backgroundColor = [UIColor clearColor];
  _mainLable.font =
      [UIFont fontWithName:@"BodoniSvtyTwoITCTT-Bold" size:18.0f];
  _mainLable.text = @"优顾理财";
  _mainLable.textAlignment = NSTextAlignmentCenter;
  _mainLable.contentMode = UIViewContentModeCenter;
  [self addSubview:_mainLable];

  _textfield = [[UITextField alloc]
      initWithFrame:CGRectMake(50, 6, windowWidth - 100.0f, 38)];
  _textfield.layer.cornerRadius = 5;
  _textfield.backgroundColor = [UIColor clearColor];
  _textfield.hidden = YES;
  _textfield.delegate = self;
  _textfield.font = [UIFont fontWithName:@"BodoniSvtyTwoITCTT-Bold" size:16];
  _textfield.textAlignment = NSTextAlignmentCenter;
  _textfield.contentVerticalAlignment =
      UIControlContentVerticalAlignmentCenter;
  _textfield.contentHorizontalAlignment =
      UIControlContentHorizontalAlignmentCenter;
  _textfield.textAlignment = NSTextAlignmentCenter;
  _textfield.returnKeyType = UIReturnKeyGo;
  _textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
  [self addSubview:_textfield];
  //子标题
  _subTitleLabel =
      [[UILabel alloc] initWithFrame:CGRectMake(50.0f, 32.0f, 100.0f, 12.0f)];
  _subTitleLabel.backgroundColor = [UIColor clearColor];
  _subTitleLabel.textAlignment = NSTextAlignmentLeft;
  _subTitleLabel.textColor = [Globle colorFromHexRGB:@"c4ccd0"];
  _subTitleLabel.font = [UIFont systemFontOfSize:13.0f];
  [self addSubview:_subTitleLabel];
  _subTitleLabel.hidden = YES;
  
  //导航条上的红线
  _xian_view =
      [[UIView alloc] initWithFrame:CGRectMake(0.0f, 49.5f, windowWidth, 0.5f)];
  [self addSubview:_xian_view];
  //白天，夜间，切换
  self.backgroundColor = [UIColor whiteColor];
  _mainLable.textColor = [Globle colorFromHexRGB:customFilledColor];
  //导航条上的红线
  _xian_view.backgroundColor = [Globle colorFromHexRGB:lightCuttingLine];
}
-(void)setMainLableString:(NSString *)mainLableString
{
  if (mainLableString && mainLableString.length>0) {
    self.textfield.hidden = YES;
    self.subTitleLabel.hidden=YES;
    self.mainLable.hidden=NO;
    self.mainLable.frame = CGRectMake(50.0f, 0.0f,windowWidth-100.0f, 50.0f);
    self.mainLable.text = mainLableString;
  }
}
- (void)leftAlignmentOfViewWithMainTitle:(NSString *)mainTitle
                            withSubTitle:(NSString *)subTitle {
  if (mainTitle && mainTitle.length>0 && subTitle && subTitle.length>0) {
    self.mainLable.hidden = NO;
    self.subTitleLabel.hidden = NO;
    self.textfield.hidden = YES;
    
    //标题
    _mainLable.text = mainTitle;
    _mainLable.textAlignment = NSTextAlignmentLeft;
    _mainLable.frame = CGRectMake(50.0f, 0.0f,windowWidth-100.0f, 40.0f);
    _mainLable.numberOfLines = 0;
    //子标题
    _subTitleLabel.text = subTitle;
    _subTitleLabel.hidden = NO;
  }
}

#pragma mark deal with textFieldDelegate & 收键盘处理

- (BOOL)textFieldShouldReturn:
    (UITextField *)
        textField //这个就是之前说的那个协议方法，只要调用了这个方法就能实现收键盘了
{

  if ([_delegate respondsToSelector:@selector(willCreatWebview:)]) {
    [_delegate willCreatWebview:_textfield.text];
  }
  [textField resignFirstResponder];
  return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
  self.textfieldString = textField.text;
  _textfield.backgroundColor = [Globle colorFromHexRGB:@"d1d1d1"];
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
  _textfield.backgroundColor = [UIColor clearColor];
  _textfield.text = self.textfieldString;
}

//全长线
- (void)setLineView {
  _xian_view.frame = CGRectMake(16.0f, 49.5, windowWidth - 32.0f, 0.5f);
}

- (void)dealloc {
  [self removeAllSubviews];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//点击事件
- (void)exit_button_click:(id)sender {
  if ([_delegate respondsToSelector:@selector(leftButtonPress)]) {
    [_delegate leftButtonPress];
  }
}
/**
 *
 *  //消息中心
 *
 **/
#pragma mark - 消息中心，回调，夜间、白天和无图、有图

//夜间模式和白天模式
- (void)Night_to_Day {
    //正文——主视图白天模式
    self.backgroundColor = [UIColor whiteColor];
    _mainLable.textColor = [Globle colorFromHexRGB:customFilledColor];
    //导航条上的红线
    _xian_view.backgroundColor = [Globle colorFromHexRGB:lightCuttingLine];
}

@end
