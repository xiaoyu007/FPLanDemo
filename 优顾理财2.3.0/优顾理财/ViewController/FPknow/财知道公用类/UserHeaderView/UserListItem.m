//
//  UserListItem.m
//  优顾理财
//
//  Created by Mac on 15/7/21.
//  Copyright (c) 2015年 Youguu. All rights reserved.
//

@implementation UserListItem

-(void)jsonToObject:(NSDictionary *)dic
{
  [super jsonToObject:dic];
  self.headPic = dic[@"headpic"];
  self.nickName = dic[@"nickname"];
  self.sessionid = dic[@"sessionid"];
  self.signature = dic[@"signature"];
  self.userId =[FPYouguUtil ishave_blank:dic[@"userid"]];
  self.userName = dic[@"username"];
  self.rating = dic[@"rating"];
  self.stockFirmFlag = dic[@"stockFirmFlag"];
  self.vipType = [FPYouguUtil ishave_blank:dic[@"vipType"]];
  self.vType =[FPYouguUtil ishave_blank:dic[@"vType"]];
  self.CertifySignature = dic[@"certifySignature"];
  //打赏率
  self.payRate = [FPYouguUtil ishave_blank:dic[@"payRate"]];
  //悬赏钻石数
  self.rewardDiamonds = [FPYouguUtil ishave_blank:dic[@"rewardDiamonds"]];
  //悬赏状态
  self.rewardState = [dic[@"rewardState"] intValue];
}

-(void)jsonToObject2:(NSDictionary *)dic
{
  [super jsonToObject:dic];
  self.userId = [FPYouguUtil ishave_blank:dic[@"user_id"]];
  self.nickName = [FPYouguUtil ishave_blank:dic[@"nick_name"]];
  self.headPic = [FPYouguUtil ishave_blank:dic[@"user_pic"]];
  self.sessionid = dic[@"sessionid"];
  self.signature = [FPYouguUtil ishave_blank:dic[@"user_sign"]];
  self.userName = dic[@"username"];
  self.rating = dic[@"rating"];
  self.stockFirmFlag = dic[@"stockFirmFlag"];
  self.vipType = [FPYouguUtil ishave_blank:dic[@"vipType"]];
  self.vipType = [FPYouguUtil ishave_blank:dic[@"vtype"]];
  self.CertifySignature =[FPYouguUtil ishave_blank:dic[@"certifySignature"]];
  //打赏率
  self.payRate = [FPYouguUtil ishave_blank:dic[@"payRate"]];
  //悬赏钻石数
  self.rewardDiamonds = [FPYouguUtil ishave_blank:dic[@"rewardDiamonds"]];
  //悬赏状态
  self.rewardState = [dic[@"rewardState"] intValue];
}

-(void)jsonToObject3:(NSDictionary *)dic
{
  [super jsonToObject:dic];
  self.nickName = [FPYouguUtil ishave_blank:dic[@"master_name"]];
  self.headPic = [FPYouguUtil ishave_blank:dic[@"master_pic"]];
  self.signature = [FPYouguUtil ishave_blank:dic[@"master_sign"]];
  self.userId = [FPYouguUtil ishave_blank:dic[@"master_id"]];
  self.userName = dic[@"username"];
  self.sessionid = dic[@"sessionid"];

  //打赏率
  self.payRate = [FPYouguUtil ishave_blank:dic[@"payRate"]];
  self.rewardDiamonds = [FPYouguUtil ishave_blank:dic[@"rewardDiamonds"]];
  self.rewardState = [dic[@"rewardState"] intValue];

  self.rating = dic[@"rating"];
  self.stockFirmFlag = dic[@"stockFirmFlag"];
  
  self.vipType = [FPYouguUtil ishave_blank:dic[@"vipType"]];
  self.vipType = [FPYouguUtil ishave_blank:dic[@"vtype"]];
  self.CertifySignature =[FPYouguUtil ishave_blank:dic[@"certifySignature"]];
}
@end

@implementation UserInfoList
-(void)jsonToObject:(NSDictionary *)dic
{
  [super jsonToObject:dic];
  self.userArray = [[NSMutableArray alloc]init];
}
- (NSArray*)getArray {
  return _userArray;
}
- (NSDictionary*)mappingDictionary {
  return @{@"userArray" : NSStringFromClass([UserListItem class]) };
}


@end
