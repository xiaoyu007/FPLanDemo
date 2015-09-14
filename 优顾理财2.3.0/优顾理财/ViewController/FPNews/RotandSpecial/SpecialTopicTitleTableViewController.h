//
//  SpecialTopicTitleTableViewController.h
//  优顾理财
//
//  Created by Yuemeng on 15/9/9.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "BaseTitleViewController.h"
#import "BaseTableViewController.h"

/**
 *  专题页面
 */
@interface SpecialTopicTableAdapter : BaseTableAdapter
@property(nonatomic, strong) NSString *channlid;

@end

@interface SpecialTopicTableViewController : BaseTableViewController
@property(nonatomic, strong) NSString *channlid;
@property(nonatomic, strong) NSString *topicid;

@end

@interface SpecialTopicTitleTableViewController : BaseTitleViewController {
  SpecialTopicTableViewController *_tableVC;
}

@property(nonatomic, strong) NSString *channlid;
@property(nonatomic, strong) NSString *topicid;

- (id)initWithTopicid:(NSString *)topicid;

@end
