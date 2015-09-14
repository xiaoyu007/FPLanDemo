//
//  LoadingView.m
//  优顾理财
//
//  Created by Mac on 14-1-3.
//  Copyright (c) 2014年 Ling YU. All rights reserved.
//

@implementation LoadingView

- (id)initWithFrame:(CGRect)frame {
  self = [[[NSBundle mainBundle] loadNibNamed:@"LoadingView" owner:self options:nil] firstObject];
  if (self) {
  }
  return self;
}
- (void)awakeFromNib {
  [super awakeFromNib];
  self.defaultView.backgroundColor = [UIColor clearColor];
  loading = [[Loading alloc] initWithFrame:CGRectMake(65, 10, 40, 40)];
  [self.defaultView addSubview:loading];
  self.InfoDefaultView.hidden = YES;
  self.notDataView.hidden = YES;
}
- (IBAction)noNetWorkBtnClickDown:(id)sender {
  self.noNetWorkImageView.image =[UIImage imageNamed:@"手.png"];
}
- (IBAction)noNetWorkBtnCancel:(id)sender {
  self.noNetWorkImageView.image =[UIImage imageNamed:@"手1.png"];
}
//点击，从新加载数据
- (IBAction)netWorkRequestBtnClick:(id)sender {
  self.noNetWorkImageView.image =[UIImage imageNamed:@"手1.png"];
  if ([self is_have_not_network] == YES) {
    [loading startAnimation];
    self.defaultView.hidden = NO;
    self.InfoDefaultView.hidden = YES;
    self.notDataView.hidden = YES;
  }

  if ([_delegate respondsToSelector:@selector(refreshNewInfo)]) {
    [_delegate refreshNewInfo];
  }
  else{NSLog(@"无网络，没有代理回调");}
}
- (IBAction)infoManagementBtnClick:(id)sender {
  if ([_delegate respondsToSelector:@selector(InfoManagementBtnClick)]) {
    [_delegate InfoManagementBtnClick];
  }
}

//正在加载，旋转动画
- (void)animationStart {
  self.userInteractionEnabled = NO;
  self.defaultView.hidden = NO;
  self.InfoDefaultView.hidden = YES;
  self.notDataView.hidden = YES;
}

//无网络
- (void)animationNoNetWork {
  self.userInteractionEnabled = YES;
  self.defaultView.hidden = YES;
  self.InfoDefaultView.hidden = NO;
  self.notDataView.hidden = YES;
}
- (void)setHidden:(BOOL)hidden{
  [super setHidden:hidden];
}
///暂无数据
- (void)notDataStatus {
  self.userInteractionEnabled = NO;
  self.defaultView.hidden = YES;
  self.InfoDefaultView.hidden = YES;
  self.notDataView.hidden = NO;
}

//是否有网络
- (BOOL)is_have_not_network {
  NSString *network = CheckNetWork();
  if ([network isEqualToString:@"无网络"]) {
    return NO;
  }
  return YES;
}

- (void)dealloc {
  [self removeAllSubviews];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
