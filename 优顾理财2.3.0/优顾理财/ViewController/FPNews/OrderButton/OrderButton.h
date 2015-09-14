//
//  OrderButton.h
//  ifengNewsOrderDemo
//
//  Created by zer0 on 14-2-27.
//  Copyright (c) 2014年 zer0. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderButton : UIButton {
  UIColor* highlightedColor_1;
}
@property(nonatomic, retain) UIViewController* vc;
@property(nonatomic, retain) UIColor* highlightedColor_1;

+ (id)orderButtonWithViewController:(UIViewController*)vc;
@end
