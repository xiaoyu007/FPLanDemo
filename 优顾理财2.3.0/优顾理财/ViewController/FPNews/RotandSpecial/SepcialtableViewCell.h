//
//  SepcialtableViewCell.h
//  优顾理财
//
//  Created by Mac on 14-3-12.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 热点cell */
@interface SepcialtableViewCell : UITableViewCell {
  /** 表头视图 */
  UIImageView *imageview_head;
  /** 表头label */
  UILabel *label_data;
  ///是否被选择过了
  BOOL isSelect;
}
@property(nonatomic, retain) UILabel *label_data;
@property(nonatomic, retain) UIImageView *imageview_head;
@property(nonatomic, assign) BOOL isSelect;
/** cell中的标题 */
- (void)cell_backgroundcolor_label;
@end
