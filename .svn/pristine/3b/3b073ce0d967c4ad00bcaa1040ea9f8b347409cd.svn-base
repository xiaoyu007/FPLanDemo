//
//  My_Datepicker.h
//  优顾理财
//
//  Created by Mac on 14/10/27.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol My_Datepicker_Delegate <NSObject>

@optional

- (void)Show_DatePicker_Time:(NSString *)time andTag:(NSInteger)Tag;

@end

@interface My_Datepicker : UIView {
  UIDatePicker *Main_datePicker;

  UILabel *Title_datePicker;

  UIButton *Btn_datePicker;
}
@property(nonatomic, retain) UIDatePicker *Main_datePicker;
@property(nonatomic, retain) UILabel *Title_datePicker;
@property(nonatomic, retain) UIButton *Btn_datePicker;
@property(nonatomic, assign) id<My_Datepicker_Delegate> delegate;
@end
