//
//  NewsHeaderView.m
//  优顾理财
//
//  Created by Mac on 15/7/14.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "NewsHeaderView.h"

@implementation NewsHeaderView

-(void)setCommentNum:(int)commentNum
{
  _commentNum = commentNum;
  if (commentNum == 0) {
    _lableNum.hidden =YES;
  }
  else{
    _lableNum.hidden = NO;
    _lableNum.text = [NSString stringWithFormat:@"(%d)",commentNum];
  }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
