//
//  DicToArray.m
//  优顾理财
//
//  Created by Mac on 14-3-5.
//  Copyright (c) 2014年 Youguu. All rights reserved.
//

#import "DateChangeSimple.h"
#import "FPFundItem.h"
#import "FundListsSqlite.h"
#import "FPMyOptionalItem.h"
#import "FPFundDetailItem.h"
#import "PlistOperation.h"
#import "FPTradeStatusInfo.h"

@implementation DicToArray
#pragma mark - 用户发言—— 数据解析
//发言解析
+ (NSMutableArray*)USER_Fa_dic_to_array:(NSDictionary*)dic {
  NSMutableArray* main_array = [[NSMutableArray alloc] initWithCapacity:0];

  NSArray* fayan_array = dic[@"talkList"];

  for (NSDictionary* first_dic in fayan_array) {
    Cai_fayan_or_answer_TableData* fayan_list =
        [[Cai_fayan_or_answer_TableData alloc] init];

    //        帖子id
    fayan_list.User_aid = [FPYouguUtil ishave_blank:first_dic[@"_id"]];
    //    帖子类型
    fayan_list.User_article_src =
        [[FPYouguUtil ishave_blank:first_dic[@"article_src"]] intValue];

    // news channelid, news_id, news_creattime
    fayan_list.User_news_channelid =
        [FPYouguUtil ishave_blank:first_dic[@"news_channelid"]];
    fayan_list.User_news_id =
        [FPYouguUtil ishave_blank:first_dic[@"news_id"]];
    fayan_list.User_news_creattime =
        [FPYouguUtil ishave_blank:first_dic[@"news_createtime"]];

    //        用户昵称
    fayan_list.User_nick_name =
        [FPYouguUtil ishave_blank:first_dic[@"nick_name"]];
    //        用户头像
    fayan_list.User_User_pic_url =
        [FPYouguUtil ishave_blank:first_dic[@"user_pic"]];
    //        用户签名
    fayan_list.User_User_sign =
        [FPYouguUtil ishave_blank:first_dic[@"user_sign"]];
    //  用户id
    fayan_list.User_User_id =
        [FPYouguUtil ishave_blank:first_dic[@"user_id"]];

    //        帖子标题
    fayan_list.User_title =
        [FPYouguUtil ishave_blank:first_dic[@"title"]];
    //        帖子摘要
    fayan_list.User_summary =
        [FPYouguUtil ishave_blank:first_dic[@"summary"]];
    fayan_list.summaryHeight =
        [fayan_list.User_summary
                 sizeWithFont:[UIFont systemFontOfSize:14.0f]
            constrainedToSize:CGSizeMake(windowWidth - 80.0f, 1000.0f)
                lineBreakMode:NSLineBreakByWordWrapping]
            .height +
        10.0f;
    //        评论数
    fayan_list.User_comment_num =
        [FPYouguUtil ishave_blank:first_dic[@"comment_num"]];
    //        赞数
    fayan_list.User_Zan_num =
        [FPYouguUtil ishave_blank:first_dic[@"up_num"]];

    //        创建时间
    fayan_list.User_creattime = [[DateChangeSimple sharedManager]
        get_time_date:[FPYouguUtil ishave_blank:first_dic[@"create_time"]]];
    //        更新时间
    fayan_list.User_update_time = [[DateChangeSimple sharedManager]
        get_time_date:[FPYouguUtil ishave_blank:first_dic[@"update_time"]]];

    //        向ta提问的对象
    fayan_list.User_be_Nickname =
        [FPYouguUtil ishave_blank:first_dic[@"be_nickname"]];
    //向ta提问id
    fayan_list.User_be_Uid =
        [FPYouguUtil ishave_blank:first_dic[@"be_uid"]];

    //打赏率
    fayan_list.User_payRate =
        [FPYouguUtil ishave_blank:first_dic[@"payRate"]];
    //悬赏钻石数
    fayan_list.User_rewardDiamonds =
        [FPYouguUtil ishave_blank:first_dic[@"rewardDiamonds"]];
    //悬赏状态
    fayan_list.User_rewardState =
        [[FPYouguUtil ishave_blank:first_dic[@"rewardState"]] intValue];

    //        是否，是加V,用户
    fayan_list.User_vtype =
        [FPYouguUtil ishave_blank:first_dic[@"vtype"]];
    //   优顾认证
    fayan_list.User_certifySignature =
        [FPYouguUtil ishave_blank:first_dic[@"certifySignature"]];

    [main_array addObject:fayan_list];
  }
  return main_array;
}

#pragma mark -评论列表—— 数据解析
//评论列表解析
+ (NSMutableArray*)USER_Comment_dic_to_array:(NSDictionary*)dic {
  NSMutableArray* main_array = [[NSMutableArray alloc] initWithCapacity:0];
  //        评论数
  NSArray* comment_array = dic[@"replyList"];

  for (NSDictionary* first_dic in comment_array) {
    Cai_fayan_or_answer_TableData* fayan_list =
        [[Cai_fayan_or_answer_TableData alloc] init];

    //        帖子id
    fayan_list.User_aid =
        [FPYouguUtil ishave_blank:first_dic[@"article_id"]];
    //    帖子类型
    fayan_list.User_article_src =
        [[FPYouguUtil ishave_blank:first_dic[@"article_src"]] intValue];

    // news channelid, news_id, news_creattime
    fayan_list.User_news_channelid =
        [FPYouguUtil ishave_blank:first_dic[@"news_channelid"]];
    fayan_list.User_news_id =
        [FPYouguUtil ishave_blank:first_dic[@"news_id"]];
    fayan_list.User_news_creattime =
        [FPYouguUtil ishave_blank:first_dic[@"news_createtime"]];

    //        用户昵称
    fayan_list.User_nick_name =
        [FPYouguUtil ishave_blank:first_dic[@"master_name"]];
    //        用户头像
    fayan_list.User_User_pic_url =
        [FPYouguUtil ishave_blank:first_dic[@"master_pic"]];
    //        用户签名
    fayan_list.User_User_sign =
        [FPYouguUtil ishave_blank:first_dic[@"master_sign"]];
    //  用户id
    fayan_list.User_User_id =
        [FPYouguUtil ishave_blank:first_dic[@"master_id"]];

    //        帖子标题
    fayan_list.User_title =
        [FPYouguUtil ishave_blank:first_dic[@"title"]];
    //        帖子摘要
    fayan_list.User_summary =
        [FPYouguUtil ishave_blank:first_dic[@"context"]];
    //稍微调小一点（全字母是存在bug）
    fayan_list.summaryHeight =
        [fayan_list.User_summary
                 sizeWithFont:[UIFont systemFontOfSize:14.0f]
            constrainedToSize:CGSizeMake(windowWidth - 80.0f, 1000.0f)]
            .height +
        10.0f;
    //        评论数
    fayan_list.User_comment_num =
        [FPYouguUtil ishave_blank:first_dic[@"comment_num"]];
    //        赞数
    fayan_list.User_Zan_num =
        [FPYouguUtil ishave_blank:first_dic[@"up_num"]];

    //        创建时间
    fayan_list.User_creattime = [[DateChangeSimple sharedManager]
        get_time_date:[FPYouguUtil ishave_blank:first_dic[@"create_time"]]];
    //        更新时间
    fayan_list.User_update_time = [[DateChangeSimple sharedManager]
        get_time_date:[FPYouguUtil ishave_blank:first_dic[@"update_time"]]];

    //        向ta提问的对象
    fayan_list.User_be_Nickname =
        [FPYouguUtil ishave_blank:first_dic[@"slave_name"]];
    //向ta提问id
    fayan_list.User_be_Uid =
        [FPYouguUtil ishave_blank:first_dic[@"slave_id"]];
    // rid
    fayan_list.User_be_be_uid =
        [FPYouguUtil ishave_blank:first_dic[@"slave_rid"]];

    //打赏率
    fayan_list.User_payRate =
        [FPYouguUtil ishave_blank:first_dic[@"payRate"]];
    //悬赏钻石数
    fayan_list.User_rewardDiamonds =
        [FPYouguUtil ishave_blank:first_dic[@"rewardDiamonds"]];
    //悬赏状态
    fayan_list.User_rewardState =
        [[FPYouguUtil ishave_blank:first_dic[@"rewardState"]] intValue];

    //        是否，是加V,用户
    fayan_list.User_vtype =
        [FPYouguUtil ishave_blank:first_dic[@"vtype"]];
    //   优顾认证
    fayan_list.User_certifySignature =
        [FPYouguUtil ishave_blank:first_dic[@"certifySignature"]];

    [main_array addObject:fayan_list];
  }
  return main_array;
}
/** 基金搜索列表存储在本地 */
+ (void)parseFundlists:(NSDictionary*)dict {
  NSString* lastTime;
  NSArray* lists = dict[@"result"];
  NSMutableArray* newDataArray = [[NSMutableArray alloc] init];
  for (NSDictionary* subDict in lists) {
    FPFundItem* item = [[FPFundItem alloc] init];
    item.fundId = subDict[@"fundid"];
    item.fundName = subDict[@"fundname"];
    item.pinyin = subDict[@"pinyin"];
    item.invstType = [subDict[@"invsttype"] stringValue];
    item.incTime = [subDict[@"inctime"] stringValue];
    if (!lastTime) {
      lastTime = item.incTime;
    }
    item.incType = [subDict[@"inctype"] stringValue];
    item.isSelected = @"0";
    //数据库存储
    switch ([item.incType integerValue]) {
      case OperatingTypeAdd:
      case OperatingTypeChange: {
        [newDataArray addObject:item];
      } break;
      case OperatingTypeDelete: {
        [[FundListsSqlite sharedManager] deleteListWithFundName:item.fundName];
      } break;
      default:
        break;
    }
  }
  if (newDataArray && [newDataArray count] > 0) {
    //先清除再添加
    [[FundListsSqlite sharedManager] deleteFundLists];
    [[FundListsSqlite sharedManager] saveFundLists:newDataArray];
  }
  if (lastTime) {
    //保存最后刷新时间
    [[NSUserDefaults standardUserDefaults] setObject:lastTime
                                              forKey:@"fundListLastUpdateTime"];
    [[NSUserDefaults standardUserDefaults] synchronize];
  }
}
/** 我的自选解析 */
+ (NSMutableArray*)parseOptionalListWithDict:(NSDictionary*)dict {
  //写缓存
  if (dict) {
    NSString *plistName = [NSString stringWithFormat:@"myOptionalLists_%@", YouGu_User_USerid];
    [dict writeToFile:[PlistOperation getPlistPath:plistName]
           atomically:YES];
  }
  NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:0];
  NSArray* lists = dict[@"result"];
  for (NSDictionary* subDict in lists) {
    FPMyOptionalItem* item = [[FPMyOptionalItem alloc] init];
    item.fundName = subDict[@"fundname"];
    item.fundId = subDict[@"fundid"];
    //基金判重
    for (FPMyOptionalItem *subItem in array) {
      if ([subItem.fundId isEqualToString:item.fundId]) {
        break;
      }
    }
    item.netValue = subDict[@"netvalue"];
    item.invsttype = subDict[@"invsttype"];
    item.cumvalue = subDict[@"cumvalue"];
    item.netValueRate = subDict[@"netvaluerate"];
    item.monthRate = subDict[@"monthrate"];
    item.fundType = subDict[@"type"];
    item.isSelected = @"1";
    [array addObject:item];
  }
  return array;
}
/** 我的资产解析 */
+ (FPMyFundItem*)parseMyFundDetailWithList:(NSDictionary*)dict {
  FPMyFundItem* item = [[FPMyFundItem alloc] init];
  NSDictionary* resultDict = dict[@"result"];
  item.userName = resultDict[@"username"];
  item.mobile = resultDict[@"mobile"];
  item.yesterdayProfit = [NSString
      stringWithFormat:@"%0.2f", [resultDict[@"yesterDayProfit"] floatValue]];
  item.countProfit = [resultDict[@"countProfit"] stringValue];
  item.countAssets = [resultDict[@"countAssets"] stringValue];
  item.yesterdayProTime = resultDict[@"yesterDay"];
  item.fundLists = [[NSMutableArray alloc] init];
  for (NSDictionary* subDict in resultDict[@"list"]) {
    FPFundDetailItem* subItem = [[FPFundDetailItem alloc] init];
    subItem.fundName = subDict[@"fundName"];
    subItem.fundId = subDict[@"fundid"];
    subItem.holdNum = [NSString stringWithFormat:@"%@ 份", subDict[@"balance"]];
    subItem.isBuy = [subDict[@"isBuy"] stringValue];
    subItem.assets = [subDict[@"assets"] stringValue];
    subItem.profit = [subDict[@"profit"] stringValue];
    subItem.profitProp = [subDict[@"profitprop"] stringValue];
    subItem.tradeacco = subDict[@"tradeacco"];
    subItem.remindStatus = ![subDict[@"remindStatus"] boolValue];
    [item.fundLists addObject:subItem];
  }
  return item;
}
/*** 交易记录*/

+ (NSMutableArray*)parseTradeWithLists:(NSDictionary*)dict {
  NSMutableArray* mutArray = [[NSMutableArray alloc] initWithCapacity:0];
  NSArray* tradeLists = dict[@"result"];
  for (NSDictionary* subDict in tradeLists) {
    FPTradeItem* item = [[FPTradeItem alloc] init];
    item.action = subDict[@"action"];
    item.fundname = subDict[@"fundname"];
    item.money = subDict[@"money"];
    item.traderemark = subDict[@"traderemark"];
    item.status = subDict[@"status"];
    item.time = subDict[@"time"];
    [mutArray addObject:item];
  }
  return mutArray;
}

/** 查询委托、撤单页*/
+ (NSMutableArray*)parseCheckAndCancelWithLists:(NSDictionary*)dict {
  NSMutableArray* mutArray = [[NSMutableArray alloc] initWithCapacity:0];
  NSArray* checkLists = dict[@"result"];
  for (NSDictionary* subDict in checkLists) {
    FPCheckAndCancelItem* item = [[FPCheckAndCancelItem alloc] init];
    item.type = [FPTradeStatusInfo getTradeTypeFromFundId:subDict[@"type"]];
    item.fundname = subDict[@"fundname"];
    item.money = subDict[@"money"];
    item.status = [FPTradeStatusInfo getTradeStatusFromId:subDict[@"status"]];
    item.fundid = subDict[@"fundid"];
    item.tradeacco = subDict[@"tradeacco"];
    item.mctserialno = subDict[@"mctserialno"];
    item.cancancel = subDict[@"cancancel"];
    item.chkflag = subDict[@"chkflag"];
    item.time = subDict[@"time"];
    [mutArray addObject:item];
  }

  return mutArray;
}

/** 跳转撤单页*/
+ (FPCancellationInfoItem*)parseCheckJumpCancelWithLists:(NSDictionary*)dict {
  NSDictionary* subDict = dict[@"result"];
  FPCancellationInfoItem* item = [[FPCancellationInfoItem alloc] init];
  item.bankName = subDict[@"bankName"];
  item.fundname = subDict[@"fundName"];
  item.subamt = subDict[@"subamt"];
  item.fundid = subDict[@"fundId"];
  item.payStatus = subDict[@"payStatus"];
  item.time = subDict[@"time"];
  return item;
}

/**** 撤单确认页 */
+ (FPCheckAndCancelItem*)parseAffirmAndCancelWithLists:(NSDictionary*)dict {
 

  FPCheckAndCancelItem* item = [[FPCheckAndCancelItem alloc] init];

  return item;
}
/**  申购页*/
+ (FPBuyItem*)parseBuyWithLists:(NSDictionary*)dict {
  FPBuyItem* item = [[FPBuyItem alloc] init];
  NSDictionary* resulltDict = dict[@"result"];
  item.money = resulltDict[@"money"];
  item.fundname = resulltDict[@"fundname"];
  item.bankname = resulltDict[@"bankname"];
  NSNumber* buyTime = resulltDict[@"purchasedt"];
  long long buyTimelong = [buyTime longLongValue] / 1000;
  item.purchasedt = [NSString stringWithFormat:@"%lld", buyTimelong];

  NSNumber* ackTime = resulltDict[@"ackdt"];
  long long ackTimelong = [ackTime longLongValue] / 1000;
  item.ackdt = [NSString stringWithFormat:@"%lld", ackTimelong];

  return item;
}
/**  赎回页*/
+ (FPRedemItem*)parseRedemWithLists:(NSDictionary*)dict {
  FPRedemItem* item = [[FPRedemItem alloc] init];
  NSDictionary* resulltDict = dict[@"result"];
  item.money = resulltDict[@"money"];
  item.fundname = resulltDict[@"fundname"];
  item.bankname = resulltDict[@"bankname"];
  item.remindStatus = resulltDict[@"remind"];
  NSNumber *redeemTime = resulltDict[@"redeemdt"];
  long redeemLong = [redeemTime longValue]/1000;
  item.redeemdt = [NSString stringWithFormat:@"%ld", redeemLong];
  
  NSNumber* buyTime = resulltDict[@"transferdt"];
  long long buyTimelong = [buyTime longLongValue] / 1000;
  item.transferdt = [NSString stringWithFormat:@"%lld", buyTimelong];

  NSNumber* ackTime = resulltDict[@"exackdt"];
  long long ackTimelong = [ackTime longLongValue] / 1000;
  item.exackdt = [NSString stringWithFormat:@"%lld", ackTimelong];
  return item;
}
/** 关联银行卡页*/
+ (FPConnectBankItem*)parseConnectBankLists:(NSDictionary*)dict {
  FPConnectBankItem* item = [[FPConnectBankItem alloc] init];
  NSDictionary* resultDict = dict[@"result"];
  item.serialno = resultDict[@"serialno"];
  item.userbankid = resultDict[@"userbankid"];

  return item;
}
/*** 添加银行列表*/

+ (NSMutableArray*)parseBankWithLists:(NSDictionary*)dict {
  NSMutableArray* mutArray = [NSMutableArray array];
  NSArray* bankLists = dict[@"result"];
  for (NSDictionary* subDic in bankLists) {
    FPBankItem* item = [[FPBankItem alloc] init];
    item.name = subDic[@"name"];
    item.no = subDic[@"no"];
    item.partnerid = subDic[@"partnerid"];
    item.logo = subDic[@"logo"];
    [mutArray addObject:item];
  }
  return mutArray;
}
/** 跳转申购解析 */
+ (FPGoToBuyItem*)parseGoToBuyWithList:(NSDictionary*)dict {
  FPGoToBuyItem* item = [[FPGoToBuyItem alloc] init];
  NSDictionary* resultDict = dict[@"result"];
  item.fundid = resultDict[@"fundid"];
  item.fundname = resultDict[@"fundname"];
  item.minPurchaseMoney = resultDict[@"minPurchaseMoney"];
  item.netfee = resultDict[@"netfee"];
  NSArray * feeAry = resultDict[@"fee"];
  NSMutableArray  * feeArray =[[NSMutableArray alloc]init];
  [feeAry enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL *stop) {
    feeItem * fees = [[feeItem alloc]init];
    fees.fee = obj[@"fee"];
    fees.condition = obj[@"condition"];
    [feeArray addObject:fees];
  }];
  item.feeLists =[[NSMutableArray alloc]initWithArray:feeArray];
  NSArray * bankAry = resultDict[@"banks"];
  NSMutableArray * bankArray =[[NSMutableArray alloc]init];
  [bankAry enumerateObjectsUsingBlock:^(NSMutableDictionary * obj, NSUInteger idx, BOOL *stop) {
    bankItem * bankObject =[[bankItem alloc]init];
    bankObject.bankid =obj[@"bankid"];
    bankObject.bankName =obj[@"bankName"];
    bankObject.logo = obj[@"logo"];
    bankObject.partnerid =obj[@"partnerid"];
    [bankArray addObject:bankObject];
  }];
  item.bankLists = [[NSMutableArray alloc]initWithArray:bankArray];
  return item;
}

/** 跳转赎回解析 */
+ (FPJumpRedeemItem*)parseGoToRedeemWithList:(NSDictionary*)dict {
  FPJumpRedeemItem* item = [[FPJumpRedeemItem alloc] init];
  NSDictionary* resultDict = dict[@"result"];
  item.minredamt = resultDict[@"minredamt"];
  item.fundname = resultDict[@"fundname"];
  item.balance = resultDict[@"balance"];
  item.bankName = resultDict[@"bankname"];
  item.bankid = resultDict[@"bankid"];
  item.isRemind = [resultDict[@"remind"]stringValue];
//  item.isRemind  = @"1";

  //    item.bankLists = [[NSMutableArray alloc]init];
  //    for (NSDictionary *subDict in [resultDict objectForKey:@"banks"]) {
  //        JumpRedeemItem *subItem = [[JumpRedeemItem alloc]init];
  //
  //        subItem.bankName = subDict[@"bankName"];
  //        subItem.bankid = subDict[@"bankid"];
  //        subItem.logo = subDict[@"logo"];
  //        subItem.partnerid= subDict[@"partnerid"];
  //
  //        [item.bankLists addObject:subItem];
  //    }
  return item;
}

/**  找回交易密码 */
+ (FPRetrieveItem*)parseRetrieveList:(NSDictionary*)dict {
  FPRetrieveItem* item = [[FPRetrieveItem alloc] init];
  item.phone = dict[@"phone"];
  return item;
}

+ (FPCountCenterItem*)pareseCountCenterList:(NSDictionary*)dict {
  FPCountCenterItem* item = [[FPCountCenterItem alloc] init];
  NSDictionary* resultDict = dict[@"result"];
  item.idno = resultDict[@"idno"];
  item.mobile = resultDict[@"mobile"];
  item.name = resultDict[@"name"];

  item.bankList = [[NSMutableArray alloc] init];
  for (NSDictionary* subDict in resultDict[@"banklist"]) {
    FPCountCenterDeatilItem* subItem = [[FPCountCenterDeatilItem alloc] init];

    subItem.no = subDict[@"no"];
    subItem.name = subDict[@"name"];
    subItem.logo = subDict[@"logo"];
    subItem.bankacco = subDict[@"bankacco"];
    item.partnerid = subDict[@"partnerid"];

    [item.bankList addObject:subItem];
  }

  return item;
}

@end
