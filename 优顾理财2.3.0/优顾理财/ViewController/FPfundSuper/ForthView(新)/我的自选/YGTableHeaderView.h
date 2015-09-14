//
//  HeaderView.h
//  定制header
//
//  Created by Mac on 15/3/24.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGTableHeaderView : UIView

- (UIView *)creatTableHeaderViewWithCategoryName:(NSString *)categoryName
                                    andItemNames:(NSArray *)itemNames;

@end
