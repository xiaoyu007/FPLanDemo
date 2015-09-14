//
//  UserPicView.h
//  优顾理财
//
//  Created by Mac on 14-4-30.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol UserPicView_Delegate <NSObject>
//从正文，设置进入个人主页
- (void)button_clickedButtonAtIndex:(NSInteger)buttonIndex;
@end
@interface UserPicView
    : UIView <UITableViewDataSource, UITableViewDelegate,
              UIGestureRecognizerDelegate> {
  NSMutableArray *main_array;

  UIView *Shard_bottom_view;

  UITableView *main_tableView;
}
@property(nonatomic, strong) NSMutableArray *main_array;
@property(nonatomic, assign) id<UserPicView_Delegate> delegate;
- (id)initWithFrame:(CGRect)frame andImages:(NSArray *)images;
@end
