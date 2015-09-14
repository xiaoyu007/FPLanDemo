//
//  UserListItem.h
//  优顾理财
//
//  Created by Mac on 15/7/21.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

#import "BaseRequestObject.h"
/** 用户Vip项类型*/
typedef NS_ENUM(NSUInteger, UserVipType) {
  /** 未开通Vip */
  NotVipType = -1,

  /** Vip用户 */
  VipUser = 1,

  /** SVip用户 */
  SVipUser = 2,

  /** 过期的Vip用户 */
  VipUserExpired = 3
};

@interface UserListItem : JsonRequestObject
/** 列表页用户头像 */
@property(strong, nonatomic) NSString *headPic;
/** 用户昵称 */
@property(strong, nonatomic) NSString *nickName;
/** 签名 */
@property(strong, nonatomic) NSString *signature;
/** 用户id */
@property(strong, nonatomic) NSString *userId;
/** sessionid*/
@property(nonatomic, strong) NSString *sessionid;
/** 用户名 */
@property(strong, nonatomic) NSString *userName;
/*  登录密码 */
@property(strong, nonatomic) NSString *passWord;
/** vip等级 [int] -1 未开通 1 vip 2.svip 3.过期 */
@property(strong, nonatomic) NSString *vipType;
/** vtype*/
@property(strong, nonatomic) NSString *vType;
/** 品级 */
@property(strong, nonatomic) NSString *rating;
/** 股评等级 stockFirmFlag */
@property(strong, nonatomic) NSString *stockFirmFlag;
//打赏率
@property(strong, nonatomic) NSString *payRate;
//悬赏钻石数
@property(strong, nonatomic) NSString *rewardDiamonds;
//悬赏状态
@property(nonatomic) int rewardState;
/** 优顾认证 */
@property(nonatomic, strong) NSString *CertifySignature;
- (void)jsonToObject2:(NSDictionary *)dic;
- (void)jsonToObject3:(NSDictionary *)dic;
@end

@interface UserInfoList : JsonRequestObject
@property(nonatomic, strong) NSMutableArray *userArray;
@end
