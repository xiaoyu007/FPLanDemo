//
//  UserPicView.m
//  优顾理财
//
//  Created by Mac on 14-4-30.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "UserPicView.h"
#import "UserPicViewCell.h"

@implementation UserPicView
@synthesize main_array;
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
    [self creat_shard_view];
  }
  return self;
}

- (id)initWithFrame:(CGRect)frame andImages:(NSArray *)images {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
    main_array = [[NSMutableArray alloc] initWithArray:images];
    [self creat_shard_view];
  }
  return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch {
  for (UIView *view in gestureRecognizer.view.subviews) {
    if ([view isKindOfClass:[UITableView class]] ||
        [view isKindOfClass:[UIButton class]]) {
      return NO;
    }
  }
  return YES;
}
//创建分享页面
- (void)creat_shard_view {
  UIView *shard_view = [[UIView alloc] initWithFrame:self.frame];
  shard_view.userInteractionEnabled = YES;
  [self addSubview:shard_view];

  UIPanGestureRecognizer *pan_back_view = [[UIPanGestureRecognizer alloc]
      initWithTarget:self
              action:@selector(pan_back_view_click:)];
  [shard_view addGestureRecognizer:pan_back_view];

  UITapGestureRecognizer *shard_shadow_view_tap =
      [[UITapGestureRecognizer alloc]
          initWithTarget:self
                  action:@selector(backBtnClick)];
  shard_shadow_view_tap.delegate = self;
  [shard_view addGestureRecognizer:shard_shadow_view_tap];

  Shard_bottom_view = [[UIView alloc]
      initWithFrame:CGRectMake(10, self.bottom, 300, 60 * [main_array count])];
  Shard_bottom_view.userInteractionEnabled = YES;
  [self addSubview:Shard_bottom_view];

  main_tableView = [[UITableView alloc]
      initWithFrame:CGRectMake(0, 0, 300, 60 * [main_array count])
              style:UITableViewStylePlain];
  main_tableView.delegate = self;
  main_tableView.dataSource = self;
  main_tableView.layer.cornerRadius = 5;
  main_tableView.backgroundColor = [UIColor clearColor];
  main_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  main_tableView.scrollEnabled = NO;
  [Shard_bottom_view addSubview:main_tableView];

  self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
  Shard_bottom_view.backgroundColor = [UIColor whiteColor];
  [main_tableView reloadData];
  
  [self animation_start];
}

- (void)sina_shard_button_click:(UIButton *)sender {
}


- (void)dealloc {
  [main_array removeAllObjects];

  main_array = nil;
  [self removeAllSubviews];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 收回 第三方分享页

//动画出现
- (void)animation_start {
  Shard_bottom_view.top = self.bottom;
  [UIView animateWithDuration:0.3f
      delay:0.0f
      options:0
      animations:^{

        Shard_bottom_view.bottom = self.bottom;

      }
      completion:^(BOOL finished){

      }];
}
/** 界面消失 */
- (void)pageReleaseAnimation {
  [UIView animateWithDuration:0.3f
      delay:0.0f
      options:0
      animations:^{

        Shard_bottom_view.top = self.bottom;

      }
      completion:^(BOOL finished) {
        [self removeFromSuperview];
      }];
}
- (void)backBtnClick {
  [UIView animateWithDuration:0.5
      animations:^{

        Shard_bottom_view.top = self.bottom;

      }
      completion:^(BOOL finished) {
        if (finished) {
          [self removeFromSuperview];
        }
      }];
}

- (void)pan_back_view_click:(UIPanGestureRecognizer *)recognizer {
  static CGPoint old_point;
  CGPoint point = [recognizer translationInView:recognizer.view];
  if (recognizer.state == UIGestureRecognizerStateBegan) {
    old_point = point;
  }
  if (recognizer.state == UIGestureRecognizerStateCancelled ||
      recognizer.state == UIGestureRecognizerStateEnded) {
    [UIView animateWithDuration:0.5
        animations:^{

          Shard_bottom_view.top = self.bottom;

        }
        completion:^(BOOL finished) {
          if (finished) {
            //                [self removeFromSuperview];
            [self pageReleaseAnimation];
          }
        }];
  }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return [main_array count];
}

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {

  return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"UserPicViewCell";
  UserPicViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UserPicViewCell alloc]
          initWithStyle:UITableViewCellStyleDefault
        reuseIdentifier:CellIdentifier];
    //    cell被选择一会的背景效果颜色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
  }
  cell.first_label.text = main_array[indexPath.row];
  if (indexPath.row == [main_array count] - 1) {
    [cell button_color:YES];
  } else {
    [cell button_color:NO];
  }
  return cell;
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if ([delegate respondsToSelector:@selector(button_clickedButtonAtIndex:)]) {
    [delegate button_clickedButtonAtIndex:indexPath.row];
  }
  //    [UIView animateWithDuration:0.3f animations:^{
  //      [self removeFromSuperview];
  //    }];
  [self pageReleaseAnimation];
  //    [main_tableView reloadData];
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
