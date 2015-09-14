//
//  AidTableviewHeaderView.h
//  优顾理财
//
//  Created by Mac on 15/7/8.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StockItemView.h"
#import "EScrollerView.h"
#import "Lineview.h"
@protocol AidTableviewHeaderViewDelegate <NSObject>
@optional
/** 标签按钮点击 */
- (void)Main_EScrollerViewDidClicked:(NSUInteger)index;
@end
@interface AidTableviewHeaderView : UIView<EScrollerViewDelegate>
@property (nonatomic,assign) id<AidTableviewHeaderViewDelegate> delegate;
/** 频道id */
@property(nonatomic, retain) NSString *NEWS_Channlid;
/** 头部数组 */
@property(nonatomic, retain) NSMutableArray *header_array;
/** 滚动视图 */
@property (weak, nonatomic) IBOutlet EScrollerView *escrollerView;
@end
