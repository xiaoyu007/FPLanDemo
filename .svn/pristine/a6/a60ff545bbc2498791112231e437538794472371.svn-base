//
//  QAViewController.h
//  优顾理财
//
//  Created by Mac on 15/7/23.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPNoTitleViewController.h"
#import "PullingRefreshTableView.h"
typedef NS_ENUM(NSUInteger, UserListType) {
  QuestionType = 0,//发言列表
  AnswerType = 1,// 回复列表
};

@protocol QAViewControllerDelegate <NSObject>
//#pragma mark - 点击 进入看文章 methods
//-(void)selectCellWithNewsDetail;
@optional
//获取发言个数
-(void)getArrayNum:(int)num andUserSign:(NSString *)sign andtype:(UserListType)type;
@end

@interface QAViewController : FPNoTitleViewController<UITableViewDelegate,UITableViewDataSource,PullingRefreshTableViewDelegate>
{
  //下载数据的start值
  int num;
  //是否在刷新的更新时间
  BOOL refrash_is_have;
  
  PullingRefreshTableView *userTableView;
  
  UITableView *tableview;
}
@property(nonatomic, assign) UserListType type;
//@property(nonatomic, weak) PullingRefreshTableView *userTableView;
@property(nonatomic, assign) id<QAViewControllerDelegate> delegate;
@property(nonatomic, strong) NSString * userId;
@property(nonatomic, strong) NSMutableArray * mainArray;

-(id)initWithFrame:(CGRect)frame andType:(UserListType)type andUid:(NSString *)userId;
@end
