//
//  FeedbackViewController.h
//  优顾理财
//
//  Created by Mac on 14-3-27.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "PullingRefreshTableView.h"
#import "PicUserHeader.h"
#import "FeedbackWriteViewController.h"

@interface FeedbackViewController
    : YGBaseViewController <PullingRefreshTableViewDelegate,
                            UITableViewDataSource, UITableViewDelegate,
                            youguu_FeedbackWriteViewController_delegate,
                            UIWebViewDelegate> {
  PullingRefreshTableView *tableview_back;

  //    写反馈
  clickLabel *Summit_btn;

  //   小优头像
  PicUserHeader *PIC_View;
}
@property(nonatomic, retain) NSMutableArray *main_array;
@property(nonatomic, assign) BOOL refrash_is_have;

@end
