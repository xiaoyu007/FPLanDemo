//
//  CustomPageDada.m
//  优顾理财
//
//  Created by Mac on 14-9-17.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

@implementation CustomPageDada

@end
//********************************************************************************************************
//**************************  Push_news_list_TableDada （推送新闻 type＝38）
//********************************************************************************************************
@implementation Push_news_list_TableDada
@synthesize Push_news_channelid;
@synthesize Push_news_id;
@synthesize Push_news_creattime;
@synthesize Push_news_summny;

- (id)init {
  self = [super init];
  if (self != nil) {
    self.Push_news_channelid = nil;
    self.Push_news_id = nil;
    self.Push_news_creattime = nil;
    self.Push_news_summny = nil;
  }
  return self;
}

- (void)dealloc {
  self.Push_news_channelid = nil;
  self.Push_news_id = nil;
  self.Push_news_creattime = nil;
  self.Push_news_summny = nil;
  [super dealloc];
}

@end
//********************************************************************************************************
//**************************  Topic_General_tableheader
//普通专题（红色的专题）tableheader
//********************************************************************************************************
@implementation Topic_General_tableheader
@synthesize Topic_title;
@synthesize Topic_pic_url;
@synthesize Topic_summny;

- (id)init {
  self = [super init];
  if (self != nil) {
    self.Topic_title = nil;
    self.Topic_pic_url = nil;
    self.Topic_summny = nil;
  }
  return self;
}

- (void)dealloc {
  self.Topic_title = nil;
  self.Topic_pic_url = nil;
  self.Topic_summny = nil;
  [super dealloc];
}

@end
//********************************************************************************************************
//**************************  Topic_General_Title_list
//普通专题（红色的专题）(专题中的小栏目 中cell信息)
//********************************************************************************************************
@implementation Topic_General_Title_list
@synthesize Topic_title;
@synthesize Topic_channelid;
@synthesize Topic_news_id;
@synthesize Topic_type;
@synthesize Topic_creattime;
@synthesize Topic_xgsj_time;
@synthesize Topic_result_type;
@synthesize is_or_read;

- (id)init {
  self = [super init];
  if (self != nil) {
    self.Topic_title = nil;
    self.Topic_channelid = nil;
    self.Topic_news_id = nil;
    self.Topic_type = 0;
    self.Topic_creattime = nil;
    self.Topic_xgsj_time = nil;
    self.Topic_result_type = 0;
    self.is_or_read = NO;
  }
  return self;
}

- (void)dealloc {
  self.Topic_title = nil;
  self.Topic_channelid = nil;
  self.Topic_news_id = nil;
  self.Topic_type = 0;
  self.Topic_creattime = nil;
  self.Topic_xgsj_time = nil;
  self.Topic_result_type = 0;
  self.is_or_read = NO;
  [super dealloc];
}

@end

//********************************************************************************************************
//**************************  Topic_General_list_TableDada
//普通专题（红色的专题）
//********************************************************************************************************
@implementation Topic_General_list_TableDada
@synthesize Topic_title;
@synthesize Topic_type;
@synthesize Topic_news_array;

- (id)init {
  self = [super init];
  if (self != nil) {
    self.Topic_title = nil;
    self.Topic_type = 0;
    self.Topic_news_array = [[NSMutableArray alloc] initWithCapacity:0];
  }
  return self;
}
@end
//********************************************************************************************************
//**************************  Cai_fayan_or_answer_TableData
//(财知道中个人，发言和回答)
//********************************************************************************************************
@implementation Cai_fayan_or_answer_TableData
@synthesize User_aid;
@synthesize User_article_src;

@synthesize User_news_channelid;
@synthesize User_news_creattime;
@synthesize User_news_id;

@synthesize User_nick_name;
@synthesize User_User_id;
@synthesize User_User_pic_url;
@synthesize User_User_sign;

@synthesize User_summary;
@synthesize User_title;

@synthesize User_creattime;
@synthesize User_update_time;

@synthesize User_Zan_num;
@synthesize User_comment_num;

@synthesize User_be_Nickname;
@synthesize User_be_Uid;
@synthesize User_be_be_uid;

@synthesize User_payRate;
@synthesize User_rewardDiamonds;
@synthesize User_rewardState;

@synthesize User_certifySignature;
@synthesize User_vtype;

@synthesize is_not_read;
@synthesize summaryHeight;

- (id)init {
  self = [super init];
  if (self != nil) {
    self.User_aid = nil;
    self.User_article_src = 0;

    self.User_news_channelid = nil;
    self.User_news_creattime = nil;
    self.User_news_id = nil;

    self.User_nick_name = nil;
    self.User_User_id = nil;
    self.User_User_pic_url = nil;
    self.User_User_sign = nil;

    self.User_summary = nil;
    self.User_title = nil;

    self.User_Zan_num = nil;
    self.User_comment_num = nil;

    self.User_creattime = nil;
    self.User_update_time = nil;

    self.User_be_Nickname = nil;
    self.User_be_Uid = nil;
    self.User_be_be_uid = nil;

    self.User_payRate = nil;
    self.User_rewardDiamonds = nil;
    self.User_rewardState = 0;

    self.User_certifySignature = nil;
    self.User_vtype = nil;

    self.is_not_read = NO;
  }
  return self;
}

- (void)dealloc {
  self.User_aid = nil;
  self.User_article_src = 0;

  self.User_news_channelid = nil;
  self.User_news_creattime = nil;
  self.User_news_id = nil;

  self.User_nick_name = nil;
  self.User_User_id = nil;
  self.User_User_pic_url = nil;
  self.User_User_sign = nil;

  self.User_summary = nil;
  self.User_title = nil;

  self.User_Zan_num = nil;
  self.User_comment_num = nil;

  self.User_creattime = nil;
  self.User_update_time = nil;

  self.User_be_Nickname = nil;
  self.User_be_Uid = nil;
  self.User_be_be_uid = nil;

  self.User_payRate = nil;
  self.User_rewardDiamonds = nil;
  self.User_rewardState = 0;

  self.User_certifySignature = nil;
  self.User_vtype = nil;

  self.is_not_read = NO;

  [super dealloc];
}

@end

//********************************************************************************************************
//**************************   packet包，解析
//********************************************************************************************************

@implementation tableFeildItemInfo

@synthesize name = tfii_name;
@synthesize namelenth = tfii_namelenth;
@synthesize isNotes = tfii_isNotes;
@synthesize type = tfii_type;
@synthesize Precision = tfii_Precision;
@synthesize maxLenth = tfii_maxLenth;
@synthesize notesLenth = tfii_notesLenth;
@synthesize notescontent = tfii_notescontent;

- (id)init {
  self = [super init];
  if (self != nil) {
    self.name = nil;
    self.namelenth = 0;
    self.isNotes = NO;
    self.type = nil;
    self.Precision = 0;
    self.maxLenth = 0;
    self.namelenth = 0;
    self.notescontent = nil;
  }
  return self;
}

- (void)dealloc {

  self.name = nil;
  self.type = nil;
  self.notescontent = nil;
  [super dealloc];
}

@end

//********************************************************************************************************************

@implementation paketTableData

@synthesize tableName = td_tableName;
@synthesize feldItemArray = td_feldItemArray;
@synthesize tableItemDataArray = td_tableItemDataArray;
@synthesize tableConnumber = td_tableConnumber;
@synthesize tableLinenumber = td_tableLinenumber;

- (id)init {
  self = [super init];
  if (self != nil) {
    self.tableName = nil;
    td_feldItemArray = [[NSMutableArray alloc] init];
    td_tableItemDataArray = [[NSMutableArray alloc] init];
    self.tableConnumber = 0;
    self.tableLinenumber = 0;
  }
  return self;
}

- (void)dealloc {
  self.tableName = nil;
  [td_feldItemArray release];
  [td_tableItemDataArray release];
  [super dealloc];
}

@end
