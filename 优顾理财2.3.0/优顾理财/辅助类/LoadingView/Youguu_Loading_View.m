//
//  Youguu_Loading_View.m
//  优顾理财
//
//  Created by Mac on 14-1-3.
//  Copyright (c) 2014年 Ling YU. All rights reserved.
//

@implementation Youguu_Loading_View
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
    self.userInteractionEnabled = YES;
    [self start];
  }
  return self;
}

- (void)start {
  view_context = [[UIView alloc]
      initWithFrame:CGRectMake(80, self.frame.size.height / 2 - 100, 160, 160)];
  view_context.backgroundColor = [UIColor clearColor];
  view_context.userInteractionEnabled = YES;
  [self addSubview:view_context];

  loading = [[Loading alloc] initWithFrame:CGRectMake(65, 10, 40, 40)];
  [view_context addSubview:loading];

  back_image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"加"
                                                                      @"载"]];
  back_image.backgroundColor = [UIColor clearColor];
  back_image.frame = CGRectMake(15, 60, 130, 90);
  [view_context addSubview:back_image];

  [self download_not_loading];
}

- (void)download_not_loading {
  view_down_tap = [[UIView alloc] initWithFrame:self.bounds];
  view_down_tap.backgroundColor = [UIColor clearColor];
  view_down_tap.userInteractionEnabled = YES;
  view_down_tap.hidden = YES;
  [self addSubview:view_down_tap];

  btn_view = [UIButton buttonWithType:UIButtonTypeCustom];
  btn_view.frame = self.bounds;
  [btn_view addTarget:self
                action:@selector(down_loading)
      forControlEvents:UIControlEventTouchUpInside];
  //    UIEdgeInsets  edginset=UIEdgeInsetsMake(80, 115,
  //    self.frame.size.height-180, 115);
  UIEdgeInsets edginset = UIEdgeInsetsMake(view_down_tap.center.y - 110, 115,
                                           view_down_tap.center.y + 10, 115);
  btn_view.imageEdgeInsets = edginset;
  [view_down_tap addSubview:btn_view];

  UILabel *lable_text = [[UILabel alloc]
      initWithFrame:CGRectMake(100, view_down_tap.center.y - 10, 120, 40)];
  lable_text.text = @"网络不给力，点击刷新";
  lable_text.textAlignment = NSTextAlignmentCenter;
  lable_text.font = [UIFont systemFontOfSize:12];
  lable_text.textColor = [UIColor grayColor];
  lable_text.backgroundColor = [UIColor clearColor];
  [view_down_tap addSubview:lable_text];

  btn_Click = [UIButton buttonWithType:UIButtonTypeCustom];
  btn_Click.frame = CGRectMake(110, view_down_tap.center.y - 10 + 40, 100, 100);
  [btn_Click addTarget:self
                action:@selector(btn_click_action)
      forControlEvents:UIControlEventTouchUpInside];
  [view_down_tap addSubview:btn_Click];

  [self Night_to_Day];
}
- (void)btn_click_action {
  if ([delegate respondsToSelector:@selector(Interest_management)]) {
    [delegate Interest_management];
  }
}

//正在加载，旋转动画
- (void)btn_click {
  view_context.hidden = YES;
  view_down_tap.hidden = NO;
  //    [loading stopAnimation];
}

//返回到旋转动画
- (void)start_btn_click {
  //    [loading startAnimation];
  view_context.hidden = NO;
  view_down_tap.hidden = YES;
}

//是否有网络
- (BOOL)is_have_not_network {
  NSString *network = CheckNetWork();
  if ([network isEqualToString:@"无网络"]) {
    return NO;
  }
  return YES;
}

//点击，从新加载数据
- (void)down_loading {
  if ([self is_have_not_network] == YES) {
    [loading startAnimation];
    view_context.hidden = NO;
    view_down_tap.hidden = YES;
  }

  if ([delegate respondsToSelector:@selector(loadData_Cai)]) {
    [delegate loadData_Cai];
  }
}
- (void)dealloc {
  [self removeAllSubviews];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *
 *  //消息中心
 *
 **/
#pragma mark - 消息中心，回调，夜间、白天和无图、有图

//夜间模式和白天模式
- (void)Night_to_Day {
    back_image.image = [UIImage imageNamed:@"加载"];
    [btn_view setImage:[UIImage imageNamed:@"手"]
              forState:UIControlStateNormal];
    [btn_view setImage:[UIImage imageNamed:@"手1"]
              forState:UIControlStateHighlighted];
    [btn_Click setBackgroundImage:[UIImage imageNamed:@"看书"]
                         forState:UIControlStateNormal];
    [btn_Click setBackgroundImage:[UIImage imageNamed:@"看书1"]
                         forState:UIControlStateHighlighted];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
