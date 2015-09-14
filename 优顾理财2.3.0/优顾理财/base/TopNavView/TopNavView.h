//
//  topNavView.h
//  优顾理财
//
//  Created by Mac on 14-3-10.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "clickLabel.h"

@protocol TopNavViewDelegate <NSObject>
@optional
/** 返回 */
- (void)leftButtonPress;
/** 加载web页面 */
- (void)willCreatWebview:(NSString *)urlstring;
@end
/** 导航栏 */
@interface TopNavView : UIView <UITextFieldDelegate>

@property(nonatomic, assign) id<TopNavViewDelegate> delegate;
@property(nonatomic, strong) UILabel * mainLable;
@property(nonatomic, strong) NSString * mainLableString;
/** url新闻链接 */
@property(nonatomic, strong) UITextField *textfield;
@property(nonatomic, strong) NSString *textfieldString;
///子标题
@property(nonatomic, strong) UILabel *subTitleLabel;
@property(nonatomic, strong) NSString *subTitleString;
/** 分割线 */
@property(nonatomic, strong) UIView *xian_view;
///全长线
- (void)setLineView;

/** 标题双行显示 */
- (void)leftAlignmentOfViewWithMainTitle:(NSString *)mainTitle
                            withSubTitle:(NSString *)subTitle;
@end
