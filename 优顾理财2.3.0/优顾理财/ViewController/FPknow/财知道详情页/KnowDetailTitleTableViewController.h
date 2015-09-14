//
//  KnowDetailTitleTableViewController.h
//  优顾理财
//
//  Created by Yuemeng on 15/9/9.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "BaseTitleViewController.h"
#import "BaseTableViewController.h"
#import "KnowDetailTableViewHeaderView.h"
#import "CommentBox.h"
#import "KnowBottomView.h"
#import "FPthirdShareView.h"

/**
 *  财知道二级详情页面
 */
@interface KnowDetailTableAdapter : BaseTableAdapter <PicUserHeaderDelegate>
@property(nonatomic, strong) KnowDetailItem *headerItem;

@end

@interface KnowDetailTableViewController
    : BaseTableViewController <CommentBoxDelegate, KnowBottomView_Delegate> {
  UserLoadingView *_userLoadingView;
  clickLabel *_footLabel;
}
@property(nonatomic, strong) KnowDetailTableViewHeaderView *tableViewHeader;
@property(nonatomic, copy) NSString *talkId;
@property(nonatomic, strong) KnowDetailItem *headerItem;
@property(nonatomic, strong) MyCollectItem *newsItem;
@property(nonatomic, strong) KnowBottomView *bottomView;
@property(nonatomic, strong) CommentBox *commentBox;
@property(nonatomic) BOOL iscommentBox;
@property(nonatomic) NSInteger selectedIndex;

- (void)reviewBtnClick:(UIButton *)sender;

@end

@interface KnowDetailTitleTableViewController
    : BaseTitleViewController <FPthirdShareViewDelegate> {
  KnowDetailTableViewController *_tableVC;
  UIButton *button_At;
}
@property(nonatomic, copy) NSString *talkId;

- (id)initWithTalkId:(NSString *)talkid;
@end
