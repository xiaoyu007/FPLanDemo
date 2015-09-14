//
//  RotTableViewController.h
//  优顾理财
//
//  Created by Mac on 15/7/9.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "FPTableViewController.h"
@interface RotTableViewController : FPTableViewController {
  
  int Refrash_num;
}
///新闻频道id
@property(nonatomic, strong) NSString *Channlid;
///频道名称
@property(nonatomic, strong) NSString *Name;
/// num 第几次上啦刷新
@property(nonatomic, assign) NSInteger UP_Refrash_Num;

///专题
@property(nonatomic, strong) NSString * topicid;

- (id)initWithTopicid:(NSString*)topicid;
@end
