//
//  CustomPageDada.h
//  优顾理财
//
//  Created by Mac on 14-9-17.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomPageDada : NSObject

@end


//********************************************************************************************************
//**************************  Push_news_list_TableDada （推送新闻 type＝38）
//********************************************************************************************************

@interface Push_news_list_TableDada : NSObject {
  // 频道id
  NSString *Push_news_channelid;
  // 新闻的id
  NSString *Push_news_id;
  // 更新时间
  NSString *Push_news_creattime;

  //简介
  NSString *Push_news_summny;
}
@property(nonatomic, strong) NSString *Push_news_channelid;
@property(nonatomic, strong) NSString *Push_news_id;
@property(nonatomic, strong) NSString *Push_news_creattime;
@property(nonatomic, strong) NSString *Push_news_summny;
@end


//********************************************************************************************************
//**************************  Topic_General_tableheader
//普通专题（红色的专题）tableheader
//********************************************************************************************************

@interface Topic_General_tableheader : NSObject {
  //专题名称
  NSString *Topic_title;
  // 专题图片
  NSString *Topic_pic_url;
  // 专题简介
  NSString *Topic_summny;
}
@property(nonatomic, strong) NSString *Topic_title;
@property(nonatomic, strong) NSString *Topic_pic_url;
@property(nonatomic, strong) NSString *Topic_summny;

@end

//********************************************************************************************************
//**************************  Topic_General_Title_list
//普通专题（红色的专题）(专题中的小栏目 中cell信息)
//********************************************************************************************************

@interface Topic_General_Title_list : NSObject {
  //标题
  NSString *Topic_title;
  //文章频道channelid
  NSString *Topic_channelid;
  //文章id
  NSString *Topic_news_id;
  //类型  1.普通新闻 2.技术转码新闻
  int Topic_type;
  //发布时间
  NSString *Topic_creattime;
  //修改时间
  NSString *Topic_xgsj_time;

  //区分，类型  1.栏目 2.新闻
  int Topic_result_type;

  //    是否已读
  BOOL is_or_read;
}
@property(nonatomic, strong) NSString *Topic_title;
@property(nonatomic, strong) NSString *Topic_channelid;
@property(nonatomic, strong) NSString *Topic_news_id;
@property(nonatomic, assign) int Topic_type;
@property(nonatomic, strong) NSString *Topic_creattime;
@property(nonatomic, strong) NSString *Topic_xgsj_time;
@property(nonatomic, assign) int Topic_result_type;
@property(nonatomic, assign) BOOL is_or_read;

@end

//********************************************************************************************************
//**************************  Topic_General_list_TableDada
//普通专题（红色的专题）
//********************************************************************************************************

@interface Topic_General_list_TableDada : NSObject {
  //栏目题目
  NSString *Topic_title;
  // type类型
  int Topic_type;
  // 栏目新闻数组
  NSMutableArray *Topic_news_array;
}
@property(nonatomic, strong) NSString *Topic_title;
@property(nonatomic, assign) int Topic_type;
@property(nonatomic, strong) NSMutableArray *Topic_news_array;
@end

///********************************************************************************************************
//**************************  Cai_fayan_or_answer_TableData
//(财知道中个人，发言和回答)
//********************************************************************************************************

@interface Cai_fayan_or_answer_TableData : NSObject {
  //帖子id
  NSString *User_aid;
  //帖子来源 0.客户端发帖 1.cms发帖 2.新闻推送 发帖
  int User_article_src;

  //相关信息，channelid，creattime，id
  NSString *User_news_channelid;
  NSString *User_news_creatime;
  NSString *User_news_id;

  //用户昵称
  NSString *User_nick_name;
  //用户ID
  NSString *User_User_id;
  //用户头像url
  NSString *User_User_pic_url;
  //用户签名
  NSString *User_User_sign;

  //帖子摘要
  NSString *User_summary;
  //摘要高度
  float summaryHeight;
  //帖子标题
  NSString *User_title;

  //赞数
  NSString *User_Zan_num;
  //评论数
  NSString *User_comment_num;

  //发布时间
  NSString *User_creattime;
  //更新时间
  NSString *User_update_time;

  //被@人的昵称
  NSString *User_be_Nickname;
  //被@人的用户id
  NSString *User_be_Uid;
  // rid
  NSString *User_be_be_uid;

  //打赏率
  NSString *User_payRate;
  //悬赏钻石数
  NSString *User_rewardDiamonds;
  //悬赏状态
  int User_rewardState;

  //优顾认证
  NSString *User_certifySignature;
  // vtype
  NSString *User_vtype;

  //    是否已读
  BOOL is_not_read;
}
@property(nonatomic, strong) NSString *User_aid;
@property(nonatomic, assign) int User_article_src;

@property(nonatomic, strong) NSString *User_news_channelid;
@property(nonatomic, strong) NSString *User_news_creattime;
@property(nonatomic, strong) NSString *User_news_id;

@property(nonatomic, strong) NSString *User_nick_name;
@property(nonatomic, strong) NSString *User_User_id;
@property(nonatomic, strong) NSString *User_User_pic_url;
@property(nonatomic, strong) NSString *User_User_sign;

@property(nonatomic, strong) NSString *User_summary;
@property(nonatomic, assign) float summaryHeight;
@property(nonatomic, strong) NSString *User_title;

@property(nonatomic, strong) NSString *User_Zan_num;
@property(nonatomic, strong) NSString *User_comment_num;

@property(nonatomic, strong) NSString *User_creattime;
@property(nonatomic, strong) NSString *User_update_time;
@property(nonatomic, strong) NSString *User_be_Nickname;
@property(nonatomic, strong) NSString *User_be_Uid;
@property(nonatomic, strong) NSString *User_be_be_uid;

@property(nonatomic, strong) NSString *User_payRate;
@property(nonatomic, strong) NSString *User_rewardDiamonds;
@property(nonatomic, assign) int User_rewardState;

@property(nonatomic, strong) NSString *User_certifySignature;
@property(nonatomic, strong) NSString *User_vtype;

@property(nonatomic, assign) BOOL is_not_read;
@end

/*
 *类说明：表格数据结构
 */

@interface paketTableData : NSObject {
  //表格名称
  NSString *td_tableName;
  //表格feild信息
  NSMutableArray *td_feldItemArray;
  //数据信息(全部行数据)
  NSMutableArray *td_tableItemDataArray;
  //表格列数
  int td_tableConnumber;
  //表格行数
  int td_tableLinenumber;
}

@property(strong, nonatomic) NSString *tableName;
@property(strong, nonatomic) NSMutableArray *feldItemArray;
@property(strong, nonatomic) NSMutableArray *tableItemDataArray;
@property(assign, nonatomic) int tableConnumber;
@property(assign, nonatomic) int tableLinenumber;

@end

/*
 *类说明：表格feld说明
 */
@interface tableFeildItemInfo : NSObject {
  // feild名称
  NSString *tfii_name;
  //字段名称长度
  int tfii_namelenth;
  // feild是否有注释
  BOOL tfii_isNotes;
  //字段类型
  NSString *tfii_type;
  //字段精度
  int tfii_Precision;
  //字段的最大长度
  int tfii_maxLenth;
  //注释长度
  int tfii_notesLenth;
  //注释内容
  NSString *tfii_notescontent;
}

@property(strong, nonatomic) NSString *name;
@property(assign, nonatomic) int namelenth;
@property(assign, nonatomic) BOOL isNotes;
@property(strong, nonatomic) NSString *type;
@property(assign, nonatomic) int Precision;
@property(assign, nonatomic) int maxLenth;
@property(assign, nonatomic) int notesLenth;
@property(strong, nonatomic) NSString *notescontent;

@end
