//
//  FPthirdShareView.h
//  优顾理财
//
//  Created by Mac on 14-1-7.
//  Copyright (c) 2014年 Ling YU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentBox.h"
#import "NewsDetailRequest.h"
@protocol FPthirdShareViewDelegate <NSObject>
@optional
/** 分享结束回调 */
- (void)button_shard_2;
/** 收藏帖子 */
-(BOOL)Collect_NEWS:(BOOL)iscollect;
@end
/** 分享弹出框 */
@interface FPthirdShareView : UIView <CommentBoxDelegate> {
  ///选择哪个按钮分享
  int change_num;
}
@property(nonatomic, assign) id<FPthirdShareViewDelegate> delegate;
@property(nonatomic) int type;
@property(weak, nonatomic) IBOutlet UIView *shareView;
@property(nonatomic, strong) NSString * shareTitle;
@property(nonatomic, strong) NSString * shareContent;
@property(nonatomic, strong) NSString * shareWebUrl;
/** 分享输入框 */
@property(nonatomic, strong) CommentBox * commentBox;
/** 收藏帖子 */
@property (weak, nonatomic) IBOutlet UIView *collectView;
@property (weak, nonatomic) IBOutlet UILabel *sixLable;
/** 收藏状况 */
@property (nonatomic) BOOL isCollect;
/** 取消分享 */
@property (weak, nonatomic) IBOutlet UIButton *cancelBtnClick;
//-(id)initWithWithData:(NewsDetailRequest*)object andType:(int)type;
@end
