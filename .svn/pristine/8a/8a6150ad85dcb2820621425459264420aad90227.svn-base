//
//  My_PickerView.h
//  优顾理财
//
//  Created by Mac on 14/10/28.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol My_PickerView_Delegate <NSObject>

@optional

- (void)Show_PickerView_Time:(NSString *)time
                      andTag:(NSInteger)Tag
                andSelectRow:(NSInteger)row;

@end

@interface My_PickerView
    : UIView <UIPickerViewDataSource, UIPickerViewDelegate> {
  UIPickerView *Main_datePicker;

  UILabel *Title_datePicker;

  UIButton *Btn_datePicker;

  NSMutableArray *pickerArray;
}
@property(nonatomic, retain) UIPickerView *Main_datePicker;
@property(nonatomic, retain) UILabel *Title_datePicker;
@property(nonatomic, retain) UIButton *Btn_datePicker;
@property(nonatomic, retain) NSMutableArray *pickerArray;

//选择哪个
@property(nonatomic, assign) int selected_num;
@property(nonatomic, assign) id<My_PickerView_Delegate> delegate;
@end
