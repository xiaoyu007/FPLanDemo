//
//  UserHomeView.h
//  优顾理财
//
//  Created by Mac on 15/7/21.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol UserHomeViewDelegate <NSObject>
-(void)selectHomeBtnClick:(NSInteger)index;
@end

@interface UserHomeView : UIView

@property (nonatomic,assign) id<UserHomeViewDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIButton *qtBtn;
@property (weak, nonatomic) IBOutlet UIButton *awBtn;

////选择按钮的状态
-(void)changeWithStatus:(BOOL)selected;
@end
