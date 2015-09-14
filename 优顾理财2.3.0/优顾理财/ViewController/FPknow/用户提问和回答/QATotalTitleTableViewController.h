//
//  QATotalTableViewController.h
//  优顾理财
//
//  Created by Yuemeng on 15/9/7.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "BaseTableViewController.h"
#import "BaseTitleViewController.h"

typedef NS_ENUM(NSUInteger, QAType) {
  QATypeMyQuestion, //我的提问
  QATypeMyAnswer,   //我的回答
  QATypeMyComment,  //我的评论
};

/**
 *  我的提问、回答、评论公共页面
 */
@interface QATotalTableAdapter : BaseTableAdapter {
  NSInteger _longProcessIndex;
}
//当前页面类型
@property(nonatomic) QAType type;
@end

@interface QATotalTableViewController : BaseTableViewController
//当前页面类型
@property(nonatomic) QAType type;
@end

@interface QATotalTitleTableViewController : BaseTitleViewController {
  //当前页面类型
  QAType _type;
  QATotalTableViewController *_tableVC;
}

- (id)initWithQAType:(QAType)type;

@end
