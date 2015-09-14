//
//  QATotalViewController.h
//  优顾理财
//
//  Created by Mac on 15/8/9.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPTableViewController.h"
/**
 我的提问、回答、评论 公共类（⚠️已禁用）
 */
typedef enum {
  QATypeMyQuestion = 0,       ///我的提问
  QATypeMyAnswer = 1,       ///我的回答
  QATypeMyComment = 2 ///我的评论
} QAType;
@interface QATotalViewController : FPTableViewController <UIAlertViewDelegate> {
  QAType type;
  ///长按选中的
  NSInteger longProcessIndex;
}
- (id)initWithQAType:(QAType)type;
@end
