//
//  circularRingView.h
//  优顾理财
//
//  Created by Mac on 15/7/24.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface circularRingView : UIView
{
  /** 中间图片部分 */
  UIImageView *imageView;
  /** 大白圆 */
  UIView *bigCircle;
  /** 中间小圆 */
  UIView *smallCircle;
}
@end
