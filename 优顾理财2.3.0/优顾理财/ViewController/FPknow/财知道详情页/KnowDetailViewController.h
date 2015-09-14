//
//  KnowDetailViewController.h
//  优顾理财
//
//  Created by Mac on 14-4-4.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "FPTableViewController.h"

#import "CommentBox.h"
#import "KnowBottomView.h"
//分享和收藏
#import "FPthirdShareView.h"

#import "UserLoadingView.h"

#import "RTLabel.h"
#import "clickLabel.h"
#import "KnowRequestItem.h"
#import "KnowDetailTableViewHeaderView.h"

/**
 *  财知道二级页面
 */
@interface KnowDetailViewController
    : FPTableViewController <CommentBoxDelegate, KnowBottomView_Delegate,
                             FPthirdShareViewDelegate, RTLabelDelegate,
                             PicUserHeaderDelegate> {
  BOOL refrash_is_have;
  clickLabel *_footLabel;
  BOOL iscommentBox;

  UIButton *button_At;
  UserLoadingView *User_loading;
  //    被评论用户的id(记录第几个，就可以了)
  int selectedIndex;

  int who_num;
  BOOL is_not_collect;
}
@property(nonatomic, strong) KnowBottomView *bottomView;
@property(nonatomic, strong) KnowDetailItem *headerItem;
@property(nonatomic, strong) KnowDetailTableViewHeaderView *tableViewHeader;
@property(nonatomic, strong) NSString *talkId;
@property(nonatomic, strong) CommentBox *commentBox;
@property(nonatomic, strong) MyCollectItem *newsItem;
- (id)initWithTalkId:(NSString *)talkid;
@end
