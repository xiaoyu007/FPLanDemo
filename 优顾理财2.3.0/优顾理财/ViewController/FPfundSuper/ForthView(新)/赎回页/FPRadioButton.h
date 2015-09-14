//
//  RadioButton.h
//  SimuStock
//
//  Created by jhss_wyz on 15/4/9.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FPRadioButton : UIButton

/** 选中状态（无需重复设置selected属性），设置后自动改变按钮的绘图结果 */
@property(assign, nonatomic) BOOL radioBtnSelected;

@end
