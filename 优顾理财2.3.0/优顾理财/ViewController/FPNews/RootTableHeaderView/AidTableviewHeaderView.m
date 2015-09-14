//
//  AidTableviewHeaderView.m
//  优顾理财
//
//  Created by Mac on 15/7/8.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "AidTableviewHeaderView.h"
#import "YouGuNewsUtil.h"
#import "Stock_Market_ViewController.h"

@implementation AidTableviewHeaderView

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    //上方的滚动时图
    self.header_array = [[NSMutableArray alloc] init];
  }
  return self;
}
- (void)awakeFromNib {
  [super awakeFromNib];
  self.layer.masksToBounds=YES;
  _escrollerView.delegate = self;
}
#pragma mark - EScrollerView图像点击delegate
//点击小scrollview，跳转
- (void)EScrollerViewDidClicked:(NSUInteger)index {
  if ([_delegate respondsToSelector:@selector(Main_EScrollerViewDidClicked:)]) {
    [_delegate Main_EScrollerViewDidClicked:index];
  }
}
@end
