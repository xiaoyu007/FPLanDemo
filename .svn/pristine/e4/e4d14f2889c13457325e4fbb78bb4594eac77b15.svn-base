//
//  SpecialViewController.h
//  优顾理财
//
//  Created by Mac on 14-3-10.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//
#import "FPBaseViewController.h"
#import "CustomPageDada.h"
#import "TopicRequestItem.h"
/** 热点列表 */
@interface SpecialViewController
    : FPBaseViewController <UITableViewDataSource,
                            UITableViewDelegate>
{
  UILabel *label_text;
//  ///阴影
  UIView *image_pic_yinying;
}
@property(nonatomic, strong) NSString * topicID;
@property(nonatomic, strong) UITableView * specialTableview;
@property(nonatomic, strong) TopicRequestItem * item;

-(id)initWithTopicid:(NSString *)topicid;
@end
