//
//  TouchView.h
//  TouchDemo
//
//  Created by Zer0 on 13-10-11.
//  Copyright (c) 2013年 Zer0. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsChannelList.h"
@class TouchViewModel;
@interface TouchView : UILabel<UIGestureRecognizerDelegate> {
  CGPoint _point;
  CGPoint _point2;
  NSInteger _sign;
 @public

  NSMutableArray* _array;
  NSMutableArray* _viewArr11;
  NSMutableArray* _viewArr22;
  
  CGRect stateFrame;
}
/** 是否可编辑 */
@property(nonatomic, assign) BOOL isEditable;
//@property (nonatomic,retain) UILabel * label;
@property(nonatomic, strong) UILabel* moreChannelsLabel;
@property(nonatomic, strong) TouchViewModel* touchViewModel;
@property(nonatomic, assign) BOOL is_not_GestureRecognizer;
@property(nonatomic, strong) NewsChannelItem * item;
@end
