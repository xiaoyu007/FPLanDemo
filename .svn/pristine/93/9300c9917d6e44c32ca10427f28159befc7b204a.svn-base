//
//  QATableViewController.h
//  优顾理财
//
//  Created by Mac on 15/8/13.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPNoTitleBaseTableViewController.h"
#import "QATotalViewController.h"

typedef NS_ENUM(NSUInteger, QAUserListType) {
  QuestionType = 0, //发言列表
  AnswerType = 1,   // 回复列表
  MyCommentType = 2 //我的评论
};
@protocol QATableViewControllerDelegate <NSObject>
@optional
//获取发言个数
- (void)getArrayNum:(NSInteger)num
        andUserSign:(NSString *)sign
            andtype:(QAUserListType)type;
@end


@interface QATableViewController
    : FPNoTitleBaseTableViewController <UIAlertViewDelegate> {
  QAUserListType type;
  ///长按选中的
  NSInteger longProcessIndex;
}
@property(nonatomic, assign) id<QATableViewControllerDelegate> delegate;
///用户的userid
@property(nonatomic, strong) NSString *userId;
- (id)initWithFrame:(CGRect)frame andQAType:(QAUserListType)state;
@end
