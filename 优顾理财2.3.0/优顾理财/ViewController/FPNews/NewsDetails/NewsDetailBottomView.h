//
//  NewsDetailBottomView.h
//  优顾理财
//
//  Created by Mac on 15/7/13.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
  Newspraise =0,//赞
  NewsReview = 1,//评论
  NewsList = 2,//列表
  Newscollect = 3,//收藏
  NewsThirdShare = 4,//第三方分享
} NewsBotttomStatus;
@protocol NewsDetailBottomViewDelegate <NSObject>
@optional
- (void)BtnClickedWithIndex:(NewsBotttomStatus)index;
@end
@interface NewsDetailBottomView : UIView

@property(nonatomic,assign) id<NewsDetailBottomViewDelegate> delegate;
@property(nonatomic,strong) NSString * channlId;
@property(nonatomic,strong) NSString * newsId;
@property(nonatomic,assign) BOOL Ispraise;
@property(nonatomic,assign) BOOL IsCollect;
@property (weak, nonatomic) IBOutlet UILabel *praiseLable;
@property (weak, nonatomic) IBOutlet UILabel *animationLable;
@property (weak, nonatomic) IBOutlet UILabel *commentNum;

//收藏按钮
- (void)getCollectStatus:(BOOL)iscollect;
//- (id)initWithFrame:(CGRect)frame  AndnewsId:(NSString *)newsID AndChannlID:(NSString *)channlid;
//赞按钮
- (void)addpraiseNum:(NSString*)num;
//列表按钮
- (void)getlistNum:(NSString*)num;
//代理delegate
- (void)CollectNewsWithTitle:(NSString *)title;
///收藏
-(void)collectBtnClick:(BOOL)iscollect;
@end
